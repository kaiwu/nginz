import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  ensureBuild,
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createRedisMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE_NAME = "redis";
let redisMock;

beforeAll(async () => {
  ensureBuild();

  // Start Redis mock on test port
  redisMock = createRedisMock(MOCK_PORTS.REDIS);

  // Pre-populate some test data
  // Keys must match the full URI path (without leading slash)
  redisMock.setValue("test-key", "test-value");
  redisMock.setValue("get/mykey", "hello-world");
  redisMock.setValue("get/counter", "42");
  redisMock.setValue("get/json-data", '{"name":"test","count":123}');

  await startNginz(`tests/${MODULE_NAME}/nginx.conf`, MODULE_NAME);
});

afterAll(async () => {
  await stopNginz();
  if (redisMock) {
    redisMock.stop();
  }
  cleanupRuntime(MODULE_NAME);
});

describe("Redis GET Operations", () => {
  test("gets value using URI as key", async () => {
    const res = await fetch(`${TEST_URL}/get/mykey`);
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.value).toBe("hello-world");
  });

  test("gets value using static key directive", async () => {
    const res = await fetch(`${TEST_URL}/static-key`);
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.value).toBe("test-value");
  });

  test("returns null for non-existent key", async () => {
    const res = await fetch(`${TEST_URL}/get/nonexistent-key`);
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.value).toBe(null);
  });

  test("handles JSON value stored in Redis", async () => {
    const res = await fetch(`${TEST_URL}/get/json-data`);
    expect(res.status).toBe(200);

    const body = await res.json();
    // Value is returned as string (not parsed JSON)
    expect(body.value).toBe('{"name":"test","count":123}');
  });

  test("handles numeric value stored in Redis", async () => {
    const res = await fetch(`${TEST_URL}/get/counter`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.value).toBe("42");
  });
});

describe("Redis Error Handling", () => {
  test("rejects non-GET HTTP methods", async () => {
    const res = await fetch(`${TEST_URL}/get/mykey`, {
      method: "POST",
    });
    expect(res.status).toBe(405);
  });
});

describe("Regular endpoints still work", () => {
  test("non-redis location returns content", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const text = await res.text();
    expect(text.trim()).toBe("Hello World");
  });
});
