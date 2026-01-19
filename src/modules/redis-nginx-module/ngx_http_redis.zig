const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_AGAIN = core.NGX_AGAIN;
const NGX_DECLINED = core.NGX_DECLINED;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_pool_t = core.ngx_pool_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const ngx_sprintf = ngx.string.ngx_sprintf;
const NChain = ngx.buf.NChain;

extern var ngx_http_core_module: ngx_module_t;
extern var ngx_http_upstream_module: ngx_module_t;
extern var ngx_pagesize: ngx_uint_t;

// Redis RESP parsing state
const RespState = enum(c_int) {
    start, // Waiting for type byte
    reading_length, // Reading bulk string length
    reading_data, // Reading bulk string data
    done, // Parsing complete
    resp_error, // Parse error
};

// Location config for redis directives
const redis_loc_conf = extern struct {
    host: ngx_str_t,
    port: ngx_uint_t,
    key: ngx_str_t,
    enabled: ngx_flag_t,
    ups: http.ngx_http_upstream_conf_t,
};

// Per-request context
const redis_request_ctx = extern struct {
    lccf: [*c]redis_loc_conf,
    res: [*c]ngx_chain_t,
    key: ngx_str_t,
    state: RespState,
    data_len: isize, // Expected length from RESP (-1 for nil)
    data: ngx_str_t, // Copied data from Redis response
};

const redis_hide_headers = [_]ngx_str_t{
    ngx.string.ngx_null_str,
};

const RedisError = error{
    UpstreamCreateFailed,
    OutOfMemory,
};

fn init_upstream_conf(cf: [*c]http.ngx_http_upstream_conf_t) void {
    cf.*.buffering = 0;
    cf.*.buffer_size = 8 * ngx_pagesize;
    cf.*.ssl_verify = 0;
    cf.*.connect_timeout = 5000;
    cf.*.send_timeout = 5000;
    cf.*.read_timeout = 5000;
    cf.*.module = ngx_string("ngx_http_redis_module");
    cf.*.hide_headers = conf.NGX_CONF_UNSET_PTR;
    cf.*.pass_headers = conf.NGX_CONF_UNSET_PTR;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(redis_loc_conf, cf.*.pool)) |p| {
        p.*.port = 6379;
        p.*.enabled = 0;
        p.*.host = ngx.string.ngx_null_str;
        p.*.key = ngx.string.ngx_null_str;
        init_upstream_conf(&p.*.ups);
        return p;
    }
    return null;
}

fn merge_loc_conf(
    cf: [*c]ngx_conf_t,
    parent: ?*anyopaque,
    child: ?*anyopaque,
) callconv(.c) [*c]u8 {
    const prev = core.castPtr(redis_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(redis_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.host.len == 0) c.*.host = prev.*.host;
    if (c.*.key.len == 0) c.*.key = prev.*.key;
    if (c.*.port == 6379 and prev.*.port != 6379) c.*.port = prev.*.port;

    // Setup upstream headers hash
    if (c.*.enabled == 1) {
        var hash = ngx.hash.ngx_hash_init_t{
            .max_size = 100,
            .bucket_size = 1024,
            .name = @constCast("redis_headers_hash"),
        };
        if (http.ngx_http_upstream_hide_headers_hash(
            cf,
            &c.*.ups,
            &prev.*.ups,
            @constCast(&redis_hide_headers),
            &hash,
        ) != NGX_OK) {
            return conf.NGX_CONF_ERROR;
        }
    }

    return conf.NGX_CONF_OK;
}

// Parse host:port from redis_pass directive
fn parse_host_port(arg: ngx_str_t) struct { host: ngx_str_t, port: u16 } {
    var host = arg;
    var port: u16 = 6379;

    var i: usize = 0;
    while (i < arg.len) : (i += 1) {
        if (arg.data[i] == ':') {
            host.len = i;
            var p: u16 = 0;
            var j: usize = i + 1;
            while (j < arg.len) : (j += 1) {
                if (arg.data[j] >= '0' and arg.data[j] <= '9') {
                    p = p * 10 + @as(u16, arg.data[j] - '0');
                } else {
                    break;
                }
            }
            if (p > 0) port = p;
            break;
        }
    }

    return .{ .host = host, .port = port };
}

fn ngx_conf_set_redis_pass(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(redis_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const parsed = parse_host_port(arg.*);
            lccf.*.host = parsed.host;
            lccf.*.port = parsed.port;
            lccf.*.enabled = 1;

            // Set content handler
            if (core.castPtr(
                http.ngx_http_core_loc_conf_t,
                conf.ngx_http_conf_get_module_loc_conf(cf, &ngx_http_core_module),
            )) |clcf| {
                clcf.*.handler = ngx_http_redis_handler;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

// Build RESP GET command: *2\r\n$3\r\nGET\r\n$<len>\r\n<key>\r\n
fn build_get_command(key: ngx_str_t, pool: [*c]ngx_pool_t) !ngx_str_t {
    // Calculate buffer size: *2\r\n$3\r\nGET\r\n$<len>\r\n<key>\r\n
    // Max length digits = 20 for usize
    const max_size = 4 + 4 + 3 + 2 + 1 + 20 + 2 + key.len + 2;

    if (core.castPtr(u8, core.ngx_pnalloc(pool, max_size))) |data| {
        var pos: usize = 0;

        // *2\r\n
        const header = "*2\r\n$3\r\nGET\r\n$";
        @memcpy(data[pos..][0..header.len], header);
        pos += header.len;

        // Write key length as decimal
        var len_buf: [20]u8 = undefined;
        var len = key.len;
        var len_pos: usize = 0;
        if (len == 0) {
            len_buf[0] = '0';
            len_pos = 1;
        } else {
            while (len > 0) : (len_pos += 1) {
                len_buf[len_pos] = @intCast('0' + @mod(len, 10));
                len = @divTrunc(len, 10);
            }
            // Reverse
            var j: usize = 0;
            while (j < len_pos / 2) : (j += 1) {
                const tmp = len_buf[j];
                len_buf[j] = len_buf[len_pos - 1 - j];
                len_buf[len_pos - 1 - j] = tmp;
            }
        }
        @memcpy(data[pos..][0..len_pos], len_buf[0..len_pos]);
        pos += len_pos;

        // \r\n
        data[pos] = '\r';
        pos += 1;
        data[pos] = '\n';
        pos += 1;

        // Copy key
        @memcpy(data[pos..][0..key.len], core.slicify(u8, key.data, key.len));
        pos += key.len;

        // \r\n
        data[pos] = '\r';
        pos += 1;
        data[pos] = '\n';
        pos += 1;

        return ngx_str_t{ .data = data, .len = pos };
    }
    return RedisError.OutOfMemory;
}

// Get key to query
fn get_redis_key(r: [*c]ngx_http_request_t, lccf: [*c]redis_loc_conf) ngx_str_t {
    if (lccf.*.key.len > 0) {
        return lccf.*.key;
    }
    var key = r.*.uri;
    if (key.len > 0 and key.data[0] == '/') {
        key.data += 1;
        key.len -= 1;
    }
    return key;
}

////////////////////////////  REDIS UPSTREAM  //////////////////////////////////////////////////

fn ngx_http_redis_upstream_create_request(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    if (core.castPtr(
        redis_request_ctx,
        r.*.ctx[ngx_http_redis_module.ctx_index],
    )) |rctx| {
        const cmd = build_get_command(rctx.*.key, r.*.pool) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

        var chain = NChain.init(r.*.pool);
        var out = ngx_chain_t{
            .buf = core.nullptr(ngx_buf_t),
            .next = core.nullptr(ngx_chain_t),
        };
        const last = chain.allocStr(cmd, &out) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

        last.*.buf.*.flags.last_buf = true;
        last.*.buf.*.flags.last_in_chain = true;
        last.*.next = r.*.upstream.*.request_bufs;
        r.*.upstream.*.request_bufs = last;

        r.*.upstream.*.flags.header_sent = false;
        r.*.upstream.*.flags.request_sent = false;
        r.*.header_hash = 1;

        ngx.log.ngz_log_error(
            ngx.log.NGX_LOG_DEBUG,
            r.*.connection.*.log,
            0,
            "redis: sending GET command for key: %V",
            .{&rctx.*.key},
        );
    }
    return NGX_OK;
}

// Build JSON response from Redis value
fn build_json_response(rctx: [*c]redis_request_ctx, pool: [*c]ngx_pool_t) ?ngx_str_t {
    var json_buf: [8192]u8 = undefined;
    var json_len: usize = 0;

    if (rctx.*.data_len < 0) {
        // Nil response
        const null_json = "{\"value\":null}";
        @memcpy(json_buf[0..null_json.len], null_json);
        json_len = null_json.len;
    } else if (rctx.*.data.len > 0) {
        // Has data
        const prefix = "{\"value\":\"";
        @memcpy(json_buf[json_len..][0..prefix.len], prefix);
        json_len += prefix.len;

        const data_slice = core.slicify(u8, rctx.*.data.data, rctx.*.data.len);
        for (data_slice) |c| {
            if (json_len >= json_buf.len - 10) break;
            switch (c) {
                '"' => {
                    json_buf[json_len] = '\\';
                    json_len += 1;
                    json_buf[json_len] = '"';
                    json_len += 1;
                },
                '\\' => {
                    json_buf[json_len] = '\\';
                    json_len += 1;
                    json_buf[json_len] = '\\';
                    json_len += 1;
                },
                '\n' => {
                    json_buf[json_len] = '\\';
                    json_len += 1;
                    json_buf[json_len] = 'n';
                    json_len += 1;
                },
                '\r' => {
                    json_buf[json_len] = '\\';
                    json_len += 1;
                    json_buf[json_len] = 'r';
                    json_len += 1;
                },
                '\t' => {
                    json_buf[json_len] = '\\';
                    json_len += 1;
                    json_buf[json_len] = 't';
                    json_len += 1;
                },
                else => {
                    json_buf[json_len] = c;
                    json_len += 1;
                },
            }
        }

        const suffix = "\"}";
        @memcpy(json_buf[json_len..][0..suffix.len], suffix);
        json_len += suffix.len;
    } else {
        // Empty string
        const empty_json = "{\"value\":\"\"}";
        @memcpy(json_buf[0..empty_json.len], empty_json);
        json_len = empty_json.len;
    }

    // Allocate in pool
    if (core.castPtr(u8, core.ngx_pnalloc(pool, json_len))) |data| {
        @memcpy(core.slicify(u8, data, json_len), json_buf[0..json_len]);
        return ngx_str_t{ .data = data, .len = json_len };
    }
    return null;
}

// Parse RESP response - Redis doesn't use HTTP headers
// Response format: $<len>\r\n<data>\r\n or $-1\r\n (nil) or -ERR msg\r\n (error)
fn ngx_http_redis_upstream_process_header(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    if (core.castPtr(
        redis_request_ctx,
        r.*.ctx[ngx_http_redis_module.ctx_index],
    )) |rctx| {
        const u = r.*.upstream;
        const b = &u.*.buffer;

        // Need at least type byte + \r\n
        if (b.*.last <= b.*.pos + 3) {
            return NGX_AGAIN;
        }

        const type_byte = b.*.pos[0];

        switch (type_byte) {
            '$' => {
                // Bulk string: $<len>\r\n<data>\r\n
                var p: [*c]u8 = b.*.pos + 1;
                var is_negative = false;

                if (p.* == '-') {
                    is_negative = true;
                    p += 1;
                }

                // Parse length
                var len: isize = 0;
                while (p < b.*.last and p.* != '\r') : (p += 1) {
                    if (p.* >= '0' and p.* <= '9') {
                        len = len * 10 + @as(isize, p.* - '0');
                    } else {
                        rctx.*.state = .resp_error;
                        return NGX_ERROR;
                    }
                }

                // Need \r\n after length
                if (p + 1 >= b.*.last) {
                    return NGX_AGAIN;
                }

                if (p.* != '\r' or (p + 1).* != '\n') {
                    rctx.*.state = .resp_error;
                    return NGX_ERROR;
                }

                if (is_negative) {
                    // Nil response ($-1\r\n)
                    rctx.*.data_len = -1;
                    rctx.*.data = ngx.string.ngx_null_str;
                    rctx.*.state = .done;
                } else {
                    // Check if we have all data: len bytes + \r\n
                    const data_start = p + 2; // skip \r\n
                    const needed: usize = @intCast(len);
                    if (data_start + needed + 2 > b.*.last) {
                        return NGX_AGAIN;
                    }

                    // Copy data to request pool
                    if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, needed))) |data_copy| {
                        @memcpy(core.slicify(u8, data_copy, needed), core.slicify(u8, data_start, needed));
                        rctx.*.data = ngx_str_t{ .data = data_copy, .len = needed };
                    } else {
                        rctx.*.data = ngx.string.ngx_null_str;
                    }

                    rctx.*.data_len = len;
                    rctx.*.state = .done;
                }

                // Build JSON response and replace buffer content
                if (build_json_response(rctx, r.*.pool)) |json| {
                    // Replace buffer with JSON
                    b.*.pos = json.data;
                    b.*.last = json.data + json.len;

                    u.*.headers_in.status_n = 200;
                    u.*.headers_in.content_length_n = @intCast(json.len);
                    // Set length to 0 - we've consumed all upstream data
                    // The content is already in the buffer ready to be sent
                    u.*.length = 0;

                    // Set content-type header
                    r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
                    r.*.headers_out.content_type_len = 16;
                    r.*.headers_out.content_type_lowcase = null;
                }

                return NGX_OK;
            },
            '-' => {
                // Error response: -ERR message\r\n
                rctx.*.state = .resp_error;
                rctx.*.data_len = -1;
                rctx.*.data = ngx.string.ngx_null_str;

                // Build error JSON
                const error_json = "{\"error\":\"redis_error\"}";
                if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, error_json.len))) |data| {
                    @memcpy(core.slicify(u8, data, error_json.len), error_json);
                    b.*.pos = data;
                    b.*.last = data + error_json.len;
                }

                u.*.headers_in.status_n = 500;
                u.*.headers_in.content_length_n = error_json.len;
                u.*.length = 0;

                r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
                r.*.headers_out.content_type_len = 16;
                r.*.headers_out.content_type_lowcase = null;

                return NGX_OK;
            },
            '+' => {
                // Simple string: +OK\r\n
                rctx.*.data_len = 0;
                rctx.*.data = ngx.string.ngx_null_str;
                rctx.*.state = .done;

                // Build empty value JSON
                if (build_json_response(rctx, r.*.pool)) |json| {
                    b.*.pos = json.data;
                    b.*.last = json.data + json.len;
                    u.*.headers_in.status_n = 200;
                    u.*.headers_in.content_length_n = @intCast(json.len);
                    u.*.length = 0;

                    r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
                    r.*.headers_out.content_type_len = 16;
                    r.*.headers_out.content_type_lowcase = null;
                }

                return NGX_OK;
            },
            ':' => {
                // Integer: :1000\r\n - treat as string
                var p: [*c]u8 = b.*.pos + 1;
                while (p < b.*.last and p.* != '\r') : (p += 1) {}

                if (p >= b.*.last) return NGX_AGAIN;

                const int_len = core.ngz_len(b.*.pos + 1, p);
                if (core.castPtr(u8, core.ngx_pnalloc(r.*.pool, int_len))) |data_copy| {
                    @memcpy(core.slicify(u8, data_copy, int_len), core.slicify(u8, b.*.pos + 1, int_len));
                    rctx.*.data = ngx_str_t{ .data = data_copy, .len = int_len };
                } else {
                    rctx.*.data = ngx.string.ngx_null_str;
                }

                rctx.*.data_len = @intCast(int_len);
                rctx.*.state = .done;

                if (build_json_response(rctx, r.*.pool)) |json| {
                    b.*.pos = json.data;
                    b.*.last = json.data + json.len;
                    u.*.headers_in.status_n = 200;
                    u.*.headers_in.content_length_n = @intCast(json.len);
                    u.*.length = 0;

                    r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
                    r.*.headers_out.content_type_len = 16;
                    r.*.headers_out.content_type_lowcase = null;
                }

                return NGX_OK;
            },
            else => {
                rctx.*.state = .resp_error;
                return NGX_ERROR;
            },
        }
    }
    return NGX_ERROR;
}

fn ngx_http_redis_upstream_input_filter_init(
    ctx: ?*anyopaque,
) callconv(.c) ngx_int_t {
    if (core.castPtr(ngx_http_request_t, ctx)) |r| {
        const u = r.*.upstream;
        // Set length to the content we'll send - will be decremented in filter
        u.*.length = u.*.headers_in.content_length_n;
    }
    return NGX_OK;
}

fn ngx_http_redis_upstream_input_filter(
    ctx: ?*anyopaque,
    bytes: isize,
) callconv(.c) ngx_int_t {
    if (core.castPtr(ngx_http_request_t, ctx)) |r| {
        const u = r.*.upstream;
        const b = &u.*.buffer;

        // Find the end of out_bufs chain
        var ll: [*c][*c]ngx_chain_t = &u.*.out_bufs;
        while (ll.* != core.nullptr(ngx_chain_t)) {
            ll = &ll.*.*.next;
        }

        // Get a free buffer from the pool
        if (buf.ngx_chain_get_free_buf(r.*.pool, &u.*.free_bufs)) |cl| {
            cl.*.buf.*.flags.flush = true;
            cl.*.buf.*.flags.memory = true;

            // Point to the data in the upstream buffer
            const last = b.*.last;
            cl.*.buf.*.pos = last;
            b.*.last += @intCast(bytes);
            cl.*.buf.*.last = b.*.last;
            cl.*.buf.*.tag = u.*.output.tag;

            // Add to output chain
            ll.* = cl;

            // Decrement remaining length
            u.*.length -= bytes;

            // When done, allow connection reuse (Redis can pipeline)
            if (u.*.length == 0) {
                u.*.flags.keepalive = true;
            }

            return NGX_OK;
        }
    }
    return NGX_ERROR;
}

fn ngx_http_redis_upstream_finalize_request(
    r: [*c]ngx_http_request_t,
    rc: ngx_int_t,
) callconv(.c) void {
    // Upstream handles sending response through filter chain
    // This callback is for cleanup only
    _ = r;
    _ = rc;
}

fn create_upstream(
    r: [*c]ngx_http_request_t,
    rctx: [*c]redis_request_ctx,
) !ngx_int_t {
    if (http.ngx_http_upstream_create(r) != NGX_OK) {
        return RedisError.UpstreamCreateFailed;
    }

    const lccf: [*c]redis_loc_conf = rctx.*.lccf;
    r.*.upstream.*.conf = &lccf.*.ups;
    r.*.upstream.*.flags.buffering = false;
    r.*.upstream.*.create_request = ngx_http_redis_upstream_create_request;
    r.*.upstream.*.process_header = ngx_http_redis_upstream_process_header;
    r.*.upstream.*.input_filter_init = ngx_http_redis_upstream_input_filter_init;
    r.*.upstream.*.input_filter = ngx_http_redis_upstream_input_filter;
    r.*.upstream.*.finalize_request = ngx_http_redis_upstream_finalize_request;
    r.*.upstream.*.input_filter_ctx = r;

    if (core.ngz_pcalloc_c(
        http.ngx_http_upstream_resolved_t,
        r.*.pool,
    )) |resolved| {
        r.*.upstream.*.resolved = resolved;
        r.*.upstream.*.resolved.*.host = lccf.*.host;
        r.*.upstream.*.resolved.*.port = @intCast(lccf.*.port);
        r.*.upstream.*.flags.ssl = false;
        r.*.upstream.*.resolved.*.naddrs = 1;

        if (core.ngz_pcalloc_c(ngx_chain_t, r.*.pool)) |chain| {
            rctx.*.res = chain;
            rctx.*.res.*.next = core.nullptr(ngx_chain_t);
            r.*.main.*.flags0.count += 1;
            http.ngx_http_upstream_init(r);
            return core.NGX_DONE;
        }
    }

    return RedisError.OutOfMemory;
}

// Body handler - called after request body is read/discarded
export fn ngx_http_redis_body_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) void {
    if (core.castPtr(
        redis_request_ctx,
        r.*.ctx[ngx_http_redis_module.ctx_index],
    )) |rctx| {
        const rc = create_upstream(r, rctx) catch {
            http.ngx_http_finalize_request(r, http.NGX_HTTP_INTERNAL_SERVER_ERROR);
            return;
        };
        // Only finalize on error - upstream will handle completion
        if (rc != core.NGX_DONE) {
            http.ngx_http_finalize_request(r, rc);
        }
    } else {
        http.ngx_http_finalize_request(r, http.NGX_HTTP_INTERNAL_SERVER_ERROR);
    }
}

export fn ngx_http_redis_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        redis_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_redis_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.enabled != 1) {
        return NGX_DECLINED;
    }

    // Only handle GET requests
    if (r.*.method != http.NGX_HTTP_GET) {
        return http.NGX_HTTP_NOT_ALLOWED;
    }

    // Get or create request context
    const rctx = http.ngz_http_get_module_ctx(
        redis_request_ctx,
        r,
        &ngx_http_redis_module,
    ) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

    if (rctx.*.lccf == core.nullptr(redis_loc_conf)) {
        rctx.*.lccf = lccf;
        rctx.*.key = get_redis_key(r, lccf);
        rctx.*.state = .start;
        rctx.*.data_len = 0;
        rctx.*.data = ngx.string.ngx_null_str;
    }

    // Read request body (for GET, this will call handler immediately)
    // This is required before starting upstream
    const rc = http.ngx_http_read_client_request_body(r, ngx_http_redis_body_handler);
    if (rc >= http.NGX_HTTP_SPECIAL_RESPONSE) {
        return rc;
    }
    return core.NGX_DONE;
}

export const ngx_http_redis_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_redis_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("redis_pass"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_redis_pass,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("redis_key"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(redis_loc_conf, "key"),
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_redis_module = ngx.module.make_module(
    @constCast(&ngx_http_redis_commands),
    @constCast(&ngx_http_redis_module_ctx),
);

// Tests
const expectEqual = std.testing.expectEqual;
const expect = std.testing.expect;

test "redis module" {
    try expect(ngx_http_redis_module.version > 0);
}

test "parse_host_port" {
    const r1 = parse_host_port(ngx_string("localhost:6379"));
    try expectEqual(r1.port, 6379);
    try expectEqual(r1.host.len, 9);

    const r2 = parse_host_port(ngx_string("127.0.0.1:6380"));
    try expectEqual(r2.port, 6380);
    try expectEqual(r2.host.len, 9);

    const r3 = parse_host_port(ngx_string("redis.local"));
    try expectEqual(r3.port, 6379);
    try expectEqual(r3.host.len, 11);
}
