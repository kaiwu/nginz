import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
} from "../harness.js";

const MODULE = "oidc";

describe("oidc module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    cleanupRuntime(MODULE);
  });

  describe("authorization redirect", () => {
    test("redirects unauthenticated request to authorization endpoint", async () => {
      const res = await fetch(`${TEST_URL}/protected`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const location = res.headers.get("location");
      expect(location).toBeDefined();
      expect(location).toContain("http://localhost:9999/authorize");
    });

    test("redirect URL contains required OIDC parameters", async () => {
      const res = await fetch(`${TEST_URL}/protected`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const location = res.headers.get("location");
      expect(location).toContain("response_type=code");
      expect(location).toContain("client_id=test-client");
      expect(location).toContain("redirect_uri=");
      expect(location).toContain("state=");
      expect(location).toContain("nonce=");
    });

    test("redirect URL includes PKCE parameters when enabled", async () => {
      const res = await fetch(`${TEST_URL}/protected`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const location = res.headers.get("location");
      expect(location).toContain("code_challenge=");
      expect(location).toContain("code_challenge_method=S256");
    });

    test("redirect URL excludes PKCE when disabled", async () => {
      const res = await fetch(`${TEST_URL}/no-pkce`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const location = res.headers.get("location");
      expect(location).not.toContain("code_challenge=");
      expect(location).not.toContain("code_challenge_method=");
    });

    test("sets state cookie on redirect", async () => {
      const res = await fetch(`${TEST_URL}/protected`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const setCookie = res.headers.get("set-cookie");
      expect(setCookie).toBeDefined();
      expect(setCookie).toContain("oidc_state=");
      expect(setCookie).toContain("Path=/");
      expect(setCookie).toContain("HttpOnly");
    });

    test("state parameter is hex encoded (64 chars)", async () => {
      const res = await fetch(`${TEST_URL}/protected`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const location = res.headers.get("location");
      const stateMatch = location.match(/state=([a-f0-9]+)/);
      expect(stateMatch).toBeDefined();
      expect(stateMatch[1].length).toBe(64);
    });
  });

  describe("callback handling", () => {
    test("callback without code returns error", async () => {
      const res = await fetch(`${TEST_URL}/callback?state=abc123`, {
        redirect: "manual",
      });
      expect(res.status).toBe(400);
      const body = await res.text();
      expect(body).toContain("Missing authorization code");
    });

    test("callback without state returns error", async () => {
      const res = await fetch(`${TEST_URL}/callback?code=abc123`, {
        redirect: "manual",
      });
      expect(res.status).toBe(400);
      const body = await res.text();
      expect(body).toContain("Missing state");
    });

    test("callback without state cookie returns error", async () => {
      const res = await fetch(`${TEST_URL}/callback?code=abc123&state=xyz789`, {
        redirect: "manual",
      });
      expect(res.status).toBe(400);
      const body = await res.text();
      expect(body).toContain("Missing state cookie");
    });
  });

  describe("public endpoints", () => {
    test("public endpoint allows access without OIDC", async () => {
      const res = await fetch(`${TEST_URL}/public`);
      expect(res.status).toBe(200);
      const body = await res.json();
      expect(body.status).toBe("public_content");
    });

    test("health endpoint works", async () => {
      const res = await fetch(`${TEST_URL}/`);
      expect(res.status).toBe(200);
      const body = await res.json();
      expect(body.status).toBe("ok");
    });
  });

  describe("scope handling", () => {
    test("default scope includes openid profile email", async () => {
      const res = await fetch(`${TEST_URL}/protected`, {
        redirect: "manual",
      });
      expect(res.status).toBe(302);

      const location = res.headers.get("location");
      // URL encoded "openid profile email" = "openid%20profile%20email"
      expect(location).toContain("scope=openid");
    });
  });
});
