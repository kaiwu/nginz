import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "prometheus";

describe("prometheus module", () => {
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
    expect(body).toContain("prometheus");
  });

  // TODO: Implement these tests when prometheus module is ready
  // test("exposes metrics endpoint", async () => {
  //   const res = await fetch(`${TEST_URL}/metrics`);
  //   expect(res.status).toBe(200);
  //   const body = await res.text();
  //   expect(body).toContain("nginx_http_requests_total");
  // });
});
