## Cache Tags Module

Tag-based cache invalidation for nginx responses.

### Status

**Implemented** - Basic functionality complete

### Features

- **Tag Collection**: Captures `Cache-Tag` header from upstream responses
- **Per-Worker Storage**: Stores URL-to-tags mapping in worker memory
- **Purge Endpoint**: REST API for invalidating cache entries by tag
- **Pattern Matching**: Purge by exact tag or wildcard pattern

### Directives

#### cache_tags

*syntax:* `cache_tags on|off;`
*context:* `location`

Enable cache tag collection for responses in this location. The module captures the `Cache-Tag` header from upstream responses.

#### cache_tags_purge

*syntax:* `cache_tags_purge;`
*context:* `location`

Enable the purge endpoint at this location. Accepts POST requests with tag parameter.

### Usage

```nginx
http {
    server {
        listen 8080;

        # Application with cache tags
        location /api {
            proxy_pass http://backend;
            cache_tags on;
        }

        # Purge endpoint
        location /cache/purge {
            cache_tags_purge;

            # Restrict access
            allow 127.0.0.1;
            deny all;
        }
    }
}
```

### Upstream Response

Your backend should include the `Cache-Tag` header:

```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Tag: user-123, product-456, category-electronics
```

### Purge API

```bash
# Purge by exact tag
curl -X POST "http://localhost:8080/cache/purge?tag=user-123"

# Response
{"purged": 5, "tag": "user-123"}
```

### Limitations

Current implementation has these limitations:

- **Per-Worker Storage**: Tags are stored per-worker and not shared
- **Memory Only**: Tags are lost on worker restart/reload
- **No Wildcards Yet**: Pattern matching limited to exact tags

### Future Enhancements

- **Shared Memory**: Cross-worker tag storage using nginx shared zones
- **Wildcard Purge**: Support patterns like `user-*` or `product-*`
- **Bulk Purge**: Purge multiple tags in one request
- **Tag TTL**: Automatic expiration of stale tags
- **Persistence**: Optional disk-backed storage

### References

- [Fastly Surrogate Keys](https://docs.fastly.com/en/guides/purging-api-cache-with-surrogate-keys)
- [Varnish Cache Tags](https://varnish-cache.org/docs/trunk/users-guide/purging.html)

### Documentation Audit Checklist

- [x] Audit date: 2026-04-10
- [x] Bun integration coverage exists at `tests/cache-tags/`.
- [x] Gap recorded: the feature list says wildcard pattern purge is available, but the current limitations/future sections and code/tests only support exact-tag purge.
- [x] Gap recorded: README documents `cache_tags on|off;`, but the current command surface and passing test config use `cache_tags;` with no argument.
- [x] Gap recorded: README says the purge endpoint accepts POST requests, but the current purge handler allows GET or DELETE.
- [x] No additional documentation gaps were identified in this audit pass.
