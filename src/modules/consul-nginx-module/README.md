## Service Discovery Module

Dynamic upstream resolution using Consul, etcd, or DNS SRV records.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Consul Integration**: Fetch healthy service instances from Consul
- **etcd Support**: Service discovery via etcd key-value store
- **DNS SRV**: Standard DNS SRV record resolution
- **Health-Aware**: Only route to healthy instances
- **Watch/Polling**: Real-time updates or configurable polling interval
- **Datacenter Support**: Multi-datacenter routing for Consul
- **Tag Filtering**: Filter services by tags

### Planned Directives

#### consul

*syntax:* `consul <address>;`  
*context:* `http`

Consul agent address.

#### consul_service

*syntax:* `consul_service <name> [tag=<tag>] [dc=<datacenter>];`  
*context:* `upstream`

Resolve upstream servers from Consul service.

#### consul_refresh

*syntax:* `consul_refresh <time>;`  
*default:* `consul_refresh 5s;`  
*context:* `http`

Interval for polling Consul for updates.

#### consul_token

*syntax:* `consul_token <token>;`  
*context:* `http`

Consul ACL token for authentication.

### Planned Usage

```nginx
http {
    consul 127.0.0.1:8500;
    consul_refresh 5s;
    consul_token "your-acl-token";
    
    upstream api {
        consul_service api-service tag=production;
        # Servers populated dynamically from Consul
    }
    
    upstream cache {
        consul_service redis tag=primary dc=us-east-1;
    }
    
    server {
        location /api {
            proxy_pass http://api;
        }
    }
}
```

### Consul Service Example

Register service in Consul:
```json
{
  "Name": "api-service",
  "Tags": ["production", "v2"],
  "Port": 8080,
  "Check": {
    "HTTP": "http://localhost:8080/health",
    "Interval": "10s"
  }
}
```

### References

- [Consul HTTP API](https://www.consul.io/api-docs)
- [nginx-upsync-module](https://github.com/weibocom/nginx-upsync-module)
- [NGINX Plus Service Discovery](https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/#service-discovery)
