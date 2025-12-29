# pgrest-nginx-module

A PostgREST-like nginx module written in Zig that provides a RESTful API for PostgreSQL databases.

## Features

### Core Features
- **RESTful CRUD operations** - Maps HTTP methods to SQL operations
- **PostgREST-compatible filtering** - Query string filters like `?column=op.value`
- **Column selection** - Select specific columns with `?select=col1,col2`
- **Ordering** - Sort results with `?order=column.desc`
- **Pagination** - Limit/offset with `?limit=N&offset=M`
- **JSON response formatting** - Query results returned as JSON array
- **Non-blocking I/O** - Connection pooling with async operations (with `pgrest_pooling`)

### RPC/Stored Procedures
- **RPC/Stored Procedures** - Call PostgreSQL functions via `/rpc/function_name`
- **Smart response formatting** - Auto-detects scalar, object, or array results
- **JSON request body parsing** - POST with JSON payloads for function parameters
- **Query string parameters** - GET requests with function parameters

### Response Format Control
- **Accept header negotiation** - `Accept: application/json`, `text/csv`, `text/plain`, `text/xml`, `application/octet-stream`
- **Multiple format support** - JSON, CSV, plain text, XML, and binary output formats
- **Schema selection** - `Accept-Profile` (GET/HEAD/DELETE) and `Content-Profile` (POST/PATCH/PUT) headers for schema-qualified table access
- **RPC parameter wrapping** - `Prefer: params=single-object` header for single JSON object parameters

## Configuration

```nginx
location /api/ {
    # Connection string for PostgreSQL
    pgrest_pass "host=localhost dbname=mydb user=postgres password=secret";
}
```

### Connection Pooling (Non-blocking Mode)

Enable connection pooling for better performance with concurrent requests:

```nginx
location /api/ {
    # Enable connection pooling (non-blocking mode)
    pgrest_pooling;

    # Connection string for PostgreSQL
    pgrest_pass "host=localhost dbname=mydb user=postgres password=secret";
}
```

With `pgrest_pooling` enabled:
- Connections are reused across requests
- Non-blocking I/O with nginx's event model
- Up to 16 pooled connections (configurable)
- Automatic connection state management

## RPC (Remote Procedure Call) - Stored Procedures

Call PostgreSQL stored functions and procedures via HTTP endpoints. Perfect for complex operations involving multiple tables or business logic.

### Configuration

```nginx
location /rpc/ {
    # Enable connection pooling (optional but recommended)
    pgrest_pooling;
    
    # PostgreSQL connection string
    pgrest_pass "host=localhost dbname=mydb user=postgres password=secret";
}
```

### Usage

Call stored functions with the `/rpc/function_name` endpoint:

```bash
# Simple function call (GET)
curl "http://localhost/rpc/get_user_count"

# Function with query string parameters (GET)
curl "http://localhost/rpc/get_users_by_status?status=active&limit=10"

# Function with JSON body (POST) - NEW!
curl -X POST "http://localhost/rpc/add_them" \
  -H "Content-Type: application/json" \
  -d '{"a": 1, "b": 2}'

# Complex POST request
curl -X POST "http://localhost/rpc/create_order" \
  -H "Content-Type: application/json" \
  -d '{"user_id": 5, "amount": 100.50, "status": "pending"}'
```

### Parameter Passing Methods

#### Method 1: Query String Parameters (GET)

For simple function calls with a few parameters, use query string parameters:

```bash
curl "http://localhost/rpc/add_them?a=1&b=2"
```

Parameters are passed directly to the function:
- `?a=1&b=2` → `add_them(a => 1, b => 2)`
- `?status=active&limit=10` → `function(status => 'active', limit => 10)`

**Limitations:**
- Query string values are always treated as strings
- Complex data types (arrays, objects) not supported
- URL encoding required for special characters

#### Method 2: JSON Request Body (POST) - Recommended for Complex Data

For functions with multiple parameters or complex data types, use JSON request body:

```bash
curl -X POST "http://localhost/rpc/add_them" \
  -H "Content-Type: application/json" \
  -d '{"a": 1, "b": 2}'
```

**Key Features:**
- JSON object keys are automatically mapped to function parameter names
- Preserves data types (numbers, booleans, nulls)
- Cleaner syntax for multiple parameters
- Supports all PostgreSQL scalar types

**Examples:**

```bash
# Simple function call
curl -X POST "http://localhost/rpc/add_them" \
  -H "Content-Type: application/json" \
  -d '{"a": 1, "b": 2}'
# Maps to: add_them(a => 1, b => 2)

# Create user with multiple parameters
curl -X POST "http://localhost/rpc/create_user" \
  -H "Content-Type: application/json" \
  -d '{"user_id": 5, "email": "test@example.com", "is_active": true}'
# Maps to: create_user(user_id => 5, email => 'test@example.com', is_active => true)

# With null values
curl -X POST "http://localhost/rpc/update_profile" \
  -H "Content-Type: application/json" \
  -d '{"user_id": 42, "bio": null, "is_verified": true}'
# Maps to: update_profile(user_id => 42, bio => NULL, is_verified => true)
```

**Data Type Mapping:**

| JSON Type | PostgreSQL Type | Example |
|-----------|-----------------|---------|
| String | `text`, `varchar` | `"email": "user@example.com"` |
| Number | `integer`, `bigint`, `decimal`, `float` | `"age": 25`, `"price": 99.99` |
| Boolean | `boolean` | `"is_active": true` |
| Null | `NULL` | `"bio": null` |

**Advantages over Query String:**
- Preserves numeric types (not all strings)
- Direct boolean values (true/false, not "true"/"false" strings)
- Proper null handling
- More readable for multiple parameters
- Standard REST convention for POST

### Function Signature Examples

Here's how to define stored functions that work with pgrest RPC:

```sql
-- Function returning a scalar value
CREATE FUNCTION get_user_count() RETURNS integer AS $$
  SELECT COUNT(*) FROM users;
$$ LANGUAGE SQL;

-- Function with parameters
CREATE FUNCTION get_users_by_status(status text) RETURNS TABLE(id int, name text, email text) AS $$
  SELECT id, name, email FROM users WHERE status = $1;
$$ LANGUAGE SQL;

-- Function returning a single object
CREATE FUNCTION get_user(user_id int) RETURNS TABLE(id int, name text, email text) AS $$
  SELECT id, name, email FROM users WHERE id = $1;
$$ LANGUAGE SQL;

-- Function with multiple parameters
CREATE FUNCTION search_products(category text, price_max decimal) 
RETURNS TABLE(id int, name text, price decimal) AS $$
  SELECT id, name, price 
  FROM products 
  WHERE category = $1 AND price <= $2
  ORDER BY price;
$$ LANGUAGE SQL;

-- Procedure with side effects (INSERT, UPDATE, DELETE)
CREATE FUNCTION create_user(name text, email text) 
RETURNS TABLE(id int, name text, email text) AS $$
  INSERT INTO users(name, email) 
  VALUES($1, $2) 
  RETURNING id, name, email;
$$ LANGUAGE SQL;
```

### Response Format

The response format depends on what your function returns:

**Scalar value** (COUNT, SUM, single value):
```json
42
```

**Single row object**:
```json
{"id": 1, "name": "John", "email": "john@example.com"}
```

**Array of objects**:
```json
[
  {"id": 1, "name": "John", "email": "john@example.com"},
  {"id": 2, "name": "Jane", "email": "jane@example.com"}
]
```

**Error response**:
```json
{"error": "RPC call failed", "function": "get_user"}
```

### Parameter Types

- **Query string parameters**: Passed as function arguments
  - `?param1=value1&param2=value2`
  - Converted to PostgreSQL function parameters
  
- **POST body**: For complex data structures
  - Send JSON or URL-encoded data in request body
  - Can be used with procedures expecting complex input

### Advanced Examples

**Complex business logic with JOINs**:
```sql
CREATE FUNCTION get_user_with_orders(user_id int) 
RETURNS TABLE(
  user_id int, 
  user_name text,
  order_count int,
  total_spent decimal
) AS $$
  SELECT 
    u.id,
    u.name,
    COUNT(o.id) as order_count,
    COALESCE(SUM(o.total), 0) as total_spent
  FROM users u
  LEFT JOIN orders o ON u.id = o.user_id
  WHERE u.id = $1
  GROUP BY u.id, u.name;
$$ LANGUAGE SQL;
```

**Stored procedure with transactions**:
```sql
CREATE FUNCTION transfer_balance(from_user int, to_user int, amount decimal) 
RETURNS TABLE(success boolean, message text) AS $$
BEGIN
  UPDATE accounts SET balance = balance - amount WHERE user_id = from_user;
  UPDATE accounts SET balance = balance + amount WHERE user_id = to_user;
  RETURN QUERY SELECT true::boolean, 'Transfer successful'::text;
EXCEPTION WHEN OTHERS THEN
  RETURN QUERY SELECT false::boolean, SQLERRM;
END;
$$ LANGUAGE plpgsql;
```

Usage with GET (query parameters):
```bash
curl "http://localhost/rpc/transfer_balance?from_user=1&to_user=2&amount=100"
```

Usage with POST (JSON body):
```bash
curl -X POST "http://localhost/rpc/transfer_balance" \
  -H "Content-Type: application/json" \
  -d '{"from_user": 1, "to_user": 2, "amount": 100}'
```

## API Usage

### SELECT (GET)

```bash
# Get all rows from users table
curl http://localhost/api/users

# Select specific columns
curl "http://localhost/api/users?select=id,name,email"

# Filter rows
curl "http://localhost/api/users?status=eq.active"
curl "http://localhost/api/users?age=gt.18&status=eq.active"

# Order results
curl "http://localhost/api/users?order=created_at.desc"
curl "http://localhost/api/users?order=name.asc,id.desc"

# Pagination
curl "http://localhost/api/users?limit=10&offset=20"

# Combined
curl "http://localhost/api/users?select=id,name&status=eq.active&order=name.asc&limit=10"
```

### INSERT (POST)

```bash
# Insert a new row
curl -X POST http://localhost/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "email": "john@example.com", "status": "active"}'
```

### UPDATE (PATCH)

```bash
# Update rows matching filter
curl -X PATCH "http://localhost/api/users?id=eq.5" \
  -H "Content-Type: application/json" \
  -d '{"status": "inactive"}'
```

### DELETE (DELETE)

```bash
# Delete rows matching filter
curl -X DELETE "http://localhost/api/users?id=eq.5"
```

## Schema Selection & Request Headers

### Accept-Profile & Content-Profile Headers

pgrest supports schema-qualified table access via Profile headers. This allows you to work with tables in different PostgreSQL schemas without modifying the table name in the URI.

#### Accept-Profile (GET/HEAD/DELETE)

Use the `Accept-Profile` header to select a schema for read and delete operations:

```bash
# Query from the public schema (default if no header)
curl "http://localhost/api/users"

# Query from a specific schema
curl "http://localhost/api/users" \
  -H "Accept-Profile: admin_schema"

# This will query: SELECT * FROM admin_schema.users
```

#### Content-Profile (POST/PATCH/PUT)

Use the `Content-Profile` header to select a schema for write operations:

```bash
# Insert into the public schema (default)
curl -X POST "http://localhost/api/users" \
  -H "Content-Type: application/json" \
  -d '{"name": "John", "email": "john@example.com"}'

# Insert into a specific schema
curl -X POST "http://localhost/api/users" \
  -H "Content-Type: application/json" \
  -H "Content-Profile: tenant_schema" \
  -d '{"name": "John", "email": "john@example.com"}'

# This will execute: INSERT INTO tenant_schema.users (name, email) VALUES (...)
```

#### Schema Profile Examples

**Multi-tenant application:**
```bash
# User A's data (tenant_001 schema)
curl "http://localhost/api/orders" \
  -H "Accept-Profile: tenant_001"

# User B's data (tenant_002 schema)
curl "http://localhost/api/orders" \
  -H "Accept-Profile: tenant_002"
```

**Separate admin schema:**
```bash
# Regular user access (public schema)
curl "http://localhost/api/users"

# Admin access (admin schema)
curl "http://localhost/api/users" \
  -H "Accept-Profile: admin"
  -H "Accept: application/json"
```

### Prefer Header for RPC Parameters

The `Prefer` header controls how RPC function parameters are handled.

#### Prefer: params=single-object

For RPC functions that accept a single JSON object parameter, use this header to wrap all parameters in a single object:

```bash
# Function definition:
# CREATE FUNCTION create_user(data json) RETURNS TABLE(id int, name text) AS ...

# Without Prefer header (parameter mapping):
curl -X POST "http://localhost/rpc/create_user" \
  -H "Content-Type: application/json" \
  -d '{"data": "{\"name\": \"John\", \"email\": \"john@example.com\"}"}'

# With Prefer header (single object wrapping):
curl -X POST "http://localhost/rpc/create_user" \
  -H "Content-Type: application/json" \
  -H "Prefer: params=single-object" \
  -d '{"name": "John", "email": "john@example.com"}'
# Automatically wrapped as: {"data": <entire JSON body>}
```

This is useful for:
- Functions expecting JSON or JSONB parameters
- Simplifying RPC calls with complex nested objects
- Avoiding double-encoding of JSON data

## Content Negotiation & Response Formats

### Accept Header Support

pgrest supports multiple response formats via the `Accept` header. The server will automatically convert query results to your requested format.

#### JSON Format (default)
```bash
curl "http://localhost/api/users" \
  -H "Accept: application/json"
```

Response:
```json
[
  {"id": 1, "name": "John", "email": "john@example.com"},
  {"id": 2, "name": "Jane", "email": "jane@example.com"}
]
```

#### CSV Format
```bash
curl "http://localhost/api/users" \
  -H "Accept: text/csv"
```

Response:
```csv
id,name,email
1,John,john@example.com
2,Jane,jane@example.com
```

#### Plain Text Format
```bash
curl "http://localhost/api/users?select=name" \
  -H "Accept: text/plain"
```

Response:
```
John
Jane
```

#### XML Format
```bash
curl "http://localhost/api/users" \
  -H "Accept: text/xml"
```

Response:
```xml
<?xml version="1.0"?>
<root>
  <row>
    <id>1</id>
    <name>John</name>
    <email>john@example.com</email>
  </row>
  <row>
    <id>2</id>
    <name>Jane</name>
    <email>jane@example.com</email>
  </row>
</root>
```

#### Binary/Octet-Stream Format
```bash
curl "http://localhost/api/files?id=eq.1&select=data" \
  -H "Accept: application/octet-stream"
```

Returns raw binary data for bytea columns.

### Accept Header Behavior

- If no `Accept` header is provided, defaults to `application/json`
- For single-row results with CSV/plain text, outputs the first column value
- For multi-column results, CSV includes all columns with proper escaping
- XML wraps results in `<root>` with `<row>` elements for each record
- Unsupported formats fall back to JSON

## Filter Operators

| Operator | SQL Equivalent | Example |
|----------|---------------|---------|
| `eq` | `=` | `?id=eq.5` |
| `neq` | `<>` | `?status=neq.deleted` |
| `gt` | `>` | `?age=gt.18` |
| `gte` | `>=` | `?age=gte.21` |
| `lt` | `<` | `?price=lt.100` |
| `lte` | `<=` | `?price=lte.50` |
| `like` | `LIKE` | `?name=like.John%` |
| `ilike` | `ILIKE` | `?name=ilike.john%` |
| `is` | `IS` | `?deleted_at=is.null` |
| `in` | `IN` | `?status=in.(active,pending)` |

## RPC Response Formats

The response format for RPC calls depends on what your function returns. The format can be controlled via the `Accept` header:

### JSON Response (default)

```bash
curl -X POST "http://localhost/rpc/get_users" \
  -H "Accept: application/json"
```

**Scalar value** (COUNT, SUM, single value):
```json
42
```

**Single row object**:
```json
{"id": 1, "name": "John", "email": "john@example.com"}
```

**Array of objects**:
```json
[
  {"id": 1, "name": "John", "email": "john@example.com"},
  {"id": 2, "name": "Jane", "email": "jane@example.com"}
]
```

**Error response**:
```json
{"error": "RPC call failed", "function": "get_users"}
```

### CSV Response

```bash
curl -X POST "http://localhost/rpc/get_users" \
  -H "Accept: text/csv"
```

Output:
```csv
id,name,email
1,John,john@example.com
2,Jane,jane@example.com
```

### Plain Text Response

For single-column results:
```bash
curl -X POST "http://localhost/rpc/get_user_names" \
  -H "Accept: text/plain"
```

Output:
```
John
Jane
```

### XML Response

```bash
curl -X POST "http://localhost/rpc/get_users" \
  -H "Accept: text/xml"
```

Output:
```xml
<?xml version="1.0"?>
<root>
  <row>
    <id>1</id>
    <name>John</name>
    <email>john@example.com</email>
  </row>
  <row>
    <id>2</id>
    <name>Jane</name>
    <email>jane@example.com</email>
  </row>
</root>
```

## Standard Query Response Format

Successful queries return a JSON array by default:

```json
[
  {"id": 1, "name": "John", "email": "john@example.com"},
  {"id": 2, "name": "Jane", "email": "jane@example.com"}
]
```

Other formats (CSV, XML, plain text) are available via `Accept` header as documented in the Content Negotiation section.

Error responses:

```json
{"error": "Query failed", "sql": "SELECT * FROM nonexistent"}
```

## Completed Features (v1.0+)

- ✅ **JSON request body for RPC** - POST with JSON payloads for function parameters
- ✅ **Accept header support** - Multiple output formats (JSON, CSV, XML, plain text, binary)
- ✅ **RPC POST requests** - Call functions with structured JSON data
- ✅ **Accept-Profile header** - Schema selection for GET/HEAD/DELETE requests
- ✅ **Content-Profile header** - Schema selection for POST/PATCH/PUT requests
- ✅ **Prefer: params=single-object** - Single JSON object parameter wrapping for RPC functions

## Planned Features (High Priority)

- **Response format control** - Singular vs plural objects (Accept: application/vnd.pgrst.object+json)
- **Stripped nulls** - Accept: application/vnd.pgrst.array+json;nulls=stripped

## Planned Features (Medium Priority)

- **Binary data upload** - Content-Type: application/octet-stream for bytea parameters
- **XML data upload** - Content-Type: text/xml for xml parameters
- **Text data upload** - Content-Type: text/plain for text parameters
- **Array parameters** - JSON arrays converted to PostgreSQL arrays in POST requests
- **Variadic functions** - Multiple parameter values for variadic functions

## Limitations

- **No authentication** - Implement auth at nginx level or with JWT (future work)
- **Basic SQL injection prevention** - Values are quoted but not fully parameterized
- **Single table operations** - CRUD on single tables only (use RPC for JOINs/complex queries)
- **Simple query building** - Complex filters use AND logic only

## Future Improvements

- JWT authentication
- Parameterized queries for SQL injection prevention
- Relationship handling (embedded resources, foreign key expansion)
- Bulk operations (multiple INSERT/UPDATE/DELETE)
- Materialized view support
- Custom response headers per endpoint
- Rate limiting and caching headers
- Request/response compression
- GraphQL support
