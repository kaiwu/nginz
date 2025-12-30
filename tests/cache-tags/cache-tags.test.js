import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "cache-tags";

describe("cache-tags module", () => {
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
    expect(body).toContain("cache-tags");
  });

  // TODO: Implement these tests when cache-tags module is ready
  // test("purges cache by tag", async () => {});
});
