## Active Health Check Module

Active health checks for upstream servers, probing backends periodically rather than relying on passive failure detection.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Periodic Probes**: Configurable interval health checks to upstream servers
- **Custom Endpoints**: Define specific URI paths for health check requests
- **Match Conditions**: Validate response status codes, headers, and body content
- **Slow Start**: Gradually increase traffic to recovered servers
- **Mandatory Checks**: Require new servers to pass health checks before receiving traffic

### Planned Directives

#### health_check

*syntax:* `health_check [interval=time] [passes=number] [fails=number] [uri=uri] [match=name];`  
*default:* `—`  
*context:* `upstream`

Enable active health checks for the upstream.

#### health_check_timeout

*syntax:* `health_check_timeout <time>;`  
*default:* `health_check_timeout 1s;`  
*context:* `upstream`

Timeout for health check requests.

#### match

*syntax:* `match <name> { ... }`  
*context:* `http`

Define a match block for health check response validation.

### Planned Usage

```nginx
upstream backend {
    server 10.0.0.1:8080;
    server 10.0.0.2:8080;
    
    health_check interval=5s passes=2 fails=3 uri=/health;
    health_check_timeout 2s;
}

match healthy {
    status 200;
    body ~ "ok";
}
```

### References

- [NGINX Plus Active Health Checks](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-health-check/)
- [lua-resty-upstream-healthcheck](https://github.com/openresty/lua-resty-upstream-healthcheck)
