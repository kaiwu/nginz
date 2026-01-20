## Redis Module

Simple Redis client using RESP protocol with non-blocking upstream I/O.

### Status

**Implemented** - GET, SET, DEL, INCR, EXPIRE, MGET commands

### Features

- **Multiple Commands**: GET, SET, DEL, INCR, EXPIRE, MGET
- **Non-blocking I/O**: Uses nginx upstream module for async operations
- **URI-based Keys**: Use request URI path as Redis key
- **Static Keys**: Configure fixed key via directive
- **JSON Responses**: Returns values as JSON objects
- **Connection Reuse**: Supports keepalive connections to Redis

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

#### redis_command

*syntax:* `redis_command <get|set|del|incr|expire|mget>;`
*context:* `location`
*default:* `get`

Set the Redis command to execute. Default is `get`.

```nginx
redis_command set;
redis_command incr;
```

### Usage

```nginx
http {
    server {
        listen 8080;

        # GET - Fetch value using URI path as key
        # GET /cache/mykey -> Redis GET "cache/mykey"
        location /cache/ {
            redis_pass 127.0.0.1:6379;
        }

        # GET - Using static key
        # GET /config -> Redis GET "app-config"
        location /config {
            redis_pass 127.0.0.1:6379;
            redis_key app-config;
        }

        # SET - Store value (POST body becomes value)
        # POST /set/mykey with body "myvalue" -> Redis SET "set/mykey" "myvalue"
        location /set/ {
            redis_pass 127.0.0.1:6379;
            redis_command set;
        }

        # DEL - Delete key
        # POST /del/mykey -> Redis DEL "del/mykey"
        location /del/ {
            redis_pass 127.0.0.1:6379;
            redis_command del;
        }

        # INCR - Increment counter
        # POST /incr/counter -> Redis INCR "incr/counter"
        location /incr/ {
            redis_pass 127.0.0.1:6379;
            redis_command incr;
        }

        # EXPIRE - Set TTL (POST body is seconds, defaults to 60)
        # POST /expire/mykey with body "3600" -> Redis EXPIRE "expire/mykey" 3600
        location /expire/ {
            redis_pass 127.0.0.1:6379;
            redis_command expire;
        }

        # MGET - Get multiple values
        # GET /mget?keys=key1,key2,key3 -> Redis MGET key1 key2 key3
        location /mget {
            redis_pass 127.0.0.1:6379;
            redis_command mget;
        }
    }
}
```

### HTTP Methods

| Command | HTTP Methods | Request Body |
|---------|-------------|--------------|
| GET     | GET         | -            |
| SET     | POST        | Value to set |
| DEL     | POST, DELETE| -            |
| INCR    | POST        | -            |
| EXPIRE  | POST        | TTL seconds (optional, default 60) |
| MGET    | GET         | - (keys in query string) |

### Response Format

**GET (value exists):**
```json
{"value":"the-value-from-redis"}
```

**GET (key not found):**
```json
{"value":null}
```

**SET (success):**
```json
{"ok":true}
```

**DEL (returns count of deleted keys):**
```json
{"value":1}
```

**INCR (returns new value):**
```json
{"value":42}
```

**EXPIRE (returns 1 if key exists, 0 if not):**
```json
{"value":1}
```

**MGET (returns array of values):**
```json
{"values":["value1","value2",null]}
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

- **No Authentication**: Redis AUTH not supported
- **No Pipelining**: Single command per connection
- **MGET Max Keys**: Limited to 16 keys per request

### Future Enhancements

- **Authentication**: Redis AUTH and ACL support
- **Variable Expansion**: Support nginx variables in redis_key
- **Timeout Configuration**: Configurable connection and read timeouts
- **Cluster Support**: Redis Cluster mode routing

### References

- [Redis Protocol (RESP)](https://redis.io/docs/reference/protocol-spec/)
- [ngx_http_redis Module](https://www.nginx.com/resources/wiki/modules/redis/)
