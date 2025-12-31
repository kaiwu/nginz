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

const MODULE = "transform";
let mocks;
let upstream;

describe("transform module", () => {
  beforeAll(async () => {
    mocks = createMockManager();

    // Create upstream server
    upstream = mocks.add("upstream", createHTTPMock(MOCK_PORTS.HTTP_UPSTREAM_1));

    // Echo endpoint - returns what it receives
    upstream.post("/echo", async (req, url, logEntry) => ({
      body: {
        received: logEntry.body,
        headers: logEntry.headers,
      },
    }));

    // API endpoint with structured response
    upstream.get("/api/user", {
      body: {
        user_id: 123,
        first_name: "John",
        last_name: "Doe",
        email_address: "john@example.com",
        created_at: "2024-01-01T00:00:00Z",
        internal_field: "should-be-removed",
      },
    });

    // XML response endpoint
    upstream.get("/api/data", {
      body: `<?xml version="1.0"?><root><item>value</item></root>`,
      status: 200,
      headers: { "Content-Type": "application/xml" },
    });

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
    expect(body).toContain("transform");
  });

  // Tests to enable when transform module is implemented:
  //
  // test("transforms request body", async () => {
  //   const res = await fetch(`${TEST_URL}/api/transform`, {
  //     method: "POST",
  //     headers: { "Content-Type": "application/json" },
  //     body: JSON.stringify({
  //       userId: 123,
  //       firstName: "Jane",
  //     }),
  //   });
  //
  //   const body = await res.json();
  //   // Should transform camelCase to snake_case
  //   expect(body.received.user_id).toBe(123);
  //   expect(body.received.first_name).toBe("Jane");
  // });
  //
  // test("transforms response body", async () => {
  //   const res = await fetch(`${TEST_URL}/api/user`);
  //   const body = await res.json();
  //
  //   // Should transform snake_case to camelCase
  //   expect(body.userId).toBe(123);
  //   expect(body.firstName).toBe("John");
  //   expect(body.lastName).toBe("Doe");
  //   expect(body.emailAddress).toBe("john@example.com");
  // });
  //
  // test("removes specified fields from response", async () => {
  //   const res = await fetch(`${TEST_URL}/api/user`);
  //   const body = await res.json();
  //
  //   // Should remove internal field
  //   expect(body.internalField).toBeUndefined();
  // });
  //
  // test("adds headers to request", async () => {
  //   const res = await fetch(`${TEST_URL}/api/transform`, {
  //     method: "POST",
  //     body: JSON.stringify({}),
  //   });
  //
  //   const body = await res.json();
  //   expect(body.headers["x-added-header"]).toBe("value");
  // });
  //
  // test("converts XML to JSON", async () => {
  //   const res = await fetch(`${TEST_URL}/api/data`);
  //   expect(res.headers.get("content-type")).toContain("application/json");
  //
  //   const body = await res.json();
  //   expect(body.root.item).toBe("value");
  // });
  //
  // test("applies JSONPath transformation", async () => {
  //   const res = await fetch(`${TEST_URL}/api/user?fields=firstName,email`);
  //   const body = await res.json();
  //
  //   // Should only include requested fields
  //   expect(Object.keys(body)).toEqual(["firstName", "email"]);
  // });
});
