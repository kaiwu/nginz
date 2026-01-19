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

extern var ngx_http_core_module: ngx_module_t;

// Simple health state - per worker, tracks if this worker is healthy
var worker_healthy: bool = true;
var worker_ready: bool = true;
var total_requests: u64 = 0;
var failed_requests: u64 = 0;

const healthcheck_loc_conf = extern struct {
    status_enabled: ngx_flag_t, // Enable /health endpoint
    liveness_enabled: ngx_flag_t, // Enable /healthz (liveness)
    readiness_enabled: ngx_flag_t, // Enable /ready (readiness)
};

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(healthcheck_loc_conf, cf.*.pool)) |p| {
        p.*.status_enabled = 0;
        p.*.liveness_enabled = 0;
        p.*.readiness_enabled = 0;
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
    const prev = core.castPtr(healthcheck_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(healthcheck_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.status_enabled == 0) c.*.status_enabled = prev.*.status_enabled;
    if (c.*.liveness_enabled == 0) c.*.liveness_enabled = prev.*.liveness_enabled;
    if (c.*.readiness_enabled == 0) c.*.readiness_enabled = prev.*.readiness_enabled;

    return conf.NGX_CONF_OK;
}

// Health status endpoint handler - returns JSON health status
export fn ngx_http_healthcheck_status_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        healthcheck_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_healthcheck_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.status_enabled != 1) {
        return NGX_DECLINED;
    }

    // Calculate health percentage
    const health_pct: u64 = if (total_requests > 0)
        ((total_requests - failed_requests) * 100) / total_requests
    else
        100;

    // Build JSON response
    var buf: [512]u8 = undefined;
    const json = std.fmt.bufPrint(&buf,
        \\{{"status":"{s}","healthy":{s},"ready":{s},"requests":{d},"failed":{d},"success_rate":{d}}}
    , .{
        if (worker_healthy) "healthy" else "unhealthy",
        if (worker_healthy) "true" else "false",
        if (worker_ready) "true" else "false",
        total_requests,
        failed_requests,
        health_pct,
    }) catch return NGX_ERROR;

    return sendJsonResponse(r, json, if (worker_healthy) 200 else 503);
}

// Liveness endpoint - simple alive check
export fn ngx_http_healthcheck_liveness_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        healthcheck_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_healthcheck_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.liveness_enabled != 1) {
        return NGX_DECLINED;
    }

    // Liveness: is the process alive and responding?
    // Always return OK unless something is catastrophically wrong
    const json = "{\"status\":\"alive\"}";
    return sendJsonResponse(r, json, 200);
}

// Readiness endpoint - ready to receive traffic
export fn ngx_http_healthcheck_readiness_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        healthcheck_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_healthcheck_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.readiness_enabled != 1) {
        return NGX_DECLINED;
    }

    // Readiness: is the worker ready to handle traffic?
    if (worker_ready) {
        const json = "{\"status\":\"ready\"}";
        return sendJsonResponse(r, json, 200);
    } else {
        const json = "{\"status\":\"not_ready\"}";
        return sendJsonResponse(r, json, 503);
    }
}

fn sendJsonResponse(r: [*c]ngx_http_request_t, json: []const u8, status: ngx_uint_t) ngx_int_t {
    // Set content type
    r.*.headers_out.content_type = ngx_str_t{ .len = 16, .data = @constCast("application/json") };
    r.*.headers_out.content_type_len = 16;
    r.*.headers_out.status = status;
    r.*.headers_out.content_length_n = @intCast(json.len);

    // Send headers
    const rc = http.ngx_http_send_header(r);
    if (rc == NGX_ERROR or rc > NGX_OK) {
        return rc;
    }

    // Allocate buffer
    const b = core.castPtr(ngx.buf.ngx_buf_t, core.ngx_pcalloc(r.*.pool, @sizeOf(ngx.buf.ngx_buf_t))) orelse return NGX_ERROR;
    const data = core.castPtr(u8, core.ngx_pnalloc(r.*.pool, json.len)) orelse return NGX_ERROR;

    @memcpy(core.slicify(u8, data, json.len), json);

    b.*.pos = data;
    b.*.last = data + json.len;
    b.*.flags.memory = true;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    var out: ngx.buf.ngx_chain_t = undefined;
    out.buf = b;
    out.next = null;

    return http.ngx_http_output_filter(r, &out);
}

// Note: Log phase handler removed - NGX_HTTP_LOG_PHASE not exported
// Request tracking could be added via header filter if needed

fn ngx_conf_set_health_status(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(healthcheck_loc_conf, loc)) |lccf| {
        lccf.*.status_enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_health_liveness(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(healthcheck_loc_conf, loc)) |lccf| {
        lccf.*.liveness_enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_health_readiness(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(healthcheck_loc_conf, loc)) |lccf| {
        lccf.*.readiness_enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    const cmcf = core.castPtr(
        http.ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    // Register content handler
    var content_handlers = ngx.array.NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[http.NGX_HTTP_CONTENT_PHASE].handlers,
    );
    const h1 = content_handlers.append() catch return NGX_ERROR;
    h1.* = ngx_http_healthcheck_status_handler;

    const h2 = content_handlers.append() catch return NGX_ERROR;
    h2.* = ngx_http_healthcheck_liveness_handler;

    const h3 = content_handlers.append() catch return NGX_ERROR;
    h3.* = ngx_http_healthcheck_readiness_handler;

    return NGX_OK;
}

export const ngx_http_healthcheck_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_healthcheck_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("health_status"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_health_status,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("health_liveness"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_health_liveness,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("health_readiness"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_health_readiness,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_healthcheck_module = ngx.module.make_module(
    @constCast(&ngx_http_healthcheck_commands),
    @constCast(&ngx_http_healthcheck_module_ctx),
);

// Tests
const expectEqual = std.testing.expectEqual;

test "healthcheck module" {
    try expectEqual(ngx_http_healthcheck_module.version, 1027004);
}
