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

const MODULE = "canary";
let mocks;
let stableUpstream;
let canaryUpstream;

describe("canary module", () => {
  beforeAll(async () => {
    mocks = createMockManager();

    // Create stable and canary upstream servers
    stableUpstream = mocks.add(
      "stable",
      createHTTPMock(MOCK_PORTS.HTTP_UPSTREAM_1)
    );
    canaryUpstream = mocks.add(
      "canary",
      createHTTPMock(MOCK_PORTS.HTTP_UPSTREAM_2)
    );

    // Configure responses to identify which upstream handled the request
    stableUpstream.get("/", { body: { version: "stable", v: "1.0.0" } });
    stableUpstream.get("/api/*", (req, url) => ({
      body: { version: "stable", path: url.pathname },
    }));

    canaryUpstream.get("/", { body: { version: "canary", v: "1.1.0-beta" } });
    canaryUpstream.get("/api/*", (req, url) => ({
      body: { version: "canary", path: url.pathname },
    }));

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
    expect(body).toContain("canary");
  });

  // Tests to enable when canary module is implemented:
  //
  // test("routes majority of traffic to stable", async () => {
  //   const versions = { stable: 0, canary: 0 };
  //
  //   for (let i = 0; i < 100; i++) {
  //     const res = await fetch(`${TEST_URL}/api/test`);
  //     const body = await res.json();
  //     versions[body.version]++;
  //   }
  //
  //   // With 10% canary, expect roughly 90 stable, 10 canary
  //   expect(versions.stable).toBeGreaterThan(80);
  //   expect(versions.canary).toBeGreaterThan(5);
  //   expect(versions.canary).toBeLessThan(20);
  // });
  //
  // test("routes canary header traffic to canary", async () => {
  //   const res = await fetch(`${TEST_URL}/api/test`, {
  //     headers: { "X-Canary": "true" },
  //   });
  //   const body = await res.json();
  //   expect(body.version).toBe("canary");
  // });
  //
  // test("routes canary cookie traffic to canary", async () => {
  //   const res = await fetch(`${TEST_URL}/api/test`, {
  //     headers: { Cookie: "canary=1" },
  //   });
  //   const body = await res.json();
  //   expect(body.version).toBe("canary");
  // });
  //
  // test("sticky sessions maintain routing", async () => {
  //   // First request gets assigned to a version
  //   const res1 = await fetch(`${TEST_URL}/api/test`);
  //   const body1 = await res1.json();
  //   const sessionCookie = res1.headers.get("set-cookie");
  //
  //   // Subsequent requests with cookie should go to same version
  //   for (let i = 0; i < 5; i++) {
  //     const res = await fetch(`${TEST_URL}/api/test`, {
  //       headers: { Cookie: sessionCookie },
  //     });
  //     const body = await res.json();
  //     expect(body.version).toBe(body1.version);
  //   }
  // });
});
