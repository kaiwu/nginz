## Nginz

nginz is a `nginx` module writer. It allows one to write nginx modules in `zig`. so far it 
is based on official nginx release 1.29.4 and zig 0.15. nginz is tested with linux only.

A typical workflow is following: 

```
$ git submodule init
$ git submodule update
$ rm -rf .zig-cache zig-out submodules/nginx/objs # might needed for a fresh build
$ zig build
$ zig build test
$ bun test
```

Nginx development requires some system library dependencies, which shall be addressed first.
A Dockerfile is provided as reference so that one can build their own dev image.

> [!NOTE]
> The SSL zig bindings are generated with `OpenSSL 3`.

> [!CAUTION]
> Many nginx structs have variable sizes, as they depend on the opt-in features at compile time.
> Options such as `--with-compat`, `--with-http_ssl_module` could drastically affect many structs.
> To ensure binary compatibility, one needs to adjust the zig bindings accordingly. The project
> defaults to the configure options showed below in `main` branch. The `docker` branch configures
> as many features as the official nginx [docker][3] debian release. Note the structs differences
> in the test asserts.

To ease the development. A `nginz` binary is built as an artifact along with the module objects.
It is a nginx wrapper, and by default built with

`./auto/configure --with-http_ssl_module --with-http_xslt_module --with-debug`

nginz also has built-in `ngx_http_js_module` with quickjs engine.

A module `echoz` is provided as an example, it is a tribute to @[agentzh][2] and his [echo][1] module. `echoz`
so far is a simplified version of `echo` and it misses some of the directives.

By all means, deploy the module objects with your own binary building toolchains.

## Module Status

All modules have integration tests. Each module has its own README with detailed documentation.

### Production Ready

| Module | Description |
|--------|-------------|
| **echoz** | Echo/response module with variable interpolation and filters |
| **jwt** | JWT validation (HS256), claims extraction |
| **jsonschema** | JSON Schema request/response validation |
| **graphql** | Query depth limiting, introspection control |
| **transform** | JSON path extraction and transformation |
| **waf** | SQL injection and XSS pattern detection |
| **canary** | Traffic splitting (percentage, header, cookie routing) |
| **consul** | Service discovery and KV store integration |
| **redis** | Redis commands via RESP protocol |
| **requestid** | UUID4 generation and X-Request-ID propagation |
| **ratelimit** | Fixed window rate limiting per IP |

### Working with Limitations

| Module | Description | Limitations |
|--------|-------------|-------------|
| **oidc** | OpenID Connect SSO with PKCE | Nginx variables (`$oidc_claim_*`) not yet implemented |
| **acme** | Let's Encrypt certificate automation | Not tested with real ACME servers; single worker only |
| **circuit-breaker** | Failure detection with half-open recovery | Per-worker state only (no shared memory) |
| **prometheus** | Native /metrics endpoint | Per-worker counters; no histograms |
| **healthcheck** | Health status endpoint | Passive only (no active probing) |
| **cache-tags** | Tag-based cache invalidation | Per-worker storage; lost on restart |
| **pgrest** | PostgreSQL REST API with JWT role-based access | Accept header ignored (JSON only) |
| **wechatpay** | WeChat Pay signature verification | Some error paths have TODOs |

### Reference

| Module | Description |
|--------|-------------|
| **hello** | Minimal module example |



[1]: https://github.com/openresty/echo-nginx-module "echo"
[2]: https://github.com/agentzh "agentzh"
[3]: https://github.com/nginxinc/docker-nginx/blob/master/stable/debian/Dockerfile "docker"
