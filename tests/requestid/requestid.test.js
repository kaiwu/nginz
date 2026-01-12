import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "requestid";

// UUID4 regex pattern: 8-4-4-4-12 hex characters
const UUID4_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/;

describe("requestid module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    cleanupRuntime(MODULE);
  });

  describe("basic functionality", () => {
    test("generates X-Request-ID response header", async () => {
      const res = await fetch(`${TEST_URL}/return-test`);
      expect(res.status).toBe(200);

      const requestId = res.headers.get("X-Request-ID");
      expect(requestId).toBeTruthy();
      expect(requestId).toMatch(UUID4_PATTERN);
    });

    test("generates unique IDs for each request", async () => {
      const ids = new Set();

      for (let i = 0; i < 10; i++) {
        const res = await fetch(`${TEST_URL}/return-test`);
        const requestId = res.headers.get("X-Request-ID");
        ids.add(requestId);
      }

      // All 10 IDs should be unique
      expect(ids.size).toBe(10);
    });
  });

  describe("custom header name", () => {
    test("uses custom header name X-Correlation-ID", async () => {
      const res = await fetch(`${TEST_URL}/custom-header`);
      expect(res.status).toBe(200);

      // Should use custom header name
      const correlationId = res.headers.get("X-Correlation-ID");
      expect(correlationId).toBeTruthy();
      expect(correlationId).toMatch(UUID4_PATTERN);

      // Standard header should not be present
      const requestId = res.headers.get("X-Request-ID");
      expect(requestId).toBeNull();
    });

    test("propagates incoming custom header", async () => {
      const customId = "custom-correlation-123";
      const res = await fetch(`${TEST_URL}/custom-header`, {
        headers: { "X-Correlation-ID": customId },
      });
      expect(res.status).toBe(200);

      const correlationId = res.headers.get("X-Correlation-ID");
      expect(correlationId).toBe(customId);
    });
  });

  describe("response header control", () => {
    test("does not add header when request_id_response is off", async () => {
      const res = await fetch(`${TEST_URL}/no-response`);
      expect(res.status).toBe(200);

      // Header should not be present
      const requestId = res.headers.get("X-Request-ID");
      expect(requestId).toBeNull();
    });
  });

  describe("disabled location", () => {
    test("does not generate ID when request_id is not enabled", async () => {
      const res = await fetch(`${TEST_URL}/disabled`);
      expect(res.status).toBe(200);

      const requestId = res.headers.get("X-Request-ID");
      expect(requestId).toBeNull();
    });
  });

  describe("ID propagation", () => {
    test("propagates existing X-Request-ID from request", async () => {
      const incomingId = "test-propagated-id-12345";
      const res = await fetch(`${TEST_URL}/propagate`, {
        headers: { "X-Request-ID": incomingId },
      });
      expect(res.status).toBe(200);

      // Response header should contain the propagated ID
      const responseId = res.headers.get("X-Request-ID");
      expect(responseId).toBe(incomingId);
    });

    test("generates new ID when no incoming header", async () => {
      const res = await fetch(`${TEST_URL}/propagate`);
      expect(res.status).toBe(200);

      const requestId = res.headers.get("X-Request-ID");
      expect(requestId).toBeTruthy();
      expect(requestId).toMatch(UUID4_PATTERN);
    });

    test("header matching is case-insensitive", async () => {
      const incomingId = "case-insensitive-test-id";

      // Test with lowercase header
      const res1 = await fetch(`${TEST_URL}/propagate`, {
        headers: { "x-request-id": incomingId },
      });
      expect(res1.headers.get("X-Request-ID")).toBe(incomingId);

      // Test with mixed case header
      const res2 = await fetch(`${TEST_URL}/propagate`, {
        headers: { "X-REQUEST-ID": incomingId },
      });
      expect(res2.headers.get("X-Request-ID")).toBe(incomingId);
    });
  });

  describe("UUID4 format validation", () => {
    test("version nibble is 4", async () => {
      const res = await fetch(`${TEST_URL}/basic`);
      const requestId = res.headers.get("X-Request-ID");

      // Character at position 14 should be '4' (version)
      expect(requestId[14]).toBe("4");
    });

    test("variant nibble is valid (8, 9, a, or b)", async () => {
      const res = await fetch(`${TEST_URL}/basic`);
      const requestId = res.headers.get("X-Request-ID");

      // Character at position 19 should be 8, 9, a, or b (variant)
      expect(["8", "9", "a", "b"]).toContain(requestId[19]);
    });

    test("correct hyphen positions", async () => {
      const res = await fetch(`${TEST_URL}/basic`);
      const requestId = res.headers.get("X-Request-ID");

      expect(requestId[8]).toBe("-");
      expect(requestId[13]).toBe("-");
      expect(requestId[18]).toBe("-");
      expect(requestId[23]).toBe("-");
    });

    test("correct total length", async () => {
      const res = await fetch(`${TEST_URL}/basic`);
      const requestId = res.headers.get("X-Request-ID");

      expect(requestId.length).toBe(36);
    });
  });
});
