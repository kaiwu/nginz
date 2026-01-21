## GraphQL Gateway Module

GraphQL-aware access handler with query validation, depth limiting, and introspection control.

### Status

**Planned** - Implementation plan below

### Implementation Plan

#### Phase 1: Core Features (Initial Implementation)

Focus on security-critical features that protect GraphQL backends:

1. **Query Depth Limiting** - Prevent deeply nested query attacks (DoS protection)
2. **Introspection Control** - Block `__schema` and `__type` queries in production
3. **Basic Query Parsing** - Extract and validate GraphQL query from request body

#### Architecture

```
Client Request (POST /graphql)
    ↓
[ACCESS PHASE] graphql_handler
    ↓
Read request body (JSON)
    ↓
Extract "query" field
    ↓
Parse GraphQL query (lightweight tokenizer)
    ↓
Check depth limit
    ↓
Check introspection blocked
    ↓
NGX_OK (pass to proxy_pass) or 400 Bad Request
```

#### Module Structure

```
src/modules/graphql-nginx-module/
├── ngx_http_graphql.zig      # Main module (handler, directives, config)
└── README.md
```

#### Config Structure

```zig
const graphql_loc_conf = extern struct {
    enabled: ngx_flag_t,           // graphql on|off
    max_depth: ngx_int_t,          // graphql_max_depth (default: 10)
    allow_introspection: ngx_flag_t, // graphql_introspection on|off
};
```

#### Directives (Phase 1)

| Directive | Syntax | Default | Description |
|-----------|--------|---------|-------------|
| `graphql` | `on\|off` | `off` | Enable GraphQL validation |
| `graphql_max_depth` | `<number>` | `10` | Max query nesting depth |
| `graphql_introspection` | `on\|off` | `on` | Allow introspection queries |

#### GraphQL Query Parsing Strategy

**Lightweight tokenizer approach** (no full AST):

1. Find `query` or `mutation` keyword
2. Track brace depth `{` `}` to measure nesting
3. Detect `__schema` or `__type` tokens for introspection check
4. Handle string literals (skip content inside quotes)
5. Handle comments (skip `#` to end of line)

```zig
const ParseResult = struct {
    max_depth: u32,
    has_introspection: bool,
    is_valid: bool,
};

fn parseGraphQL(query: []const u8) ParseResult {
    // Tokenize and track depth without building full AST
}
```

#### Request Body Handling

GraphQL requests come as POST with JSON body:

```json
{
  "query": "{ user { name } }",
  "variables": { ... },
  "operationName": "..."
}
```

Use `ngx_http_read_client_request_body` + body handler pattern (like consul module).

#### Error Responses

Return JSON errors matching GraphQL conventions:

```json
{"errors":[{"message":"Query depth 12 exceeds maximum allowed 10"}]}
```

```json
{"errors":[{"message":"Introspection queries are disabled"}]}
```

#### Handler Flow

```zig
export fn ngx_http_graphql_handler(r) -> ngx_int_t {
    // 1. Check if enabled
    // 2. Only handle POST requests
    // 3. Read request body with callback
    return ngx_http_read_client_request_body(r, graphql_body_handler);
}

fn graphql_body_handler(r) void {
    // 1. Extract body as string
    // 2. Parse JSON, get "query" field
    // 3. Parse GraphQL query
    // 4. Validate depth
    // 5. Validate introspection
    // 6. finalize_request with NGX_OK or error
}
```

#### Test Cases

1. **Valid query under depth limit** → passes through
2. **Query exceeds depth limit** → 400 + error JSON
3. **Introspection query when disabled** → 400 + error JSON
4. **Introspection query when enabled** → passes through
5. **Invalid JSON body** → 400
6. **GET request** → passes through (no validation)
7. **Nested fragments** → depth counted correctly
8. **Query with comments** → comments ignored

#### nginx.conf Example

```nginx
location /graphql {
    graphql on;
    graphql_max_depth 5;
    graphql_introspection off;

    proxy_pass http://127.0.0.1:4000;
}
```

### Phase 2: Future Enhancements

Not in initial implementation:

- [ ] Query complexity scoring
- [ ] Persisted queries (query hash lookup)
- [ ] Response caching
- [ ] Field-level authorization
- [ ] Rate limiting per operation

### Implementation Order

1. Create module skeleton with config structs
2. Implement directives parsing
3. Implement body reading (copy pattern from consul)
4. Implement JSON parsing (extract query field)
5. Implement GraphQL tokenizer (depth + introspection detection)
6. Implement error response generation
7. Register as ACCESS phase handler
8. Write integration tests
9. Update README with final documentation

### Complexity Estimate

- **Lines of code**: ~600-800
- **Difficulty**: Medium (GraphQL parsing is the main challenge)
- **Dependencies**: cJSON for JSON parsing (already available)

### References

- [GraphQL Specification](https://spec.graphql.org/)
- [GraphQL Query Syntax](https://graphql.org/learn/queries/)
- [Why Disable Introspection](https://www.apollographql.com/blog/graphql/security/why-you-should-disable-graphql-introspection-in-production/)
