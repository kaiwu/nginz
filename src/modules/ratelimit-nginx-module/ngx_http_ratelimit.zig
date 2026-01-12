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
const NArray = ngx.array.NArray;

// External nginx core module
extern var ngx_http_core_module: ngx_module_t;

// Location configuration
const ratelimit_loc_conf = extern struct {
    enabled: ngx_flag_t,
    rate: ngx_uint_t, // requests per second
    burst: ngx_uint_t, // extra requests allowed
};

// Per-IP rate limit entry
const RateLimitEntry = struct {
    ip_hash: u32,
    count: u32,
    window_start: i64, // timestamp in seconds
};

// Global per-worker rate limit storage
const MAX_ENTRIES = 1024;
var rate_entries: [MAX_ENTRIES]?RateLimitEntry = [_]?RateLimitEntry{null} ** MAX_ENTRIES;

// Simple hash function for IP address string
fn hashIPString(addr_text: ngx_str_t) u32 {
    if (addr_text.len == 0 or addr_text.data == null) return 0;

    const slice = core.slicify(u8, addr_text.data, addr_text.len);
    var hash: u32 = 0;
    for (slice) |c| {
        hash = hash *% 31 +% c;
    }
    return hash;
}

// Get current time in seconds
fn getCurrentTimeSec() i64 {
    const tp = core.ngx_timeofday();
    if (tp) |t| {
        return @intCast(t.*.sec);
    }
    return 0;
}

// Find or create rate limit entry for an IP
fn getOrCreateEntry(ip_hash: u32, current_time: i64) *RateLimitEntry {
    // First pass: look for existing entry or expired entry to reuse
    var oldest_idx: usize = 0;
    var oldest_time: i64 = std.math.maxInt(i64);

    for (&rate_entries, 0..) |*entry, i| {
        if (entry.*) |*e| {
            if (e.ip_hash == ip_hash) {
                return e;
            }
            // Track oldest for potential eviction
            if (e.window_start < oldest_time) {
                oldest_time = e.window_start;
                oldest_idx = i;
            }
        }
    }

    // Second pass: find empty slot
    for (&rate_entries) |*entry| {
        if (entry.* == null) {
            entry.* = RateLimitEntry{
                .ip_hash = ip_hash,
                .count = 0,
                .window_start = current_time,
            };
            return &entry.*.?;
        }
    }

    // No empty slot - reuse oldest entry
    rate_entries[oldest_idx] = RateLimitEntry{
        .ip_hash = ip_hash,
        .count = 0,
        .window_start = current_time,
    };
    return &rate_entries[oldest_idx].?;
}

// Check rate limit and return true if allowed
fn checkRateLimit(ip_hash: u32, rate: ngx_uint_t, burst: ngx_uint_t) bool {
    const current_time = getCurrentTimeSec();
    const entry = getOrCreateEntry(ip_hash, current_time);

    // Check if window has expired (1 second window)
    if (current_time > entry.window_start) {
        // Reset for new window
        entry.window_start = current_time;
        entry.count = 0;
    }

    // Check if under limit (rate + burst)
    const limit = rate + burst;
    if (entry.count < limit) {
        entry.count += 1;
        return true;
    }

    return false;
}

// Get remaining requests in current window
fn getRemainingRequests(ip_hash: u32, rate: ngx_uint_t, burst: ngx_uint_t) u32 {
    const current_time = getCurrentTimeSec();
    const limit = rate + burst;

    for (&rate_entries) |*entry| {
        if (entry.*) |*e| {
            if (e.ip_hash == ip_hash) {
                // Check if window is current
                if (current_time == e.window_start) {
                    if (e.count >= limit) return 0;
                    return @intCast(limit - e.count);
                }
                // Window expired, full limit available
                return @intCast(limit);
            }
        }
    }

    // No entry found, full limit available
    return @intCast(limit);
}

// Access phase handler
fn ngx_http_ratelimit_access_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        ratelimit_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_ratelimit_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.enabled != 1) {
        return NGX_DECLINED;
    }

    // Get client IP hash from addr_text (formatted IP string)
    var ip_hash = hashIPString(r.*.connection.*.addr_text);

    // Fallback: use a constant hash for localhost if addr_text is empty
    if (ip_hash == 0) {
        // Use connection fd as a simple identifier, or default to 1 for localhost
        ip_hash = 1;
    }

    // Check rate limit
    if (checkRateLimit(ip_hash, lccf.*.rate, lccf.*.burst)) {
        return NGX_DECLINED; // Request allowed
    }

    // Rate limit exceeded - return 429 Too Many Requests
    return 429;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(ratelimit_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = conf.NGX_CONF_UNSET;
        p.*.rate = 10; // default 10 requests per second
        p.*.burst = 0; // no burst by default
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
    const prev = core.castPtr(ratelimit_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(ratelimit_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.enabled == conf.NGX_CONF_UNSET) {
        c.*.enabled = if (prev.*.enabled == conf.NGX_CONF_UNSET) 0 else prev.*.enabled;
    }

    if (c.*.rate == 10 and prev.*.rate != 10) {
        c.*.rate = prev.*.rate;
    }

    if (c.*.burst == 0 and prev.*.burst != 0) {
        c.*.burst = prev.*.burst;
    }

    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_ratelimit(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(ratelimit_loc_conf, loc)) |lccf| {
        lccf.*.enabled = 1;
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_ratelimit_rate(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(ratelimit_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const slice = core.slicify(u8, arg.*.data, arg.*.len);
            // Parse "Nr/s" format (e.g., "10r/s")
            if (std.mem.indexOf(u8, slice, "r/s")) |idx| {
                lccf.*.rate = std.fmt.parseInt(ngx_uint_t, slice[0..idx], 10) catch 10;
            } else {
                // Plain number
                lccf.*.rate = std.fmt.parseInt(ngx_uint_t, slice, 10) catch 10;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_ratelimit_burst(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(ratelimit_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const slice = core.slicify(u8, arg.*.data, arg.*.len);
            lccf.*.burst = std.fmt.parseInt(ngx_uint_t, slice, 10) catch 0;
        }
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register preaccess phase handler (NGX_HTTP_PREACCESS_PHASE = 5)
    const cmcf = core.castPtr(
        http.ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    var handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[5].handlers,
    );
    const h = handlers.append() catch return NGX_ERROR;
    h.* = ngx_http_ratelimit_access_handler;

    return NGX_OK;
}

export const ngx_http_ratelimit_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_ratelimit_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("ratelimit"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_ratelimit,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("ratelimit_rate"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_ratelimit_rate,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("ratelimit_burst"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_ratelimit_burst,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_ratelimit_module = ngx.module.make_module(
    @constCast(&ngx_http_ratelimit_commands),
    @constCast(&ngx_http_ratelimit_module_ctx),
);

// Tests
const expectEqual = std.testing.expectEqual;

test "ratelimit module" {
    try expectEqual(ngx_http_ratelimit_module.version, 1027004);
}
