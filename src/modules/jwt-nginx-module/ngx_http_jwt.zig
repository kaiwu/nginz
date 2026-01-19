const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const cjson = ngx.cjson;
const ssl = ngx.ssl;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;
const NGX_HTTP_UNAUTHORIZED = http.NGX_HTTP_UNAUTHORIZED;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NArray = ngx.array.NArray;
const CJSON = cjson.CJSON;

extern var ngx_http_core_module: ngx_module_t;

// OpenSSL HMAC bindings from ssl module
const HMAC_CTX = ssl.HMAC_CTX;
const HMAC_CTX_new = ssl.HMAC_CTX_new;
const HMAC_CTX_free = ssl.HMAC_CTX_free;
const HMAC_Init_ex = ssl.HMAC_Init_ex;
const HMAC_Update = ssl.HMAC_Update;
const HMAC_Final = ssl.HMAC_Final;
const EVP_sha256 = ssl.EVP_sha256;

const jwt_loc_conf = extern struct {
    enabled: ngx_flag_t,
    secret: ngx_str_t,
};

// Base64URL decode (JWT uses URL-safe base64 without padding)
fn base64url_decode(input: []const u8, output: []u8) ?usize {
    if (input.len == 0) return 0;

    // Convert base64url to standard base64
    var temp: [4096]u8 = undefined;
    if (input.len > temp.len) return null;

    var temp_len: usize = 0;
    for (input) |c| {
        temp[temp_len] = switch (c) {
            '-' => '+',
            '_' => '/',
            else => c,
        };
        temp_len += 1;
    }

    // Add padding if needed
    while (temp_len % 4 != 0) {
        temp[temp_len] = '=';
        temp_len += 1;
    }

    // Decode using standard base64
    const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    var out_idx: usize = 0;
    var i: usize = 0;

    while (i + 4 <= temp_len) : (i += 4) {
        const a = std.mem.indexOfScalar(u8, alphabet, temp[i]) orelse return null;
        const b = std.mem.indexOfScalar(u8, alphabet, temp[i + 1]) orelse return null;
        const c_val: usize = if (temp[i + 2] == '=') 0 else std.mem.indexOfScalar(u8, alphabet, temp[i + 2]) orelse return null;
        const d_val: usize = if (temp[i + 3] == '=') 0 else std.mem.indexOfScalar(u8, alphabet, temp[i + 3]) orelse return null;

        if (out_idx >= output.len) return null;
        output[out_idx] = @truncate((a << 2) | (b >> 4));
        out_idx += 1;

        if (temp[i + 2] != '=') {
            if (out_idx >= output.len) return null;
            output[out_idx] = @truncate(((b & 0x0f) << 4) | (c_val >> 2));
            out_idx += 1;
        }

        if (temp[i + 3] != '=') {
            if (out_idx >= output.len) return null;
            output[out_idx] = @truncate(((c_val & 0x03) << 6) | d_val);
            out_idx += 1;
        }
    }

    return out_idx;
}

// Compute HMAC-SHA256
fn hmac_sha256(key: []const u8, data: []const u8, output: *[32]u8) bool {
    const ctx = HMAC_CTX_new() orelse return false;
    defer HMAC_CTX_free(ctx);

    if (HMAC_Init_ex(ctx, key.ptr, @intCast(key.len), EVP_sha256(), null) != 1) {
        return false;
    }

    if (HMAC_Update(ctx, data.ptr, data.len) != 1) {
        return false;
    }

    var len: c_uint = 32;
    if (HMAC_Final(ctx, output, &len) != 1) {
        return false;
    }

    return len == 32;
}

// Validate JWT signature (HS256)
fn validate_jwt_hs256(token: []const u8, secret: []const u8) bool {
    // Find the two dots separating header.payload.signature
    const first_dot = std.mem.indexOfScalar(u8, token, '.') orelse return false;
    const rest = token[first_dot + 1 ..];
    const second_dot = std.mem.indexOfScalar(u8, rest, '.') orelse return false;

    const header_payload = token[0 .. first_dot + 1 + second_dot];
    const signature_b64 = rest[second_dot + 1 ..];

    // Decode signature
    var signature: [256]u8 = undefined;
    const sig_len = base64url_decode(signature_b64, &signature) orelse return false;

    if (sig_len != 32) return false; // HS256 produces 32 bytes

    // Compute expected signature
    var expected: [32]u8 = undefined;
    if (!hmac_sha256(secret, header_payload, &expected)) {
        return false;
    }

    // Constant-time comparison
    var diff: u8 = 0;
    for (0..32) |i| {
        diff |= signature[i] ^ expected[i];
    }

    return diff == 0;
}

// Check if token is expired
fn check_expiration(payload_json: []const u8, pool: [*c]core.ngx_pool_t) bool {
    var cj = CJSON.init(pool);
    const json = cj.decode(ngx_str_t{ .data = @constCast(payload_json.ptr), .len = payload_json.len }) catch return true;
    defer cj.free(json);

    // Check exp claim
    if (CJSON.query(json, "$.exp")) |exp_node| {
        if (CJSON.intValue(exp_node)) |exp| {
            const now = std.time.timestamp();
            if (exp < now) {
                return false; // Token expired
            }
        }
    }

    // Check nbf claim (not before)
    if (CJSON.query(json, "$.nbf")) |nbf_node| {
        if (CJSON.intValue(nbf_node)) |nbf| {
            const now = std.time.timestamp();
            if (nbf > now) {
                return false; // Token not yet valid
            }
        }
    }

    return true;
}

// Extract Bearer token from Authorization header
fn extract_bearer_token(r: [*c]ngx_http_request_t) ?[]const u8 {
    const auth_header = r.*.headers_in.authorization;
    if (auth_header == null) return null;

    const value = core.slicify(u8, auth_header.*.value.data, auth_header.*.value.len);

    // Check for "Bearer " prefix (case-insensitive)
    if (value.len < 7) return null;

    const prefix = value[0..7];
    if (!std.ascii.eqlIgnoreCase(prefix, "Bearer ")) return null;

    return value[7..];
}

export fn ngx_http_jwt_access_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    // Get location config
    const lccf = core.castPtr(
        jwt_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_jwt_module),
    ) orelse return NGX_DECLINED;

    // Skip if not enabled
    if (lccf.*.enabled != 1) {
        return NGX_DECLINED;
    }

    // Skip if no secret configured
    if (lccf.*.secret.len == 0) {
        return NGX_DECLINED;
    }

    // Extract token from Authorization header
    const token = extract_bearer_token(r) orelse {
        return NGX_HTTP_UNAUTHORIZED;
    };

    // Validate signature
    const secret = core.slicify(u8, lccf.*.secret.data, lccf.*.secret.len);
    if (!validate_jwt_hs256(token, secret)) {
        return NGX_HTTP_UNAUTHORIZED;
    }

    // Decode and check payload for expiration
    const first_dot = std.mem.indexOfScalar(u8, token, '.') orelse return NGX_HTTP_UNAUTHORIZED;
    const rest = token[first_dot + 1 ..];
    const second_dot = std.mem.indexOfScalar(u8, rest, '.') orelse return NGX_HTTP_UNAUTHORIZED;
    const payload_b64 = rest[0..second_dot];

    var payload: [4096]u8 = undefined;
    const payload_len = base64url_decode(payload_b64, &payload) orelse return NGX_HTTP_UNAUTHORIZED;

    if (!check_expiration(payload[0..payload_len], r.*.pool)) {
        return NGX_HTTP_UNAUTHORIZED;
    }

    return NGX_OK;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(jwt_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        p.*.secret = ngx_str_t{ .len = 0, .data = null };
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
    const prev = core.castPtr(jwt_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(jwt_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.enabled == 0) c.*.enabled = prev.*.enabled;
    if (c.*.secret.len == 0) c.*.secret = prev.*.secret;

    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_jwt(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(jwt_loc_conf, loc)) |lccf| {
        lccf.*.enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_jwt_secret(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(jwt_loc_conf, loc)) |lccf| {
        var index: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &index)) |arg| {
            lccf.*.secret = arg.*;
        }
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register access phase handler
    const cmcf = core.castPtr(
        http.ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    var handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[http.NGX_HTTP_ACCESS_PHASE].handlers,
    );
    const h = handlers.append() catch return NGX_ERROR;
    h.* = ngx_http_jwt_access_handler;

    return NGX_OK;
}

export const ngx_http_jwt_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_jwt_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("jwt"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_jwt,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("jwt_secret"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_jwt_secret,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_jwt_module = ngx.module.make_module(
    @constCast(&ngx_http_jwt_commands),
    @constCast(&ngx_http_jwt_module_ctx),
);

// Tests
const expectEqual = std.testing.expectEqual;
const expect = std.testing.expect;

test "jwt module" {
    try expectEqual(ngx_http_jwt_module.version, 1027004);
}

test "base64url_decode" {
    var output: [256]u8 = undefined;

    // Test basic decoding
    const len = base64url_decode("SGVsbG8", &output) orelse 0;
    try expectEqual(len, 5);
    try expectEqual(output[0..5].*, "Hello".*);
}
