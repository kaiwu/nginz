const std = @import("std");
const ngx = @import("ngx");

const ssl = ngx.ssl;
const core = ngx.core;
const http = ngx.http;
const cjson = ngx.cjson;
const CJSON = cjson.CJSON;

const ngx_str_t = core.ngx_str_t;
const ngx_pool_t = core.ngx_pool_t;
const ngx_http_request_t = http.ngx_http_request_t;

fn extract_header_value(r: [*c]ngx_http_request_t, header_name: []const u8) ?[]const u8 {
    if (r == null) return null;

    const headers_list = &r.*.headers_in.headers;
    var part = &headers_list.*.part;

    var search_limit: usize = 100;
    while (search_limit > 0) : (search_limit -= 1) {
        const elts = core.castPtr(ngx.hash.ngx_table_elt_t, part.*.elts) orelse {
            if (part.*.next) |next_part| {
                part = next_part;
                continue;
            } else break;
        };

        var i: usize = 0;
        while (i < part.*.nelts) : (i += 1) {
            const elt = elts[i];
            if (elt.key.len > 0 and elt.key.data != core.nullptr(u8)) {
                const key = core.slicify(u8, elt.key.data, elt.key.len);
                if (std.mem.eql(u8, key, header_name) or std.ascii.eqlIgnoreCase(key, header_name)) {
                    if (elt.value.len > 0 and elt.value.data != core.nullptr(u8)) {
                        return core.slicify(u8, elt.value.data, elt.value.len);
                    }
                }
            }
        }

        if (part.*.next) |next_part| {
            part = next_part;
        } else break;
    }

    return null;
}

pub fn extract_jwt_token(r: [*c]ngx_http_request_t) ?[]const u8 {
    if (extract_header_value(r, "authorization")) |auth_header| {
        const bearer_prefix = "Bearer ";
        if (auth_header.len > bearer_prefix.len and std.mem.eql(u8, auth_header[0..bearer_prefix.len], bearer_prefix)) {
            return auth_header[bearer_prefix.len..];
        }
    }
    return null;
}

pub fn base64url_decode(input: []const u8, output: []u8) ?usize {
    const b64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
    var out_idx: usize = 0;
    var bits: u32 = 0;
    var bit_count: u32 = 0;

    for (input) |c| {
        const val: u32 = for (b64_chars, 0..) |bc, i| {
            if (bc == c) break @intCast(i);
        } else return null;

        bits = (bits << 6) | val;
        bit_count += 6;

        if (bit_count >= 8) {
            bit_count -= 8;
            if (out_idx >= output.len) return null;
            output[out_idx] = @truncate(bits >> @intCast(bit_count));
            out_idx += 1;
        }
    }

    return out_idx;
}

pub fn hmac_sha256(key: []const u8, data: []const u8, output: *[32]u8) bool {
    const ctx = ssl.HMAC_CTX_new() orelse return false;
    defer ssl.HMAC_CTX_free(ctx);

    if (ssl.HMAC_Init_ex(ctx, key.ptr, @intCast(key.len), ssl.EVP_sha256(), null) != 1) return false;
    if (ssl.HMAC_Update(ctx, data.ptr, data.len) != 1) return false;

    var len: c_uint = 32;
    if (ssl.HMAC_Final(ctx, output, &len) != 1) return false;
    return len == 32;
}

pub fn validate_jwt_hs256(token: []const u8, secret: []const u8) bool {
    const first_dot = std.mem.indexOfScalar(u8, token, '.') orelse return false;
    const rest = token[first_dot + 1 ..];
    const second_dot = std.mem.indexOfScalar(u8, rest, '.') orelse return false;

    const header_payload = token[0 .. first_dot + 1 + second_dot];
    const signature_b64 = rest[second_dot + 1 ..];

    var signature: [256]u8 = undefined;
    const sig_len = base64url_decode(signature_b64, &signature) orelse return false;
    if (sig_len != 32) return false;

    var expected: [32]u8 = undefined;
    if (!hmac_sha256(secret, header_payload, &expected)) return false;

    var diff: u8 = 0;
    for (0..32) |i| diff |= signature[i] ^ expected[i];
    return diff == 0;
}

pub fn extract_jwt_role(pool: [*c]ngx_pool_t, jwt_token: []const u8, role_claim: []const u8) ?[]const u8 {
    const first_dot = std.mem.indexOfScalar(u8, jwt_token, '.') orelse return null;
    const rest = jwt_token[first_dot + 1 ..];
    const second_dot = std.mem.indexOfScalar(u8, rest, '.') orelse return null;
    const payload_b64 = rest[0..second_dot];

    var payload_buf: [4096]u8 = undefined;
    const payload_len = base64url_decode(payload_b64, &payload_buf) orelse return null;
    const payload = payload_buf[0..payload_len];

    var cj = CJSON.init(pool);
    const json = cj.decode(ngx_str_t{ .data = @constCast(payload.ptr), .len = payload.len }) catch return null;
    defer cj.free(json);

    var query_buf: [128]u8 = undefined;
    const query = std.fmt.bufPrint(&query_buf, "$.{s}", .{role_claim}) catch return null;
    const role_node = CJSON.query(json, query) orelse return null;
    const role_str = CJSON.stringValue(role_node) orelse return null;
    return core.slicify(u8, role_str.data, role_str.len);
}

pub fn build_set_postgresql_jwt_claim_query(jwt_token: []const u8, query_buf: []u8) ?usize {
    if (jwt_token.len == 0) return null;

    var pos: usize = 0;
    const set_prefix = "SET request.jwt TO '";
    if (set_prefix.len + jwt_token.len + 4 > query_buf.len) return null;
    @memcpy(query_buf[pos..][0..set_prefix.len], set_prefix);
    pos += set_prefix.len;

    for (jwt_token) |c| {
        if (pos >= query_buf.len - 2) return null;
        if (c == '\'') {
            if (pos >= query_buf.len - 3) return null;
            query_buf[pos] = '\'';
            pos += 1;
            query_buf[pos] = '\'';
            pos += 1;
        } else {
            query_buf[pos] = c;
            pos += 1;
        }
    }

    if (pos >= query_buf.len - 1) return null;
    query_buf[pos] = '\'';
    pos += 1;
    query_buf[pos] = 0;
    return pos;
}

pub fn build_set_postgresql_role_query(role: []const u8, query_buf: []u8) ?usize {
    if (role.len == 0) return null;

    var pos: usize = 0;
    const set_prefix = "SET ROLE '";
    if (set_prefix.len + role.len + 4 > query_buf.len) return null;
    @memcpy(query_buf[pos..][0..set_prefix.len], set_prefix);
    pos += set_prefix.len;

    for (role) |c| {
        if (pos >= query_buf.len - 2) return null;
        if (c == '\'') {
            if (pos >= query_buf.len - 3) return null;
            query_buf[pos] = '\'';
            pos += 1;
            query_buf[pos] = '\'';
            pos += 1;
        } else {
            query_buf[pos] = c;
            pos += 1;
        }
    }

    if (pos >= query_buf.len - 1) return null;
    query_buf[pos] = '\'';
    pos += 1;
    query_buf[pos] = 0;
    return pos;
}

test "auth base64url decode handles jwt alphabet" {
    var out: [8]u8 = undefined;
    const len = base64url_decode("SGVsbG8", &out) orelse return error.TestUnexpectedResult;
    try std.testing.expectEqualStrings("Hello", out[0..len]);
}
