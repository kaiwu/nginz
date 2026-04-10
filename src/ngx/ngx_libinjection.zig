const std = @import("std");

pub const injection_result_t = c_int;
pub const LIBINJECTION_RESULT_FALSE: injection_result_t = 0;
pub const LIBINJECTION_RESULT_TRUE: injection_result_t = 1;
pub const LIBINJECTION_RESULT_ERROR: injection_result_t = -1;

extern fn libinjection_sqli(s: [*c]const u8, slen: usize, fingerprint: [*c]u8) injection_result_t;
extern fn libinjection_xss(s: [*c]const u8, slen: usize) injection_result_t;

pub fn detectSqli(input: []const u8) bool {
    var fingerprint: [8]u8 = std.mem.zeroes([8]u8);
    const result = libinjection_sqli(input.ptr, input.len, &fingerprint);
    return result == LIBINJECTION_RESULT_TRUE;
}

pub fn detectXss(input: []const u8) bool {
    const result = libinjection_xss(input.ptr, input.len);
    return result == LIBINJECTION_RESULT_TRUE;
}
