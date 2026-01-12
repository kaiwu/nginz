const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;
const NGX_DONE = core.NGX_DONE;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_msec_t = core.ngx_msec_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NArray = ngx.array.NArray;

// External nginx core module
extern var ngx_http_core_module: ngx_module_t;

// Per-worker metrics (simple counters, no shared memory)
var metrics_requests_total: u64 = 0;
var metrics_requests_1xx: u64 = 0;
var metrics_requests_2xx: u64 = 0;
var metrics_requests_3xx: u64 = 0;
var metrics_requests_4xx: u64 = 0;
var metrics_requests_5xx: u64 = 0;

const prometheus_loc_conf = extern struct {
    metrics_endpoint: ngx_flag_t,
};

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(prometheus_loc_conf, cf.*.pool)) |p| {
        p.*.metrics_endpoint = 0;
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
    const prev = core.castPtr(prometheus_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(prometheus_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.metrics_endpoint == 0) {
        c.*.metrics_endpoint = prev.*.metrics_endpoint;
    }

    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_prometheus_endpoint(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;

    if (core.castPtr(prometheus_loc_conf, loc)) |lccf| {
        lccf.*.metrics_endpoint = 1;

        // Register content handler for this location
        const clcf = core.castPtr(
            http.ngx_http_core_loc_conf_t,
            conf.ngx_http_conf_get_module_loc_conf(cf, &ngx_http_core_module),
        ) orelse return conf.NGX_CONF_OK;

        clcf.*.handler = ngx_http_prometheus_handler;
    }
    return conf.NGX_CONF_OK;
}

// Format a u64 as decimal string into buffer, return slice
fn formatU64(buf: []u8, value: u64) []const u8 {
    var temp: [20]u8 = undefined;
    var v = value;
    var i: usize = 20;

    if (v == 0) {
        return "0";
    }

    while (v > 0) {
        i -= 1;
        temp[i] = @intCast((v % 10) + '0');
        v /= 10;
    }

    const len = 20 - i;
    @memcpy(buf[0..len], temp[i..20]);
    return buf[0..len];
}

// Content handler for /metrics endpoint
export fn ngx_http_prometheus_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    // Only handle GET/HEAD
    if (r.*.method != http.NGX_HTTP_GET and r.*.method != http.NGX_HTTP_HEAD) {
        return http.NGX_HTTP_NOT_ALLOWED;
    }

    // Set content type
    const content_type = ngx_string("text/plain; version=0.0.4; charset=utf-8");
    r.*.headers_out.content_type = content_type;
    r.*.headers_out.content_type_len = content_type.len;

    // Build metrics response - use placeholders that won't conflict with Prometheus labels
    const metrics_template =
        \\# HELP nginx_up Whether nginx is up
        \\# TYPE nginx_up gauge
        \\nginx_up 1
        \\
        \\# HELP nginx_http_requests_total Total number of HTTP requests
        \\# TYPE nginx_http_requests_total counter
        \\nginx_http_requests_total <0>
        \\
        \\# HELP nginx_http_requests_by_status HTTP requests by status code class
        \\# TYPE nginx_http_requests_by_status counter
        \\nginx_http_requests_by_status{status="1xx"} <1>
        \\nginx_http_requests_by_status{status="2xx"} <2>
        \\nginx_http_requests_by_status{status="3xx"} <3>
        \\nginx_http_requests_by_status{status="4xx"} <4>
        \\nginx_http_requests_by_status{status="5xx"} <5>
        \\
    ;

    // Format metrics with current values
    var num_bufs: [6][20]u8 = undefined;
    const total_str = formatU64(&num_bufs[0], metrics_requests_total);
    const r1xx_str = formatU64(&num_bufs[1], metrics_requests_1xx);
    const r2xx_str = formatU64(&num_bufs[2], metrics_requests_2xx);
    const r3xx_str = formatU64(&num_bufs[3], metrics_requests_3xx);
    const r4xx_str = formatU64(&num_bufs[4], metrics_requests_4xx);
    const r5xx_str = formatU64(&num_bufs[5], metrics_requests_5xx);

    // Calculate response size
    const base_len = metrics_template.len - 12; // subtract format placeholders
    const response_len = base_len + total_str.len + r1xx_str.len + r2xx_str.len + r3xx_str.len + r4xx_str.len + r5xx_str.len;

    // Allocate buffer
    const buf_mem = core.ngx_pnalloc(r.*.pool, response_len) orelse return NGX_ERROR;
    const buf_ptr = core.castPtr(u8, buf_mem) orelse return NGX_ERROR;
    const response_buf = core.slicify(u8, buf_ptr, response_len);

    // Build response manually (simple template substitution)
    var pos: usize = 0;
    var tmpl_pos: usize = 0;
    var placeholder_idx: usize = 0;
    const placeholders = [_][]const u8{ total_str, r1xx_str, r2xx_str, r3xx_str, r4xx_str, r5xx_str };

    while (tmpl_pos < metrics_template.len) {
        if (tmpl_pos + 2 < metrics_template.len and metrics_template[tmpl_pos] == '<' and metrics_template[tmpl_pos + 2] == '>') {
            // Replace placeholder <N>
            if (placeholder_idx < placeholders.len) {
                @memcpy(response_buf[pos..][0..placeholders[placeholder_idx].len], placeholders[placeholder_idx]);
                pos += placeholders[placeholder_idx].len;
                placeholder_idx += 1;
            }
            tmpl_pos += 3;
        } else {
            response_buf[pos] = metrics_template[tmpl_pos];
            pos += 1;
            tmpl_pos += 1;
        }
    }

    // Set content length
    r.*.headers_out.status = 200;
    r.*.headers_out.content_length_n = @intCast(pos);

    // Send headers
    const header_rc = http.ngx_http_send_header(r);
    if (header_rc == NGX_ERROR or header_rc > NGX_OK) {
        return header_rc;
    }

    // Create output buffer
    const b = core.castPtr(ngx_buf_t, core.ngx_pcalloc(r.*.pool, @sizeOf(ngx_buf_t))) orelse return NGX_ERROR;

    b.*.pos = buf_ptr;
    b.*.last = buf_ptr + pos;
    b.*.flags.memory = true;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    // Create chain
    var out: ngx_chain_t = undefined;
    out.buf = b;
    out.next = null;

    return http.ngx_http_output_filter(r, &out);
}

// Log phase handler to count requests
fn ngx_http_prometheus_log_handler(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    // Don't count subrequests
    if (r != r.*.main) {
        return NGX_OK;
    }

    // Don't count the metrics endpoint itself
    const lccf = core.castPtr(
        prometheus_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_prometheus_module),
    );
    if (lccf != null and lccf.?.*.metrics_endpoint == 1) {
        return NGX_OK;
    }

    // Increment total counter
    metrics_requests_total += 1;

    // Increment status-specific counter
    const status = r.*.headers_out.status;
    if (status >= 100 and status < 200) {
        metrics_requests_1xx += 1;
    } else if (status >= 200 and status < 300) {
        metrics_requests_2xx += 1;
    } else if (status >= 300 and status < 400) {
        metrics_requests_3xx += 1;
    } else if (status >= 400 and status < 500) {
        metrics_requests_4xx += 1;
    } else if (status >= 500 and status < 600) {
        metrics_requests_5xx += 1;
    }

    return NGX_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register log phase handler
    const cmcf = core.castPtr(
        http.ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    // NGX_HTTP_LOG_PHASE = 10
    var handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[10].handlers,
    );
    const h = handlers.append() catch return NGX_ERROR;
    h.* = ngx_http_prometheus_log_handler;

    return NGX_OK;
}

export const ngx_http_prometheus_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_prometheus_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("prometheus_metrics"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_prometheus_endpoint,
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

// Tests
const expectEqual = std.testing.expectEqual;

test "prometheus module" {
    try expectEqual(ngx_http_prometheus_module.version, 1027004);
}

test "formatU64" {
    var buf: [20]u8 = undefined;
    try expectEqual(formatU64(&buf, 0), "0");
    try expectEqual(formatU64(&buf, 123), "123");
    try expectEqual(formatU64(&buf, 9999999), "9999999");
}
