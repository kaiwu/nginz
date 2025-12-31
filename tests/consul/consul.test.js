import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createConsulMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "consul";
let consulMock;

describe("consul module", () => {
  beforeAll(async () => {
    // Start Consul mock
    consulMock = createConsulMock(MOCK_PORTS.CONSUL);

    // Register test services
    consulMock.addService("api-service", [
      { id: "api-1", address: "127.0.0.1", port: 9001, tags: ["v1"] },
      { id: "api-2", address: "127.0.0.1", port: 9002, tags: ["v1"] },
    ]);

    consulMock.addService("backend-service", [
      { id: "backend-1", address: "127.0.0.1", port: 9003, tags: ["primary"] },
    ]);

    // Set some KV data
    consulMock.setKV("config/app/timeout", "30");
    consulMock.setKV("config/app/retries", "3");

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (consulMock) {
      consulMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  test("placeholder - module not implemented", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body).toContain("consul");
  });

  // Tests to enable when consul module is implemented:
  //
  // test("resolves service from consul", async () => {
  //   const res = await fetch(`${TEST_URL}/api`);
  //   expect(res.status).toBe(200);
  // });
  //
  // test("load balances across service instances", async () => {
  //   const ports = new Set();
  //   for (let i = 0; i < 10; i++) {
  //     const res = await fetch(`${TEST_URL}/api`);
  //     // Check which backend was hit
  //   }
  //   expect(ports.size).toBeGreaterThan(1);
  // });
  //
  // test("reads config from KV store", async () => {
  //   const res = await fetch(`${TEST_URL}/config/timeout`);
  //   expect(await res.text()).toBe("30");
  // });
  //
  // test("excludes unhealthy instances", async () => {
  //   consulMock.setServiceHealth("api-service", "api-1", "critical");
  //   const res = await fetch(`${TEST_URL}/api`);
  //   // Should only hit api-2
  // });
});
