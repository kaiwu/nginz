## Redis Client Module

Non-blocking Redis client for nginx with connection pooling.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Non-blocking I/O**: Fully asynchronous Redis operations
- **Connection Pooling**: Reuse connections across requests
- **Full Command Support**: GET, SET, HGET, HSET, DEL, EXPIRE, PUBLISH, etc.
- **Pipeline Support**: Batch multiple commands in a single round-trip
- **Lua Scripting**: Execute Redis Lua scripts
- **Cluster Support**: Redis Cluster routing (future)

### Planned Directives

#### redis_pass

*syntax:* `redis_pass <upstream>;`  
*context:* `location`

Proxy requests to Redis server.

#### redis_server

*syntax:* `redis_server <host>:<port> [weight=n] [pool_size=n];`  
*context:* `upstream`

Define Redis server in upstream block.

#### redis_timeout

*syntax:* `redis_timeout <time>;`  
*default:* `redis_timeout 1s;`  
*context:* `location`

Timeout for Redis operations.

#### redis_query

*syntax:* `redis_query <command> [args...];`  
*context:* `location`

Execute a Redis command.

### Planned Usage

```nginx
upstream redis {
    redis_server 127.0.0.1:6379 pool_size=10;
}

server {
    location /cache {
        redis_pass redis;
        redis_query GET $uri;
    }
    
    location /session {
        set $session_key "session:$cookie_sid";
        redis_pass redis;
        redis_query HGETALL $session_key;
    }
}
```

### References

- [lua-resty-redis](https://github.com/openresty/lua-resty-redis)
- [redis2-nginx-module](https://github.com/openresty/redis2-nginx-module)
