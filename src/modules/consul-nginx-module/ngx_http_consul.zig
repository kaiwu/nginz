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

// Service discovery backend
const discovery_backend = enum {
    consul,
    etcd,
    dns_srv,
};

const consul_main_conf = extern struct {
    enabled: ngx_flag_t,
    consul_addr: ngx_str_t,
    consul_port: ngx_uint_t,
    refresh_interval: ngx_msec_t,
    token: ngx_str_t,
};

const consul_upstream_conf = extern struct {
    service_name: ngx_str_t,
    datacenter: ngx_str_t,
    tag: ngx_str_t,
    // TODO: health-aware routing options
};

fn create_main_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(consul_main_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        p.*.consul_port = 8500;
        p.*.refresh_interval = 5000; // 5 seconds
        return p;
    }
    return null;
}

fn create_srv_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(consul_upstream_conf, cf.*.pool)) |p| {
        return p;
    }
    return null;
}

fn init_process(cycle: [*c]core.ngx_cycle_t) callconv(.c) ngx_int_t {
    _ = cycle;
    // TODO: Initialize Consul polling timer
    // TODO: Fetch initial service list
    return NGX_OK;
}

export const ngx_http_consul_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = create_main_conf,
    .init_main_conf = null,
    .create_srv_conf = create_srv_conf,
    .merge_srv_conf = null,
    .create_loc_conf = null,
    .merge_loc_conf = null,
};

export const ngx_http_consul_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("consul"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("consul_service"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("consul_refresh"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_msec_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_consul_module = ngx.module.make_module(
    @constCast(&ngx_http_consul_commands),
    @constCast(&ngx_http_consul_module_ctx),
);
