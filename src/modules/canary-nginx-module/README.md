## Canary/Traffic Splitting Module

Traffic splitting for canary deployments and A/B testing.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Percentage-Based**: Route N% of traffic to canary upstream
- **Header Routing**: Route based on specific header values
- **Cookie Routing**: Route based on cookie values (sticky sessions)
- **Weighted Upstreams**: Weighted distribution across multiple upstreams
- **Gradual Rollout**: Automatically increase canary percentage
- **Metrics Export**: Track traffic split for monitoring

### Planned Directives

#### canary

*syntax:* `canary on|off;`  
*default:* `canary off;`  
*context:* `location`

Enable canary routing.

#### canary_percentage

*syntax:* `canary_percentage <0-100>;`  
*context:* `location`

Percentage of traffic to route to canary upstream.

#### canary_header

*syntax:* `canary_header <name> <value>;`  
*context:* `location`

Route to canary when header matches value.

#### canary_cookie

*syntax:* `canary_cookie <name> <value>;`  
*context:* `location`

Route to canary when cookie matches value.

#### canary_upstream

*syntax:* `canary_upstream <upstream_name>;`  
*context:* `location`

Upstream to use for canary traffic.

### Planned Usage

```nginx
upstream stable {
    server 10.0.0.1:8080;
    server 10.0.0.2:8080;
}

upstream canary {
    server 10.0.1.1:8080;
}

server {
    # Percentage-based canary
    location /api {
        canary on;
        canary_percentage 10;  # 10% to canary
        canary_upstream canary;
        
        proxy_pass http://stable;
    }
    
    # Header-based routing (for testers)
    location /api/v2 {
        canary on;
        canary_header X-Canary true;
        canary_upstream canary;
        
        proxy_pass http://stable;
    }
    
    # Cookie-based sticky routing
    location /app {
        canary on;
        canary_cookie beta_user 1;
        canary_upstream canary;
        
        proxy_pass http://stable;
    }
}
```

### Variables

- `$canary_routed` - "1" if request routed to canary, "0" otherwise
- `$canary_upstream` - Name of upstream used

### References

- [Kubernetes Canary Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#canary-deployment)
- [NGINX Canary Deployments](https://www.nginx.com/blog/dynamic-a-b-testing-with-nginx-plus/)
