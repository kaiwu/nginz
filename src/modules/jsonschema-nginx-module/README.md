## JSON Schema Validation Module

Request and response validation against JSON Schema.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Request Validation**: Validate JSON request bodies against schemas
- **Response Validation**: Validate backend responses (dev/staging mode)
- **Schema Caching**: Compile and cache schemas for performance
- **Detailed Errors**: Return structured error responses with validation details
- **Draft Support**: JSON Schema Draft 4, 6, 7, and 2019-09
- **Refs Support**: $ref resolution for modular schemas

### Planned Directives

#### jsonschema

*syntax:* `jsonschema on|off;`  
*default:* `jsonschema off;`  
*context:* `location`

Enable JSON Schema validation.

#### jsonschema_request

*syntax:* `jsonschema_request <schema_file>;`  
*context:* `location`

Path to JSON Schema file for request validation.

#### jsonschema_response

*syntax:* `jsonschema_response <schema_file>;`  
*context:* `location`

Path to JSON Schema file for response validation.

#### jsonschema_error_format

*syntax:* `jsonschema_error_format simple|detailed;`  
*default:* `jsonschema_error_format detailed;`  
*context:* `location`

Error response format.

### Planned Usage

```nginx
http {
    server {
        location /api/users {
            jsonschema on;
            jsonschema_request /etc/nginx/schemas/user-create.json;
            
            proxy_pass http://backend;
        }
        
        # Development mode - validate responses too
        location /api/dev {
            jsonschema on;
            jsonschema_request /etc/nginx/schemas/request.json;
            jsonschema_response /etc/nginx/schemas/response.json;
            
            proxy_pass http://backend;
        }
    }
}
```

### Example Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["name", "email"],
  "properties": {
    "name": {
      "type": "string",
      "minLength": 1,
      "maxLength": 100
    },
    "email": {
      "type": "string",
      "format": "email"
    },
    "age": {
      "type": "integer",
      "minimum": 0
    }
  }
}
```

### Example Error Response

```json
{
  "error": "validation_failed",
  "details": [
    {
      "path": "/email",
      "message": "must be a valid email address"
    },
    {
      "path": "/age",
      "message": "must be >= 0"
    }
  ]
}
```

### References

- [JSON Schema](https://json-schema.org/)
- [Understanding JSON Schema](https://json-schema.org/understanding-json-schema/)
