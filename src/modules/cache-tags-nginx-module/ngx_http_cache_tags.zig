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

const cache_tags_main_conf = extern struct {
    enabled: ngx_flag_t,
    tag_header: ngx_str_t, // Header containing tags
    // TODO: tag storage, index
};

const cache_tags_loc_conf = extern struct {
    enabled: ngx_flag_t,
    purge_enabled: ngx_flag_t,
    tags_from_response: ngx_flag_t,
};

fn create_main_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(cache_tags_main_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        return p;
    }
    return null;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(cache_tags_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        p.*.purge_enabled = 0;
        p.*.tags_from_response = 1;
        return p;
    }
    return null;
}

fn ngx_conf_set_cache_tags(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(cache_tags_loc_conf, loc)) |lccf| {
        lccf.*.enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

export fn ngx_http_cache_tags_purge_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    _ = r;
    // TODO: Implement cache purge by tag
    // 1. Extract tag from request
    // 2. Look up cache entries with tag
    // 3. Invalidate matching entries
    // 4. Return success/count
    return NGX_DECLINED;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    _ = cf;
    // TODO: Register response filter to extract tags
    return NGX_OK;
}

export const ngx_http_cache_tags_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = create_main_conf,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = null,
};

export const ngx_http_cache_tags_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("cache_tags"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = ngx_conf_set_cache_tags,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("cache_tags_header"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("cache_tags_purge"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_cache_tags_module = ngx.module.make_module(
    @constCast(&ngx_http_cache_tags_commands),
    @constCast(&ngx_http_cache_tags_module_ctx),
);
