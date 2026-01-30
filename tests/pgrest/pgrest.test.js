import { describe, test, expect, beforeAll, afterAll, beforeEach } from "bun:test";
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

    // Handler for SELECT with single column (name)
    pgMock.setQueryHandler(/^SELECT name FROM users/, (query) => ({
      columns: ["name"],
      rows: [
        ["John Doe"],
        ["Jane Smith"],
        ["Bob Wilson"],
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
  // Content Negotiation (Accept Header) Tests
  // ============================================================================

  test("GET /api/users with Accept: text/csv returns CSV format", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      headers: { Accept: "text/csv" },
    });
    expect(res.status).toBe(200);

    const contentType = res.headers.get("content-type");
    expect(contentType).toContain("text/csv");

    const body = await res.text();
    // CSV should have header row and data rows
    const lines = body.trim().split("\n");
    expect(lines.length).toBeGreaterThan(1);
    // Header row should contain column names
    expect(lines[0]).toContain("id");
    expect(lines[0]).toContain("name");
  });

  test("GET /api/users with Accept: text/xml returns XML format", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      headers: { Accept: "text/xml" },
    });
    expect(res.status).toBe(200);

    const contentType = res.headers.get("content-type");
    expect(contentType).toContain("text/xml");

    const body = await res.text();
    // XML should have root element and row elements
    expect(body).toContain("<?xml");
    expect(body).toContain("<root>");
    expect(body).toContain("<row>");
    expect(body).toContain("</root>");
  });

  test("GET /api/users with Accept: text/plain returns plain text", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=name`, {
      headers: { Accept: "text/plain" },
    });
    expect(res.status).toBe(200);

    const contentType = res.headers.get("content-type");
    expect(contentType).toContain("text/plain");
  });

  test("GET /api/users with Accept: application/json returns JSON (default)", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      headers: { Accept: "application/json" },
    });
    expect(res.status).toBe(200);

    const contentType = res.headers.get("content-type");
    expect(contentType).toContain("application/json");

    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
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

  // ============================================================================
  // JWT Role-Based Access Control Tests
  // ============================================================================

  describe("JWT role-based access", () => {
    // Helper to create a HS256 JWT
    function createJwt(payload, secret) {
      const header = { alg: "HS256", typ: "JWT" };
      const b64Header = Buffer.from(JSON.stringify(header)).toString("base64url");
      const b64Payload = Buffer.from(JSON.stringify(payload)).toString("base64url");
      const data = `${b64Header}.${b64Payload}`;

      // Create HMAC-SHA256 signature
      const crypto = require("crypto");
      const signature = crypto
        .createHmac("sha256", secret)
        .update(data)
        .digest("base64url");

      return `${data}.${signature}`;
    }

    const JWT_SECRET = "test-secret-key-for-hs256-jwt";

    beforeEach(() => {
      // Clear tracking between tests
      pgMock.clearTracking();

      // Handler for jwt-api/users endpoint
      pgMock.setQueryHandler(/^SELECT \* FROM users$/, (query) => ({
        columns: ["id", "name", "role"],
        rows: [["1", "Test User", "authenticated"]],
      }));
    });

    test("valid JWT with role claim sets PostgreSQL role", async () => {
      const jwt = createJwt(
        { sub: "user123", role: "authenticated_user", exp: Math.floor(Date.now() / 1000) + 3600 },
        JWT_SECRET
      );

      const res = await fetch(`${TEST_URL}/jwt-api/users`, {
        headers: { Authorization: `Bearer ${jwt}` },
      });
      expect(res.status).toBe(200);

      // Check that SET ROLE was called with the role from JWT
      expect(pgMock.getLastSetRole()).toBe("authenticated_user");
    });

    test("valid JWT without role claim uses anon_role", async () => {
      const jwt = createJwt(
        { sub: "user123", exp: Math.floor(Date.now() / 1000) + 3600 },
        JWT_SECRET
      );

      const res = await fetch(`${TEST_URL}/jwt-api/users`, {
        headers: { Authorization: `Bearer ${jwt}` },
      });
      expect(res.status).toBe(200);

      // Should fall back to anon role since no role claim in JWT
      expect(pgMock.getLastSetRole()).toBe("anon");
    });

    test("invalid JWT signature uses anon_role", async () => {
      const jwt = createJwt(
        { sub: "user123", role: "admin", exp: Math.floor(Date.now() / 1000) + 3600 },
        "wrong-secret-key" // Different secret = invalid signature
      );

      const res = await fetch(`${TEST_URL}/jwt-api/users`, {
        headers: { Authorization: `Bearer ${jwt}` },
      });
      expect(res.status).toBe(200);

      // Should use anon role since JWT signature is invalid
      expect(pgMock.getLastSetRole()).toBe("anon");
    });

    test("missing JWT uses anon_role", async () => {
      const res = await fetch(`${TEST_URL}/jwt-api/users`);
      expect(res.status).toBe(200);

      // Should use anon role since no JWT provided
      expect(pgMock.getLastSetRole()).toBe("anon");
    });

    test("JWT is passed to PostgreSQL via request.jwt claim", async () => {
      const jwt = createJwt(
        { sub: "user123", role: "authenticated_user", exp: Math.floor(Date.now() / 1000) + 3600 },
        JWT_SECRET
      );

      const res = await fetch(`${TEST_URL}/jwt-api/users`, {
        headers: { Authorization: `Bearer ${jwt}` },
      });
      expect(res.status).toBe(200);

      // Check that the JWT was also set as request.jwt
      expect(pgMock.getLastSetJwt()).toBe(jwt);
    });
  });
});
