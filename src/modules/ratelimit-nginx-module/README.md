## Rate Limiting Module

Simple per-IP rate limiting with fixed window algorithm.

### Directives

#### ratelimit_rate

*syntax:* `ratelimit_rate <N>r/s;` or `ratelimit_rate <N>;`
*context:* `location`

Enable rate limiting and set the rate limit in requests per second.

#### ratelimit_burst

*syntax:* `ratelimit_burst <N>;`
*default:* `0`
*context:* `location`

Allow additional burst requests beyond the rate limit.

### Usage

```nginx
http {
    server {
        listen 8888;

        # Basic rate limiting: 10 requests/second
        location /api {
            ratelimit_rate 10r/s;
            proxy_pass http://backend;
        }

        # Custom rate with burst
        location /api/heavy {
            ratelimit_rate 5r/s;
            ratelimit_burst 10;
            proxy_pass http://backend;
        }

        # Strict rate limiting
        location /login {
            ratelimit_rate 3r/s;
            proxy_pass http://auth;
        }
    }
}
```

### Behavior

- Rate limiting is per client IP address
- Uses a 1-second fixed window algorithm
- Returns HTTP 429 (Too Many Requests) when limit exceeded
- Runs in the preaccess phase
- Storage is per-worker (not shared between workers)
- Maximum 1024 unique IP entries tracked per worker (LRU eviction)

### Algorithm

The module uses a simple fixed window counter:
- Each IP gets a counter that resets every second
- Requests are allowed if `count < rate + burst`
- When the window expires, the counter resets to 0
