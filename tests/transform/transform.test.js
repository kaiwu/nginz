import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  ensureBuild,
  startNginz,
  stopNginz,
  cleanupRuntime,
  createHTTPMock,
  MOCK_PORTS,
  TEST_URL,
} from "../harness.js";

const MODULE_NAME = "transform";

let httpMock;

beforeAll(async () => {
  ensureBuild();

  // Create mock backend that returns various JSON responses
  httpMock = createHTTPMock(MOCK_PORTS.HTTP);
  httpMock.setDefault((req) => {
    const url = new URL(req.url);

    if (url.pathname === "/nested") {
      return Response.json({
        status: "ok",
        data: {
          value: 42,
          name: "test"
        }
      });
    }

    if (url.pathname === "/with-array") {
      return Response.json({
        items: [
          { id: 1, name: "first" },
          { id: 2, name: "second" },
          { id: 3, name: "third" }
        ],
        total: 3
      });
    }

    if (url.pathname === "/text") {
      return new Response("plain text response", {
        headers: { "Content-Type": "text/plain" }
      });
    }

    return Response.json({ error: "not found" }, { status: 404 });
  });

  await startNginz(`tests/${MODULE_NAME}/nginx.conf`, MODULE_NAME);
});

afterAll(async () => {
  await stopNginz();
  httpMock?.stop();
  cleanupRuntime(MODULE_NAME);
});

describe("transform_response directive", () => {
  test("extracts nested object with $.data path", async () => {
    const res = await fetch(`${TEST_URL}/extract-object`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body).toEqual({ value: 42, name: "test" });
  });

  test("extracts array with $.items path", async () => {
    const res = await fetch(`${TEST_URL}/extract-array`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body).toBeArray();
    expect(body.length).toBe(3);
    expect(body[0]).toEqual({ id: 1, name: "first" });
  });

  test("extracts nested value with $.data.value path", async () => {
    const res = await fetch(`${TEST_URL}/extract-nested`);
    expect(res.status).toBe(200);
    const text = await res.text();
    // Parse as number since cJSON may add trailing characters
    expect(parseInt(text, 10)).toBe(42);
  });

  test("extracts array element with $.items.0 path", async () => {
    const res = await fetch(`${TEST_URL}/extract-element`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body).toEqual({ id: 1, name: "first" });
  });

  test("passes through response without transform directive", async () => {
    const res = await fetch(`${TEST_URL}/passthrough`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body).toEqual({
      status: "ok",
      data: { value: 42, name: "test" }
    });
  });

  test("passes through when path does not exist", async () => {
    const res = await fetch(`${TEST_URL}/invalid-path`);
    expect(res.status).toBe(200);
    const body = await res.json();
    // Original response passed through on transform failure
    expect(body).toEqual({
      status: "ok",
      data: { value: 42, name: "test" }
    });
  });

  test("passes through non-JSON responses", async () => {
    const res = await fetch(`${TEST_URL}/non-json`);
    expect(res.status).toBe(200);
    const text = await res.text();
    expect(text).toBe("plain text response");
  });
});
