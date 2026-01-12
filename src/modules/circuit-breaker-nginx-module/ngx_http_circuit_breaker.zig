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
const ngx_msec_t = core.ngx_msec_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;
const ngx_http_variable_value_t = http.ngx_http_variable_value_t;

const ngx_string = ngx.string.ngx_string;
const NArray = ngx.array.NArray;

// External nginx core module
extern var ngx_http_core_module: ngx_module_t;

// Circuit breaker states
const CircuitState = enum(u8) {
    closed, // Normal operation, requests pass through
    open, // Circuit tripped, requests fail fast with 503
    half_open, // Testing if service recovered
};

// Location configuration
const circuit_breaker_loc_conf = extern struct {
    enabled: ngx_flag_t,
    failure_threshold: ngx_uint_t, // failures before opening
    success_threshold: ngx_uint_t, // successes in half-open before closing
    timeout_ms: ngx_uint_t, // milliseconds before half-open
};

// Per-location circuit state (stored globally per worker)
const CircuitStats = struct {
    state: CircuitState,
    failure_count: u32,
    success_count: u32,
    last_state_change_ms: i64, // timestamp when state last changed
};

// Global circuit state storage (per-worker, keyed by location config pointer)
// Using a simple array for now - in production would use shared memory
const MAX_CIRCUITS = 64;

const CircuitEntry = struct {
    loc_conf: *circuit_breaker_loc_conf,
    stats: CircuitStats,
};

var circuit_states: [MAX_CIRCUITS]?CircuitEntry = [_]?CircuitEntry{null} ** MAX_CIRCUITS;

// Get or create circuit stats for a location
fn getCircuitStats(lccf: *circuit_breaker_loc_conf) *CircuitStats {
    // Find existing
    for (&circuit_states) |*entry| {
        if (entry.*) |*e| {
            if (e.loc_conf == lccf) {
                return &e.stats;
            }
        }
    }

    // Create new
    for (&circuit_states) |*entry| {
        if (entry.* == null) {
            entry.* = .{
                .loc_conf = lccf,
                .stats = CircuitStats{
                    .state = .closed,
                    .failure_count = 0,
                    .success_count = 0,
                    .last_state_change_ms = 0,
                },
            };
            return &entry.*.?.stats;
        }
    }

    // Fallback - reuse first slot (shouldn't happen with reasonable MAX_CIRCUITS)
    return &circuit_states[0].?.stats;
}

// Get current time in milliseconds
fn getCurrentTimeMs() i64 {
    // Use nginx's cached time
    const tp = core.ngx_timeofday();
    if (tp) |t| {
        return @as(i64, @intCast(t.*.sec)) * 1000 + @as(i64, @intCast(t.*.msec));
    }
    return 0;
}

// Check if circuit should transition from OPEN to HALF_OPEN
fn checkTimeout(stats: *CircuitStats, timeout_ms: ngx_uint_t) void {
    if (stats.state != .open) return;

    const now = getCurrentTimeMs();
    const elapsed = now - stats.last_state_change_ms;

    if (elapsed >= @as(i64, @intCast(timeout_ms))) {
        stats.state = .half_open;
        stats.success_count = 0;
        stats.failure_count = 0;
        stats.last_state_change_ms = now;
    }
}

// Record a successful request
fn recordSuccess(stats: *CircuitStats, success_threshold: ngx_uint_t) void {
    switch (stats.state) {
        .closed => {
            // Reset failure count on success
            stats.failure_count = 0;
        },
        .half_open => {
            stats.success_count += 1;
            if (stats.success_count >= success_threshold) {
                // Enough successes, close the circuit
                stats.state = .closed;
                stats.failure_count = 0;
                stats.success_count = 0;
                stats.last_state_change_ms = getCurrentTimeMs();
            }
        },
        .open => {
            // Shouldn't happen - requests blocked when open
        },
    }
}

// Record a failed request
fn recordFailure(stats: *CircuitStats, failure_threshold: ngx_uint_t) void {
    switch (stats.state) {
        .closed => {
            stats.failure_count += 1;
            if (stats.failure_count >= failure_threshold) {
                // Too many failures, open the circuit
                stats.state = .open;
                stats.last_state_change_ms = getCurrentTimeMs();
            }
        },
        .half_open => {
            // Any failure in half-open immediately opens the circuit
            stats.state = .open;
            stats.failure_count = 0;
            stats.success_count = 0;
            stats.last_state_change_ms = getCurrentTimeMs();
        },
        .open => {
            // Already open
        },
    }
}

// Request context to track if we should record the response
const circuit_breaker_ctx = extern struct {
    should_track: ngx_flag_t,
};

// Access phase handler - check circuit state
fn ngx_http_circuit_breaker_access_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        circuit_breaker_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_circuit_breaker_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.enabled != 1) {
        return NGX_DECLINED;
    }

    const stats = getCircuitStats(lccf);

    // Check for timeout transition
    checkTimeout(stats, lccf.*.timeout_ms);

    switch (stats.state) {
        .open => {
            // Circuit is open - fail fast with 503
            r.*.headers_out.status = 503;
            return 503;
        },
        .half_open, .closed => {
            // Set context to track this request
            if (http.ngz_http_get_module_ctx(circuit_breaker_ctx, r, &ngx_http_circuit_breaker_module)) |ctx| {
                ctx.*.should_track = 1;
            } else |_| {}
            return NGX_DECLINED;
        },
    }
}

// Log phase handler - record success/failure
fn ngx_http_circuit_breaker_log_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    // Don't track subrequests
    if (r != r.*.main) {
        return NGX_OK;
    }

    const lccf = core.castPtr(
        circuit_breaker_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_circuit_breaker_module),
    ) orelse return NGX_OK;

    if (lccf.*.enabled != 1) {
        return NGX_OK;
    }

    // Check if we should track this request
    const ctx = http.ngz_http_get_module_ctx(circuit_breaker_ctx, r, &ngx_http_circuit_breaker_module) catch return NGX_OK;
    if (ctx.*.should_track != 1) {
        return NGX_OK;
    }

    const stats = getCircuitStats(lccf);
    const status = r.*.headers_out.status;

    // Consider 5xx as failures, everything else as success
    if (status >= 500 and status < 600) {
        recordFailure(stats, lccf.*.failure_threshold);
    } else if (status > 0) {
        recordSuccess(stats, lccf.*.success_threshold);
    }

    return NGX_OK;
}

// Variable getter for $ngz_circuit_state
fn ngx_http_circuit_state_variable(
    r: [*c]ngx_http_request_t,
    v: [*c]ngx_http_variable_value_t,
    data: core.uintptr_t,
) callconv(.c) ngx_int_t {
    _ = data;

    const lccf = core.castPtr(
        circuit_breaker_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_circuit_breaker_module),
    ) orelse {
        v.*.flags.not_found = true;
        return NGX_OK;
    };

    if (lccf.*.enabled != 1) {
        v.*.flags.not_found = true;
        return NGX_OK;
    }

    const stats = getCircuitStats(lccf);
    checkTimeout(stats, lccf.*.timeout_ms);

    const state_str = switch (stats.state) {
        .closed => "closed",
        .open => "open",
        .half_open => "half_open",
    };

    v.*.data = @constCast(state_str.ptr);
    v.*.flags.len = @intCast(state_str.len);
    v.*.flags.valid = true;
    v.*.flags.no_cacheable = true;
    v.*.flags.not_found = false;

    return NGX_OK;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(circuit_breaker_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = conf.NGX_CONF_UNSET;
        p.*.failure_threshold = 5;
        p.*.success_threshold = 2;
        p.*.timeout_ms = 30000; // 30 seconds
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
    const prev = core.castPtr(circuit_breaker_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(circuit_breaker_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.enabled == conf.NGX_CONF_UNSET) {
        c.*.enabled = if (prev.*.enabled == conf.NGX_CONF_UNSET) 0 else prev.*.enabled;
    }

    if (c.*.failure_threshold == 5 and prev.*.failure_threshold != 5) {
        c.*.failure_threshold = prev.*.failure_threshold;
    }

    if (c.*.success_threshold == 2 and prev.*.success_threshold != 2) {
        c.*.success_threshold = prev.*.success_threshold;
    }

    if (c.*.timeout_ms == 30000 and prev.*.timeout_ms != 30000) {
        c.*.timeout_ms = prev.*.timeout_ms;
    }

    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_circuit_breaker(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(circuit_breaker_loc_conf, loc)) |lccf| {
        lccf.*.enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_threshold(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(circuit_breaker_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const slice = core.slicify(u8, arg.*.data, arg.*.len);
            lccf.*.failure_threshold = std.fmt.parseInt(ngx_uint_t, slice, 10) catch 5;
        }
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_success_threshold(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(circuit_breaker_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const slice = core.slicify(u8, arg.*.data, arg.*.len);
            lccf.*.success_threshold = std.fmt.parseInt(ngx_uint_t, slice, 10) catch 2;
        }
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_timeout(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(circuit_breaker_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const slice = core.slicify(u8, arg.*.data, arg.*.len);
            // Parse as milliseconds or with 's' suffix for seconds
            if (slice.len > 0 and slice[slice.len - 1] == 's') {
                const secs = std.fmt.parseInt(ngx_uint_t, slice[0 .. slice.len - 1], 10) catch 30;
                lccf.*.timeout_ms = secs * 1000;
            } else {
                lccf.*.timeout_ms = std.fmt.parseInt(ngx_uint_t, slice, 10) catch 30000;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register $ngz_circuit_state variable
    var vs = [_]http.ngx_http_variable_t{http.ngx_http_variable_t{
        .name = ngx_string("ngz_circuit_state"),
        .set_handler = null,
        .get_handler = ngx_http_circuit_state_variable,
        .data = 0,
        .flags = http.NGX_HTTP_VAR_NOCACHEABLE,
        .index = 0,
    }};
    for (&vs) |*v| {
        if (http.ngx_http_add_variable(cf, &v.name, v.flags)) |x| {
            x.*.get_handler = v.get_handler;
            x.*.data = v.data;
        }
    }

    // Register access phase handler
    const cmcf = core.castPtr(
        http.ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    var access_handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[http.NGX_HTTP_ACCESS_PHASE].handlers,
    );
    const h1 = access_handlers.append() catch return NGX_ERROR;
    h1.* = ngx_http_circuit_breaker_access_handler;

    // Register log phase handler (NGX_HTTP_LOG_PHASE = 10)
    var log_handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[10].handlers,
    );
    const h2 = log_handlers.append() catch return NGX_ERROR;
    h2.* = ngx_http_circuit_breaker_log_handler;

    return NGX_OK;
}

export const ngx_http_circuit_breaker_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_circuit_breaker_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("circuit_breaker"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_circuit_breaker,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("circuit_breaker_threshold"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_threshold,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("circuit_breaker_success_threshold"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_success_threshold,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("circuit_breaker_timeout"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_timeout,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_circuit_breaker_module = ngx.module.make_module(
    @constCast(&ngx_http_circuit_breaker_commands),
    @constCast(&ngx_http_circuit_breaker_module_ctx),
);

// Tests
const expectEqual = std.testing.expectEqual;

test "circuit_breaker module" {
    try expectEqual(ngx_http_circuit_breaker_module.version, 1027004);
}
