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
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;

// Metrics storage (shared memory)
const prometheus_metrics = extern struct {
    requests_total: ngx_uint_t,
    requests_duration_sum: ngx_uint_t,
    requests_duration_count: ngx_uint_t,
    // TODO: histogram buckets, per-status counts, etc.
};

const prometheus_main_conf = extern struct {
    enabled: ngx_flag_t,
    // TODO: shared memory zone, labels config
};

const prometheus_loc_conf = extern struct {
    metrics_enabled: ngx_flag_t,
    metrics_endpoint: ngx_flag_t,
    labels: ngx_str_t,
};

fn create_main_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(prometheus_main_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        return p;
    }
    return null;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(prometheus_loc_conf, cf.*.pool)) |p| {
        p.*.metrics_enabled = 1;
        p.*.metrics_endpoint = 0;
        return p;
    }
    return null;
}

fn ngx_conf_set_prometheus_endpoint(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(prometheus_loc_conf, loc)) |lccf| {
        lccf.*.metrics_endpoint = 1;
    }
    return conf.NGX_CONF_OK;
}

export fn ngx_http_prometheus_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    _ = r;
    // TODO: Implement /metrics endpoint
    // 1. Collect metrics from shared memory
    // 2. Format as Prometheus exposition format
    // 3. Return response
    return NGX_ERROR;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    _ = cf;
    // TODO: Register log phase handler for metrics collection
    return NGX_OK;
}

export const ngx_http_prometheus_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = create_main_conf,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = null,
};

export const ngx_http_prometheus_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("prometheus"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_FLAG,
        .set = conf.ngx_conf_set_flag_slot,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("prometheus_metrics"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_prometheus_endpoint,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("prometheus_labels"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = conf.ngx_conf_set_str_slot,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_prometheus_module = ngx.module.make_module(
    @constCast(&ngx_http_prometheus_commands),
    @constCast(&ngx_http_prometheus_module_ctx),
);
