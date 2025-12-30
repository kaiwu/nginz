## Cache Tags Module

Tag-based cache invalidation for advanced cache management.

### Status

**Not Implemented** - Skeleton only

### Planned Features

- **Tag Association**: Associate cache entries with tags from response headers
- **Tag-Based Purge**: Invalidate all cache entries with a specific tag
- **Pattern Purge**: Purge by tag prefix or pattern
- **Multi-Tag**: Support multiple tags per cache entry
- **Surrogate Keys**: Support Fastly-style surrogate-key headers
- **API Endpoint**: REST API for cache management

### Planned Directives

#### cache_tags

*syntax:* `cache_tags on|off;`  
*default:* `cache_tags off;`  
*context:* `location`

Enable cache tagging.

#### cache_tags_header

*syntax:* `cache_tags_header <name>;`  
*default:* `cache_tags_header Cache-Tag;`  
*context:* `http`

Header containing cache tags (comma-separated).

#### cache_tags_purge

*syntax:* `cache_tags_purge on|off;`  
*context:* `location`

Enable purge endpoint at this location.

### Planned Usage

```nginx
http {
    proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=cache:10m;
    
    cache_tags_header Cache-Tag;
    
    server {
        location /api {
            proxy_cache cache;
            cache_tags on;
            
            proxy_pass http://backend;
        }
        
        # Purge endpoint
        location /cache/purge {
            cache_tags_purge on;
            
            # Restrict access
            allow 127.0.0.1;
            deny all;
        }
    }
}
```

### Backend Response Headers

Backend should send tags in response:
```http
HTTP/1.1 200 OK
Cache-Tag: product-123, category-electronics, homepage
Cache-Control: public, max-age=3600
```

### Purge API

```bash
# Purge all entries with tag "product-123"
curl -X PURGE http://localhost/cache/purge?tag=product-123

# Purge multiple tags
curl -X PURGE http://localhost/cache/purge?tag=category-electronics,homepage

# Purge by pattern
curl -X PURGE http://localhost/cache/purge?pattern=product-*
```

### References

- [Fastly Surrogate Keys](https://docs.fastly.com/en/guides/purging-api-cache-with-surrogate-keys)
- [Varnish Cache Tags](https://varnish-cache.org/docs/6.0/users-guide/purging.html)
- [NGINX Cache Purging](https://docs.nginx.com/nginx/admin-guide/content-cache/content-caching/#purging-content-from-the-cache)
