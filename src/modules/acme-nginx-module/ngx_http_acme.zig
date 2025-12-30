const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;

// ACME challenge types
const acme_challenge_type = enum {
    http_01, // HTTP-01 challenge
    dns_01, // DNS-01 challenge
    tls_alpn_01, // TLS-ALPN-01 challenge
};

const acme_main_conf = extern struct {
    enabled: ngx_flag_t,
    directory_url: ngx_str_t,
    account_email: ngx_str_t,
    storage_path: ngx_str_t,
    challenge_type: ngx_uint_t,
    renew_before_days: ngx_uint_t,
};

const acme_srv_conf = extern struct {
    domains: ngx_str_t, // comma-separated domain list
    // TODO: per-server certificate storage
};

fn create_main_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(acme_main_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        p.*.challenge_type = @intFromEnum(acme_challenge_type.http_01);
        p.*.renew_before_days = 30;
        return p;
    }
    return null;
}

fn create_srv_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(acme_srv_conf, cf.*.pool)) |p| {
        return p;
    }
    return null;
}

export fn ngx_http_acme_challenge_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    _ = r;
    // TODO: Handle /.well-known/acme-challenge/ requests
    // 1. Check if path matches challenge pattern
    // 2. Return challenge response
    return NGX_DECLINED;
}

fn init_process(cycle: [*c]core.ngx_cycle_t) callconv(.c) ngx_int_t {
    _ = cycle;
    // TODO: Initialize certificate renewal timer
    return NGX_OK;
}

export const ngx_http_acme_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = create_main_conf,
    .init_main_conf = null,
    .create_srv_conf = create_srv_conf,
    .merge_srv_conf = null,
    .create_loc_conf = null,
    .merge_loc_conf = null,
};

export const ngx_http_acme_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("acme"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_server"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_email"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("acme_domain"),
        .type = conf.NGX_HTTP_SRV_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_acme_module = ngx.module.make_module(
    @constCast(&ngx_http_acme_commands),
    @constCast(&ngx_http_acme_module_ctx),
);
