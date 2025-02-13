const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const conf = @import("ngx_conf.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_module_t = ngx.ngx_module_t;
pub const NGX_HTTP_MODULE = ngx.NGX_HTTP_MODULE;

const ngx_uint_t = core.ngx_uint_t;
const ngx_conf_t = core.ngx_conf_t;
const nginx_version = core.ngx_version;
const ngx_command_t = conf.ngx_command_t;

pub const NGX_MODULE_UNSET_INDEX = std.math.maxInt(ngx_uint_t);
pub const NGX_MODULE_SIGNATURE_0 = "8,4,8,";
pub const NGX_MODULE_SIGNATURE_1 = "0";
pub const NGX_MODULE_SIGNATURE_2 = "0";
pub const NGX_MODULE_SIGNATURE_3 = "0";
pub const NGX_MODULE_SIGNATURE_4 = "0";
pub const NGX_MODULE_SIGNATURE_5 = "1";
pub const NGX_MODULE_SIGNATURE_6 = "1";
pub const NGX_MODULE_SIGNATURE_7 = "1";
pub const NGX_MODULE_SIGNATURE_8 = "1";
pub const NGX_MODULE_SIGNATURE_9 = "1";
pub const NGX_MODULE_SIGNATURE_10 = "1";
pub const NGX_MODULE_SIGNATURE_11 = "0";
pub const NGX_MODULE_SIGNATURE_12 = "1";
pub const NGX_MODULE_SIGNATURE_13 = "0";
pub const NGX_MODULE_SIGNATURE_14 = "1";
pub const NGX_MODULE_SIGNATURE_15 = "1";
pub const NGX_MODULE_SIGNATURE_16 = "1";
pub const NGX_MODULE_SIGNATURE_17 = "0";
pub const NGX_MODULE_SIGNATURE_18 = "0";
pub const NGX_MODULE_SIGNATURE_19 = "1";
pub const NGX_MODULE_SIGNATURE_20 = "1";
pub const NGX_MODULE_SIGNATURE_21 = "1";
pub const NGX_MODULE_SIGNATURE_22 = "0";
pub const NGX_MODULE_SIGNATURE_23 = "1";
pub const NGX_MODULE_SIGNATURE_24 = "1";
pub const NGX_MODULE_SIGNATURE_25 = "1";
pub const NGX_MODULE_SIGNATURE_26 = "1";
pub const NGX_MODULE_SIGNATURE_27 = "1";
pub const NGX_MODULE_SIGNATURE_28 = "1";
pub const NGX_MODULE_SIGNATURE_29 = "0";
pub const NGX_MODULE_SIGNATURE_30 = "0";
pub const NGX_MODULE_SIGNATURE_31 = "0";
pub const NGX_MODULE_SIGNATURE_32 = "1";
pub const NGX_MODULE_SIGNATURE_33 = "1";
pub const NGX_MODULE_SIGNATURE_34 = "0";
pub const NGX_MODULE_SIGNATURE = NGX_MODULE_SIGNATURE_0 ++ NGX_MODULE_SIGNATURE_1 ++ NGX_MODULE_SIGNATURE_2 ++ NGX_MODULE_SIGNATURE_3 ++ NGX_MODULE_SIGNATURE_4 ++ NGX_MODULE_SIGNATURE_5 ++ NGX_MODULE_SIGNATURE_6 ++ NGX_MODULE_SIGNATURE_7 ++ NGX_MODULE_SIGNATURE_8 ++ NGX_MODULE_SIGNATURE_9 ++ NGX_MODULE_SIGNATURE_10 ++ NGX_MODULE_SIGNATURE_11 ++ NGX_MODULE_SIGNATURE_12 ++ NGX_MODULE_SIGNATURE_13 ++ NGX_MODULE_SIGNATURE_14 ++ NGX_MODULE_SIGNATURE_15 ++ NGX_MODULE_SIGNATURE_16 ++ NGX_MODULE_SIGNATURE_17 ++ NGX_MODULE_SIGNATURE_18 ++ NGX_MODULE_SIGNATURE_19 ++ NGX_MODULE_SIGNATURE_20 ++ NGX_MODULE_SIGNATURE_21 ++ NGX_MODULE_SIGNATURE_22 ++ NGX_MODULE_SIGNATURE_23 ++ NGX_MODULE_SIGNATURE_24 ++ NGX_MODULE_SIGNATURE_25 ++ NGX_MODULE_SIGNATURE_26 ++ NGX_MODULE_SIGNATURE_27 ++ NGX_MODULE_SIGNATURE_28 ++ NGX_MODULE_SIGNATURE_29 ++ NGX_MODULE_SIGNATURE_30 ++ NGX_MODULE_SIGNATURE_31 ++ NGX_MODULE_SIGNATURE_32 ++ NGX_MODULE_SIGNATURE_33 ++ NGX_MODULE_SIGNATURE_34;

pub inline fn make_module(cmds: [*c]ngx_command_t, ctx: ?*anyopaque) ngx_module_t {
    return ngx_module_t{
        .ctx_index = NGX_MODULE_UNSET_INDEX,
        .index = NGX_MODULE_UNSET_INDEX,
        .name = core.nullptr(u8),
        .signature = NGX_MODULE_SIGNATURE,
        .spare0 = 0,
        .spare1 = 0,
        .version = nginx_version,
        .ctx = ctx,
        .commands = cmds,
        .type = NGX_HTTP_MODULE,
        .init_master = null,
        .init_module = null,
        .init_process = null,
        .init_thread = null,
        .exit_thread = null,
        .exit_process = null,
        .exit_master = null,
        .spare_hook0 = 0,
        .spare_hook1 = 0,
        .spare_hook2 = 0,
        .spare_hook3 = 0,
        .spare_hook4 = 0,
        .spare_hook5 = 0,
        .spare_hook6 = 0,
        .spare_hook7 = 0,
    };
}

test "module" {
    try expectEqual(@sizeOf(ngx_module_t), 200);
}
