## Request/Response Transform Module

Transform request and response bodies between formats.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **JSON-to-JSON**: jq-like transformations for restructuring JSON
- **XML-to-JSON**: Convert XML responses to JSON
- **JSON-to-XML**: Convert JSON requests to XML for legacy backends
- **Template Engine**: Template-based transformations
- **Field Mapping**: Map fields between different API schemas
- **Streaming**: Stream large responses without full buffering

### Planned Directives

#### transform

*syntax:* `transform on|off;`  
*default:* `transform off;`  
*context:* `location`

Enable body transformation.

#### transform_request

*syntax:* `transform_request <expression|file>;`  
*context:* `location`

Transformation rule for request body.

#### transform_response

*syntax:* `transform_response <expression|file>;`  
*context:* `location`

Transformation rule for response body.

#### transform_type

*syntax:* `transform_type json|xml|template;`  
*default:* `transform_type json;`  
*context:* `location`

Transformation type.

### Planned Usage

```nginx
http {
    server {
        # Restructure JSON response
        location /api/v2/users {
            transform on;
            transform_response '{id: .user_id, name: .full_name, email: .email_address}';
            
            proxy_pass http://legacy-api/users;
        }
        
        # Convert XML backend to JSON API
        location /api/orders {
            transform on;
            transform_type xml;
            transform_response /etc/nginx/transforms/orders-xml-to-json.tpl;
            
            proxy_pass http://soap-backend/orders;
        }
        
        # Transform request for legacy backend
        location /api/submit {
            transform on;
            transform_request '{legacy_field: .modern_field, old_format: .new_format}';
            
            proxy_pass http://legacy-backend;
        }
    }
}
```

### Example Transformations

**Input:**
```json
{
  "user_id": 123,
  "full_name": "John Doe",
  "email_address": "john@example.com"
}
```

**Rule:** `{id: .user_id, name: .full_name, email: .email_address}`

**Output:**
```json
{
  "id": 123,
  "name": "John Doe",
  "email": "john@example.com"
}
```

### References

- [jq Manual](https://stedolan.github.io/jq/manual/)
- [Kong Request Transformer](https://docs.konghq.com/hub/kong-inc/request-transformer/)
