## Advanced Rate Limiting Module

Flexible rate limiting with multiple algorithms and per-key limits.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Multiple Algorithms**: Leaky bucket, token bucket, sliding window, fixed window
- **Flexible Keys**: Rate limit by IP, API key, user ID, or any nginx variable
- **Burst Handling**: Allow bursts with configurable limits
- **Delay vs Reject**: Option to delay excess requests instead of rejecting
- **Shared State**: Cross-worker rate limiting via shared memory
- **Distributed**: Optional Redis backend for multi-instance deployments

### Planned Directives

#### ratelimit_zone

*syntax:* `ratelimit_zone zone=<name>:<size> rate=<rate> [burst=<n>] [algorithm=<type>];`  
*context:* `http`

Define a shared memory zone for rate limiting.

#### ratelimit

*syntax:* `ratelimit zone=<name> [key=<variable>] [delay] [status=<code>];`  
*context:* `location`

Apply rate limiting to a location.

#### ratelimit_status

*syntax:* `ratelimit_status <code>;`  
*default:* `ratelimit_status 429;`  
*context:* `location`

HTTP status code to return when rate limit is exceeded.

### Planned Usage

```nginx
http {
    ratelimit_zone zone=api:10m rate=100r/s burst=50 algorithm=sliding_window;
    ratelimit_zone zone=login:1m rate=5r/m burst=2;
    
    server {
        location /api {
            ratelimit zone=api key=$http_x_api_key;
            proxy_pass http://backend;
        }
        
        location /login {
            ratelimit zone=login key=$binary_remote_addr delay;
            proxy_pass http://auth;
        }
    }
}
```

### References

- [NGINX Rate Limiting](https://www.nginx.com/blog/rate-limiting-nginx/)
- [lua-resty-limit-traffic](https://github.com/openresty/lua-resty-limit-traffic)
