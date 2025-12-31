/**
 * Mock OIDC/OAuth2 Provider
 * Supports authorization code flow, token endpoint, userinfo, and JWKS
 */

import { createHash, randomBytes } from "crypto";

export class OIDCMock {
  constructor(port = 9000) {
    this.port = port;
    this.server = null;
    this.issuer = `http://127.0.0.1:${port}`;
    this.authorizationCodes = new Map(); // code -> { clientId, redirectUri, scope, nonce }
    this.tokens = new Map(); // access_token -> { sub, scope, exp }
    this.refreshTokens = new Map(); // refresh_token -> { sub, scope }
    this.users = new Map(); // sub -> user info
    this.clients = new Map(); // client_id -> { secret, redirectUris }

    // Default test client
    this.registerClient("test-client", "test-secret", [
      "http://localhost:8888/callback",
      "http://127.0.0.1:8888/callback",
    ]);

    // Default test user
    this.registerUser("user1", {
      sub: "user1",
      name: "Test User",
      email: "test@example.com",
      email_verified: true,
    });

    // RSA key for signing (simplified - in real use, generate proper keys)
    this.keyId = "test-key-1";
  }

  start() {
    this.server = Bun.serve({
      port: this.port,
      fetch: (req) => this.handleRequest(req),
    });
    return this;
  }

  stop() {
    if (this.server) {
      this.server.stop();
      this.server = null;
    }
    this.authorizationCodes.clear();
    this.tokens.clear();
    this.refreshTokens.clear();
  }

  async handleRequest(req) {
    const url = new URL(req.url);
    const path = url.pathname;
    const method = req.method;

    // OpenID Configuration (Discovery)
    if (path === "/.well-known/openid-configuration") {
      return this.jsonResponse({
        issuer: this.issuer,
        authorization_endpoint: `${this.issuer}/authorize`,
        token_endpoint: `${this.issuer}/token`,
        userinfo_endpoint: `${this.issuer}/userinfo`,
        jwks_uri: `${this.issuer}/.well-known/jwks.json`,
        revocation_endpoint: `${this.issuer}/revoke`,
        introspection_endpoint: `${this.issuer}/introspect`,
        end_session_endpoint: `${this.issuer}/logout`,
        response_types_supported: ["code", "token", "id_token", "code token"],
        subject_types_supported: ["public"],
        id_token_signing_alg_values_supported: ["RS256", "HS256"],
        scopes_supported: ["openid", "profile", "email", "offline_access"],
        token_endpoint_auth_methods_supported: [
          "client_secret_basic",
          "client_secret_post",
        ],
        claims_supported: [
          "sub",
          "iss",
          "aud",
          "exp",
          "iat",
          "name",
          "email",
          "email_verified",
        ],
        code_challenge_methods_supported: ["S256", "plain"],
        grant_types_supported: [
          "authorization_code",
          "refresh_token",
          "client_credentials",
        ],
      });
    }

    // JWKS endpoint
    if (path === "/.well-known/jwks.json") {
      return this.jsonResponse({
        keys: [
          {
            kty: "RSA",
            kid: this.keyId,
            use: "sig",
            alg: "RS256",
            n: "0vx7agoebGcQSuuPiLJXZptN9nndrQmbXEps2aiAFbWhM78LhWx4cbbfAAtVT86zwu1RK7aPFFxuhDR1L6tSoc_BJECPebWKRXjBZCiFV4n3oknjhMstn64tZ_2W-5JsGY4Hc5n9yBXArwl93lqt7_RN5w6Cf0h4QyQ5v-65YGjQR0_FDW2QvzqY368QQMicAtaSqzs8KJZgnYb9c7d0zgdAZHzu6qMQvRL5hajrn1n91CbOpbISD08qNLyrdkt-bFTWhAI4vMQFh6WeZu0fM4lFd2NcRwr3XPksINHaQ-G_xBniIqbw0Ls1jF44-csFCur-kEgU8awapJzKnqDKgw",
            e: "AQAB",
          },
        ],
      });
    }

    // Authorization endpoint
    if (path === "/authorize") {
      return this.handleAuthorize(url);
    }

    // Token endpoint
    if (path === "/token" && method === "POST") {
      return await this.handleToken(req);
    }

    // UserInfo endpoint
    if (path === "/userinfo") {
      return this.handleUserInfo(req);
    }

    // Token introspection
    if (path === "/introspect" && method === "POST") {
      return await this.handleIntrospect(req);
    }

    // Token revocation
    if (path === "/revoke" && method === "POST") {
      return await this.handleRevoke(req);
    }

    // Logout endpoint
    if (path === "/logout") {
      const redirectUri = url.searchParams.get("post_logout_redirect_uri");
      if (redirectUri) {
        return Response.redirect(redirectUri, 302);
      }
      return new Response("Logged out", { status: 200 });
    }

    return new Response("Not Found", { status: 404 });
  }

  handleAuthorize(url) {
    const clientId = url.searchParams.get("client_id");
    const redirectUri = url.searchParams.get("redirect_uri");
    const responseType = url.searchParams.get("response_type") || "code";
    const scope = url.searchParams.get("scope") || "openid";
    const state = url.searchParams.get("state");
    const nonce = url.searchParams.get("nonce");
    const codeChallenge = url.searchParams.get("code_challenge");
    const codeChallengeMethod =
      url.searchParams.get("code_challenge_method") || "plain";

    // Validate client
    const client = this.clients.get(clientId);
    if (!client) {
      return this.errorRedirect(
        redirectUri,
        "invalid_client",
        "Unknown client",
        state
      );
    }

    if (!client.redirectUris.includes(redirectUri)) {
      return new Response("Invalid redirect_uri", { status: 400 });
    }

    // Generate authorization code
    const code = this.generateCode();
    this.authorizationCodes.set(code, {
      clientId,
      redirectUri,
      scope,
      nonce,
      codeChallenge,
      codeChallengeMethod,
      sub: "user1", // Default user
      exp: Date.now() + 600000, // 10 minutes
    });

    // Redirect back with code
    const redirectUrl = new URL(redirectUri);
    redirectUrl.searchParams.set("code", code);
    if (state) redirectUrl.searchParams.set("state", state);

    return Response.redirect(redirectUrl.toString(), 302);
  }

  async handleToken(req) {
    const contentType = req.headers.get("content-type") || "";
    let params;

    if (contentType.includes("application/x-www-form-urlencoded")) {
      const body = await req.text();
      params = new URLSearchParams(body);
    } else if (contentType.includes("application/json")) {
      const body = await req.json();
      params = new URLSearchParams(body);
    } else {
      return this.jsonError("invalid_request", "Invalid content type");
    }

    const grantType = params.get("grant_type");

    // Get client credentials
    let clientId = params.get("client_id");
    let clientSecret = params.get("client_secret");

    // Check Authorization header for client credentials
    const authHeader = req.headers.get("authorization");
    if (authHeader && authHeader.startsWith("Basic ")) {
      const decoded = atob(authHeader.slice(6));
      const [id, secret] = decoded.split(":");
      clientId = clientId || id;
      clientSecret = clientSecret || secret;
    }

    // Validate client
    const client = this.clients.get(clientId);
    if (!client || client.secret !== clientSecret) {
      return this.jsonError("invalid_client", "Invalid client credentials");
    }

    switch (grantType) {
      case "authorization_code":
        return this.handleAuthCodeGrant(params, clientId);

      case "refresh_token":
        return this.handleRefreshTokenGrant(params, clientId);

      case "client_credentials":
        return this.handleClientCredentialsGrant(clientId);

      default:
        return this.jsonError("unsupported_grant_type", "Unsupported grant type");
    }
  }

  handleAuthCodeGrant(params, clientId) {
    const code = params.get("code");
    const redirectUri = params.get("redirect_uri");
    const codeVerifier = params.get("code_verifier");

    const authCode = this.authorizationCodes.get(code);
    if (!authCode) {
      return this.jsonError("invalid_grant", "Invalid authorization code");
    }

    // Check expiration
    if (Date.now() > authCode.exp) {
      this.authorizationCodes.delete(code);
      return this.jsonError("invalid_grant", "Authorization code expired");
    }

    // Validate
    if (authCode.clientId !== clientId) {
      return this.jsonError("invalid_grant", "Client ID mismatch");
    }

    if (authCode.redirectUri !== redirectUri) {
      return this.jsonError("invalid_grant", "Redirect URI mismatch");
    }

    // Validate PKCE
    if (authCode.codeChallenge) {
      if (!codeVerifier) {
        return this.jsonError("invalid_grant", "Code verifier required");
      }
      const challenge = this.computeCodeChallenge(
        codeVerifier,
        authCode.codeChallengeMethod
      );
      if (challenge !== authCode.codeChallenge) {
        return this.jsonError("invalid_grant", "Invalid code verifier");
      }
    }

    // Consume the code
    this.authorizationCodes.delete(code);

    // Generate tokens
    return this.generateTokenResponse(authCode.sub, authCode.scope, authCode.nonce);
  }

  handleRefreshTokenGrant(params, clientId) {
    const refreshToken = params.get("refresh_token");
    const tokenData = this.refreshTokens.get(refreshToken);

    if (!tokenData) {
      return this.jsonError("invalid_grant", "Invalid refresh token");
    }

    return this.generateTokenResponse(tokenData.sub, tokenData.scope);
  }

  handleClientCredentialsGrant(clientId) {
    return this.generateTokenResponse(clientId, "openid");
  }

  generateTokenResponse(sub, scope, nonce) {
    const accessToken = this.generateToken();
    const refreshToken = this.generateToken();
    const expiresIn = 3600;

    // Store tokens
    this.tokens.set(accessToken, {
      sub,
      scope,
      exp: Date.now() + expiresIn * 1000,
    });
    this.refreshTokens.set(refreshToken, { sub, scope });

    // Generate ID token (simplified JWT)
    const idToken = this.generateIdToken(sub, nonce);

    return this.jsonResponse({
      access_token: accessToken,
      token_type: "Bearer",
      expires_in: expiresIn,
      refresh_token: refreshToken,
      id_token: idToken,
      scope,
    });
  }

  generateIdToken(sub, nonce) {
    const header = { alg: "HS256", typ: "JWT", kid: this.keyId };
    const payload = {
      iss: this.issuer,
      sub,
      aud: "test-client",
      exp: Math.floor(Date.now() / 1000) + 3600,
      iat: Math.floor(Date.now() / 1000),
      ...(nonce && { nonce }),
    };

    // Simplified JWT (not cryptographically signed for testing)
    const headerB64 = Buffer.from(JSON.stringify(header)).toString("base64url");
    const payloadB64 = Buffer.from(JSON.stringify(payload)).toString(
      "base64url"
    );
    const signature = Buffer.from("mock-signature").toString("base64url");

    return `${headerB64}.${payloadB64}.${signature}`;
  }

  handleUserInfo(req) {
    const authHeader = req.headers.get("authorization");
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return new Response("Unauthorized", { status: 401 });
    }

    const token = authHeader.slice(7);
    const tokenData = this.tokens.get(token);

    if (!tokenData || Date.now() > tokenData.exp) {
      return new Response("Invalid token", { status: 401 });
    }

    const user = this.users.get(tokenData.sub);
    if (!user) {
      return this.jsonResponse({ sub: tokenData.sub });
    }

    return this.jsonResponse(user);
  }

  async handleIntrospect(req) {
    const body = await req.text();
    const params = new URLSearchParams(body);
    const token = params.get("token");

    const tokenData = this.tokens.get(token);
    if (!tokenData || Date.now() > tokenData.exp) {
      return this.jsonResponse({ active: false });
    }

    return this.jsonResponse({
      active: true,
      sub: tokenData.sub,
      scope: tokenData.scope,
      exp: Math.floor(tokenData.exp / 1000),
      iat: Math.floor((tokenData.exp - 3600000) / 1000),
      token_type: "Bearer",
    });
  }

  async handleRevoke(req) {
    const body = await req.text();
    const params = new URLSearchParams(body);
    const token = params.get("token");

    this.tokens.delete(token);
    this.refreshTokens.delete(token);

    return new Response(null, { status: 200 });
  }

  computeCodeChallenge(verifier, method) {
    if (method === "plain") {
      return verifier;
    }
    // S256
    const hash = createHash("sha256").update(verifier).digest();
    return Buffer.from(hash).toString("base64url");
  }

  generateCode() {
    return randomBytes(32).toString("hex");
  }

  generateToken() {
    return randomBytes(32).toString("hex");
  }

  jsonResponse(data) {
    return new Response(JSON.stringify(data), {
      headers: { "Content-Type": "application/json" },
    });
  }

  jsonError(error, description) {
    return new Response(
      JSON.stringify({ error, error_description: description }),
      { status: 400, headers: { "Content-Type": "application/json" } }
    );
  }

  errorRedirect(redirectUri, error, description, state) {
    const url = new URL(redirectUri);
    url.searchParams.set("error", error);
    url.searchParams.set("error_description", description);
    if (state) url.searchParams.set("state", state);
    return Response.redirect(url.toString(), 302);
  }

  // Helper methods for test setup
  registerClient(clientId, secret, redirectUris) {
    this.clients.set(clientId, { secret, redirectUris });
  }

  registerUser(sub, userInfo) {
    this.users.set(sub, { sub, ...userInfo });
  }

  createAccessToken(sub, scope = "openid", expiresIn = 3600) {
    const token = this.generateToken();
    this.tokens.set(token, {
      sub,
      scope,
      exp: Date.now() + expiresIn * 1000,
    });
    return token;
  }

  invalidateToken(token) {
    this.tokens.delete(token);
    this.refreshTokens.delete(token);
  }
}

export function createOIDCMock(port = 9000) {
  return new OIDCMock(port).start();
}
