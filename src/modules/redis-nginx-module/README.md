## Redis Module

Simple Redis client for fetching cached values from Redis.

### Status

**Implemented** - Basic GET functionality complete

### Features

- **GET Command**: Fetch values from Redis using RESP protocol
- **URI-based Keys**: Use request URI path as Redis key
- **Static Keys**: Configure fixed key via directive
- **JSON Responses**: Returns values as JSON objects

### Directives

#### redis_pass

*syntax:* `redis_pass <host>:<port>;`
*context:* `location`

Enable Redis passthrough and specify the Redis server address.

```nginx
redis_pass 127.0.0.1:6379;
redis_pass redis.local:6380;
```

#### redis_key

*syntax:* `redis_key <key>;`
*context:* `location`

Set a static Redis key instead of deriving from URI.

```nginx
redis_key mykey;
```

### Usage

```nginx
http {
    server {
        listen 8080;

        # Get value using URI path as key
        # GET /cache/mykey -> Redis GET "cache/mykey"
        location /cache/ {
            redis_pass 127.0.0.1:6379;
        }

        # Get value using static key
        # GET /config -> Redis GET "app-config"
        location /config {
            redis_pass 127.0.0.1:6379;
            redis_key app-config;
        }
    }
}
```

### Response Format

**Successful GET (key exists):**
```json
{"value":"the-value-from-redis"}
```

**Key not found:**
```json
{"value":null}
```

**Error response:**
```json
{"error":"connection_failed"}
```

### Key Derivation

When `redis_key` is not configured, the key is derived from the request URI:
- URI `/cache/mykey` → Redis key `cache/mykey`
- URI `/data` → Redis key `data`

The leading slash is stripped from the URI to form the key.

### Limitations

Current implementation has these limitations:

- **GET Only**: Only Redis GET command is supported
- **Blocking I/O**: Uses blocking TCP connection (not nginx upstream)
- **No Connection Pooling**: New connection per request
- **No Authentication**: Redis AUTH not supported
- **No Pipelining**: Single command per connection

### Future Enhancements

- **More Commands**: SET, DEL, INCR, EXPIRE, MGET
- **Non-blocking I/O**: nginx upstream integration with connection pooling
- **Authentication**: Redis AUTH and ACL support
- **Variable Expansion**: Support nginx variables in redis_key
- **Timeout Configuration**: Configurable connection and read timeouts
- **Cluster Support**: Redis Cluster mode routing

### References

- [Redis Protocol (RESP)](https://redis.io/docs/reference/protocol-spec/)
- [ngx_http_redis Module](https://www.nginx.com/resources/wiki/modules/redis/)
