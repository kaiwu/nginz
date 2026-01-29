## OpenID Connect Module

OpenID Connect Relying Party implementation for nginx SSO integration.

### Status

**Implemented** - Core OIDC flow with token exchange

- Authorization redirect with state, nonce, and PKCE
- Callback handling with state validation
- Token exchange via nginx upstream with proper 302 redirect
- ID token JWT parsing (claims extraction)
- Encrypted session cookie creation (AES-256-GCM)
- Session validation for protected resources

### Implementation Plan

#### Phase 1: Core Authorization Code Flow

Focus on essential OIDC functionality for protecting applications:

1. **Session Management** - Encrypted cookie-based sessions
2. **Authorization Redirect** - Redirect unauthenticated users to IdP
3. **Callback Handling** - Process authorization code from IdP
4. **Token Exchange** - HTTP POST to token endpoint
5. **ID Token Parsing** - Extract claims from JWT (decode, no signature verification)
6. **Claim Passthrough** - Set nginx variables for backend

#### Architecture

```
Client Request
    |
[ACCESS PHASE] oidc_handler
    |
    +-- Has valid session cookie? ──Yes──> Extract claims, set $oidc_* vars, NGX_DECLINED
    |
    No
    |
    +-- Is callback URI? ──Yes──> Extract code from ?code=
    |                                   |
    |                              Token Exchange (HTTP POST)
    |                                   |
    |                              Parse ID token, extract claims
    |                                   |
    |                              Set session cookie, redirect to original URL
    |
    No
    |
    +-- Generate state, nonce, PKCE
    |
    +-- Store state in cookie (queued)
    |
    +-- 302 Redirect to authorization_endpoint
         |
     [HEADER FILTER] inject Set-Cookie before headers are sent
```

#### Module Structure

```
src/modules/oidc-nginx-module/
├── ngx_http_oidc.zig      # Main module
└── README.md
```

#### Config Structure

```zig
const oidc_loc_conf = extern struct {
    enabled: ngx_flag_t,           // oidc on|off
    discovery_url: ngx_str_t,      // .well-known/openid-configuration URL
    client_id: ngx_str_t,          // OAuth client ID
    client_secret: ngx_str_t,      // OAuth client secret (optional for PKCE)
    redirect_uri: ngx_str_t,       // Callback URL
    scope: ngx_str_t,              // Scopes (default: "openid profile email")
    cookie_name: ngx_str_t,        // Session cookie name (default: "oidc_session")
    cookie_secret: ngx_str_t,      // AES key for cookie encryption (32 bytes hex)
    use_pkce: ngx_flag_t,          // Enable PKCE (default: on)

    // Cached discovery endpoints (populated at runtime)
    authorization_endpoint: ngx_str_t,
    token_endpoint: ngx_str_t,
    userinfo_endpoint: ngx_str_t,

    // Upstream config for token endpoint
    ups: ngx_http_upstream_conf_t,
};
```

#### Request Context

```zig
const oidc_request_ctx = extern struct {
    // Session state
    has_session: ngx_flag_t,
    session_claims: [*c]cjson.cJSON,

    // Token exchange state
    authorization_code: ngx_str_t,
    state: ngx_str_t,
    code_verifier: ngx_str_t,  // PKCE

    // Upstream response
    token_response: ngx_str_t,

    // Extracted claims for variables
    sub: ngx_str_t,
    email: ngx_str_t,
    name: ngx_str_t,

    // Pending Set-Cookie values (queued until header filter)
    pending_cookies: [MAX_PENDING_COOKIES]ngx_str_t,
    pending_cookie_count: ngx_uint_t,
};
```

#### Directives (Phase 1)

| Directive | Syntax | Default | Description |
|-----------|--------|---------|-------------|
| `oidc` | `on\|off` | `off` | Enable OIDC authentication |
| `oidc_discovery` | `<url>` | - | Discovery document URL |
| `oidc_client_id` | `<id>` | - | OAuth 2.0 client ID |
| `oidc_client_secret` | `<secret>` | - | OAuth 2.0 client secret |
| `oidc_redirect_uri` | `<uri>` | - | Callback URI |
| `oidc_scope` | `<scopes>` | `"openid profile email"` | OAuth scopes |
| `oidc_cookie_name` | `<name>` | `"oidc_session"` | Session cookie name |
| `oidc_cookie_secret` | `<hex>` | - | 32-byte AES key (hex encoded) |
| `oidc_pkce` | `on\|off` | `on` | Enable PKCE |

#### Session Cookie Format

Encrypted JSON payload:
```json
{
  "sub": "user123",
  "email": "user@example.com",
  "name": "John Doe",
  "exp": 1704067200,
  "iat": 1704063600,
  "original_uri": "/protected/page"
}
```

Cookie: `oidc_session=<base64(AES-256-GCM encrypted JSON)>`

#### OIDC Flow Details

**1. Check Session**
```zig
fn checkSession(r: *ngx_http_request_t, lccf: *oidc_loc_conf) ?*oidc_session {
    // 1. Find cookie by name
    // 2. Base64 decode
    // 3. AES-256-GCM decrypt with cookie_secret
    // 4. Parse JSON
    // 5. Check expiration
    // Return session or null
}
```

**2. Authorization Redirect**
```zig
fn redirectToAuthorization(r: *ngx_http_request_t, lccf: *oidc_loc_conf) ngx_int_t {
    // 1. Generate random state (32 bytes, hex encoded)
    // 2. Generate nonce (32 bytes, hex encoded)
    // 3. If PKCE: generate code_verifier, compute code_challenge (S256)
    // 4. Store state + code_verifier + original_uri in state cookie (queued)
    // 5. Build authorization URL:
    //    {authorization_endpoint}?
    //      response_type=code&
    //      client_id={client_id}&
    //      redirect_uri={redirect_uri}&
    //      scope={scope}&
    //      state={state}&
    //      nonce={nonce}&
    //      code_challenge={code_challenge}&
    //      code_challenge_method=S256
    // 6. Return 302 redirect (header filter adds Set-Cookie)
}
```

**3. Callback Handler**
```zig
fn handleCallback(r: *ngx_http_request_t, lccf: *oidc_loc_conf) ngx_int_t {
    // 1. Extract ?code= and ?state= from query string
    // 2. Retrieve state cookie, verify state matches
    // 3. Extract code_verifier from state cookie
    // 4. Call token endpoint (upstream HTTP POST)
}
```

**4. Token Exchange**

POST to token_endpoint:
```
POST /oauth/token HTTP/1.1
Host: idp.example.com
Content-Type: application/x-www-form-urlencoded

grant_type=authorization_code&
code={authorization_code}&
redirect_uri={redirect_uri}&
client_id={client_id}&
client_secret={client_secret}&     (if not PKCE)
code_verifier={code_verifier}      (if PKCE)
```

Response:
```json
{
  "access_token": "...",
  "token_type": "Bearer",
  "expires_in": 3600,
  "refresh_token": "...",
  "id_token": "eyJhbGciOiJSUzI1NiIs..."
}
```

**5. ID Token Parsing**

JWT structure: `header.payload.signature`

```zig
fn parseIdToken(id_token: []const u8) ?*Claims {
    // 1. Split by '.'
    // 2. Base64url decode payload (middle part)
    // 3. Parse JSON
    // 4. Extract: sub, email, name, exp, iat, nonce
    // Note: Signature verification in Phase 2
}
```

**6. Session Creation**
```zig
fn createSession(r: *ngx_http_request_t, claims: *Claims, original_uri: []const u8) ngx_int_t {
    // 1. Build session JSON with claims + exp + original_uri
    // 2. AES-256-GCM encrypt with cookie_secret
    // 3. Base64 encode
    // 4. Queue Set-Cookie (header filter injects later)
    // 5. 302 redirect to original_uri
}
```

#### nginx Variables (Phase 1)

| Variable | Description |
|----------|-------------|
| `$oidc_claim_sub` | Subject identifier |
| `$oidc_claim_email` | User email |
| `$oidc_claim_name` | User display name |
| `$oidc_access_token` | Access token (for API calls) |

#### Handler Flow

```zig
export fn ngx_http_oidc_handler(r: *ngx_http_request_t) ngx_int_t {
    // 1. Get location config
    // 2. Check if enabled

    // 3. Check for valid session cookie
    if (checkSession(r, lccf)) |session| {
        // Set nginx variables from session claims
        setClaimVariables(r, session);
        return NGX_DECLINED;  // Continue to content phase
    }

    // 4. Check if this is the callback URI
    if (isCallbackUri(r, lccf)) {
        // Handle authorization code
        return handleCallback(r, lccf);
    }

    // 5. No session, not callback - redirect to IdP
    return redirectToAuthorization(r, lccf);
}
```

#### Test Cases

1. **Unauthenticated request** → 302 redirect to IdP
2. **Callback with valid code** → Token exchange, session cookie, redirect to original
3. **Callback with invalid state** → 400 Bad Request
4. **Request with valid session** → Pass through, claims in variables
5. **Request with expired session** → 302 redirect to IdP
6. **PKCE flow** → code_challenge in auth URL, code_verifier in token request
7. **Missing client_secret with PKCE** → Works (public client)
8. **Logout** → Clear session cookie

#### nginx.conf Example

```nginx
server {
    listen 443 ssl;
    server_name app.example.com;

    # Protected location
    location / {
        oidc on;
        oidc_discovery https://keycloak.example.com/realms/myrealm/.well-known/openid-configuration;
        oidc_client_id my-nginx-client;
        oidc_client_secret my-secret;
        oidc_redirect_uri https://app.example.com/callback;
        oidc_cookie_secret 0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;

        # Pass claims to backend
        proxy_set_header X-User-Sub $oidc_claim_sub;
        proxy_set_header X-User-Email $oidc_claim_email;
        proxy_set_header X-User-Name $oidc_claim_name;

        proxy_pass http://backend;
    }

    # Callback endpoint (same config, module handles internally)
    location /callback {
        oidc on;
        oidc_discovery https://keycloak.example.com/realms/myrealm/.well-known/openid-configuration;
        oidc_client_id my-nginx-client;
        oidc_client_secret my-secret;
        oidc_redirect_uri https://app.example.com/callback;
        oidc_cookie_secret 0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef;

        # No proxy_pass needed - module handles response
    }
}
```

### Phase 2: Future Enhancements

Not in initial implementation:

- [ ] **Nginx Variables** - Set `$oidc_claim_sub`, `$oidc_claim_email`, etc. for backend passthrough
- [ ] **ID Token Signature Verification** - RSA/ECDSA verification with JWKS
- [ ] **Discovery Caching** - Cache .well-known response
- [ ] **Token Refresh** - Automatic access token refresh
- [ ] **Logout Support** - RP-Initiated Logout, back-channel logout
- [ ] **Session Storage** - Redis/shared memory for clustered deployments
- [ ] **Custom Claim Mapping** - Extract arbitrary claims to variables
- [ ] **Authorization** - Role/group-based access control
- [ ] **Multiple IdPs** - Support different IdPs per location

### Implementation Order

1. Create module skeleton with config structs and directives
2. Implement session cookie encryption/decryption (AES-256-GCM)
3. Implement session check logic
4. Implement authorization redirect with state/nonce
5. Implement PKCE (code_verifier/code_challenge)
6. Implement callback handler (extract code/state)
7. Implement token exchange using upstream pattern
8. Implement ID token parsing (JWT decode)
9. Implement session creation
10. Implement nginx variable handlers
11. Register as ACCESS phase handler
12. Write integration tests with mock IdP

### Complexity Estimate

- **Lines of code**: ~1200-1500
- **Difficulty**: High (HTTP client, crypto, JWT, state management)
- **Dependencies**: cJSON (available), AES-256-GCM (ngx.ssl), upstream (ngx.http)

### Testing Strategy

Mock IdP server that:
- Returns discovery document at /.well-known/openid-configuration
- Accepts authorization requests and returns codes
- Exchanges codes for tokens at /token endpoint
- Returns mock ID tokens (JWT format)

### Security Considerations

- **State Parameter**: CSRF protection, stored in HttpOnly cookie
- **PKCE**: Prevents authorization code interception
- **Cookie Encryption**: Session cannot be forged without secret
- **HttpOnly + Secure**: Cookies protected from XSS
- **SameSite=Lax**: CSRF protection for session cookie
- **Nonce**: Replay attack prevention (verified in Phase 2)

### References

- [OpenID Connect Core 1.0](https://openid.net/specs/openid-connect-core-1_0.html)
- [OAuth 2.0 for Browser-Based Apps (PKCE)](https://datatracker.ietf.org/doc/html/draft-ietf-oauth-browser-based-apps)
- [RFC 7636 - PKCE](https://datatracker.ietf.org/doc/html/rfc7636)
- [lua-resty-openidc](https://github.com/zmartzone/lua-resty-openidc)
