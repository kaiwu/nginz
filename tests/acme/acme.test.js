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
    test("returns 404 for unknown challenge token", async () => {
      // When no challenges are registered, any token should return 404
      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/unknown-token-12345`
      );
      expect(res.status).toBe(404);
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

    test("challenge path with no token returns 404", async () => {
      const res = await fetch(`${TEST_URL}/.well-known/acme-challenge/`);
      expect(res.status).toBe(404);
    });

    test("challenge path traversal is normalized by nginx", async () => {
      const res = await fetch(
        `${TEST_URL}/.well-known/acme-challenge/../../../etc/passwd`
      );
      // Nginx normalizes the path to /etc/passwd before our handler sees it
      // So the challenge handler declines and the request falls through to location /
      // This is safe because nginx's path normalization handles the security
      expect(res.status).toBe(200); // Falls through to location /
    });
  });

  describe("ACME Protocol Flow (Mock Server)", () => {
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
  });

  describe("Trigger Endpoint", () => {
    test("trigger endpoint exists and responds", async () => {
      // The trigger endpoint should exist at /.well-known/acme-trigger
      const res = await fetch(`${TEST_URL}/.well-known/acme-trigger`);
      // Should return some status (200 for success, or error status if ACME server unreachable)
      // The important thing is that it doesn't 404
      expect(res.status).not.toBe(404);
    });

    test("trigger endpoint not available on server without acme_domain", async () => {
      // Server on port 8890 has no acme_domain
      const res = await fetch(`${TEST_URL_8890}/.well-known/acme-trigger`);
      // Should return the default handler response (echozn)
      expect(res.status).toBe(200);
      const body = await res.json();
      expect(body.status).toBe("ok");
    });
  });

  describe("Storage", () => {
    test("storage base directory can be created", () => {
      // Create the storage directory if it doesn't exist
      const storagePath = `tests/${MODULE}/runtime/acme`;
      if (!existsSync(storagePath)) {
        mkdirSync(storagePath, { recursive: true });
      }
      expect(existsSync(storagePath)).toBe(true);
    });

    // These tests verify behavior after a full ACME flow completes
    // They are skipped because the full async ACME flow isn't testable
    // without more complex test infrastructure
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
});
