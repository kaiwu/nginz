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

const oidc_loc_conf = extern struct {
    enabled: ngx_flag_t,
    discovery_url: ngx_str_t, // .well-known/openid-configuration
    client_id: ngx_str_t,
    client_secret: ngx_str_t,
    redirect_uri: ngx_str_t,
    scope: ngx_str_t,
    // TODO: token endpoints, session storage, etc.
};

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(oidc_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        return p;
    }
    return null;
}

fn merge_loc_conf(
    cf: [*c]ngx_conf_t,
    parent: ?*anyopaque,
    child: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = parent;
    _ = child;
    // TODO: Implement merge logic
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_oidc(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(oidc_loc_conf, loc)) |lccf| {
        lccf.*.enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

export fn ngx_http_oidc_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    _ = r;
    // TODO: Implement OIDC flow
    // 1. Check for existing session
    // 2. If no session, redirect to authorization endpoint
    // 3. Handle callback with authorization code
    // 4. Exchange code for tokens
    // 5. Validate ID token
    // 6. Create session
    // 7. Set user info in headers
    return NGX_DECLINED;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    _ = cf;
    // TODO: Register access phase handler
    return NGX_OK;
}

export const ngx_http_oidc_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_oidc_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("oidc"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = ngx_conf_set_oidc,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("oidc_discovery"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("oidc_client_id"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("oidc_client_secret"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_oidc_module = ngx.module.make_module(
    @constCast(&ngx_http_oidc_commands),
    @constCast(&ngx_http_oidc_module_ctx),
);
