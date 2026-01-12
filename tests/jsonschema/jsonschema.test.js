import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "jsonschema";

describe("jsonschema module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    cleanupRuntime(MODULE);
  });

  describe("non-validated endpoints", () => {
    test("allows any request to non-validated endpoint", async () => {
      const res = await fetch(`${TEST_URL}/`);
      expect(res.status).toBe(200);
    });

    test("allows GET requests without validation", async () => {
      const res = await fetch(`${TEST_URL}/api/users`);
      expect(res.status).toBe(200);
    });
  });

  describe("valid JSON validation", () => {
    test("accepts valid JSON with required fields", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name: "John", email: "john@example.com" }),
      });
      expect(res.status).toBe(200);
    });

    test("accepts valid JSON with all fields", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: "John",
          email: "john@example.com",
          age: 25,
        }),
      });
      expect(res.status).toBe(200);
    });

    test("accepts valid object type", async () => {
      const res = await fetch(`${TEST_URL}/api/simple`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ any: "data" }),
      });
      expect(res.status).toBe(200);
    });
  });

  describe("invalid JSON validation", () => {
    test("rejects invalid JSON syntax with 400", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: "not valid json",
      });
      expect(res.status).toBe(400);
      const body = await res.json();
      expect(body.error).toBe("validation_failed");
    });

    test("rejects missing required field with 400", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name: "John" }), // missing email
      });
      expect(res.status).toBe(400);
      const body = await res.json();
      expect(body.error).toBe("validation_failed");
    });

    test("rejects wrong type with 400", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: 123, // should be string
          email: "test@example.com",
        }),
      });
      expect(res.status).toBe(400);
    });

    test("rejects number below minimum with 400", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: "John",
          email: "john@example.com",
          age: -5, // minimum is 0
        }),
      });
      expect(res.status).toBe(400);
    });

    test("rejects string below minLength with 400", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          name: "", // minLength is 1
          email: "john@example.com",
        }),
      });
      expect(res.status).toBe(400);
    });

    test("rejects non-object when object required", async () => {
      const res = await fetch(`${TEST_URL}/api/simple`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify("just a string"),
      });
      expect(res.status).toBe(400);
    });
  });

  describe("content type handling", () => {
    test("skips validation for non-JSON content type", async () => {
      const res = await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "text/plain" },
        body: "not json",
      });
      // Should pass through without validation
      expect(res.status).toBe(200);
    });
  });
});
