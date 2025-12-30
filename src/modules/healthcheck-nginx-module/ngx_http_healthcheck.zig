const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_msec_t = core.ngx_msec_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;

const ngx_string = ngx.string.ngx_string;

// Health check state
const health_state = enum {
    unknown,
    healthy,
    unhealthy,
};

const healthcheck_upstream_conf = extern struct {
    enabled: ngx_flag_t,
    interval: ngx_msec_t,
    timeout: ngx_msec_t,
    passes: ngx_uint_t,
    fails: ngx_uint_t,
    uri: ngx_str_t,
    match_status: ngx_uint_t,
    // TODO: Add match body, headers
};

fn create_srv_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(healthcheck_upstream_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        p.*.interval = 5000; // 5 seconds default
        p.*.timeout = 1000; // 1 second default
        p.*.passes = 1;
        p.*.fails = 1;
        p.*.match_status = 200;
        return p;
    }
    return null;
}

fn ngx_conf_set_health_check(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(healthcheck_upstream_conf, loc)) |ucf| {
        ucf.*.enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn init_module(cycle: [*c]core.ngx_cycle_t) callconv(.c) ngx_int_t {
    _ = cycle;
    // TODO: Initialize health check timer events
    return NGX_OK;
}

export const ngx_http_healthcheck_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = create_srv_conf,
    .merge_srv_conf = null,
    .create_loc_conf = null,
    .merge_loc_conf = null,
};

export const ngx_http_healthcheck_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("health_check"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_NOARGS | conf.NGX_CONF_1MORE,
        .set = ngx_conf_set_health_check,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_healthcheck_module = ngx.module.make_module(
    @constCast(&ngx_http_healthcheck_commands),
    @constCast(&ngx_http_healthcheck_module_ctx),
);
