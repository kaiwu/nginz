## Transform Module

JSON response transformation using JSON path extraction.

### Status

**Implemented** - Basic functionality complete

### Features

- **JSON Path Extraction**: Extract nested values from JSON responses
- **Path Syntax**: Supports `$.data.items`, `$.items.0` notation
- **Passthrough**: Non-JSON responses pass through unchanged
- **Graceful Fallback**: Returns original response if path not found

### Directives

#### transform_response

*syntax:* `transform_response <json_path>;`
*context:* `location`

Extract and return only the specified JSON path from upstream responses.

### Usage

```nginx
http {
    server {
        listen 8080;

        # Extract nested data
        location /api/users {
            proxy_pass http://backend/users;
            transform_response $.data;
        }

        # Extract specific field
        location /api/count {
            proxy_pass http://backend/stats;
            transform_response $.data.total;
        }

        # Extract array element
        location /api/first {
            proxy_pass http://backend/items;
            transform_response $.items.0;
        }
    }
}
```

### Examples

**Original Response:**
```json
{
  "status": "ok",
  "data": {
    "users": [
      {"id": 1, "name": "Alice"},
      {"id": 2, "name": "Bob"}
    ],
    "total": 2
  }
}
```

**With `transform_response $.data`:**
```json
{
  "users": [
    {"id": 1, "name": "Alice"},
    {"id": 2, "name": "Bob"}
  ],
  "total": 2
}
```

**With `transform_response $.data.users`:**
```json
[
  {"id": 1, "name": "Alice"},
  {"id": 2, "name": "Bob"}
]
```

**With `transform_response $.data.total`:**
```
2
```

### Path Syntax

| Pattern | Description |
|---------|-------------|
| `$.foo` | Root-level field |
| `$.foo.bar` | Nested field |
| `$.items.0` | Array index (0-based) |
| `$.data.items.0.name` | Deeply nested with array |

### Behavior

- **Non-JSON**: Responses without `application/json` content-type pass through unchanged
- **Invalid Path**: If path doesn't exist, original response is returned
- **Parse Error**: If JSON parsing fails, original response is returned

### Limitations

Current implementation has these limitations:

- **Simple Paths Only**: No array filters or complex JSONPath expressions
- **Memory Buffering**: Full response is buffered in memory
- **No Request Transform**: Only transforms responses, not requests

### Future Enhancements

- **Request Transform**: Transform request bodies before proxying
- **JSONPath Filters**: Support `$.items[?(@.active)]` syntax
- **XML Support**: XML-to-JSON transformation
- **Template Transform**: Jinja-style response templates
- **Multiple Extractions**: Extract multiple paths into new structure

### References

- [JSONPath Specification](https://goessner.net/articles/JsonPath/)
- [jq Manual](https://stedolan.github.io/jq/manual/)
