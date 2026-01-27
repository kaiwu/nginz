import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { existsSync, mkdirSync, rmSync, readFileSync } from "fs";
import { join } from "path";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createACMEMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "acme";
const TEST_URL_8889 = "http://127.0.0.1:8889";
const TEST_URL_8890 = "http://127.0.0.1:8890";
const ACME_MOCK_URL = `http://127.0.0.1:${MOCK_PORTS.ACME}`;

let acmeMock;

describe("acme module", () => {
  beforeAll(async () => {
    // Ensure clean state
    const acmeStoragePath = `tests/${MODULE}/runtime/acme`;
    if (existsSync(acmeStoragePath)) {
      rmSync(acmeStoragePath, { recursive: true });
    }
    mkdirSync(acmeStoragePath, { recursive: true });

    // Start ACME mock server
    acmeMock = createACMEMock(MOCK_PORTS.ACME);

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (acmeMock) {
      acmeMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  describe("HTTP-01 Challenge Handler", () => {
    test("serves key authorization for valid challenge token", async () => {
      // First, create an order to get a challenge token
      const orderRes = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "test.example.com" }],
        }),
      });
      expect(orderRes.status).toBe(201);
      const order = await orderRes.json();

      // Get the authorization
      const authzRes = await fetch(order.authorizations[0], {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      const authz = await authzRes.json();
      const challenge = authz.challenges.find((c) => c.type === "http-01");

      // The nginx module should serve the challenge response
      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/${challenge.token}`
      );
      expect(res.status).toBe(200);

      const body = await res.text();
      // Key authorization format: {token}.{thumbprint}
      expect(body).toContain(challenge.token);
      expect(body).toContain(".");
    });

    test("returns 404 for unknown challenge token", async () => {
      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/unknown-token-12345`
      );
      expect(res.status).toBe(404);
    });

    test("returns correct Content-Type for challenge response", async () => {
      // Create order and get challenge
      const orderRes = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "test.example.com" }],
        }),
      });
      const order = await orderRes.json();

      const authzRes = await fetch(order.authorizations[0], {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      const authz = await authzRes.json();
      const challenge = authz.challenges.find((c) => c.type === "http-01");

      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/${challenge.token}`
      );

      // ACME spec requires text/plain
      const contentType = res.headers.get("Content-Type");
      expect(contentType).toMatch(/text\/plain/);
    });

    test("does not intercept challenges on server without acme_domain", async () => {
      // Server on port 8890 has no acme_domain, should use manual handler
      const res = await fetch(
        `${TEST_URL_8890}/.well-known/acme-challenge/any-token`
      );
      expect(res.status).toBe(200);

      const body = await res.json();
      expect(body.handler).toBe("manual");
    });

    test("normal requests pass through on ACME-enabled server", async () => {
      const res = await fetch(`${TEST_URL}/`);
      expect(res.status).toBe(200);

      const body = await res.json();
      expect(body.status).toBe("ok");
      expect(body.server).toBe("test.example.com");
    });
  });

  describe("ACME Protocol Flow", () => {
    test("fetches directory from ACME server", async () => {
      const res = await fetch(`${ACME_MOCK_URL}/directory`);
      expect(res.status).toBe(200);

      const directory = await res.json();
      expect(directory.newAccount).toBeDefined();
      expect(directory.newOrder).toBeDefined();
      expect(directory.newNonce).toBeDefined();
    });

    test("creates new account", async () => {
      const res = await fetch(`${ACME_MOCK_URL}/new-account`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          termsOfServiceAgreed: true,
          contact: ["mailto:test@example.com"],
        }),
      });
      expect(res.status).toBe(201);

      const account = await res.json();
      expect(account.status).toBe("valid");

      // Should have Location header with account URL
      const location = res.headers.get("Location");
      expect(location).toContain("/account/");
    });

    test("creates order for domain", async () => {
      const res = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "test.example.com" }],
        }),
      });
      expect(res.status).toBe(201);

      const order = await res.json();
      expect(order.status).toBe("pending");
      expect(order.authorizations).toHaveLength(1);
      expect(order.finalize).toBeDefined();
    });

    test("retrieves authorization with challenge", async () => {
      // Create order
      const orderRes = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "test.example.com" }],
        }),
      });
      const order = await orderRes.json();

      // Get authorization
      const authzRes = await fetch(order.authorizations[0], {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      expect(authzRes.status).toBe(200);

      const authz = await authzRes.json();
      expect(authz.status).toBe("pending");
      expect(authz.challenges).toBeDefined();

      const httpChallenge = authz.challenges.find((c) => c.type === "http-01");
      expect(httpChallenge).toBeDefined();
      expect(httpChallenge.token).toBeDefined();
      expect(httpChallenge.status).toBe("pending");
    });

    test("completes challenge and finalizes order", async () => {
      // Create order
      const orderRes = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "test.example.com" }],
        }),
      });
      const order = await orderRes.json();

      // Get authorization
      const authzRes = await fetch(order.authorizations[0], {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      const authz = await authzRes.json();
      const challenge = authz.challenges.find((c) => c.type === "http-01");

      // Respond to challenge (mock auto-validates)
      const challengeRes = await fetch(challenge.url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      expect(challengeRes.status).toBe(200);

      const validatedChallenge = await challengeRes.json();
      expect(validatedChallenge.status).toBe("valid");

      // Check order is ready
      const orderUrl = orderRes.headers.get("Location");
      const readyOrderRes = await fetch(orderUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      const readyOrder = await readyOrderRes.json();
      expect(readyOrder.status).toBe("ready");

      // Finalize order with CSR
      const finalizeRes = await fetch(readyOrder.finalize, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          csr: "mock-csr-base64url",
        }),
      });
      expect(finalizeRes.status).toBe(200);

      const finalizedOrder = await finalizeRes.json();
      expect(finalizedOrder.status).toBe("valid");
      expect(finalizedOrder.certificate).toBeDefined();

      // Download certificate
      const certRes = await fetch(finalizedOrder.certificate);
      expect(certRes.status).toBe(200);

      const cert = await certRes.text();
      expect(cert).toContain("-----BEGIN CERTIFICATE-----");
    });
  });

  describe("Multiple Domains", () => {
    test("handles challenges for different domains on different ports", async () => {
      // Create order for second domain
      const orderRes = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "other.example.com" }],
        }),
      });
      const order = await orderRes.json();

      const authzRes = await fetch(order.authorizations[0], {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      const authz = await authzRes.json();
      const challenge = authz.challenges.find((c) => c.type === "http-01");

      // Challenge should be served on port 8889 (other.example.com)
      const res = await fetch(
        `${TEST_URL_8889}/.well-known/acme-challenge/${challenge.token}`
      );
      expect(res.status).toBe(200);

      const body = await res.text();
      expect(body).toContain(challenge.token);
    });
  });

  describe("Nonce Management", () => {
    test("ACME server returns Replay-Nonce header", async () => {
      const res = await fetch(`${ACME_MOCK_URL}/new-nonce`, {
        method: "HEAD",
      });
      expect(res.status).toBe(200);

      const nonce = res.headers.get("Replay-Nonce");
      expect(nonce).toBeDefined();
      expect(nonce.length).toBeGreaterThan(0);
    });

    test("each request returns a new nonce", async () => {
      const res1 = await fetch(`${ACME_MOCK_URL}/new-nonce`, { method: "HEAD" });
      const res2 = await fetch(`${ACME_MOCK_URL}/new-nonce`, { method: "HEAD" });

      const nonce1 = res1.headers.get("Replay-Nonce");
      const nonce2 = res2.headers.get("Replay-Nonce");

      expect(nonce1).not.toBe(nonce2);
    });
  });

  describe("Storage", () => {
    test("storage directory is created", () => {
      const storagePath = `tests/${MODULE}/runtime/acme`;
      expect(existsSync(storagePath)).toBe(true);
    });

    // These tests verify behavior after module stores certs
    test.skip("account key is stored in storage directory", () => {
      const accountKeyPath = `tests/${MODULE}/runtime/acme/account.key`;
      expect(existsSync(accountKeyPath)).toBe(true);

      const key = readFileSync(accountKeyPath, "utf8");
      expect(key).toContain("-----BEGIN RSA PRIVATE KEY-----");
    });

    test.skip("certificate is stored after successful issuance", () => {
      const certPath = `tests/${MODULE}/runtime/acme/certs/test.example.com/fullchain.pem`;
      const keyPath = `tests/${MODULE}/runtime/acme/certs/test.example.com/privkey.pem`;

      expect(existsSync(certPath)).toBe(true);
      expect(existsSync(keyPath)).toBe(true);
    });
  });

  describe("Error Handling", () => {
    test("handles ACME server errors gracefully", async () => {
      // Request with invalid identifier
      const res = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [], // Empty - should fail
        }),
      });
      expect(res.status).toBe(400);

      const error = await res.json();
      expect(error.type).toContain("urn:ietf:params:acme:error:");
    });

    test("challenge path with no token returns 404", async () => {
      const res = await fetch(`${TEST_URL}/.well-known/acme-challenge/`);
      expect(res.status).toBe(404);
    });

    test("challenge path traversal is blocked", async () => {
      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/../../../etc/passwd`
      );
      // Should either 404 or 400, not serve sensitive files
      expect([400, 404]).toContain(res.status);
    });
  });

  describe("Key Authorization Format", () => {
    test("key authorization contains token and thumbprint", async () => {
      // Create order
      const orderRes = await fetch(`${ACME_MOCK_URL}/new-order`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          identifiers: [{ type: "dns", value: "test.example.com" }],
        }),
      });
      const order = await orderRes.json();

      const authzRes = await fetch(order.authorizations[0], {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "{}",
      });
      const authz = await authzRes.json();
      const challenge = authz.challenges.find((c) => c.type === "http-01");

      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/${challenge.token}`
      );
      const keyAuth = await res.text();

      // Format: {token}.{base64url(SHA256(JWK))}
      const parts = keyAuth.trim().split(".");
      expect(parts).toHaveLength(2);
      expect(parts[0]).toBe(challenge.token);
      // Thumbprint should be base64url encoded (no padding)
      expect(parts[1]).toMatch(/^[A-Za-z0-9_-]+$/);
    });
  });
});
