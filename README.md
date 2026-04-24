## Nginz

nginz is a `nginx` module writer. It allows one to write nginx modules in `zig`. so far it 
is based on official nginx release 1.30.0 and zig 0.16. nginz is tested with linux only.

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

For nftables-related work, `tests/nftset/` now includes a Docker-isolated live nftables suite.
It provisions temporary tables/sets inside a disposable container namespace via `sudo docker`,
so nobody's host nftables ruleset needs to be modified during development or CI-like validation.

> [!NOTE]
> The SSL zig bindings are generated with `OpenSSL 3`.

> [!CAUTION]
> Many nginx structs have variable sizes, as they depend on the opt-in features at compile time.
> Options such as `--with-compat`, `--with-http_ssl_module` could drastically affect many structs.
> To ensure binary compatibility, one needs to adjust the zig bindings accordingly. The project
> defaults to the configure options showed below in `main` branch. The `docker` branch configures
> as many features as the official nginx [docker][3] debian release. Note the structs differences
> in the test asserts.
>
> After upgrading the nginx submodule, run `zig build check-layout` (or `zig build check-layout
> -Ddocker=true` for the docker config) to verify C and Zig struct layouts match. Mismatches
> are typically caused by `spare` array sizes in `ngx.zig` not being adjusted when nginx adds
> new conditional fields that consume `NGX_COMPAT_BEGIN` slots.

To ease the development. A `nginz` binary is built as an artifact along with the module objects.
It is a nginx wrapper, and by default built with

`./auto/configure --with-http_ssl_module --with-http_xslt_module --with-debug`

nginz also has built-in `ngx_http_js_module` with quickjs engine.

For the higher-level product and module direction, see [ROADMAP.md](ROADMAP.md).

A module `echoz` is provided as an example, it is a tribute to @[agentzh][2] and his [echo][1] module. `echoz`
so far is a simplified version of `echo` and it misses some of the directives.

By all means, deploy the module objects with your own binary building toolchains.

## Integrating Modules with Stock Nginx

nginz provides a `package` build step that creates nginx-compatible module packages. Each package
contains the compiled object file and a `config` script for nginx's `./configure --add-module`.

### Building Module Packages

```bash
zig build package
```

This creates `zig-out/modules/` with a directory for each module:

```
zig-out/modules/
  echoz/
    config                      # nginx configure script
    ngx_http_echoz_module.o     # compiled module object
  jwt/
    config
    libcjson.a                  # bundled dependency
    ngx_http_jwt_module.o
  ...
```

### Using with Nginx

```bash
cd /path/to/nginx-source
./configure \
  --with-http_ssl_module \
  --add-module=/path/to/nginz/zig-out/modules/echoz \
  --add-module=/path/to/nginz/zig-out/modules/jwt
make
make install
```

### Important Notes

- **nginx version**: Modules are built against nginx 1.30.0. Using with other versions may cause
  compatibility issues.
- **Filter modules**: Modules containing filters (echoz, wechatpay, oidc, requestid, cache-tags,
  transform) have ordering dependencies. Their position relative to nginx's built-in filters is
  determined by `--add-module` order.
- **Dependencies**: Some modules require system libraries (e.g., pgrest needs `-lpq`). The config
  script handles this automatically.

## Module Status

21 modules total. All modules have integration tests and individual README documentation.

### Feature Ready (19)

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
| **circuit-breaker** | Failure detection with half-open recovery |
| **prometheus** | Native /metrics endpoint with histograms |
| **cache-tags** | Tag-based cache invalidation |
| **nftset** | nftables-backed IP allow/block checks via raw Netlink lookup |
| **oidc** | OpenID Connect SSO with PKCE and RS256 ID token verification |
| **pgrest** | PostgreSQL REST API with JWT auth, content negotiation (JSON/CSV/XML) |
| **healthcheck** | Health/readiness endpoints with shared-memory state and active HTTP probing |
| **wechatpay** | WeChat Pay signature verification |

### Implemented with Limitations (1)

| Module | Description | Limitations |
|--------|-------------|-------------|
| **acme** | Let's Encrypt certificate automation | Not tested with real ACME servers; multi-worker sequential flow is covered via shared-memory sessions and mock-backed tests, but concurrent trigger hardening is still limited |

### Reference (1)

| Module | Description |
|--------|-------------|
| **hello** | Minimal module example |

[1]: https://github.com/openresty/echo-nginx-module "echo"
[2]: https://github.com/agentzh "agentzh"
[3]: https://github.com/nginxinc/docker-nginx/blob/master/stable/debian/Dockerfile "docker"
