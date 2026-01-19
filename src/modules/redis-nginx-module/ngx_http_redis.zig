const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
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
const NChain = ngx.buf.NChain;

extern var ngx_http_core_module: ngx_module_t;

// Redis errors
const RedisError = error{
    ConnectionFailed,
    SendFailed,
    RecvFailed,
    ProtocolError,
    KeyNotFound,
    OOM,
};

// Location config for redis directives
const redis_loc_conf = extern struct {
    host: ngx_str_t,
    port: ngx_uint_t,
    key: ngx_str_t,
    enabled: ngx_flag_t,
};

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(redis_loc_conf, cf.*.pool)) |p| {
        p.*.port = 6379;
        p.*.enabled = 0;
        p.*.host = ngx.string.ngx_null_str;
        p.*.key = ngx.string.ngx_null_str;
        return p;
    }
    return null;
}

fn merge_loc_conf(
    cf: [*c]ngx_conf_t,
    parent: ?*anyopaque,
    child: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    const prev = core.castPtr(redis_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(redis_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.host.len == 0) c.*.host = prev.*.host;
    if (c.*.key.len == 0) c.*.key = prev.*.key;
    if (c.*.port == 6379 and prev.*.port != 6379) c.*.port = prev.*.port;

    return conf.NGX_CONF_OK;
}

// Parse host:port from redis_pass directive
fn parse_host_port(arg: ngx_str_t) struct { host: ngx_str_t, port: u16 } {
    var host = arg;
    var port: u16 = 6379;

    // Find colon separator
    var i: usize = 0;
    while (i < arg.len) : (i += 1) {
        if (arg.data[i] == ':') {
            host.len = i;
            // Parse port number
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
        // Get the argument (host:port)
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

// Build RESP protocol GET command: *2\r\n$3\r\nGET\r\n$<len>\r\n<key>\r\n
fn build_get_command(key: ngx_str_t, buffer: []u8) usize {
    var pos: usize = 0;

    // Array with 2 elements
    buffer[pos] = '*';
    pos += 1;
    buffer[pos] = '2';
    pos += 1;
    buffer[pos] = '\r';
    pos += 1;
    buffer[pos] = '\n';
    pos += 1;

    // First element: GET (bulk string)
    buffer[pos] = '$';
    pos += 1;
    buffer[pos] = '3';
    pos += 1;
    buffer[pos] = '\r';
    pos += 1;
    buffer[pos] = '\n';
    pos += 1;
    buffer[pos] = 'G';
    pos += 1;
    buffer[pos] = 'E';
    pos += 1;
    buffer[pos] = 'T';
    pos += 1;
    buffer[pos] = '\r';
    pos += 1;
    buffer[pos] = '\n';
    pos += 1;

    // Second element: key (bulk string)
    buffer[pos] = '$';
    pos += 1;

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
    @memcpy(buffer[pos..][0..len_pos], len_buf[0..len_pos]);
    pos += len_pos;

    buffer[pos] = '\r';
    pos += 1;
    buffer[pos] = '\n';
    pos += 1;

    // Write key
    @memcpy(buffer[pos..][0..key.len], core.slicify(u8, key.data, key.len));
    pos += key.len;

    buffer[pos] = '\r';
    pos += 1;
    buffer[pos] = '\n';
    pos += 1;

    return pos;
}

// Parse RESP bulk string response: $<len>\r\n<data>\r\n or $-1\r\n (nil)
fn parse_bulk_string(response: []const u8) ?[]const u8 {
    if (response.len < 4) return null;

    // Check for bulk string marker
    if (response[0] != '$') return null;

    // Find first \r\n to get length
    var i: usize = 1;
    var is_negative = false;
    if (response[i] == '-') {
        is_negative = true;
        i += 1;
    }

    var len: isize = 0;
    while (i < response.len and response[i] != '\r') : (i += 1) {
        if (response[i] >= '0' and response[i] <= '9') {
            len = len * 10 + @as(isize, response[i] - '0');
        }
    }

    if (is_negative) {
        // Nil response ($-1\r\n)
        return null;
    }

    // Skip \r\n after length
    if (i + 2 > response.len) return null;
    i += 2; // skip \r\n

    // Extract data
    const data_len: usize = @intCast(len);
    if (i + data_len > response.len) return null;

    return response[i..][0..data_len];
}

// Parse RESP error response: -ERR <message>\r\n
fn parse_error(response: []const u8) ?[]const u8 {
    if (response.len < 2) return null;
    if (response[0] != '-') return null;

    var i: usize = 1;
    while (i < response.len and response[i] != '\r') : (i += 1) {}
    return response[1..i];
}

// Simple blocking TCP connection to Redis
const Socket = struct {
    fd: i32,

    pub fn connect(host: []const u8, port: u16) !Socket {
        const c = @cImport({
            @cInclude("sys/socket.h");
            @cInclude("netinet/in.h");
            @cInclude("arpa/inet.h");
            @cInclude("unistd.h");
            @cInclude("string.h");
            @cInclude("netdb.h");
        });

        const fd = c.socket(c.AF_INET, c.SOCK_STREAM, 0);
        if (fd < 0) return RedisError.ConnectionFailed;

        // Prepare host string (null-terminated)
        var host_buf: [256]u8 = undefined;
        if (host.len >= host_buf.len) return RedisError.ConnectionFailed;
        @memcpy(host_buf[0..host.len], host);
        host_buf[host.len] = 0;

        var addr: c.struct_sockaddr_in = undefined;
        @memset(@as([*]u8, @ptrCast(&addr))[0..@sizeOf(c.struct_sockaddr_in)], 0);
        addr.sin_family = c.AF_INET;
        addr.sin_port = c.htons(port);

        // Try parsing as IP address first
        if (c.inet_pton(c.AF_INET, &host_buf, &addr.sin_addr) != 1) {
            // Not an IP, try resolving hostname
            const hints = c.struct_addrinfo{
                .ai_family = c.AF_INET,
                .ai_socktype = c.SOCK_STREAM,
                .ai_protocol = 0,
                .ai_flags = 0,
                .ai_addrlen = 0,
                .ai_addr = null,
                .ai_canonname = null,
                .ai_next = null,
            };
            var result: ?*c.struct_addrinfo = null;
            if (c.getaddrinfo(&host_buf, null, &hints, &result) != 0) {
                _ = c.close(fd);
                return RedisError.ConnectionFailed;
            }
            if (result) |res| {
                defer c.freeaddrinfo(res);
                if (res.ai_addr) |ai_addr| {
                    const sin: *c.struct_sockaddr_in = @ptrCast(@alignCast(ai_addr));
                    addr.sin_addr = sin.sin_addr;
                }
            }
        }

        if (c.connect(fd, @ptrCast(&addr), @sizeOf(c.struct_sockaddr_in)) < 0) {
            _ = c.close(fd);
            return RedisError.ConnectionFailed;
        }

        return Socket{ .fd = fd };
    }

    pub fn send(self: Socket, data: []const u8) !void {
        const c = @cImport({
            @cInclude("sys/socket.h");
        });
        const sent = c.send(self.fd, data.ptr, data.len, 0);
        if (sent < 0) return RedisError.SendFailed;
    }

    pub fn recv(self: Socket, buffer: []u8) !usize {
        const c = @cImport({
            @cInclude("sys/socket.h");
        });
        const received = c.recv(self.fd, buffer.ptr, buffer.len, 0);
        if (received < 0) return RedisError.RecvFailed;
        return @intCast(received);
    }

    pub fn close(self: Socket) void {
        const c = @cImport({
            @cInclude("unistd.h");
        });
        _ = c.close(self.fd);
    }
};

// Get key to query - uses URI path stripped of leading slash
fn get_redis_key(r: [*c]ngx_http_request_t, lccf: [*c]redis_loc_conf) ngx_str_t {
    // If key is configured, use it
    if (lccf.*.key.len > 0) {
        return lccf.*.key;
    }

    // Otherwise use URI without leading slash
    var key = r.*.uri;
    if (key.len > 0 and key.data[0] == '/') {
        key.data += 1;
        key.len -= 1;
    }
    return key;
}

fn send_json_response(r: [*c]ngx_http_request_t, value: ?[]const u8, status: ngx_uint_t) ngx_int_t {
    // Build JSON response
    var json_buf: [8192]u8 = undefined;
    var json_len: usize = 0;

    if (value) |v| {
        // {"value":"..."}
        const prefix = "{\"value\":\"";
        @memcpy(json_buf[json_len..][0..prefix.len], prefix);
        json_len += prefix.len;

        // Escape JSON special characters
        for (v) |c| {
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
        // null response
        const null_json = "{\"value\":null}";
        @memcpy(json_buf[0..null_json.len], null_json);
        json_len = null_json.len;
    }

    // Set content type
    r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
    r.*.headers_out.content_type_len = 16;
    r.*.headers_out.status = status;
    r.*.headers_out.content_length_n = @intCast(json_len);

    // Send headers
    const rc = http.ngx_http_send_header(r);
    if (rc == NGX_ERROR or rc > NGX_OK) {
        return rc;
    }

    // Allocate buffer
    const b = core.castPtr(ngx_buf_t, core.ngx_pcalloc(r.*.pool, @sizeOf(ngx_buf_t))) orelse return NGX_ERROR;
    const data = core.castPtr(u8, core.ngx_pnalloc(r.*.pool, json_len)) orelse return NGX_ERROR;

    @memcpy(core.slicify(u8, data, json_len), json_buf[0..json_len]);

    b.*.pos = data;
    b.*.last = data + json_len;
    b.*.flags.memory = true;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    var out: ngx_chain_t = undefined;
    out.buf = b;
    out.next = null;

    return http.ngx_http_output_filter(r, &out);
}

fn send_error_response(r: [*c]ngx_http_request_t, message: []const u8, status: ngx_uint_t) ngx_int_t {
    var json_buf: [512]u8 = undefined;
    const prefix = "{\"error\":\"";
    @memcpy(json_buf[0..prefix.len], prefix);
    var pos = prefix.len;
    @memcpy(json_buf[pos..][0..message.len], message);
    pos += message.len;
    const suffix = "\"}";
    @memcpy(json_buf[pos..][0..suffix.len], suffix);
    pos += suffix.len;

    // Set content type
    r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
    r.*.headers_out.content_type_len = 16;
    r.*.headers_out.status = status;
    r.*.headers_out.content_length_n = @intCast(pos);

    const rc = http.ngx_http_send_header(r);
    if (rc == NGX_ERROR or rc > NGX_OK) {
        return rc;
    }

    const b = core.castPtr(ngx_buf_t, core.ngx_pcalloc(r.*.pool, @sizeOf(ngx_buf_t))) orelse return NGX_ERROR;
    const data = core.castPtr(u8, core.ngx_pnalloc(r.*.pool, pos)) orelse return NGX_ERROR;

    @memcpy(core.slicify(u8, data, pos), json_buf[0..pos]);

    b.*.pos = data;
    b.*.last = data + pos;
    b.*.flags.memory = true;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    var out: ngx_chain_t = undefined;
    out.buf = b;
    out.next = null;

    return http.ngx_http_output_filter(r, &out);
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

    // Get host string
    const host_slice = core.slicify(u8, lccf.*.host.data, lccf.*.host.len);

    // Connect to Redis
    const socket = Socket.connect(host_slice, @intCast(lccf.*.port)) catch {
        return send_error_response(r, "connection_failed", http.NGX_HTTP_BAD_GATEWAY);
    };
    defer socket.close();

    // Get key to query
    const key = get_redis_key(r, lccf);

    // Build GET command
    var cmd_buf: [1024]u8 = undefined;
    const cmd_len = build_get_command(key, &cmd_buf);

    // Send command
    socket.send(cmd_buf[0..cmd_len]) catch {
        return send_error_response(r, "send_failed", http.NGX_HTTP_BAD_GATEWAY);
    };

    // Receive response
    var recv_buf: [8192]u8 = undefined;
    const recv_len = socket.recv(&recv_buf) catch {
        return send_error_response(r, "recv_failed", http.NGX_HTTP_BAD_GATEWAY);
    };

    if (recv_len == 0) {
        return send_error_response(r, "empty_response", http.NGX_HTTP_BAD_GATEWAY);
    }

    // Parse response
    const response = recv_buf[0..recv_len];

    // Check for error response
    if (response[0] == '-') {
        if (parse_error(response)) |err_msg| {
            return send_error_response(r, err_msg, http.NGX_HTTP_INTERNAL_SERVER_ERROR);
        }
        return send_error_response(r, "redis_error", http.NGX_HTTP_INTERNAL_SERVER_ERROR);
    }

    // Parse bulk string response
    const value = parse_bulk_string(response);
    return send_json_response(r, value, http.NGX_HTTP_OK);
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
    try expectEqual(ngx_http_redis_module.version, 1027004);
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

test "build_get_command" {
    var cmd_buffer: [256]u8 = undefined;
    const len = build_get_command(ngx_string("mykey"), &cmd_buffer);
    const expected = "*2\r\n$3\r\nGET\r\n$5\r\nmykey\r\n";
    try expect(std.mem.eql(u8, cmd_buffer[0..len], expected));
}

test "parse_bulk_string" {
    // Normal response
    const resp1 = "$5\r\nhello\r\n";
    const val1 = parse_bulk_string(resp1);
    try expect(val1 != null);
    try expect(std.mem.eql(u8, val1.?, "hello"));

    // Nil response
    const resp2 = "$-1\r\n";
    const val2 = parse_bulk_string(resp2);
    try expect(val2 == null);

    // Empty string
    const resp3 = "$0\r\n\r\n";
    const val3 = parse_bulk_string(resp3);
    try expect(val3 != null);
    try expectEqual(val3.?.len, 0);
}

test "parse_error" {
    const resp = "-ERR unknown command\r\n";
    const err = parse_error(resp);
    try expect(err != null);
    try expect(std.mem.eql(u8, err.?, "ERR unknown command"));
}
