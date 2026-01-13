# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Nginz is a framework for writing nginx modules in Zig. It wraps nginx 1.29.4 and requires Zig 0.15. The project produces a `nginz` binary (nginx wrapper) and individual module object files.

## Build Commands

```bash
# Initial setup
git submodule init && git submodule update

# Build everything
zig build

# Run all Zig unit tests
zig build test

# Run integration tests for a specific module
bun test tests/<module-name>/
```

## Architecture

### Directory Structure
- `src/ngx/` - Zig bindings for nginx internals (nginx.zig is the main entry point)
- `src/modules/<name>-nginx-module/` - Individual nginx modules written in Zig
- `src/ngz_modules.zig` - Module registration and load order (critical for phase ordering)
- `tests/<module>/` - Integration tests with nginx.conf and JS test files

### Module Registration Order

Module order in `ngz_modules.zig` is critical. Access phase modules must be placed together after limit modules:
```zig
// Limit modules
&ngx_http_limit_conn_module,
&ngx_http_limit_req_module,

// Access phase modules (custom) - must be grouped here
&ngx_http_wechatpay_module,
&ngx_http_jsonschema_module,
&ngx_http_ratelimit_module,
...
```

### nginx HTTP Phases

Understanding nginx phases is essential:
1. REWRITE phase - `return` directive runs here
2. ACCESS phase - authentication/authorization handlers
3. CONTENT phase - response generation (`echozn`, `proxy_pass`)

**Critical**: Access phase handlers won't execute if `return` is used in the same location block (return runs in rewrite phase before access). Use `echozn` or `proxy_pass` for content.

### Writing a New Module

Each module needs:
1. `src/modules/<name>-nginx-module/ngx_http_<name>.zig` - Module implementation
2. Entry in `build.zig` modules array
3. Entry in `src/ngz_modules.zig` (both `ngx_modules` array and `ngx_module_names`)
4. `tests/<name>/nginx.conf` and `<name>.test.js` for integration tests

Module structure pattern:
```zig
const ngx = @import("ngx");

// Location config struct
const my_loc_conf = extern struct { ... };

// Handlers (use `export fn` for debuggable symbols)
export fn ngx_http_mymodule_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t { ... }

// Config functions
fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque { ... }
fn merge_loc_conf(...) callconv(.c) [*c]u8 { ... }

// Phase registration in postconfiguration
fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register handler in appropriate phase (e.g., NGX_HTTP_ACCESS_PHASE)
}

// Module exports
export const ngx_http_mymodule_module_ctx = ngx_http_module_t{ ... };
export const ngx_http_mymodule_commands = [_]ngx_command_t{ ... };
export var ngx_http_mymodule_module = ngx.module.make_module(...);
```

### Ngx Bindings

Access nginx APIs through the ngx namespace:
- `ngx.core` - Core types (ngx_str_t, ngx_pool_t, NGX_OK/ERROR/DECLINED)
- `ngx.http` - HTTP types and functions
- `ngx.conf` - Configuration parsing
- `ngx.cjson` - JSON parsing via cJSON wrapper
- `ngz_log_error`- Logging

### Reference modules
- `echoz-nginx-module` - content module, header filter module
- `wechatpay-nginx-module` - upstream, access module, header filter module, json encode/decode

### Testing

Integration tests use Bun and run against a live nginx instance:
```bash
bun test tests/jsonschema/
```

Test nginx.conf files should use `error_log logs/error.log debug;` for debugging.

Comment `cleanupRuntime(MODULE);` for the `test.js` file to keep the runtime folder and its nginx logs from being removed

### Debugging

For GDB debugging, Zig mangles function names with module prefix:
```gdb
break ngx_http_jsonschema.ngx_http_jsonschema_access_handler
```

Use `nm zig-out/bin/nginz | grep <module>` to find actual symbol names.
