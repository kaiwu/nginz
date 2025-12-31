import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import {
  startNginz,
  stopNginz,
  cleanupRuntime,
  TEST_URL,
  createPostgresMock,
  MOCK_PORTS,
} from "../harness.js";

const MODULE = "pgrest";
let pgMock;

describe("pgrest module", () => {
  beforeAll(async () => {
    // Start PostgreSQL mock server
    pgMock = createPostgresMock(MOCK_PORTS.POSTGRES);

    // Default handler for SELECT * FROM users (no filters)
    pgMock.setQueryHandler(/^SELECT \* FROM users$/, (query) => ({
      columns: ["id", "name", "email", "status"],
      rows: [
        ["1", "John Doe", "john@example.com", "active"],
        ["2", "Jane Smith", "jane@example.com", "active"],
        ["3", "Bob Wilson", "bob@example.com", "inactive"],
      ],
    }));

    // Handler for SELECT with specific columns
    pgMock.setQueryHandler(/^SELECT id,name FROM users/, (query) => ({
      columns: ["id", "name"],
      rows: [
        ["1", "John Doe"],
        ["2", "Jane Smith"],
        ["3", "Bob Wilson"],
      ],
    }));

    // Handler for SELECT with status filter
    pgMock.setQueryHandler(/SELECT \* FROM users WHERE status = 'active'/, (query) => ({
      columns: ["id", "name", "email", "status"],
      rows: [
        ["1", "John Doe", "john@example.com", "active"],
        ["2", "Jane Smith", "jane@example.com", "active"],
      ],
    }));

    // Handler for SELECT with id filter
    pgMock.setQueryHandler(/SELECT \* FROM users WHERE id = '1'/, (query) => ({
      columns: ["id", "name", "email", "status"],
      rows: [["1", "John Doe", "john@example.com", "active"]],
    }));

    // Handler for SELECT with ORDER BY
    pgMock.setQueryHandler(/SELECT \* FROM users.*ORDER BY name ASC/, (query) => ({
      columns: ["id", "name", "email", "status"],
      rows: [
        ["3", "Bob Wilson", "bob@example.com", "inactive"],
        ["2", "Jane Smith", "jane@example.com", "active"],
        ["1", "John Doe", "john@example.com", "active"],
      ],
    }));

    // Handler for SELECT with LIMIT
    pgMock.setQueryHandler(/SELECT \* FROM users.*LIMIT 2/, (query) => ({
      columns: ["id", "name", "email", "status"],
      rows: [
        ["1", "John Doe", "john@example.com", "active"],
        ["2", "Jane Smith", "jane@example.com", "active"],
      ],
    }));

    // Handler for INSERT
    pgMock.setQueryHandler(/^INSERT INTO users/, (query) => ({
      columns: ["id", "name", "email", "status"],
      rows: [["4", "New User", "new@example.com", "active"]],
    }));

    // Handler for RPC: get_user_count
    pgMock.setQueryHandler(/SELECT get_user_count\(\)/, (query) => ({
      columns: ["get_user_count"],
      rows: [["3"]],
    }));

    // Handler for RPC: add_them
    pgMock.setQueryHandler(/SELECT add_them\(/, (query) => ({
      columns: ["add_them"],
      rows: [["3"]],
    }));

    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (pgMock) {
      pgMock.stop();
    }
    cleanupRuntime(MODULE);
  });

  // ============================================================================
  // Basic SELECT Tests
  // ============================================================================

  test("GET /api/users returns all users as JSON array", async () => {
    const res = await fetch(`${TEST_URL}/api/users`);
    expect(res.status).toBe(200);

    const contentType = res.headers.get("content-type");
    expect(contentType).toContain("application/json");

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(3);
    expect(body[0]).toHaveProperty("id");
    expect(body[0]).toHaveProperty("name");
    expect(body[0]).toHaveProperty("email");
  });

  test("GET /api/users with select parameter returns specified columns", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=id,name`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBeGreaterThan(0);

    // Should have id and name columns
    const firstRow = body[0];
    expect(firstRow).toHaveProperty("id");
    expect(firstRow).toHaveProperty("name");
  });

  // ============================================================================
  // Filter Tests (PostgREST-style)
  // ============================================================================

  test("GET /api/users with eq filter returns filtered results", async () => {
    const res = await fetch(`${TEST_URL}/api/users?status=eq.active`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(2);

    // All returned users should be active
    body.forEach((user) => {
      expect(user.status).toBe("active");
    });
  });

  test("GET /api/users with id filter returns single user", async () => {
    const res = await fetch(`${TEST_URL}/api/users?id=eq.1`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(1);
    expect(body[0].id).toBe("1");
    expect(body[0].name).toBe("John Doe");
  });

  // ============================================================================
  // Ordering Tests
  // ============================================================================

  test("GET /api/users with order parameter sorts results", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=name.asc`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBeGreaterThan(0);

    // First user should be Bob (alphabetically first)
    expect(body[0].name).toBe("Bob Wilson");
  });

  // ============================================================================
  // Pagination Tests
  // ============================================================================

  test("GET /api/users with limit parameter limits results", async () => {
    const res = await fetch(`${TEST_URL}/api/users?limit=2`);
    expect(res.status).toBe(200);

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(2);
  });

  // ============================================================================
  // INSERT Tests (POST)
  // ============================================================================

  test("POST /api/users inserts new user and returns result", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        name: "New User",
        email: "new@example.com",
        status: "active",
      }),
    });

    expect(res.status).toBe(200);

    const body = await res.json();
    // Response should be an array with the inserted row
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(1);
    expect(body[0]).toHaveProperty("id");
    expect(body[0].name).toBe("New User");
  });

  // ============================================================================
  // RPC Tests (Stored Procedures)
  // ============================================================================

  test("GET /rpc/get_user_count calls stored function", async () => {
    const res = await fetch(`${TEST_URL}/rpc/get_user_count`);
    expect(res.status).toBe(200);

    const body = await res.text();
    // Should return result containing count value
    expect(body).toContain("3");
  });

  test("POST /rpc/add_them with JSON body calls function with parameters", async () => {
    const res = await fetch(`${TEST_URL}/rpc/add_them`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ a: 1, b: 2 }),
    });

    expect(res.status).toBe(200);

    const body = await res.text();
    // add_them(1, 2) should return 3
    expect(body).toContain("3");
  });

  // ============================================================================
  // Health Check
  // ============================================================================

  test("GET /health returns OK", async () => {
    const res = await fetch(`${TEST_URL}/health`);
    expect(res.status).toBe(200);
    const body = await res.text();
    expect(body.trim()).toBe("OK");
  });
});
