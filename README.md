## Nginz

nginz is a `nginx` module writer, which allows one to write nginx modules in `zig`. so far it 
is based on official nginx release 1.29.4 and zig 0.15. nginz is tested with linux only.

A typical workflow is following: 

```
$ git submodule init
$ git submodule update
$ zig build
$ zig build test
```

One might need to first address the system library dependencies, a requirement for nginx development.
specifically they are.
  
  * -lz
  * -lcrypt
  * -lcrypto
  * -lexslt
  * -lxslt
  * -lpcre
  * -lssl
  * -lgd

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

## Roadmap

The following modules are planned for implementation. They aim to provide NGINX Plus and OpenResty 
functionality in native Zig:

### High Priority

- ✅  **ngx-http-jwt-module** - JWT Authentication (HS256/RS256/ES256 validation, claims extraction)
- ✅  **ngx-http-healthcheck-module** - Active Health Checks (periodic probes, custom endpoints, slow-start)
- ✅  **ngx-http-ratelimit-module** - Advanced Rate Limiting (token bucket, sliding window, per-user limits)
- ✅  **ngx-http-redis-module** - Redis Client (GET command, JSON response)
- ✅  **ngx-http-circuit-breaker-module** - Circuit Breaker Pattern (failure detection, half-open state, gradual recovery)

### Medium Priority

- ✅  **ngx-http-waf-module** - Web Application Firewall (SQLi, XSS, OWASP rules, IP reputation)
- ✅  **ngx-http-acme-module** - Auto SSL/Let's Encrypt (certificate provisioning, renewal, ACME protocol)
- ✅  **ngx-http-oidc-module** - OpenID Connect (SSO with IdPs, token refresh, session management)
- ✅  **ngx-http-graphql-module** - GraphQL Gateway (query parsing, depth limiting, field auth, caching)
- ✅  **ngx-http-jsonschema-module** - Request/Response Validation (JSON schema validation, structured errors)
- ✅  **ngx-http-transform-module** - Request/Response Transformation (JSON-to-JSON, XML-to-JSON)
- ✅  **ngx-http-consul-module** - Service Discovery (Consul/etcd integration, dynamic upstreams)
- ✅  **ngx-http-canary-module** - Traffic Splitting (percentage-based, header/cookie routing, A/B testing)
- ✅  **ngx-http-prometheus-module** - Native Prometheus Metrics (request counts, latencies, /metrics endpoint)

### Low Priority

- ✅  **ngx-http-requestid-module** - Request Correlation (unique ID generation, X-Request-ID propagation)
- ✅  **ngx-http-cache-tags-module** - Cache Invalidation (tag-based entries, purge by tag/pattern)



[1]: https://github.com/openresty/echo-nginx-module "echo"
[2]: https://github.com/agentzh "agentzh"
[3]: https://github.com/nginxinc/docker-nginx/blob/master/stable/debian/Dockerfile "docker"
