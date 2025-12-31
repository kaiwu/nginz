import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createOIDCMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "oidc";
let oidcMock;

describe("oidc module", () => {
  beforeAll(async () => {
    // Start OIDC mock provider
    oidcMock = createOIDCMock(MOCK_PORTS.OIDC);

    // Register additional test users
    oidcMock.registerUser("admin", {
      name: "Admin User",
      email: "admin@example.com",
      email_verified: true,
      roles: ["admin"],
    });

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (oidcMock) {
      oidcMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  test("placeholder - module not implemented", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body).toContain("oidc");
  });

  // Tests to enable when oidc module is implemented:
  //
  // test("redirects unauthenticated requests to IdP", async () => {
  //   const res = await fetch(`${TEST_URL}/protected`, { redirect: "manual" });
  //   expect(res.status).toBe(302);
  //   const location = res.headers.get("location");
  //   expect(location).toContain(`127.0.0.1:${MOCK_PORTS.OIDC}/authorize`);
  // });
  //
  // test("handles callback with authorization code", async () => {
  //   // Simulate the callback from IdP
  //   const res = await fetch(`${TEST_URL}/callback?code=test-code&state=test-state`);
  //   expect(res.status).toBe(302); // Redirect to original URL
  // });
  //
  // test("allows access with valid token", async () => {
  //   const token = oidcMock.createAccessToken("user1", "openid profile");
  //   const res = await fetch(`${TEST_URL}/protected`, {
  //     headers: { Authorization: `Bearer ${token}` },
  //   });
  //   expect(res.status).toBe(200);
  // });
  //
  // test("rejects expired token", async () => {
  //   const token = oidcMock.createAccessToken("user1", "openid", -1);
  //   const res = await fetch(`${TEST_URL}/protected`, {
  //     headers: { Authorization: `Bearer ${token}` },
  //   });
  //   expect(res.status).toBe(401);
  // });
  //
  // test("validates token scopes", async () => {
  //   const token = oidcMock.createAccessToken("user1", "openid");
  //   const res = await fetch(`${TEST_URL}/admin`, {
  //     headers: { Authorization: `Bearer ${token}` },
  //   });
  //   expect(res.status).toBe(403); // Missing admin scope
  // });
});
