import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "requestid";

describe("requestid module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    cleanupRuntime(MODULE);
  });

  test("placeholder - module not implemented", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body).toContain("requestid");
  });

  // TODO: Implement these tests when requestid module is ready
  // test("generates request ID header", async () => {
  //   const res = await fetch(`${TEST_URL}/`);
  //   expect(res.headers.get("X-Request-ID")).toBeTruthy();
  // });
  // test("propagates existing request ID", async () => {
  //   const res = await fetch(`${TEST_URL}/`, {
  //     headers: { "X-Request-ID": "test-id-123" }
  //   });
  //   expect(res.headers.get("X-Request-ID")).toBe("test-id-123");
  // });
});
