const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");

pub const ngx_regex_t = ngx.ngx_regex_t;
pub const ngx_regex_compile_t = ngx.ngx_regex_compile_t;

pub const NGX_REGEX_CASELESS = ngx.NGX_REGEX_CASELESS;
pub const NGX_REGEX_MULTILINE = ngx.NGX_REGEX_MULTILINE;

pub const ngx_regex_compile = ngx.ngx_regex_compile;
pub const ngx_regex_exec = ngx.ngx_regex_exec;

pub inline fn initCompile(pattern: core.ngx_str_t, pool: [*c]core.ngx_pool_t, err_buf: []u8) ngx_regex_compile_t {
    return .{
        .pattern = pattern,
        .pool = pool,
        .options = NGX_REGEX_CASELESS,
        .regex = null,
        .captures = 0,
        .named_captures = 0,
        .name_size = 0,
        .names = core.nullptr(u8),
        .err = .{ .data = err_buf.ptr, .len = err_buf.len },
    };
}
