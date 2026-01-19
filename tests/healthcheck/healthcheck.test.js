import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  ensureBuild,
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
} from "../harness.js";

const MODULE_NAME = "healthcheck";

beforeAll(async () => {
  ensureBuild();
  await startNginz(`tests/${MODULE_NAME}/nginx.conf`, MODULE_NAME);
});

afterAll(async () => {
  await stopNginz();
  cleanupRuntime(MODULE_NAME);
});

describe("Health Check Endpoints", () => {
  describe("health_status directive", () => {
    test("returns JSON health status", async () => {
      const res = await fetch(`${TEST_URL}/health`);
      expect(res.status).toBe(200);
      expect(res.headers.get("content-type")).toBe("application/json");
      
      const body = await res.json();
      expect(body.status).toBe("healthy");
      expect(body.healthy).toBe(true);
      expect(body.ready).toBe(true);
      expect(typeof body.requests).toBe("number");
      expect(typeof body.failed).toBe("number");
      expect(typeof body.success_rate).toBe("number");
    });

    test("includes success rate", async () => {
      const res = await fetch(`${TEST_URL}/health`);
      const body = await res.json();
      expect(body.success_rate).toBeGreaterThanOrEqual(0);
      expect(body.success_rate).toBeLessThanOrEqual(100);
    });
  });

  describe("health_liveness directive", () => {
    test("returns alive status", async () => {
      const res = await fetch(`${TEST_URL}/healthz`);
      expect(res.status).toBe(200);
      expect(res.headers.get("content-type")).toBe("application/json");
      
      const body = await res.json();
      expect(body.status).toBe("alive");
    });

    test("always returns 200 for liveness", async () => {
      // Multiple requests should all succeed
      for (let i = 0; i < 5; i++) {
        const res = await fetch(`${TEST_URL}/healthz`);
        expect(res.status).toBe(200);
      }
    });
  });

  describe("health_readiness directive", () => {
    test("returns ready status", async () => {
      const res = await fetch(`${TEST_URL}/ready`);
      expect(res.status).toBe(200);
      expect(res.headers.get("content-type")).toBe("application/json");
      
      const body = await res.json();
      expect(body.status).toBe("ready");
    });
  });

  describe("normal endpoints still work", () => {
    test("regular endpoint returns content", async () => {
      const res = await fetch(`${TEST_URL}/`);
      expect(res.status).toBe(200);
      const text = await res.text();
      expect(text.trim()).toBe("Hello World");
    });
  });
});
