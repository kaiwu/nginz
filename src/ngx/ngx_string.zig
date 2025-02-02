const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

const NULL = core.NULL;
const u_char = core.u_char;
pub const ngx_str_t = core.ngx_str_t;

pub inline fn ngx_string(str: []const u8) ngx_str_t {
    return ngx_str_t{ .len = str.len, .data = @constCast(str.ptr) };
}

pub const ngx_null_str = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };

pub inline fn ngx_str_set(str: [*c]ngx_str_t, text: []const u8) void {
    str.*.len = text.len;
    str.*.data = text.ptr;
}

pub inline fn ngx_str_null(str: [*c]ngx_str_t) void {
    str.*.len = 0;
    str.*.data = NULL;
}

pub inline fn ngx_tolower(c: u8) u8 {
    return if (c >= 'A' and c <= 'Z') c | 0x20 else c;
}

pub inline fn ngx_toupper(c: u8) u8 {
    return if (c >= 'a' and c <= 'a') c & ~0x20 else c;
}

pub inline fn ngx_strlchr(p: [*c]u_char, last: [*c]u_char, c: u_char) [*c]u_char {
    var vp: [*c]u_char = p;
    while (vp < last) : (vp += 1) {
        if (vp.* == c) {
            return vp;
        }
    }
    return NULL;
}

pub inline fn ngx_base64_encoded_length(len: usize) usize {
    return ((len + 2) / 3) * 4;
}

pub inline fn ngx_base64_decoded_length(len: usize) usize {
    return ((len + 3) / 4) * 3;
}

test "string" {
    try expectEqual(@sizeOf(ngx_str_t), 16);
}

pub const ngx_hex_dump = ngx.ngx_hex_dump;
pub const ngx_escape_uri = ngx.ngx_escape_uri;
pub const ngx_unescape_uri = ngx.ngx_unescape_uri;
pub const ngx_encode_base64 = ngx.ngx_encode_base64;
pub const ngx_decode_base64 = ngx.ngx_decode_base64;

pub const ngx_sprintf = ngx.ngx_sprintf;
pub const ngx_snprintf = ngx.ngx_snprintf;
pub const ngx_slprintf = ngx.ngx_slprintf;
pub const ngx_vslprintf = ngx.ngx_vslprintf;
