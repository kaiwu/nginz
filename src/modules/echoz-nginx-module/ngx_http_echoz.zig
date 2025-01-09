const std = @import("std");
const ngx = @import("nginx");

const NULL = ngx.NULL;
const NGX_OK = ngx.NGX_OK;
const NGX_LOG_ERR = ngx.NGX_LOG_ERR;

const ngx_int_t = ngx.ngx_int_t;
const ngx_flag_t = ngx.ngx_flag_t;
const ngx_conf_t = ngx.ngx_conf_t;
const ngx_module_t = ngx.ngx_module_t;
const ngx_command_t = ngx.ngx_command_t;
const ngx_http_module_t = ngx.ngx_http_module_t;

const ngx_string = ngx.ngx_string;

const loc_conf = extern struct {
    flag: ngx_flag_t,
};

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    ngx.ngz_log_error(NGX_LOG_ERR, cf.*.log, 0, "echoz %d", .{ngx_http_echoz_module.ctx_index});
    return NGX_OK;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (ngx.ngz_pcalloc(loc_conf, cf.*.pool)) |p| {
        p.*.flag = ngx.NGX_CONF_UNSET;
        return p;
    }
    return null;
}

export const ngx_http_echoz_module_ctx = ngx_http_module_t{
    .preconfiguration = @ptrCast(NULL),
    .postconfiguration = postconfiguration,
    .create_main_conf = @ptrCast(NULL),
    .init_main_conf = @ptrCast(NULL),
    .create_srv_conf = @ptrCast(NULL),
    .merge_srv_conf = @ptrCast(NULL),
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = @ptrCast(NULL),
};

export const ngx_http_echoz_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("echoz"),
        .type = ngx.NGX_HTTP_LOC_CONF | ngx.NGX_CONF_FLAG,
        .set = ngx.ngx_conf_set_flag_slot,
        .conf = ngx.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = @offsetOf(loc_conf, "flag"),
        .post = NULL,
    },
};

export var ngx_http_echoz_module = ngx.make_module(
    @constCast(&ngx_http_echoz_commands),
    @constCast(&ngx_http_echoz_module_ctx),
);

test "module" {
    try std.testing.expectEqual(ngx_http_echoz_module.version, 1027003);
    const len = ngx.sizeof(ngx.NGX_MODULE_SIGNATURE);
    const slice = ngx.make_slice(@constCast(ngx_http_echoz_module.signature), len);
    try std.testing.expectEqual(slice.len, 40);
}
