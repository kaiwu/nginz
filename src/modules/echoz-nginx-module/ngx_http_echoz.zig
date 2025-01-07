const std = @import("std");
const ngx = @import("nginx");

const NULL = ngx.NULL;
const NGX_HTTP_MODULE = ngx.NGX_HTTP_MODULE;
const ngx_module_t = ngx.ngx_module_t;
const ngx_command_t = ngx.ngx_command_t;
const ngx_http_module_t = ngx.ngx_http_module_t;

export const ngx_http_echoz_module_ctx = ngx_http_module_t{
    .preconfiguration = @ptrCast(NULL),
    .postconfiguration = @ptrCast(NULL),
    .create_main_conf = @ptrCast(NULL),
    .init_main_conf = @ptrCast(NULL),
    .create_srv_conf = @ptrCast(NULL),
    .merge_srv_conf = @ptrCast(NULL),
    .create_loc_conf = @ptrCast(NULL),
    .merge_loc_conf = @ptrCast(NULL),
};

export const ngx_http_echoz_commands = [_]ngx_command_t{};

export const ngx_http_echoz_module = ngx.make_module(
    &ngx_http_echoz_commands,
    @constCast(&ngx_http_echoz_module_ctx),
);

test "module" {
    try std.testing.expectEqual(ngx_http_echoz_module.version, 1027003);
    const len = ngx.sizeof(ngx.NGX_MODULE_SIGNATURE);
    const slice = ngx.make_slice(@constCast(ngx_http_echoz_module.signature), len);
    try std.testing.expectEqual(slice.len, 40);
}
