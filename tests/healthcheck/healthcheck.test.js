import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createHTTPMock,
  MOCK_PORTS,
  createMockManager,
} from "../harness.js";

const MODULE = "healthcheck";
let mocks;
let upstream1;
let upstream2;

describe("healthcheck module", () => {
  beforeAll(async () => {
    mocks = createMockManager();

    // Create two upstream servers for testing health checks
    upstream1 = mocks.add(
      "upstream1",
      createHTTPMock(MOCK_PORTS.HTTP_UPSTREAM_1)
    );
    upstream2 = mocks.add(
      "upstream2",
      createHTTPMock(MOCK_PORTS.HTTP_UPSTREAM_2)
    );

    // Configure upstream responses
    upstream1.get("/", { body: { server: "upstream1" }, status: 200 });
    upstream1.get("/health", { body: "OK", status: 200 });

    upstream2.get("/", { body: { server: "upstream2" }, status: 200 });
    upstream2.get("/health", { body: "OK", status: 200 });

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    await mocks.stopAll();
    cleanupRuntime(MODULE);
  });

  test("placeholder - module not implemented", async () => {
    const res = await fetch(`${TEST_URL}/`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body).toContain("healthcheck");
  });

  // Tests to enable when healthcheck module is implemented:
  //
  // test("routes to healthy upstreams", async () => {
  //   const res = await fetch(`${TEST_URL}/api`);
  //   expect(res.status).toBe(200);
  // });
  //
  // test("marks upstream as down after health check failures", async () => {
  //   // Make upstream1 return 500 on health checks
  //   upstream1.get("/health", { body: "Error", status: 500 });
  //
  //   // Wait for health check interval
  //   await Bun.sleep(2000);
  //
  //   // All requests should go to upstream2
  //   for (let i = 0; i < 5; i++) {
  //     const res = await fetch(`${TEST_URL}/api`);
  //     const body = await res.json();
  //     expect(body.server).toBe("upstream2");
  //   }
  // });
  //
  // test("recovers upstream after health check passes", async () => {
  //   // Restore upstream1 health
  //   upstream1.get("/health", { body: "OK", status: 200 });
  //
  //   // Wait for recovery threshold
  //   await Bun.sleep(3000);
  //
  //   // Requests should now balance between both upstreams
  //   const servers = new Set();
  //   for (let i = 0; i < 10; i++) {
  //     const res = await fetch(`${TEST_URL}/api`);
  //     const body = await res.json();
  //     servers.add(body.server);
  //   }
  //   expect(servers.size).toBe(2);
  // });
  //
  // test("returns 502 when all upstreams are down", async () => {
  //   upstream1.get("/health", { body: "Error", status: 500 });
  //   upstream2.get("/health", { body: "Error", status: 500 });
  //
  //   await Bun.sleep(2000);
  //
  //   const res = await fetch(`${TEST_URL}/api`);
  //   expect(res.status).toBe(502);
  // });
});
