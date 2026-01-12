import { describe, test, expect, beforeAll, afterAll, beforeEach } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createHTTPMock,
  MOCK_PORTS,
  createMockManager,
} from "../harness.js";

const MODULE = "circuit-breaker";
let mocks;
let upstream;

describe("circuit-breaker module", () => {
  beforeAll(async () => {
    mocks = createMockManager();

    // Create upstream server on port 19002
    upstream = mocks.add("upstream", createHTTPMock(MOCK_PORTS.HTTP_UPSTREAM_1));

    // Default successful response
    upstream.get("/", { body: { status: "ok" }, status: 200 });
    upstream.get("/*", { body: { status: "ok" }, status: 200 });

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    await mocks.stopAll();
    cleanupRuntime(MODULE);
  });

  beforeEach(() => {
    // Reset failure rate before each test
    upstream.setFailureRate(0);
    upstream.clearLog();
  });

  describe("closed state", () => {
    test("allows requests when circuit is closed", async () => {
      const res = await fetch(`${TEST_URL}/protected`);
      expect(res.status).toBe(200);
    });

    test("forwards requests to upstream", async () => {
      await fetch(`${TEST_URL}/protected`);
      const requests = upstream.getRequests();
      expect(requests.length).toBeGreaterThanOrEqual(1);
    });
  });

  describe("open state", () => {
    test("opens circuit after threshold failures", async () => {
      // Set upstream to return 500 errors
      upstream.setFailureRate(1.0);

      // Trigger failures to open circuit (threshold = 3 for /protected)
      for (let i = 0; i < 4; i++) {
        await fetch(`${TEST_URL}/protected`);
      }

      // Circuit should be open now, returning 503 without hitting upstream
      upstream.clearLog();
      const res = await fetch(`${TEST_URL}/protected`);
      expect(res.status).toBe(503);

      // Verify no request reached upstream (circuit breaker blocked it)
      const requests = upstream.getRequests();
      expect(requests.length).toBe(0);
    });

    test("returns 503 when circuit is open", async () => {
      // Open the circuit using /fast endpoint (threshold = 2)
      upstream.setFailureRate(1.0);

      for (let i = 0; i < 3; i++) {
        await fetch(`${TEST_URL}/fast`);
      }

      upstream.setFailureRate(0);
      upstream.clearLog();

      // Should return 503 immediately
      const res = await fetch(`${TEST_URL}/fast`);
      expect(res.status).toBe(503);
    });
  });

  describe("half-open state", () => {
    test("transitions to half-open after timeout", async () => {
      // Open the circuit using /fast endpoint (timeout = 1s)
      upstream.setFailureRate(1.0);

      for (let i = 0; i < 3; i++) {
        await fetch(`${TEST_URL}/fast`);
      }

      // Verify circuit is open
      upstream.setFailureRate(0);
      upstream.clearLog();

      const openRes = await fetch(`${TEST_URL}/fast`);
      expect(openRes.status).toBe(503);

      // Wait for timeout (1s + buffer)
      await Bun.sleep(1200);

      // Circuit should be half-open, allowing a test request
      const halfOpenRes = await fetch(`${TEST_URL}/fast`);
      expect(halfOpenRes.status).toBe(200);
    });

    test("closes circuit after successful requests in half-open", async () => {
      // Open the circuit
      upstream.setFailureRate(1.0);

      for (let i = 0; i < 3; i++) {
        await fetch(`${TEST_URL}/fast`);
      }

      upstream.setFailureRate(0);

      // Wait for timeout
      await Bun.sleep(1200);

      // Send successful request (half-open allows 1)
      const res1 = await fetch(`${TEST_URL}/fast`);
      expect(res1.status).toBe(200);

      // Circuit should be closed now (success_threshold = 1 for /fast)
      // Next request should also succeed
      const res2 = await fetch(`${TEST_URL}/fast`);
      expect(res2.status).toBe(200);
    });

    test("re-opens circuit on failure in half-open state", async () => {
      // Open the circuit
      upstream.setFailureRate(1.0);

      for (let i = 0; i < 3; i++) {
        await fetch(`${TEST_URL}/fast`);
      }

      // Wait for timeout
      await Bun.sleep(1200);

      // Still failing - this should re-open the circuit immediately
      const halfOpenRes = await fetch(`${TEST_URL}/fast`);
      expect(halfOpenRes.status).toBe(500); // Upstream error

      // Circuit should be open again
      upstream.setFailureRate(0);
      upstream.clearLog();

      const openRes = await fetch(`${TEST_URL}/fast`);
      expect(openRes.status).toBe(503);
    });
  });

  describe("circuit state variable", () => {
    test("exposes $ngz_circuit_state variable", async () => {
      const res = await fetch(`${TEST_URL}/state`);
      expect(res.status).toBe(200);

      const body = await res.text();
      expect(body).toContain("state:");
    });

    test("shows closed state initially", async () => {
      const res = await fetch(`${TEST_URL}/state`);
      const body = await res.text();
      expect(body).toContain("closed");
    });

    test("sets X-Circuit-State header", async () => {
      const res = await fetch(`${TEST_URL}/state`);
      const state = res.headers.get("X-Circuit-State");
      expect(state).toBe("closed");
    });
  });

  describe("non-circuit-breaker endpoints", () => {
    test("regular endpoints work normally", async () => {
      const res = await fetch(`${TEST_URL}/`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toBe("ok\n");
    });
  });
});
