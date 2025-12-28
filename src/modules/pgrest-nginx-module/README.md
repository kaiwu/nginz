# pgrest-nginx-module

A PostgREST-like nginx module written in Zig that provides a RESTful API for PostgreSQL databases.

## Features

- **RESTful CRUD operations** - Maps HTTP methods to SQL operations
- **PostgREST-compatible filtering** - Query string filters like `?column=op.value`
- **Column selection** - Select specific columns with `?select=col1,col2`
- **Ordering** - Sort results with `?order=column.desc`
- **Pagination** - Limit/offset with `?limit=N&offset=M`
- **JSON request body parsing** - INSERT/UPDATE with JSON payloads
- **JSON response formatting** - Query results returned as JSON array

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

## Response Format

Successful queries return a JSON array:

```json
[
  {"id": 1, "name": "John", "email": "john@example.com"},
  {"id": 2, "name": "Jane", "email": "jane@example.com"}
]
```

Error responses:

```json
{"error": "Query failed", "sql": "SELECT * FROM nonexistent"}
```

## Limitations

- **No authentication** - Implement auth at nginx level or with JWT (future work)
- **Basic SQL injection prevention** - Values are quoted but not fully parameterized
- **Single table operations** - No JOINs or complex queries

## Future Improvements

- JWT authentication
- Parameterized queries for SQL injection prevention
- Relationship handling (embedded resources)
- RPC (stored procedure) calls
- Bulk operations
