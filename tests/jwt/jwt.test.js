import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "jwt";

describe("jwt module", () => {
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
    expect(body).toContain("jwt");
  });

  // TODO: Implement these tests when jwt module is ready
  // test("rejects request without token", async () => {
  //   const res = await fetch(`${TEST_URL}/protected`);
  //   expect(res.status).toBe(401);
  // });

  // test("accepts valid token", async () => {
  //   const res = await fetch(`${TEST_URL}/protected`, {
  //     headers: { Authorization: "Bearer <valid-token>" }
  //   });
  //   expect(res.status).toBe(200);
  // });
});
