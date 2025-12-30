## Request ID Module

Generate and propagate unique request IDs for distributed tracing.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **ID Generation**: UUID v4, UUID v7, ULID, Snowflake, custom formats
- **ID Propagation**: Accept incoming ID or generate new one
- **Header Support**: Configurable header name (X-Request-ID, X-Correlation-ID)
- **Response Header**: Optionally add ID to response headers
- **Logging Integration**: Available as nginx variable for logging
- **Upstream Propagation**: Automatically forward to backend

### Planned Directives

#### request_id

*syntax:* `request_id on|off;`  
*default:* `request_id off;`  
*context:* `location`

Enable request ID generation/propagation.

#### request_id_header

*syntax:* `request_id_header <name>;`  
*default:* `request_id_header X-Request-ID;`  
*context:* `location`

Header name to use for request ID.

#### request_id_format

*syntax:* `request_id_format uuid4|uuid7|ulid|snowflake;`  
*default:* `request_id_format uuid4;`  
*context:* `location`

Format for generated request IDs.

#### request_id_response

*syntax:* `request_id_response on|off;`  
*default:* `request_id_response on;`  
*context:* `location`

Add request ID to response headers.

### Planned Usage

```nginx
http {
    # Log format with request ID
    log_format traced '$remote_addr - $request_id - $request';
    
    server {
        access_log /var/log/nginx/access.log traced;
        
        location /api {
            request_id on;
            request_id_header X-Request-ID;
            request_id_format uuid4;
            request_id_response on;
            
            # Forward to backend
            proxy_set_header X-Request-ID $request_id;
            proxy_pass http://backend;
        }
    }
}
```

### Variables

- `$request_id` - The request ID (generated or from incoming header)

### Example IDs

```
# UUID v4
550e8400-e29b-41d4-a716-446655440000

# UUID v7
0188a6d3-7c00-7000-8000-000000000000

# ULID
01ARZ3NDEKTSV4RRFFQ69G5FAV

# Snowflake
1234567890123456789
```

### References

- [OpenTelemetry Trace Context](https://www.w3.org/TR/trace-context/)
- [RFC 4122 - UUID](https://tools.ietf.org/html/rfc4122)
- [ULID Spec](https://github.com/ulid/spec)
