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

describe("Redis SET Operations", () => {
  test("sets a value and returns ok", async () => {
    const res = await fetch(`${TEST_URL}/set/newkey`, {
      method: "POST",
      body: "new-value",
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.ok).toBe(true);

    // Verify value was stored
    expect(redisMock.getValue("set/newkey")).toBe("new-value");
  });

  test("overwrites existing value", async () => {
    redisMock.setValue("set/existing", "old-value");

    const res = await fetch(`${TEST_URL}/set/existing`, {
      method: "POST",
      body: "updated-value",
    });
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.ok).toBe(true);
    expect(redisMock.getValue("set/existing")).toBe("updated-value");
  });

  test("rejects GET method for SET command", async () => {
    const res = await fetch(`${TEST_URL}/set/testkey`);
    expect(res.status).toBe(405);
  });

  test("rejects empty body for SET", async () => {
    const res = await fetch(`${TEST_URL}/set/emptykey`, {
      method: "POST",
      body: "",
    });
    expect(res.status).toBe(400);
  });
});

describe("Redis DEL Operations", () => {
  test("deletes existing key and returns count", async () => {
    redisMock.setValue("del/deletekey", "to-delete");

    const res = await fetch(`${TEST_URL}/del/deletekey`, {
      method: "POST",
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.value).toBe(1); // 1 key deleted

    // Verify key was deleted
    expect(redisMock.getValue("del/deletekey")).toBeUndefined();
  });

  test("returns 0 for non-existent key", async () => {
    const res = await fetch(`${TEST_URL}/del/nonexistent`, {
      method: "POST",
    });
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.value).toBe(0);
  });

  test("accepts DELETE method", async () => {
    redisMock.setValue("del/deletemethod", "delete-me");

    const res = await fetch(`${TEST_URL}/del/deletemethod`, {
      method: "DELETE",
    });
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.value).toBe(1);
  });
});

describe("Redis INCR Operations", () => {
  test("increments existing numeric key", async () => {
    redisMock.setValue("incr/counter", "10");

    const res = await fetch(`${TEST_URL}/incr/counter`, {
      method: "POST",
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.value).toBe(11);
    expect(redisMock.getValue("incr/counter")).toBe("11");
  });

  test("creates key with value 1 if not exists", async () => {
    const res = await fetch(`${TEST_URL}/incr/newcounter`, {
      method: "POST",
    });
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.value).toBe(1);
    expect(redisMock.getValue("incr/newcounter")).toBe("1");
  });

  test("rejects GET method for INCR command", async () => {
    const res = await fetch(`${TEST_URL}/incr/counter`);
    expect(res.status).toBe(405);
  });
});

describe("Redis EXPIRE Operations", () => {
  test("sets expiration on existing key", async () => {
    redisMock.setValue("expire/tempkey", "temporary");

    const res = await fetch(`${TEST_URL}/expire/tempkey`, {
      method: "POST",
      body: "3600", // 1 hour in seconds
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.value).toBe(1); // Success
  });

  test("returns 0 for non-existent key", async () => {
    const res = await fetch(`${TEST_URL}/expire/nonexistent`, {
      method: "POST",
      body: "60",
    });
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.value).toBe(0);
  });

  test("uses default TTL if body is empty", async () => {
    redisMock.setValue("expire/defaultttl", "default-ttl-test");

    const res = await fetch(`${TEST_URL}/expire/defaultttl`, {
      method: "POST",
      body: "",
    });
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.value).toBe(1);
  });
});

describe("Redis MGET Operations", () => {
  test("gets multiple values with query string", async () => {
    redisMock.setValue("key1", "value1");
    redisMock.setValue("key2", "value2");
    redisMock.setValue("key3", "value3");

    const res = await fetch(`${TEST_URL}/mget?keys=key1,key2,key3`);
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toBe("application/json");

    const body = await res.json();
    expect(body.values).toEqual(["value1", "value2", "value3"]);
  });

  test("returns null for missing keys in array", async () => {
    redisMock.setValue("exists1", "exists-value");
    // missing2 doesn't exist
    redisMock.setValue("exists3", "exists-value-3");

    const res = await fetch(`${TEST_URL}/mget?keys=exists1,missing2,exists3`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.values).toEqual(["exists-value", null, "exists-value-3"]);
  });

  test("handles single key in query string", async () => {
    redisMock.setValue("singlekey", "single-value");

    const res = await fetch(`${TEST_URL}/mget?keys=singlekey`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(body.values).toEqual(["single-value"]);
  });
});

describe("Redis Error Handling", () => {
  test("rejects non-GET HTTP methods for GET command", async () => {
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
