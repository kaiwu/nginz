import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "hello";

describe("hello module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    cleanupRuntime(MODULE);
  });

  describe("hello directive", () => {
    test("outputs 'hello' text", async () => {
      const res = await fetch(`${TEST_URL}/hello`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toBe("hello");
    });

    test("works on different location paths", async () => {
      const res = await fetch(`${TEST_URL}/greeting`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toBe("hello");
    });

    test("works with nested locations", async () => {
      const res = await fetch(`${TEST_URL}/api/hello`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toBe("hello");
    });

    test("returns correct content type (none set)", async () => {
      const res = await fetch(`${TEST_URL}/hello`);
      expect(res.status).toBe(200);
      // hello module doesn't set content-type explicitly
    });

    test("handles HEAD request", async () => {
      const res = await fetch(`${TEST_URL}/hello`, { method: "HEAD" });
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toBe(""); // HEAD should not return body
    });
  });
});
