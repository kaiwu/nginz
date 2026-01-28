## GraphQL Gateway Module

GraphQL-aware access handler with query validation, depth limiting, and introspection control.

### Status

**Implemented** - All Phase 1 features complete with 26 passing tests

### Features

- [x] **Query Depth Limiting** - Prevent deeply nested query attacks (DoS protection)
- [x] **Introspection Control** - Block `__schema` and `__type` queries in production
- [x] **Lightweight Query Parsing** - Tokenizer-based parsing without full AST
- [x] **JSON Error Responses** - GraphQL-compliant error format
- [x] **Comment Handling** - Properly skips `#` comments
- [x] **String Handling** - Correctly handles quoted strings

### Directives

| Directive | Syntax | Default | Context | Description |
|-----------|--------|---------|---------|-------------|
| `graphql` | `on\|off` | `off` | location | Enable GraphQL validation |
| `graphql_max_depth` | `<number>` | `10` | location | Max query nesting depth |
| `graphql_introspection` | `on\|off` | `on` | location | Allow introspection queries |

### Usage

```nginx
location /graphql {
    graphql on;
    graphql_max_depth 5;
    graphql_introspection off;

    proxy_pass http://127.0.0.1:4000;
}
```

### How It Works

1. Handler runs in ACCESS phase (before content)
2. Only validates POST requests with JSON body
3. Extracts `query` field from JSON body
4. Parses GraphQL query with lightweight tokenizer:
   - Tracks brace depth `{` `}` to measure nesting
   - Detects `__schema` and `__type` for introspection
   - Handles strings and comments correctly
5. Returns 400 with JSON error if validation fails
6. Returns `NGX_OK` to pass request to backend

### Error Responses

Depth exceeded:
```json
{"errors":[{"message":"Query depth 12 exceeds maximum allowed 5"}]}
```

Introspection blocked:
```json
{"errors":[{"message":"Introspection queries are disabled"}]}
```

Invalid JSON:
```json
{"errors":[{"message":"Invalid JSON body"}]}
```

### Architecture

```
Client Request (POST /graphql)
    ↓
[ACCESS PHASE] graphql_handler
    ↓
Read request body (JSON)
    ↓
Extract "query" field (cJSON)
    ↓
Parse GraphQL query (tokenizer)
    ↓
Check depth limit
    ↓
Check introspection blocked
    ↓
NGX_OK (pass to proxy_pass) or 400 Bad Request
```

### Test Coverage

- Valid query under depth limit → passes through
- Query exceeds depth limit → 400 + error JSON
- Introspection query when disabled → 400 + error JSON
- Introspection query when enabled → passes through
- Invalid JSON body → 400
- GET request → passes through (no validation)
- Deeply nested queries → depth counted correctly
- Query with comments → comments ignored
- Multiple selection sets → depth tracked correctly
- Fragment introspection (`__typename`) → detected

### Phase 2: Future Enhancements

- [ ] Query complexity scoring (field weights)
- [ ] Persisted queries (query hash lookup)
- [ ] Response caching
- [ ] Field-level authorization
- [ ] Rate limiting per operation

### References

- [GraphQL Specification](https://spec.graphql.org/)
- [GraphQL Query Syntax](https://graphql.org/learn/queries/)
- [Why Disable Introspection](https://www.apollographql.com/blog/graphql/security/why-you-should-disable-graphql-introspection-in-production/)
