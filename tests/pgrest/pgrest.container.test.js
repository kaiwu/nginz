import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "pgrest";
const PG_CONTAINER = "pg18";
const PG_USER = "nginz_test";
const PG_PASSWORD = "nginz_test_pass";
const PG_DB = "nginz_test";

// ---------------------------------------------------------------------------
// Shell helpers
// ---------------------------------------------------------------------------

function runResult(command) {
  const result = Bun.spawnSync(command, {
    stdout: "pipe",
    stderr: "pipe",
    cwd: process.cwd(),
    env: process.env,
  });
  return {
    exitCode: result.exitCode,
    stdout: result.stdout ? Buffer.from(result.stdout).toString() : "",
    stderr: result.stderr ? Buffer.from(result.stderr).toString() : "",
  };
}

function run(command) {
  const result = runResult(command);
  if (result.exitCode !== 0) {
    throw new Error(`Command failed: ${command.join(" ")}\n${result.stdout}${result.stderr}`.trim());
  }
  return result;
}

function ensureContainerRunning(name) {
  const result = runResult(["sudo", "docker", "inspect", "--format", "{{.State.Running}}", name]);
  if (result.exitCode !== 0 || !result.stdout.trim().includes("true")) {
    throw new Error(`Container ${name} is not running. Start it before running container tests.`);
  }
}

// Run SQL as the postgres superuser (trust from inside the container).
function psqlAdmin(sql) {
  const result = Bun.spawnSync(
    ["sudo", "docker", "exec", "-i", PG_CONTAINER, "psql", "-U", "postgres"],
    { stdout: "pipe", stderr: "pipe", stdin: Buffer.from(sql) }
  );
  const stdout = result.stdout ? Buffer.from(result.stdout).toString() : "";
  const stderr = result.stderr ? Buffer.from(result.stderr).toString() : "";
  if (result.exitCode !== 0) {
    throw new Error(`psqlAdmin failed:\n${stdout}${stderr}`);
  }
  return stdout;
}

// Run SQL as the test user against the test database.
function psqlDb(sql) {
  const result = Bun.spawnSync(
    ["sudo", "docker", "exec", "-i", PG_CONTAINER, "psql", "-U", PG_USER, "-d", PG_DB],
    { stdout: "pipe", stderr: "pipe", stdin: Buffer.from(sql) }
  );
  const stdout = result.stdout ? Buffer.from(result.stdout).toString() : "";
  const stderr = result.stderr ? Buffer.from(result.stderr).toString() : "";
  if (result.exitCode !== 0) {
    throw new Error(`psqlDb failed:\n${stdout}${stderr}`);
  }
  return stdout;
}

// ---------------------------------------------------------------------------
// Schema and seed data
// ---------------------------------------------------------------------------

const SETUP_SQL = `
CREATE TABLE users (
    id     SERIAL PRIMARY KEY,
    name   TEXT   NOT NULL,
    email  TEXT   UNIQUE NOT NULL,
    status TEXT   NOT NULL DEFAULT 'active',
    age    INTEGER,
    bio    TEXT
);

CREATE TABLE orders (
    id         SERIAL PRIMARY KEY,
    user_id    INTEGER REFERENCES users(id) ON DELETE CASCADE,
    amount     DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO users (name, email, status, age, bio) VALUES
    ('Alice Smith', 'alice@example.com', 'active',   30, 'Engineer'),
    ('Bob Jones',   'bob@example.com',   'active',   25, 'Designer'),
    ('Carol White', 'carol@example.com', 'inactive', 17, NULL),
    ('Dave Brown',  'dave@example.com',  'active',   45, NULL),
    ('Eve Davis',   'eve@example.com',   'inactive', 22, NULL);

INSERT INTO orders (user_id, amount, order_date) VALUES
    (1, 100.00, '2023-01-01'),
    (1, 200.00, '2023-01-02'),
    (2, 150.00, '2023-01-01'),
    (3,  50.00, '2023-01-02'),
    (4, 300.00, '2023-01-03');

CREATE OR REPLACE FUNCTION get_user_count()
RETURNS BIGINT LANGUAGE SQL STABLE AS $func$
    SELECT COUNT(*) FROM users;
$func$;

CREATE OR REPLACE FUNCTION add_them(a INTEGER, b INTEGER)
RETURNS INTEGER LANGUAGE SQL IMMUTABLE AS $func$
    SELECT a + b;
$func$;
`;

// ---------------------------------------------------------------------------
// Suite
// ---------------------------------------------------------------------------

describe("pgrest module - real PostgreSQL 18 integration", () => {
  beforeAll(async () => {
    ensureContainerRunning(PG_CONTAINER);

    // Create test user and database
    psqlAdmin(`CREATE USER ${PG_USER} WITH PASSWORD '${PG_PASSWORD}';`);
    run(["sudo", "docker", "exec", PG_CONTAINER, "createdb", "-U", "postgres", `--owner=${PG_USER}`, PG_DB]);
    psqlDb(SETUP_SQL);

    await startNginz(`tests/${MODULE}/nginx.container.conf`, MODULE);
  }, 60000);

  afterAll(async () => {
    await stopNginz();

    try { run(["sudo", "docker", "exec", PG_CONTAINER, "dropdb", "-U", "postgres", "--if-exists", PG_DB]); } catch {}
    try { psqlAdmin(`DROP USER IF EXISTS ${PG_USER};`); } catch {}

    cleanupRuntime(MODULE);
  }, 30000);

  // =========================================================================
  // Basic reads
  // =========================================================================

  test("GET /api/users returns all 5 seed users as JSON array", async () => {
    const res = await fetch(`${TEST_URL}/api/users`);
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toContain("application/json");
    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(5);
    expect(body[0]).toHaveProperty("id");
    expect(body[0]).toHaveProperty("name");
    expect(body[0]).toHaveProperty("email");
    expect(body[0]).toHaveProperty("status");
  });

  test("GET /api/users with select=id,name returns only those columns", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=id,name`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(5);
    const keys = Object.keys(body[0]);
    expect(keys).toContain("id");
    expect(keys).toContain("name");
    expect(keys).not.toContain("email");
    expect(keys).not.toContain("status");
  });

  // =========================================================================
  // Filtering operators
  // =========================================================================

  test("GET /api/users with eq filter returns only active users", async () => {
    const res = await fetch(`${TEST_URL}/api/users?status=eq.active`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(3); // Alice, Bob, Dave
    body.forEach((row) => expect(row.status).toBe("active"));
  });

  test("GET /api/users with neq filter excludes active users", async () => {
    const res = await fetch(`${TEST_URL}/api/users?status=neq.active`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(2); // Carol, Eve
    body.forEach((row) => expect(row.status).not.toBe("active"));
  });

  test("GET /api/users with gt filter returns users with age > 25", async () => {
    const res = await fetch(`${TEST_URL}/api/users?age=gt.25`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(2); // Alice (30), Dave (45)
    body.forEach((row) => expect(Number(row.age)).toBeGreaterThan(25));
  });

  test("GET /api/users with gte filter returns users with age >= 25", async () => {
    const res = await fetch(`${TEST_URL}/api/users?age=gte.25`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(3); // Alice (30), Bob (25), Dave (45)
    body.forEach((row) => expect(Number(row.age)).toBeGreaterThanOrEqual(25));
  });

  test("GET /api/users with lt filter returns users with age < 25", async () => {
    const res = await fetch(`${TEST_URL}/api/users?age=lt.25`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(2); // Carol (17), Eve (22)
    body.forEach((row) => expect(Number(row.age)).toBeLessThan(25));
  });

  test("GET /api/users with lte filter returns users with age <= 22", async () => {
    const res = await fetch(`${TEST_URL}/api/users?age=lte.22`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(2); // Carol (17), Eve (22)
    body.forEach((row) => expect(Number(row.age)).toBeLessThanOrEqual(22));
  });

  test("GET /api/users with in filter matches multiple values", async () => {
    const res = await fetch(`${TEST_URL}/api/users?status=in.(active,inactive)`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(5);
  });

  test("GET /api/users with like filter uses wildcard matching", async () => {
    const res = await fetch(`${TEST_URL}/api/users?name=like.Alice*`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(1);
    expect(body[0].name).toBe("Alice Smith");
  });

  test("GET /api/users with ilike filter is case-insensitive", async () => {
    const res = await fetch(`${TEST_URL}/api/users?name=ilike.bob*`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(1);
    expect(body[0].name).toBe("Bob Jones");
  });

  // =========================================================================
  // Ordering and pagination
  // =========================================================================

  test("GET /api/users with order=name.asc returns names in ascending order", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=name.asc`);
    expect(res.status).toBe(200);
    const body = await res.json();
    const names = body.map((r) => r.name);
    expect(names).toEqual([...names].sort());
  });

  test("GET /api/users with order=age.desc returns ages in descending order", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=age.desc`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body[0].name).toBe("Dave Brown"); // 45
    expect(body[1].name).toBe("Alice Smith"); // 30
  });

  test("GET /api/users with limit=2 returns exactly 2 rows", async () => {
    const res = await fetch(`${TEST_URL}/api/users?limit=2`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(2);
  });

  test("GET /api/users with limit and offset returns correct page", async () => {
    const allRes = await fetch(`${TEST_URL}/api/users?order=id.asc`);
    const allUsers = await allRes.json();

    const pageRes = await fetch(`${TEST_URL}/api/users?order=id.asc&limit=2&offset=2`);
    expect(pageRes.status).toBe(200);
    const page = await pageRes.json();
    expect(page.length).toBe(2);
    expect(page[0].id).toBe(allUsers[2].id);
    expect(page[1].id).toBe(allUsers[3].id);
  });

  // =========================================================================
  // Response format negotiation
  // =========================================================================

  test("GET /api/users with Accept: text/csv returns CSV response", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=id.asc&limit=1`, {
      headers: { Accept: "text/csv" },
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toContain("text/csv");
    const text = await res.text();
    const lines = text.trim().split("\n");
    expect(lines.length).toBeGreaterThanOrEqual(2);
    expect(lines[0]).toContain("id");
    expect(lines[0]).toContain("name");
    expect(lines[1]).toContain("Alice Smith");
  });

  test("GET /api/users with unknown Accept returns 406", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      headers: { Accept: "application/vnd.unknown+format" },
    });
    expect(res.status).toBe(406);
  });

  test("HEAD /api/users returns headers without body", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, { method: "HEAD" });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toContain("application/json");
    const text = await res.text();
    expect(text).toBe("");
  });

  // =========================================================================
  // Range headers and count pagination (Batch 8)
  // =========================================================================

  test("GET /api/users with Range: 1-2 returns slice with Content-Range header", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=id.asc`, {
      headers: { "Range-Unit": "items", Range: "1-2" },
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("range-unit")).toBe("items");
    expect(res.headers.get("content-range")).toBe("1-2/*");
    const body = await res.json();
    expect(body.length).toBe(2);
  });

  test("GET /api/users with Prefer: count=exact returns 206 with total in Content-Range", async () => {
    const res = await fetch(`${TEST_URL}/api/users?limit=2`, {
      headers: { Prefer: "count=exact" },
    });
    expect(res.status).toBe(206);
    expect(res.headers.get("range-unit")).toBe("items");
    expect(res.headers.get("content-range")).toBe("0-1/5");
    expect(res.headers.get("preference-applied")).toContain("count=exact");
    const body = await res.json();
    expect(body.length).toBe(2);
  });

  // =========================================================================
  // RPC calls (Batch 7)
  // =========================================================================

  test("GET /rpc/get_user_count invokes STABLE function and returns count of 5", async () => {
    const res = await fetch(`${TEST_URL}/rpc/get_user_count`);
    expect(res.status).toBe(200);
    const text = await res.text();
    expect(text).toContain("5");
  });

  test("POST /rpc/add_them with JSON body returns sum of two integers", async () => {
    const res = await fetch(`${TEST_URL}/rpc/add_them`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ a: 3, b: 4 }),
    });
    expect(res.status).toBe(200);
    const text = await res.text();
    expect(text).toContain("7");
  });

  test("POST /rpc/add_them with form-urlencoded body returns sum", async () => {
    const res = await fetch(`${TEST_URL}/rpc/add_them`, {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "a=10&b=20",
    });
    expect(res.status).toBe(200);
    const text = await res.text();
    expect(text).toContain("30");
  });

  // =========================================================================
  // Aggregate functions (Batch 9)
  // =========================================================================

  test("GET /api/users with select=count() returns row count aggregate", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=count()`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(1);
    expect(Number(body[0].count)).toBe(5);
  });

  test("GET /api/orders with grouped sum aggregate returns per-date totals", async () => {
    const res = await fetch(`${TEST_URL}/api/orders?select=amount.sum(),order_date&order=order_date.asc`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(Array.isArray(body)).toBe(true);
    expect(body.length).toBe(3); // 3 distinct order dates
    // 2023-01-01: 100 + 150 = 250
    expect(Number(body[0].sum)).toBe(250);
    expect(body[0].order_date).toBe("2023-01-01");
    // 2023-01-03: 300
    expect(Number(body[2].sum)).toBe(300);
  });

  // =========================================================================
  // Write operations — each test is self-contained and cleans up
  // =========================================================================

  test("POST /api/users with return=representation inserts row and returns it", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "New User", email: "newuser@example.com", status: "active", age: 28 }),
    });
    expect(res.status).toBe(201);
    const rows = await res.json();
    expect(rows[0].name).toBe("New User");
    expect(rows[0].email).toBe("newuser@example.com");
    expect(rows[0]).toHaveProperty("id");

    // Cleanup
    await fetch(`${TEST_URL}/api/users?id=eq.${rows[0].id}`, { method: "DELETE" });
  });

  test("POST /api/users with return=minimal returns empty body", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=minimal" },
      body: JSON.stringify({ name: "Minimal User", email: "minimal@example.com", status: "active", age: 31 }),
    });
    expect(res.status).toBe(201);
    const text = await res.text();
    expect(text).toBe("");

    // Cleanup via psql since we have no returned ID
    psqlDb("DELETE FROM users WHERE email = 'minimal@example.com';");
  });

  test("POST /api/users with return=headers-only returns Location header without body", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=headers-only" },
      body: JSON.stringify({ name: "Headers Only", email: "headersonly@example.com", status: "inactive", age: 26 }),
    });
    expect(res.status).toBe(201);
    const text = await res.text();
    expect(text).toBe("");

    // Cleanup
    psqlDb("DELETE FROM users WHERE email = 'headersonly@example.com';");
  });

  test("PATCH /api/users updates a row and returns updated data", async () => {
    const insertRes = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "Patch Target", email: "patchtarget@example.com", status: "active", age: 35 }),
    });
    const inserted = await insertRes.json();
    const id = inserted[0].id;

    const patchRes = await fetch(`${TEST_URL}/api/users?id=eq.${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ status: "inactive" }),
    });
    expect(patchRes.status).toBe(200);
    const updated = await patchRes.json();
    expect(updated[0].status).toBe("inactive");
    expect(updated[0].name).toBe("Patch Target");

    // Cleanup
    await fetch(`${TEST_URL}/api/users?id=eq.${id}`, { method: "DELETE" });
  });

  test("DELETE /api/users removes the matching row", async () => {
    const insertRes = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "Delete Target", email: "deletetarget@example.com", status: "active", age: 40 }),
    });
    const inserted = await insertRes.json();
    const id = inserted[0].id;

    const delRes = await fetch(`${TEST_URL}/api/users?id=eq.${id}`, { method: "DELETE" });
    expect(delRes.status).toBe(200);

    const check = await fetch(`${TEST_URL}/api/users?id=eq.${id}`);
    const rows = await check.json();
    expect(rows.length).toBe(0);
  });

  test("bulk POST /api/users inserts multiple rows from JSON array", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify([
        { name: "Bulk A", email: "bulk-a@example.com", status: "active", age: 20 },
        { name: "Bulk B", email: "bulk-b@example.com", status: "inactive", age: 21 },
      ]),
    });
    expect(res.status).toBe(201);
    const rows = await res.json();
    expect(rows.length).toBe(2);
    expect(rows[0].name).toBe("Bulk A");
    expect(rows[1].name).toBe("Bulk B");

    // Cleanup
    await fetch(`${TEST_URL}/api/users?email=in.(bulk-a@example.com,bulk-b@example.com)`, { method: "DELETE" });
  });

  // =========================================================================
  // Null handling and logical operators
  // =========================================================================

  test("GET /api/users with is.null filter returns rows where bio is null", async () => {
    const res = await fetch(`${TEST_URL}/api/users?bio=is.null`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(3); // Carol, Dave, Eve have null bio
    body.forEach((row) => expect(row.bio).toBeNull());
  });

  test("GET /api/users with not.like filter excludes matching names", async () => {
    const res = await fetch(`${TEST_URL}/api/users?name=not.like.Alice*`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(4);
    body.forEach((row) => expect(row.name).not.toContain("Alice"));
  });

  test("GET /api/users with or() filter matches either condition", async () => {
    // bio=Engineer (Alice) OR status=inactive (Carol, Eve)
    const res = await fetch(`${TEST_URL}/api/users?or=(bio.eq.Engineer,status.eq.inactive)`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(3); // Alice, Carol, Eve
  });

  // =========================================================================
  // Column projection: aliasing and casting
  // =========================================================================

  test("GET /api/users with alias:col in select renames the JSON key", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=user_name:name&order=id.asc&limit=1`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body[0]).toHaveProperty("user_name");
    expect(body[0].user_name).toBe("Alice Smith");
    expect(body[0]).not.toHaveProperty("name");
  });

  test("GET /api/users with col::text cast returns the value as text", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=age::text&order=id.asc&limit=1`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body[0]).toHaveProperty("age");
    expect(body[0].age).toBe("30");
  });

  // =========================================================================
  // Additional response formats
  // =========================================================================

  test("GET /api/users with Accept: text/xml returns XML-structured response", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=id.asc&limit=1`, {
      headers: { Accept: "text/xml" },
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toContain("text/xml");
    const text = await res.text();
    expect(text).toContain("<?xml");
    expect(text).toContain("<root>");
    expect(text).toContain("<row>");
    expect(text).toContain("Alice Smith");
  });

  test("GET /api/users with Accept: text/plain returns newline-separated values", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=name&order=id.asc&limit=2`, {
      headers: { Accept: "text/plain" },
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("content-type")).toContain("text/plain");
    const text = await res.text();
    expect(text).toContain("Alice Smith");
    expect(text).toContain("Bob Jones");
  });

  // =========================================================================
  // Schema profile headers
  // =========================================================================

  test("GET /api/users with Accept-Profile: public uses the allowed schema", async () => {
    const res = await fetch(`${TEST_URL}/api/users?order=id.asc&limit=1`, {
      headers: { "Accept-Profile": "public" },
    });
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(1);
  });

  test("GET /api/users with disallowed Accept-Profile returns PGRST106 error", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      headers: { "Accept-Profile": "secret_schema" },
    });
    expect(res.status).toBe(406);
    const body = await res.json();
    expect(body.code).toBe("PGRST106");
  });

  test("POST /api/users with disallowed Content-Profile returns PGRST106 error", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", "Content-Profile": "secret_schema" },
      body: JSON.stringify({ name: "X", email: "x@x.com" }),
    });
    expect(res.status).toBe(406);
    const body = await res.json();
    expect(body.code).toBe("PGRST106");
  });

  // =========================================================================
  // Singular object semantics (application/vnd.pgrst.object+json)
  // =========================================================================

  test("pgrst.object+json with exactly one matching row returns a JSON object", async () => {
    const res = await fetch(`${TEST_URL}/api/users?email=eq.alice@example.com`, {
      headers: { Accept: "application/vnd.pgrst.object+json" },
    });
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(Array.isArray(body)).toBe(false);
    expect(body.name).toBe("Alice Smith");
    expect(res.headers.get("content-range")).toBe("0-0/*");
  });

  test("pgrst.object+json with zero matching rows returns 406", async () => {
    const res = await fetch(`${TEST_URL}/api/users?email=eq.nobody@example.com`, {
      headers: { Accept: "application/vnd.pgrst.object+json" },
    });
    expect(res.status).toBe(406);
    const body = await res.json();
    expect(body.message).toContain("JSON object requested");
  });

  test("pgrst.object+json with multiple matching rows returns 406", async () => {
    const res = await fetch(`${TEST_URL}/api/users?status=eq.active`, {
      headers: { Accept: "application/vnd.pgrst.object+json" },
    });
    expect(res.status).toBe(406);
    const body = await res.json();
    expect(body.message).toContain("JSON object requested");
  });

  test("nulls=stripped removes null fields from JSON array results", async () => {
    // Alice and Bob have non-null bio; Carol has null bio
    const res = await fetch(`${TEST_URL}/api/users?select=name,bio&email=eq.carol@example.com`, {
      headers: { Accept: "application/vnd.pgrst.array+json;nulls=stripped" },
    });
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body[0]).toHaveProperty("name");
    expect(body[0]).not.toHaveProperty("bio"); // null stripped
  });

  test("pgrst.object+json;nulls=stripped combines singular and stripped semantics", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=name,bio&email=eq.carol@example.com`, {
      headers: { Accept: "application/vnd.pgrst.object+json;nulls=stripped" },
    });
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(Array.isArray(body)).toBe(false);
    expect(body).toHaveProperty("name");
    expect(body).not.toHaveProperty("bio");
  });

  // =========================================================================
  // Null-aware ordering (nullsfirst / nullslast)
  // =========================================================================

  test("GET /api/users with order=bio.asc.nullsfirst puts null bios first", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=name,bio&order=bio.asc.nullsfirst`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body[0].bio).toBeNull();
    expect(body[1].bio).toBeNull();
    expect(body[2].bio).toBeNull();
    expect(body[3].bio).not.toBeNull();
    expect(body[4].bio).not.toBeNull();
  });

  test("GET /api/users with order=bio.asc.nullslast puts null bios last", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=name,bio&order=bio.asc.nullslast`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body[0].bio).toBe("Designer"); // Bob
    expect(body[1].bio).toBe("Engineer"); // Alice
    expect(body[2].bio).toBeNull();
    expect(body[3].bio).toBeNull();
    expect(body[4].bio).toBeNull();
  });

  // =========================================================================
  // More aggregate functions
  // =========================================================================

  test("GET /api/users with min and max aggregates returns bounds of seed data", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=age.min(),age.max()`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(1);
    expect(Number(body[0].min)).toBe(17); // Carol
    expect(Number(body[0].max)).toBe(45); // Dave
  });

  test("GET /api/users with avg aggregate returns mean of seed ages", async () => {
    const res = await fetch(`${TEST_URL}/api/users?select=age.avg()`);
    expect(res.status).toBe(200);
    const body = await res.json();
    expect(body.length).toBe(1);
    // (30 + 25 + 17 + 45 + 22) / 5 = 27.8
    expect(Number(body[0].avg)).toBeCloseTo(27.8, 0);
  });

  // =========================================================================
  // Prefer: handling=strict / lenient
  // =========================================================================

  test("Prefer: handling=strict rejects unknown preference before any SQL", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Prefer: "handling=strict, unknown-preference",
      },
      body: JSON.stringify({ name: "Strict User", email: "strict@example.com" }),
    });
    expect(res.status).toBe(400);
    const body = await res.json();
    expect(body.message).toContain("Invalid Prefer header");
    // Verify no row was inserted
    const check = await fetch(`${TEST_URL}/api/users?email=eq.strict@example.com`);
    expect((await check.json()).length).toBe(0);
  });

  test("Prefer: handling=lenient ignores unknown preference and proceeds normally", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Prefer: "handling=lenient, unknown-preference, return=representation",
      },
      body: JSON.stringify({ name: "Lenient User", email: "lenient@example.com", status: "active", age: 29 }),
    });
    expect(res.status).toBe(201);
    const rows = await res.json();
    expect(rows[0].name).toBe("Lenient User");
    await fetch(`${TEST_URL}/api/users?id=eq.${rows[0].id}`, { method: "DELETE" });
  });

  // =========================================================================
  // Prefer: max-affected enforcement
  // =========================================================================

  test("Prefer: max-affected=1 emits Preference-Applied when limit is not exceeded", async () => {
    const insertRes = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "MaxAffect Target", email: "maxaffect@example.com", status: "pending", age: 25 }),
    });
    const inserted = await insertRes.json();
    const id = inserted[0].id;

    const res = await fetch(`${TEST_URL}/api/users?id=eq.${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", Prefer: "max-affected=1" },
      body: JSON.stringify({ status: "active" }),
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("preference-applied")).toContain("max-affected=1");

    await fetch(`${TEST_URL}/api/users?id=eq.${id}`, { method: "DELETE" });
  });

  test("Prefer: max-affected=1 returns 400 when more rows would be affected", async () => {
    const emails = ["maxo1@example.com", "maxo2@example.com", "maxo3@example.com"];
    for (const email of emails) {
      await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name: "Overflow", email, status: "overflow_test", age: 20 }),
      });
    }

    const res = await fetch(`${TEST_URL}/api/users?status=eq.overflow_test`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", Prefer: "max-affected=1" },
      body: JSON.stringify({ age: 99 }),
    });
    expect(res.status).toBe(400);
    const body = await res.json();
    expect(body.message).toContain("max-affected");

    // Cleanup regardless — module may have executed the SQL before rejecting
    psqlDb(`DELETE FROM users WHERE email IN ('${emails.join("','")}');`);
  });

  // =========================================================================
  // Prefer: count=planned / count=estimated
  // =========================================================================

  test("Prefer: count=planned returns 206 with Content-Range total", async () => {
    const res = await fetch(`${TEST_URL}/api/users?limit=2`, {
      headers: { Prefer: "count=planned" },
    });
    expect(res.status).toBe(206);
    expect(res.headers.get("range-unit")).toBe("items");
    expect(res.headers.get("preference-applied")).toContain("count=planned");
    expect(res.headers.get("content-range")).toMatch(/^0-1\/\d+$/);
  });

  test("Prefer: count=estimated returns 206 with Content-Range total", async () => {
    const res = await fetch(`${TEST_URL}/api/users?limit=2`, {
      headers: { Prefer: "count=estimated" },
    });
    expect(res.status).toBe(206);
    expect(res.headers.get("range-unit")).toBe("items");
    expect(res.headers.get("preference-applied")).toContain("count=estimated");
    expect(res.headers.get("content-range")).toMatch(/^0-1\/\d+$/);
  });

  // =========================================================================
  // Upsert semantics
  // =========================================================================

  test("PUT /api/users with non-existent id inserts a new row", async () => {
    const res = await fetch(`${TEST_URL}/api/users?id=eq.9999`, {
      method: "PUT",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ id: 9999, name: "Put User", email: "putuser@example.com", status: "active", age: 28 }),
    });
    expect(res.status).toBe(200);
    const rows = await res.json();
    expect(rows[0].id).toBe("9999");
    expect(rows[0].name).toBe("Put User");

    await fetch(`${TEST_URL}/api/users?id=eq.9999`, { method: "DELETE" });
  });

  test("PUT /api/users with existing id updates the row", async () => {
    const insertRes = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "Put Target", email: "puttarget@example.com", status: "active", age: 30 }),
    });
    const inserted = await insertRes.json();
    const id = Number(inserted[0].id);

    const res = await fetch(`${TEST_URL}/api/users?id=eq.${id}`, {
      method: "PUT",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ id, name: "Put Updated", email: "puttarget@example.com", status: "inactive", age: 31 }),
    });
    expect(res.status).toBe(200);
    const rows = await res.json();
    expect(rows[0].name).toBe("Put Updated");
    expect(rows[0].status).toBe("inactive");

    await fetch(`${TEST_URL}/api/users?id=eq.${id}`, { method: "DELETE" });
  });

  test("POST with resolution=merge-duplicates upserts on email conflict", async () => {
    const insertRes = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "Conflict Original", email: "conflict@example.com", status: "active", age: 30 }),
    });
    const original = await insertRes.json();
    const id = original[0].id;

    const upsertRes = await fetch(`${TEST_URL}/api/users?on_conflict=email`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Prefer: "resolution=merge-duplicates, return=representation",
      },
      body: JSON.stringify({ name: "Conflict Updated", email: "conflict@example.com", status: "inactive", age: 31 }),
    });
    expect(upsertRes.status).toBe(201);
    const upserted = await upsertRes.json();
    expect(upserted[0].name).toBe("Conflict Updated");
    expect(upserted[0].email).toBe("conflict@example.com");

    await fetch(`${TEST_URL}/api/users?id=eq.${id}`, { method: "DELETE" });
  });

  // =========================================================================
  // CSV body insert
  // =========================================================================

  test("POST /api/users with text/csv body inserts rows from CSV", async () => {
    const csvBody = "name,email,status,age\nCsv User,csvuser@example.com,active,27";
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "text/csv", Prefer: "return=representation" },
      body: csvBody,
    });
    expect(res.status).toBe(201);
    const rows = await res.json();
    expect(rows[0].name).toBe("Csv User");
    expect(rows[0].email).toBe("csvuser@example.com");

    await fetch(`${TEST_URL}/api/users?id=eq.${rows[0].id}`, { method: "DELETE" });
  });

  // =========================================================================
  // Prefer: missing=default
  // =========================================================================

  test("POST /api/users with missing=default uses column DEFAULT for omitted fields", async () => {
    const res = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Prefer: "missing=default, return=representation",
      },
      body: JSON.stringify({ name: "Default Status", email: "defstatus@example.com", age: 25 }),
    });
    expect(res.status).toBe(201);
    const rows = await res.json();
    expect(rows[0].status).toBe("active"); // column DEFAULT
    expect(rows[0].name).toBe("Default Status");

    await fetch(`${TEST_URL}/api/users?id=eq.${rows[0].id}`, { method: "DELETE" });
  });

  // =========================================================================
  // Limited writes (CTE-based PATCH and DELETE)
  // =========================================================================

  test("PATCH with limit=1 and order updates only one row via CTE", async () => {
    const emailA = "limitpatch-a@example.com";
    const emailB = "limitpatch-b@example.com";

    for (const [name, email] of [["Limit A", emailA], ["Limit B", emailB]]) {
      await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name, email, status: "draft", age: 20 }),
      });
    }

    const patchRes = await fetch(`${TEST_URL}/api/users?status=eq.draft&limit=1&order=id.asc`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ status: "done" }),
    });
    expect(patchRes.status).toBe(200);
    const patched = await patchRes.json();
    expect(patched.length).toBe(1);
    expect(patched[0].email).toBe(emailA); // lower id → patched first

    psqlDb(`DELETE FROM users WHERE email IN ('${emailA}','${emailB}');`);
  });

  test("DELETE with limit=1 and order removes only one row via CTE", async () => {
    const emailA = "limitdel-a@example.com";
    const emailB = "limitdel-b@example.com";

    for (const [name, email] of [["Del A", emailA], ["Del B", emailB]]) {
      await fetch(`${TEST_URL}/api/users`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ name, email, status: "todelete", age: 20 }),
      });
    }

    const delRes = await fetch(`${TEST_URL}/api/users?status=eq.todelete&limit=1&order=id.asc`, {
      method: "DELETE",
    });
    expect(delRes.status).toBe(200);

    const check = await fetch(`${TEST_URL}/api/users?status=eq.todelete`);
    const remaining = await check.json();
    expect(remaining.length).toBe(1);
    expect(remaining[0].email).toBe(emailB); // emailA was deleted (lower id)

    psqlDb(`DELETE FROM users WHERE email IN ('${emailA}','${emailB}');`);
  });

  // =========================================================================
  // Prefer: return=headers-only for PATCH
  // =========================================================================

  test("PATCH with return=headers-only emits Preference-Applied and returns empty body", async () => {
    const insertRes = await fetch(`${TEST_URL}/api/users`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Prefer: "return=representation" },
      body: JSON.stringify({ name: "HdrsOnly", email: "hdrsonly@example.com", status: "active", age: 28 }),
    });
    const inserted = await insertRes.json();
    const id = inserted[0].id;

    const res = await fetch(`${TEST_URL}/api/users?id=eq.${id}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json", Prefer: "return=headers-only" },
      body: JSON.stringify({ status: "inactive" }),
    });
    expect(res.status).toBe(200);
    expect(res.headers.get("preference-applied")).toContain("return=headers-only");
    expect(await res.text()).toBe("");

    await fetch(`${TEST_URL}/api/users?id=eq.${id}`, { method: "DELETE" });
  });

});
