import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createRedisMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "redis";
let redisMock;

describe("redis module", () => {
  beforeAll(async () => {
    // Start Redis mock on test port
    redisMock = createRedisMock(MOCK_PORTS.REDIS);

    // Pre-populate some test data
    redisMock.setValue("test-key", "test-value");
    redisMock.setValue("counter", "42");

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (redisMock) {
      redisMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  test("placeholder - module not implemented", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body).toContain("redis");
  });

  // Tests to enable when redis module is implemented:
  //
  // test("gets value from redis", async () => {
  //   const res = await fetch(`${TEST_URL}/get?key=test-key`);
  //   expect(res.status).toBe(200);
  //   expect(await res.text()).toBe("test-value");
  // });
  //
  // test("sets value in redis", async () => {
  //   const res = await fetch(`${TEST_URL}/set?key=new-key&value=new-value`);
  //   expect(res.status).toBe(200);
  //   expect(redisMock.getValue("new-key")).toBe("new-value");
  // });
  //
  // test("increments counter", async () => {
  //   const res = await fetch(`${TEST_URL}/incr?key=counter`);
  //   expect(res.status).toBe(200);
  //   expect(await res.text()).toBe("43");
  // });
  //
  // test("returns null for missing key", async () => {
  //   const res = await fetch(`${TEST_URL}/get?key=nonexistent`);
  //   expect(res.status).toBe(404);
  // });
  //
  // test("handles SET with expiry", async () => {
  //   const res = await fetch(`${TEST_URL}/set?key=expiring&value=temp&ex=60`);
  //   expect(res.status).toBe(200);
  // });
});
