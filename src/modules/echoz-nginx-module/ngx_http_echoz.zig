const std = @import("std");
const ngx = @import("nginx");

const NULL = ngx.NULL;
const NGX_OK = ngx.NGX_OK;
const NGX_LOG_ERR = ngx.NGX_LOG_ERR;

const ngx_str_t = ngx.ngx_str_t;
const ngx_int_t = ngx.ngx_int_t;
const ngx_flag_t = ngx.ngx_flag_t;
const ngx_conf_t = ngx.ngx_conf_t;
const ngx_array_t = ngx.ngx_array_t;
const ngx_module_t = ngx.ngx_module_t;
const ngx_command_t = ngx.ngx_command_t;
const ngx_http_module_t = ngx.ngx_http_module_t;

const ngx_string = ngx.ngx_string;

const echoz_parameter = extern struct {
    plain: ngx_str_t,
    lengths: [*c]ngx_array_t = undefined,
    values: [*c]ngx_array_t = undefined,
};

extern var ngx_http_core_module: ngx_module_t;

const loc_conf = extern struct {
    params: ngx.NArray(echoz_parameter),
};

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.C) ngx_int_t {
    _ = cf;
    return NGX_OK;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (ngx.ngz_pcalloc_c(loc_conf, cf.*.pool)) |p| {
        return p;
    }
    return null;
}

fn ngx_conf_set_echoz(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, loc: ?*anyopaque) callconv(.C) [*c]u8 {
    _ = cmd;
    if (ngx.castPtr(loc_conf, loc)) |lccf| {
        lccf.*.params = ngx.NArray(echoz_parameter).init(cf.*.pool, 1) catch return ngx.NGX_CONF_ERROR;

        var i: ngx.ngx_uint_t = 0;
        while (ngx.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            ngx.ngx_http_conf_debug(cf, "%V", .{arg});
            const param = lccf.*.params.append() catch return ngx.NGX_CONF_ERROR;
            param.*.plain = arg.*;
            if (ngx.ngx_conf_variables_parse(cf, arg, &param.*.lengths, &param.*.values) == ngx.NGX_CONF_ERROR) {
                return ngx.NGX_CONF_ERROR;
            }
        }
    }
    return ngx.NGX_CONF_OK;
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
        .type = ngx.NGX_HTTP_LOC_CONF | ngx.NGX_CONF_ANY,
        .set = ngx_conf_set_echoz,
        .conf = ngx.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
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
