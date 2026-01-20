const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;

const NGX_OK = core.NGX_OK;
const NGX_DONE = core.NGX_DONE;
const NGX_AGAIN = core.NGX_AGAIN;
const NGX_ERROR = core.NGX_ERROR;
const NGX_DECLINED = core.NGX_DECLINED;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = buf.ngx_buf_t;
const ngx_chain_t = buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NArray = ngx.array.NArray;

extern var ngx_http_core_module: ngx_module_t;

// WAF modes
const WAF_MODE_DETECT: ngx_uint_t = 0;
const WAF_MODE_BLOCK: ngx_uint_t = 1;

// WAF location configuration
const waf_loc_conf = extern struct {
    enabled: ngx_flag_t,
    mode: ngx_uint_t, // 0=detect, 1=block
    sqli_enabled: ngx_flag_t,
    xss_enabled: ngx_flag_t,
    check_body: ngx_flag_t,
};

// Request context for tracking WAF state
const waf_ctx = extern struct {
    done: ngx_flag_t,
    waiting_body: ngx_flag_t,
    lccf: [*c]waf_loc_conf,
};

// Detection result
const DetectionResult = struct {
    detected: bool,
    rule_type: []const u8,
    pattern: []const u8,
};

// SQL injection patterns - common attack signatures
const sqli_patterns = [_][]const u8{
    // Comment-based attacks
    "'--",
    "/*",
    "*/",
    "#'",
    // Boolean-based attacks
    "' or ",
    "' and ",
    "1=1",
    "1'='1",
    "'='",
    "or '1'='1",
    "or 1=1",
    "or true",
    // Union-based attacks
    "union select",
    "union all select",
    // Keyword-based attacks
    "select ",
    "insert ",
    "update ",
    "delete ",
    "drop ",
    "exec ",
    "execute ",
    "xp_",
    // Time-based attacks
    "sleep(",
    "waitfor delay",
    "benchmark(",
    // Other dangerous patterns
    "' or 1",
    "'; --",
    "'; drop",
    "1'; --",
};

// XSS patterns - common attack signatures
const xss_patterns = [_][]const u8{
    // Script tags and protocols
    "<script",
    "</script",
    "javascript:",
    "vbscript:",
    "data:text/html",
    // Event handlers
    "onerror=",
    "onclick=",
    "onload=",
    "onmouseover=",
    "onfocus=",
    "onblur=",
    "oninput=",
    "onchange=",
    "onsubmit=",
    "onkeydown=",
    "onkeyup=",
    "onkeypress=",
    // DOM manipulation
    "document.cookie",
    "document.write",
    "document.location",
    "window.location",
    ".innerhtml",
    // Script functions
    "alert(",
    "confirm(",
    "prompt(",
    "eval(",
    "expression(",
    "fromcharcode",
    // Other XSS vectors
    "<img",
    "<svg",
    "<iframe",
    "<object",
    "<embed",
    "<body",
    "<input",
    "<form",
    "src=",
    "href=",
};

// Decode a single hex character to value
fn hexCharToValue(c: u8) ?u8 {
    if (c >= '0' and c <= '9') return c - '0';
    if (c >= 'a' and c <= 'f') return c - 'a' + 10;
    if (c >= 'A' and c <= 'F') return c - 'A' + 10;
    return null;
}

// URL decode a string (handles %XX encoding)
fn urlDecode(input: []const u8, output: []u8) usize {
    var i: usize = 0;
    var j: usize = 0;
    while (i < input.len and j < output.len) {
        if (input[i] == '%' and i + 2 < input.len) {
            if (hexCharToValue(input[i + 1])) |high| {
                if (hexCharToValue(input[i + 2])) |low| {
                    output[j] = (high << 4) | low;
                    i += 3;
                    j += 1;
                    continue;
                }
            }
        }
        if (input[i] == '+') {
            output[j] = ' ';
        } else {
            output[j] = input[i];
        }
        i += 1;
        j += 1;
    }
    return j;
}

// Convert a byte to lowercase
fn toLower(c: u8) u8 {
    if (c >= 'A' and c <= 'Z') return c + 32;
    return c;
}

// Convert slice to lowercase in-place
fn toLowerSlice(slice: []u8) void {
    for (slice) |*c| {
        c.* = toLower(c.*);
    }
}

// Check for SQL injection patterns
fn checkSqli(input: []const u8) ?[]const u8 {
    for (sqli_patterns) |pattern| {
        if (std.mem.indexOf(u8, input, pattern) != null) {
            return pattern;
        }
    }
    return null;
}

// Check for XSS patterns
fn checkXss(input: []const u8) ?[]const u8 {
    for (xss_patterns) |pattern| {
        if (std.mem.indexOf(u8, input, pattern) != null) {
            return pattern;
        }
    }
    return null;
}

// Analyze input for attacks
fn analyzeInput(input: []const u8, lccf: *waf_loc_conf, decode_buf: []u8, lower_buf: []u8) DetectionResult {
    // First, URL decode the input
    const decoded_len = urlDecode(input, decode_buf);
    if (decoded_len == 0) {
        return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
    }

    // Convert to lowercase for case-insensitive matching
    const actual_len = @min(decoded_len, lower_buf.len);
    @memcpy(lower_buf[0..actual_len], decode_buf[0..actual_len]);
    toLowerSlice(lower_buf[0..actual_len]);

    const normalized = lower_buf[0..actual_len];

    // Check for SQL injection
    if (lccf.sqli_enabled == 1) {
        if (checkSqli(normalized)) |pattern| {
            return DetectionResult{ .detected = true, .rule_type = "sqli", .pattern = pattern };
        }
    }

    // Check for XSS
    if (lccf.xss_enabled == 1) {
        if (checkXss(normalized)) |pattern| {
            return DetectionResult{ .detected = true, .rule_type = "xss", .pattern = pattern };
        }
    }

    return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
}

// Send blocked response
fn sendBlockedResponse(r: [*c]ngx_http_request_t, rule_type: []const u8) ngx_int_t {
    // Set content type
    const content_type = ngx_string("application/json");
    r.*.headers_out.content_type = content_type;
    r.*.headers_out.content_type_len = content_type.len;
    r.*.headers_out.status = http.NGX_HTTP_FORBIDDEN;

    // Build error response: {"error":"waf_blocked","rule":"<type>"}
    const prefix = "{\"error\":\"waf_blocked\",\"rule\":\"";
    const suffix = "\"}";
    const response_len = prefix.len + rule_type.len + suffix.len;

    const buf_mem = core.ngx_pnalloc(r.*.pool, response_len) orelse return NGX_ERROR;
    const buf_ptr = core.castPtr(u8, buf_mem) orelse return NGX_ERROR;
    const response_buf = core.slicify(u8, buf_ptr, response_len);

    @memcpy(response_buf[0..prefix.len], prefix);
    @memcpy(response_buf[prefix.len..][0..rule_type.len], rule_type);
    @memcpy(response_buf[prefix.len + rule_type.len ..][0..suffix.len], suffix);

    r.*.headers_out.content_length_n = @intCast(response_len);

    const header_rc = http.ngx_http_send_header(r);
    if (header_rc == NGX_ERROR or header_rc > NGX_OK) {
        return header_rc;
    }

    // Create output buffer
    const b = core.castPtr(ngx_buf_t, core.ngx_pcalloc(r.*.pool, @sizeOf(ngx_buf_t))) orelse return NGX_ERROR;

    b.*.pos = buf_ptr;
    b.*.last = buf_ptr + response_len;
    b.*.flags.memory = true;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    var out: ngx_chain_t = undefined;
    out.buf = b;
    out.next = null;

    return http.ngx_http_output_filter(r, &out);
}

// Log detection without blocking
fn logDetection(r: [*c]ngx_http_request_t, rule_type: []const u8, pattern: []const u8) void {
    _ = pattern;
    // Log the detection
    ngx.log.ngz_log_error(ngx.log.NGX_LOG_WARN, r.*.connection.*.log, 0, "WAF: %s attack detected (detect mode)", .{rule_type.ptr});
}

// Body handler - called after request body is read
export fn ngx_http_waf_body_handler(r: [*c]ngx_http_request_t) callconv(.c) void {
    const rctx = core.castPtr(waf_ctx, r.*.ctx[ngx_http_waf_module.ctx_index]) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    };
    rctx.*.waiting_body = 0;

    const lccf = rctx.*.lccf;

    // Check if request body exists
    if (r.*.request_body == null or r.*.request_body.*.bufs == null) {
        rctx.*.done = 1;
        r.*.write_event_handler = http.ngx_http_core_run_phases;
        http.ngx_http_core_run_phases(r);
        return;
    }

    // Collect request body into a single buffer
    var body_len: usize = 0;
    var chain = r.*.request_body.*.bufs;
    while (chain != null) : (chain = chain.*.next) {
        if (chain.*.buf != null) {
            const b = chain.*.buf;
            body_len += @intFromPtr(b.*.last) - @intFromPtr(b.*.pos);
        }
    }

    if (body_len == 0) {
        rctx.*.done = 1;
        r.*.write_event_handler = http.ngx_http_core_run_phases;
        http.ngx_http_core_run_phases(r);
        return;
    }

    // Allocate body buffer
    const body_buf = core.ngx_pnalloc(r.*.pool, body_len) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    };
    const body_ptr = core.castPtr(u8, body_buf) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    };

    // Copy body data
    var offset: usize = 0;
    chain = r.*.request_body.*.bufs;
    while (chain != null) : (chain = chain.*.next) {
        if (chain.*.buf != null) {
            const b = chain.*.buf;
            const chunk_len = @intFromPtr(b.*.last) - @intFromPtr(b.*.pos);
            if (chunk_len > 0) {
                @memcpy(body_ptr[offset..][0..chunk_len], core.slicify(u8, b.*.pos, chunk_len));
                offset += chunk_len;
            }
        }
    }

    const body = core.slicify(u8, body_ptr, body_len);

    // Allocate buffers for analysis (limit to reasonable size)
    const max_analyze_len: usize = 8192;
    const analyze_len = @min(body_len, max_analyze_len);

    const decode_buf_mem = core.ngx_pnalloc(r.*.pool, analyze_len * 2) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    };
    const decode_buf = core.slicify(u8, core.castPtr(u8, decode_buf_mem) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    }, analyze_len * 2);

    const lower_buf_mem = core.ngx_pnalloc(r.*.pool, analyze_len * 2) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    };
    const lower_buf = core.slicify(u8, core.castPtr(u8, lower_buf_mem) orelse {
        http.ngx_http_finalize_request(r, NGX_ERROR);
        return;
    }, analyze_len * 2);

    // Analyze request body
    const result = analyzeInput(body[0..analyze_len], lccf, decode_buf, lower_buf);

    if (result.detected) {
        if (lccf.*.mode == WAF_MODE_BLOCK) {
            _ = sendBlockedResponse(r, result.rule_type);
            http.ngx_http_finalize_request(r, http.NGX_HTTP_FORBIDDEN);
            return;
        } else {
            logDetection(r, result.rule_type, result.pattern);
        }
    }

    // Continue to next phase
    rctx.*.done = 1;
    r.*.write_event_handler = http.ngx_http_core_run_phases;
    http.ngx_http_core_run_phases(r);
}

// Access phase handler
export fn ngx_http_waf_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        waf_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_waf_module),
    ) orelse return NGX_DECLINED;

    if (lccf.*.enabled != 1) {
        return NGX_DECLINED;
    }

    // Skip if neither SQLi nor XSS detection is enabled
    if (lccf.*.sqli_enabled != 1 and lccf.*.xss_enabled != 1) {
        return NGX_DECLINED;
    }

    // Check if we've already processed this request
    const rctx = http.ngz_http_get_module_ctx(
        waf_ctx,
        r,
        &ngx_http_waf_module,
    ) catch return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

    if (rctx.*.done == 1) {
        return NGX_DECLINED;
    }
    rctx.*.lccf = lccf;

    // Allocate buffers for analysis
    const max_uri_len: usize = 4096;
    const decode_buf_mem = core.ngx_pnalloc(r.*.pool, max_uri_len) orelse return NGX_ERROR;
    const decode_buf = core.slicify(u8, core.castPtr(u8, decode_buf_mem) orelse return NGX_ERROR, max_uri_len);

    const lower_buf_mem = core.ngx_pnalloc(r.*.pool, max_uri_len) orelse return NGX_ERROR;
    const lower_buf = core.slicify(u8, core.castPtr(u8, lower_buf_mem) orelse return NGX_ERROR, max_uri_len);

    // Check URI
    if (r.*.uri.len > 0 and r.*.uri.data != null) {
        const uri = core.slicify(u8, r.*.uri.data, r.*.uri.len);
        const uri_result = analyzeInput(uri, lccf, decode_buf, lower_buf);

        if (uri_result.detected) {
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, uri_result.rule_type);
            } else {
                logDetection(r, uri_result.rule_type, uri_result.pattern);
            }
        }
    }

    // Check query string (args)
    if (r.*.args.len > 0 and r.*.args.data != null) {
        const args = core.slicify(u8, r.*.args.data, r.*.args.len);
        const args_result = analyzeInput(args, lccf, decode_buf, lower_buf);

        if (args_result.detected) {
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, args_result.rule_type);
            } else {
                logDetection(r, args_result.rule_type, args_result.pattern);
            }
        }
    }

    // Check request body for POST/PUT/PATCH if enabled
    if (lccf.*.check_body == 1) {
        if (r.*.method == http.NGX_HTTP_POST or
            r.*.method == http.NGX_HTTP_PUT or
            r.*.method == http.NGX_HTTP_PATCH)
        {
            rctx.*.waiting_body = 1;
            const rc = http.ngx_http_read_client_request_body(r, ngx_http_waf_body_handler);
            if (rc == NGX_AGAIN) {
                return NGX_DONE;
            }
            if (rc >= http.NGX_HTTP_SPECIAL_RESPONSE) {
                return rc;
            }
            // Body was read synchronously, check has already been done in body handler
            return if (rctx.*.done == 1) NGX_DECLINED else rc;
        }
    }

    rctx.*.done = 1;
    return NGX_DECLINED;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(waf_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = conf.NGX_CONF_UNSET;
        p.*.mode = WAF_MODE_BLOCK; // Default to block mode
        p.*.sqli_enabled = conf.NGX_CONF_UNSET;
        p.*.xss_enabled = conf.NGX_CONF_UNSET;
        p.*.check_body = conf.NGX_CONF_UNSET;
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
    const prev = core.castPtr(waf_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(waf_loc_conf, child) orelse return conf.NGX_CONF_OK;

    // Inherit enabled flag
    if (c.*.enabled == conf.NGX_CONF_UNSET) {
        c.*.enabled = if (prev.*.enabled == conf.NGX_CONF_UNSET) 0 else prev.*.enabled;
    }

    // Inherit mode (only if child is unset and parent was explicitly set)
    if (prev.*.enabled == 1 and c.*.enabled == conf.NGX_CONF_UNSET) {
        c.*.mode = prev.*.mode;
    }

    // Inherit sqli_enabled
    if (c.*.sqli_enabled == conf.NGX_CONF_UNSET) {
        c.*.sqli_enabled = if (prev.*.sqli_enabled == conf.NGX_CONF_UNSET) 1 else prev.*.sqli_enabled;
    }

    // Inherit xss_enabled
    if (c.*.xss_enabled == conf.NGX_CONF_UNSET) {
        c.*.xss_enabled = if (prev.*.xss_enabled == conf.NGX_CONF_UNSET) 1 else prev.*.xss_enabled;
    }

    // Inherit check_body
    if (c.*.check_body == conf.NGX_CONF_UNSET) {
        c.*.check_body = if (prev.*.check_body == conf.NGX_CONF_UNSET) 0 else prev.*.check_body;
    }

    return conf.NGX_CONF_OK;
}

// Set waf on|off
fn ngx_conf_set_waf(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            if (std.mem.eql(u8, value, "on")) {
                lccf.*.enabled = 1;
            } else if (std.mem.eql(u8, value, "off")) {
                lccf.*.enabled = 0;
            } else {
                return conf.NGX_CONF_ERROR;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

// Set waf_mode detect|block
fn ngx_conf_set_waf_mode(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            if (std.mem.eql(u8, value, "detect")) {
                lccf.*.mode = WAF_MODE_DETECT;
            } else if (std.mem.eql(u8, value, "block")) {
                lccf.*.mode = WAF_MODE_BLOCK;
            } else {
                return conf.NGX_CONF_ERROR;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

// Set waf_sqli on|off
fn ngx_conf_set_waf_sqli(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            if (std.mem.eql(u8, value, "on")) {
                lccf.*.sqli_enabled = 1;
            } else if (std.mem.eql(u8, value, "off")) {
                lccf.*.sqli_enabled = 0;
            } else {
                return conf.NGX_CONF_ERROR;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

// Set waf_xss on|off
fn ngx_conf_set_waf_xss(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            if (std.mem.eql(u8, value, "on")) {
                lccf.*.xss_enabled = 1;
            } else if (std.mem.eql(u8, value, "off")) {
                lccf.*.xss_enabled = 0;
            } else {
                return conf.NGX_CONF_ERROR;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

// Set waf_check_body on|off
fn ngx_conf_set_waf_check_body(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            if (std.mem.eql(u8, value, "on")) {
                lccf.*.check_body = 1;
            } else if (std.mem.eql(u8, value, "off")) {
                lccf.*.check_body = 0;
            } else {
                return conf.NGX_CONF_ERROR;
            }
        }
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    // Register access phase handler
    const cmcf = core.castPtr(
        http.ngx_http_core_main_conf_t,
        conf.ngx_http_conf_get_module_main_conf(cf, &ngx_http_core_module),
    ) orelse return NGX_ERROR;

    var handlers = NArray(http.ngx_http_handler_pt).init0(
        &cmcf.*.phases[http.NGX_HTTP_ACCESS_PHASE].handlers,
    );
    const h = handlers.append() catch return NGX_ERROR;
    h.* = ngx_http_waf_handler;

    return NGX_OK;
}

export const ngx_http_waf_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_waf_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("waf"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_mode"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_mode,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_sqli"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_sqli,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_xss"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_xss,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_check_body"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_check_body,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_waf_module = ngx.module.make_module(
    @constCast(&ngx_http_waf_commands),
    @constCast(&ngx_http_waf_module_ctx),
);

// Unit tests
const expectEqual = std.testing.expectEqual;
const expect = std.testing.expect;

test "waf module" {
    try expectEqual(ngx_http_waf_module.version, 1027004);
}

test "urlDecode - basic decoding" {
    var output: [256]u8 = undefined;

    // Test %27 -> '
    const len1 = urlDecode("%27", &output);
    try expectEqual(len1, 1);
    try expectEqual(output[0], '\'');

    // Test %20 -> space
    const len2 = urlDecode("hello%20world", &output);
    try expectEqual(len2, 11);
    try expect(std.mem.eql(u8, output[0..len2], "hello world"));

    // Test + -> space
    const len3 = urlDecode("hello+world", &output);
    try expectEqual(len3, 11);
    try expect(std.mem.eql(u8, output[0..len3], "hello world"));

    // Test complex SQL injection encoded
    const len4 = urlDecode("%27%20OR%20%271%27=%271", &output);
    try expect(std.mem.eql(u8, output[0..len4], "' OR '1'='1"));
}

test "urlDecode - hex characters" {
    var output: [256]u8 = undefined;

    // Test uppercase hex
    const len1 = urlDecode("%2F", &output);
    try expectEqual(len1, 1);
    try expectEqual(output[0], '/');

    // Test lowercase hex
    const len2 = urlDecode("%2f", &output);
    try expectEqual(len2, 1);
    try expectEqual(output[0], '/');
}

test "toLowerSlice - converts to lowercase" {
    var test_buf = [_]u8{ 'H', 'E', 'L', 'L', 'O' };
    toLowerSlice(&test_buf);
    try expect(std.mem.eql(u8, &test_buf, "hello"));

    var test_buf2 = [_]u8{ 'H', 'e', 'L', 'l', 'O' };
    toLowerSlice(&test_buf2);
    try expect(std.mem.eql(u8, &test_buf2, "hello"));
}

test "checkSqli - detects SQL injection patterns" {
    // Test union-based
    try expect(checkSqli("union select * from users") != null);

    // Test comment-based
    try expect(checkSqli("admin'--") != null);

    // Test boolean-based
    try expect(checkSqli("' or 1=1") != null);
    try expect(checkSqli("' or '1'='1") != null);

    // Test clean input
    try expect(checkSqli("hello world") == null);
    try expect(checkSqli("john.doe@example.com") == null);
}

test "checkXss - detects XSS patterns" {
    // Test script tag
    try expect(checkXss("<script>alert(1)</script>") != null);

    // Test event handler
    try expect(checkXss("<img src=x onerror=alert(1)>") != null);

    // Test javascript protocol
    try expect(checkXss("javascript:alert(1)") != null);

    // Test document.cookie
    try expect(checkXss("document.cookie") != null);

    // Test clean input
    try expect(checkXss("hello world") == null);
    try expect(checkXss("normal text here") == null);
}

test "checkSqli - false positives avoided" {
    // Common legitimate inputs that shouldn't trigger
    try expect(checkSqli("john's pizza") == null); // possessive
    try expect(checkSqli("user@example.com") == null);
    try expect(checkSqli("product-name-123") == null);
}

test "checkXss - false positives avoided" {
    // Common legitimate inputs that shouldn't trigger
    try expect(checkXss("hello world") == null);
    try expect(checkXss("price: $100") == null);
    try expect(checkXss("2 < 3 and 5 > 4") == null);
}
