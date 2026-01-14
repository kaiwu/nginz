## JSON Schema Validation Module

Validates JSON request bodies against inline JSON Schema in the access phase.

### Directives

#### jsonschema

*syntax:* `jsonschema '<json_schema>';`
*context:* `location`

Enable JSON Schema validation with an inline schema. Only validates POST, PUT, and PATCH requests with `Content-Type: application/json`.

### Supported Schema Keywords

- **type**: `string`, `number`, `integer`, `boolean`, `object`, `array`, `null`
- **required**: Array of required field names for objects
- **properties**: Nested schema definitions for object properties
- **minLength** / **maxLength**: String length constraints
- **minimum** / **maximum**: Number value constraints

### Usage

```nginx
http {
    server {
        listen 8888;

        location /api/users {
            jsonschema '{"type":"object","required":["name","email"],"properties":{"name":{"type":"string","minLength":1},"email":{"type":"string"},"age":{"type":"number","minimum":0}}}';
            proxy_pass http://backend;
        }

        location /api/simple {
            jsonschema '{"type":"object"}';
            echozn '{"status":"ok"}';
        }
    }
}
```

### Error Response

On validation failure, returns HTTP 400 with JSON body:

```json
{
  "error": "validation_failed",
  "message": "missing required field"
}
```

Possible error messages:
- `invalid JSON` - Request body is not valid JSON
- `must be a string` / `must be a number` / `must be an object` / etc. - Type mismatch
- `missing required field` - Required field not present
- `string too short` / `string too long` - String length violation
- `number below minimum` / `number above maximum` - Number range violation
- `schema too deep` - Schema exceeds maximum recursion depth (100)

### Behavior

- GET requests and other methods without body pass through without validation
- Requests without `Content-Type: application/json` header pass through without validation
- Empty request bodies pass through without validation
- Validation runs in the access phase before content handlers
