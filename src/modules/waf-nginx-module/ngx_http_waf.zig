const std = @import("std");
const ngx = @import("ngx");
const libinjection = @import("ngx_libinjection");

const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const file = ngx.file;
const http = ngx.http;
const regex = ngx.regex;
const shm = ngx.shm;

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
const ngx_table_elt_t = ngx.hash.ngx_table_elt_t;
const NArray = ngx.array.NArray;
const NList = ngx.list.NList;

const WAF_PHASE_REQUEST: u8 = 1;
const WAF_PHASE_BODY: u8 = 2;

const WAF_TARGET_REQUEST_URI: u8 = 1;
const WAF_TARGET_ARGS: u8 = 2;
const WAF_TARGET_REQUEST_BODY: u8 = 3;
const WAF_TARGET_REQUEST_HEADERS: u8 = 4;
const WAF_TARGET_REQUEST_COOKIES: u8 = 5;
const WAF_TARGET_REQUEST_METHOD: u8 = 6;
const WAF_TARGET_REMOTE_ADDR: u8 = 7;

const WAF_OPERATOR_CONTAINS: u8 = 1;
const WAF_OPERATOR_LIBINJECTION_SQLI: u8 = 2;
const WAF_OPERATOR_LIBINJECTION_XSS: u8 = 3;
const WAF_OPERATOR_REGEX: u8 = 4;
const WAF_OPERATOR_EQUALS: u8 = 5;

const WAF_BAN_ZONE_SIZE: usize = 64 * 1024;
const WAF_BAN_MAX_IP_LEN: usize = 64;
const WAF_BAN_MAX_ENTRIES: usize = 256;

const waf_rule = extern struct {
    target: u8,
    phase: u8,
    operator: u8,
    id: ngx_uint_t,
    selector: ngx_str_t,
    pattern: ngx_str_t,
    compiled_regex: ?*regex.ngx_regex_t,
    msg: ngx_str_t,
};

const waf_ban_entry = extern struct {
    ip_len: u8,
    count: u16,
    first_seen: ngx_uint_t,
    ban_until: ngx_uint_t,
    ip: [WAF_BAN_MAX_IP_LEN]u8,
};

const waf_ban_store = extern struct {
    initialized: ngx_flag_t,
    entries_count: ngx_uint_t,
    entries: [*c]waf_ban_entry,
};

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
    rules_file: ngx_str_t,
    rules: [*c]waf_rule,
    rule_count: usize,
    ban_threshold: ngx_uint_t,
    ban_window: ngx_uint_t,
    ban_duration: ngx_uint_t,
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

var ngx_http_waf_ban_zone: [*c]core.ngx_shm_zone_t = core.nullptr(core.ngx_shm_zone_t);

fn trimAscii(slice: []const u8) []const u8 {
    return std.mem.trim(u8, slice, " \t\r\n");
}

fn lowerDup(pool: [*c]core.ngx_pool_t, value: []const u8) ?ngx_str_t {
    const out_buf = core.castPtr(u8, core.ngx_pnalloc(pool, value.len)) orelse return null;
    for (value, 0..) |c, i| {
        out_buf[i] = toLower(c);
    }
    return ngx_str_t{ .data = out_buf, .len = value.len };
}

fn dupSlice(pool: [*c]core.ngx_pool_t, value: []const u8) ?ngx_str_t {
    const out_buf = core.castPtr(u8, core.ngx_pnalloc(pool, value.len)) orelse return null;
    @memcpy(core.slicify(u8, out_buf, value.len), value);
    return ngx_str_t{ .data = out_buf, .len = value.len };
}

fn parseQuotedSegment(line: []const u8, start_at: usize) ?struct { value: []const u8, next: usize } {
    if (start_at >= line.len or line[start_at] != '"') return null;
    const rest = line[start_at + 1 ..];
    const end_rel = std.mem.indexOfScalar(u8, rest, '"') orelse return null;
    return .{ .value = rest[0..end_rel], .next = start_at + 1 + end_rel + 1 };
}

fn parseBaseTarget(target: []const u8) ?u8 {
    if (std.mem.eql(u8, target, "REQUEST_URI")) return WAF_TARGET_REQUEST_URI;
    if (std.mem.eql(u8, target, "ARGS")) return WAF_TARGET_ARGS;
    if (std.mem.eql(u8, target, "REQUEST_BODY")) return WAF_TARGET_REQUEST_BODY;
    if (std.mem.eql(u8, target, "REQUEST_HEADERS")) return WAF_TARGET_REQUEST_HEADERS;
    if (std.mem.eql(u8, target, "REQUEST_COOKIES")) return WAF_TARGET_REQUEST_COOKIES;
    if (std.mem.eql(u8, target, "REQUEST_METHOD")) return WAF_TARGET_REQUEST_METHOD;
    if (std.mem.eql(u8, target, "REMOTE_ADDR")) return WAF_TARGET_REMOTE_ADDR;
    return null;
}

fn parseRuleTargetAndSelector(target_text: []const u8, rule: *waf_rule, pool: [*c]core.ngx_pool_t) bool {
    if (std.mem.indexOfScalar(u8, target_text, ':')) |sep| {
        const base = trimAscii(target_text[0..sep]);
        const selector = trimAscii(target_text[sep + 1 ..]);
        const target = parseBaseTarget(base) orelse return false;
        if (selector.len == 0) return false;
        if (target != WAF_TARGET_REQUEST_HEADERS and target != WAF_TARGET_REQUEST_COOKIES) return false;
        rule.target = target;
        rule.selector = lowerDup(pool, selector) orelse return false;
        return true;
    }

    rule.target = parseBaseTarget(target_text) orelse return false;
    rule.selector = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    return true;
}

fn parseRuleActions(actions: []const u8, rule: *waf_rule, pool: [*c]core.ngx_pool_t) bool {
    var it = std.mem.splitScalar(u8, actions, ',');
    var saw_phase = false;
    while (it.next()) |part_raw| {
        const part = trimAscii(part_raw);
        if (part.len == 0) continue;

        if (std.mem.startsWith(u8, part, "id:")) {
            const id_text = trimAscii(part[3..]);
            rule.id = std.fmt.parseInt(ngx_uint_t, id_text, 10) catch return false;
        } else if (std.mem.startsWith(u8, part, "phase:")) {
            const phase_text = trimAscii(part[6..]);
            if (std.mem.eql(u8, phase_text, "1")) {
                rule.phase = WAF_PHASE_REQUEST;
            } else if (std.mem.eql(u8, phase_text, "2")) {
                rule.phase = WAF_PHASE_BODY;
            } else {
                return false;
            }
            saw_phase = true;
        } else if (std.mem.startsWith(u8, part, "msg:")) {
            const msg_text = trimAscii(part[4..]);
            if (msg_text.len >= 2 and ((msg_text[0] == '\'' and msg_text[msg_text.len - 1] == '\'') or (msg_text[0] == '"' and msg_text[msg_text.len - 1] == '"'))) {
                rule.msg = dupSlice(pool, msg_text[1 .. msg_text.len - 1]) orelse return false;
            } else {
                rule.msg = dupSlice(pool, msg_text) orelse return false;
            }
        } else if (std.mem.eql(u8, part, "deny") or std.mem.eql(u8, part, "log") or std.mem.eql(u8, part, "t:none")) {
            continue;
        } else {
            return false;
        }
    }

    return saw_phase;
}

fn compileRuleRegex(pattern: ngx_str_t, pool: [*c]core.ngx_pool_t) ?*regex.ngx_regex_t {
    var err_buf: [256]u8 = undefined;
    var rc = regex.initCompile(pattern, pool, &err_buf);
    if (regex.ngx_regex_compile(&rc) != NGX_OK) {
        return null;
    }
    return rc.regex;
}

fn parseWafRuleLine(line_raw: []const u8, rule: *waf_rule, pool: [*c]core.ngx_pool_t) bool {
    const line = trimAscii(line_raw);
    if (line.len == 0 or line[0] == '#') return false;
    if (!std.mem.startsWith(u8, line, "SecRule ")) return false;

    const after_prefix = line[8..];
    const first_space = std.mem.indexOfScalar(u8, after_prefix, ' ') orelse return false;
    const op_start = 8 + first_space + 1;
    const operator_segment = parseQuotedSegment(line, op_start) orelse return false;
    const actions_start = std.mem.indexOfPos(u8, line, operator_segment.next, "\"") orelse return false;
    const actions_segment = parseQuotedSegment(line, actions_start) orelse return false;

    const operator_text = trimAscii(operator_segment.value);

    rule.* = std.mem.zeroes(waf_rule);
    rule.msg = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    rule.compiled_regex = null;

    const target_text = trimAscii(after_prefix[0..first_space]);
    if (!parseRuleTargetAndSelector(target_text, rule, pool)) return false;

    if (std.mem.startsWith(u8, operator_text, "@contains ")) {
        const pattern_text = trimAscii(operator_text[10..]);
        if (pattern_text.len == 0) return false;
        rule.operator = WAF_OPERATOR_CONTAINS;
        rule.pattern = lowerDup(pool, pattern_text) orelse return false;
    } else if (std.mem.startsWith(u8, operator_text, "@streq ") or std.mem.startsWith(u8, operator_text, "@eq ")) {
        const offset: usize = if (std.mem.startsWith(u8, operator_text, "@streq ")) 7 else 4;
        const pattern_text = trimAscii(operator_text[offset..]);
        if (pattern_text.len == 0) return false;
        rule.operator = WAF_OPERATOR_EQUALS;
        rule.pattern = lowerDup(pool, pattern_text) orelse return false;
    } else if (std.mem.startsWith(u8, operator_text, "@rx ")) {
        const pattern_text = trimAscii(operator_text[4..]);
        if (pattern_text.len == 0) return false;
        rule.operator = WAF_OPERATOR_REGEX;
        rule.pattern = dupSlice(pool, pattern_text) orelse return false;
        rule.compiled_regex = compileRuleRegex(rule.pattern, pool) orelse return false;
    } else if (std.mem.eql(u8, operator_text, "@libinjection_sqli")) {
        rule.operator = WAF_OPERATOR_LIBINJECTION_SQLI;
        rule.pattern = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    } else if (std.mem.eql(u8, operator_text, "@libinjection_xss")) {
        rule.operator = WAF_OPERATOR_LIBINJECTION_XSS;
        rule.pattern = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
    } else {
        return false;
    }

    if (!parseRuleActions(actions_segment.value, rule, pool)) return false;
    if (rule.target == WAF_TARGET_REQUEST_BODY and rule.phase != WAF_PHASE_BODY) return false;
    if (rule.target != WAF_TARGET_REQUEST_BODY and rule.phase != WAF_PHASE_REQUEST) return false;

    return true;
}

fn loadWafRules(contents: ngx_str_t, pool: [*c]core.ngx_pool_t, out_rules: *[*c]waf_rule, out_count: *usize) bool {
    const text = core.slicify(u8, contents.data, contents.len);

    var count: usize = 0;
    var count_it = std.mem.splitScalar(u8, text, '\n');
    while (count_it.next()) |line| {
        const trimmed = trimAscii(line);
        if (trimmed.len == 0 or trimmed[0] == '#') continue;
        if (!std.mem.startsWith(u8, trimmed, "SecRule ")) return false;
        count += 1;
    }

    if (count == 0) {
        out_rules.* = core.nullptr(waf_rule);
        out_count.* = 0;
        return true;
    }

    const rules_mem = core.castPtr(waf_rule, core.ngx_pcalloc(pool, count * @sizeOf(waf_rule))) orelse return false;
    var index: usize = 0;
    var parse_it = std.mem.splitScalar(u8, text, '\n');
    while (parse_it.next()) |line| {
        const trimmed = trimAscii(line);
        if (trimmed.len == 0 or trimmed[0] == '#') continue;
        const rule_ptr: *waf_rule = @ptrCast(&rules_mem[index]);
        if (!parseWafRuleLine(trimmed, rule_ptr, pool)) return false;
        index += 1;
    }

    out_rules.* = rules_mem;
    out_count.* = count;
    return true;
}

fn analyzeCustomRules(input: []const u8, target: u8, phase: u8, lccf: *waf_loc_conf, decode_buf: []u8, lower_buf: []u8) DetectionResult {
    if (lccf.rule_count == 0 or lccf.rules == null) {
        return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
    }

    const decoded_len = urlDecode(input, decode_buf);
    if (decoded_len == 0) {
        return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
    }

    const actual_len = @min(decoded_len, lower_buf.len);
    @memcpy(lower_buf[0..actual_len], decode_buf[0..actual_len]);
    toLowerSlice(lower_buf[0..actual_len]);
    const normalized = lower_buf[0..actual_len];
    var decoded_str = ngx_str_t{ .data = decode_buf.ptr, .len = actual_len };

    for (0..lccf.rule_count) |i| {
        const rule = &lccf.rules[i];
        if (rule.selector.len != 0) continue;
        if (rule.target != target or rule.phase != phase) continue;

        switch (rule.operator) {
            WAF_OPERATOR_CONTAINS => {
                const pattern = core.slicify(u8, rule.pattern.data, rule.pattern.len);
                if (std.mem.indexOf(u8, normalized, pattern) != null) {
                    const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else pattern;
                    return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
                }
            },
            WAF_OPERATOR_LIBINJECTION_SQLI => {
                if (libinjection.detectSqli(decode_buf[0..actual_len])) {
                    const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else "libinjection_sqli";
                    return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
                }
            },
            WAF_OPERATOR_LIBINJECTION_XSS => {
                if (libinjection.detectXss(decode_buf[0..actual_len])) {
                    const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else "libinjection_xss";
                    return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
                }
            },
            WAF_OPERATOR_EQUALS => {
                const pattern = core.slicify(u8, rule.pattern.data, rule.pattern.len);
                if (std.mem.eql(u8, normalized, pattern)) {
                    const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else pattern;
                    return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
                }
            },
            WAF_OPERATOR_REGEX => {
                if (rule.compiled_regex != null) {
                    const rc = regex.ngx_regex_exec(rule.compiled_regex, &decoded_str, core.nullptr(c_int), 0);
                    if (rc >= 0) {
                        const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else core.slicify(u8, rule.pattern.data, rule.pattern.len);
                        return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
                    }
                }
            },
            else => {},
        }
    }

    return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
}

fn hasBodyRules(lccf: *waf_loc_conf) bool {
    for (0..lccf.rule_count) |i| {
        if (lccf.rules[i].target == WAF_TARGET_REQUEST_BODY) return true;
    }
    return false;
}

fn nowSeconds() ngx_uint_t {
    return @intCast(core.ngx_time());
}

fn getBanStore() ?[*c]waf_ban_store {
    if (ngx_http_waf_ban_zone == core.nullptr(core.ngx_shm_zone_t)) return null;
    return core.castPtr(waf_ban_store, ngx_http_waf_ban_zone.*.data);
}

fn getClientIp(r: [*c]ngx_http_request_t) ?[]const u8 {
    if (r.*.connection != null and r.*.connection.*.addr_text.len > 0 and r.*.connection.*.addr_text.data != null) {
        const raw = core.slicify(u8, r.*.connection.*.addr_text.data, r.*.connection.*.addr_text.len);
        const len = std.mem.indexOfScalar(u8, raw, 0) orelse raw.len;
        return raw[0..len];
    }
    return null;
}

fn findBanEntry(store: [*c]waf_ban_store, ip: []const u8) ?[*c]waf_ban_entry {
    for (0..store.*.entries_count) |i| {
        const entry = &store.*.entries[i];
        if (entry.ip_len == ip.len and std.mem.eql(u8, entry.ip[0..entry.ip_len], ip)) {
            return @ptrCast(entry);
        }
    }
    return null;
}

fn getOrCreateBanEntry(shpool: [*c]core.ngx_slab_pool_t, store: [*c]waf_ban_store, ip: []const u8) ?[*c]waf_ban_entry {
    if (findBanEntry(store, ip)) |entry| return entry;

    if (store.*.entries_count < WAF_BAN_MAX_ENTRIES) {
        const entry = &store.*.entries[store.*.entries_count];
        store.*.entries_count += 1;
        entry.* = std.mem.zeroes(waf_ban_entry);
        const copy_len: usize = @min(ip.len, WAF_BAN_MAX_IP_LEN);
        @memcpy(entry.ip[0..copy_len], ip[0..copy_len]);
        entry.ip_len = @intCast(copy_len);
        return @ptrCast(entry);
    }

    const now = nowSeconds();
    for (0..store.*.entries_count) |i| {
        const entry = &store.*.entries[i];
        if (entry.ban_until <= now and entry.count == 0) {
            entry.* = std.mem.zeroes(waf_ban_entry);
            const copy_len: usize = @min(ip.len, WAF_BAN_MAX_IP_LEN);
            @memcpy(entry.ip[0..copy_len], ip[0..copy_len]);
            entry.ip_len = @intCast(copy_len);
            return @ptrCast(entry);
        }
    }

    _ = shpool;
    return null;
}

fn isClientBanned(r: [*c]ngx_http_request_t, lccf: *waf_loc_conf) bool {
    if (lccf.ban_threshold == 0) return false;
    const ip = getClientIp(r) orelse return false;
    const store = getBanStore() orelse return false;
    const zone = ngx_http_waf_ban_zone;
    const shpool = if (zone != core.nullptr(core.ngx_shm_zone_t) and zone.*.shm.addr != null and zone.*.data != null)
        core.castPtr(core.ngx_slab_pool_t, zone.*.shm.addr)
    else
        null;
    if (shpool == null) return false;

    shm.ngx_shmtx_lock(&shpool.?.*.mutex);
    defer shm.ngx_shmtx_unlock(&shpool.?.*.mutex);

    if (findBanEntry(store, ip)) |entry| {
        const now = nowSeconds();
        if (entry.*.ban_until > now) return true;
        if (entry.*.ban_until != 0 and entry.*.ban_until <= now) {
            entry.*.ban_until = 0;
            entry.*.count = 0;
            entry.*.first_seen = 0;
        }
    }
    return false;
}

fn recordOffense(r: [*c]ngx_http_request_t, lccf: *waf_loc_conf) void {
    if (lccf.ban_threshold == 0) return;
    const ip = getClientIp(r) orelse return;
    const store = getBanStore() orelse return;
    const zone = ngx_http_waf_ban_zone;
    const shpool = if (zone != core.nullptr(core.ngx_shm_zone_t) and zone.*.shm.addr != null and zone.*.data != null)
        core.castPtr(core.ngx_slab_pool_t, zone.*.shm.addr)
    else
        null;

    if (shpool == null) return;
    shm.ngx_shmtx_lock(&shpool.?.*.mutex);
    defer shm.ngx_shmtx_unlock(&shpool.?.*.mutex);

    const entry = getOrCreateBanEntry(shpool.?, store, ip) orelse return;
    const now = nowSeconds();

    if (entry.*.ban_until > now) return;
    if (entry.*.first_seen == 0 or now - entry.*.first_seen > lccf.ban_window) {
        entry.*.first_seen = now;
        entry.*.count = 1;
        return;
    }

    entry.*.count += 1;
    if (entry.*.count >= lccf.ban_threshold) {
        entry.*.ban_until = now + lccf.ban_duration;
        entry.*.count = 0;
        entry.*.first_seen = now;
    }
}

fn ngx_http_waf_ban_zone_init(zone: [*c]core.ngx_shm_zone_t, data: ?*anyopaque) callconv(.c) ngx_int_t {
    if (data != null) {
        zone.*.data = data;
        return NGX_OK;
    }

    const shpool = core.castPtr(core.ngx_slab_pool_t, zone.*.shm.addr) orelse return NGX_ERROR;
    if (shpool.*.data != null) {
        zone.*.data = shpool.*.data;
        return NGX_OK;
    }

    const store_mem = shm.ngx_slab_calloc(shpool, @sizeOf(waf_ban_store)) orelse return NGX_ERROR;
    const store = core.castPtr(waf_ban_store, store_mem) orelse return NGX_ERROR;
    const entries_mem = shm.ngx_slab_calloc(shpool, @sizeOf(waf_ban_entry) * WAF_BAN_MAX_ENTRIES) orelse return NGX_ERROR;
    const entries = core.castPtr(waf_ban_entry, entries_mem) orelse return NGX_ERROR;

    store.*.initialized = 1;
    store.*.entries_count = 0;
    store.*.entries = entries;
    shpool.*.data = store;
    zone.*.data = store;
    return NGX_OK;
}

fn collectRequestHeaders(r: [*c]ngx_http_request_t, pool: [*c]core.ngx_pool_t) ?ngx_str_t {
    var headers = NList(ngx_table_elt_t).init0(&r.*.headers_in.headers);
    var it = headers.iterator();

    var total_len: usize = 0;
    while (it.next()) |h| {
        total_len += h.*.key.len + 2 + h.*.value.len + 1;
    }
    if (total_len == 0) return null;

    const out = core.castPtr(u8, core.ngx_pnalloc(pool, total_len)) orelse return null;
    var pos: usize = 0;

    var headers2 = NList(ngx_table_elt_t).init0(&r.*.headers_in.headers);
    var it2 = headers2.iterator();
    while (it2.next()) |h| {
        const key = core.slicify(u8, h.*.key.data, h.*.key.len);
        const value = core.slicify(u8, h.*.value.data, h.*.value.len);
        @memcpy(out[pos..][0..key.len], key);
        pos += key.len;
        out[pos] = ':';
        out[pos + 1] = ' ';
        pos += 2;
        @memcpy(out[pos..][0..value.len], value);
        pos += value.len;
        out[pos] = '\n';
        pos += 1;
    }

    return ngx_str_t{ .data = out, .len = pos };
}

fn analyzeHeaderSelectorRules(r: [*c]ngx_http_request_t, lccf: *waf_loc_conf, decode_buf: []u8, lower_buf: []u8) DetectionResult {
    var headers = NList(ngx_table_elt_t).init0(&r.*.headers_in.headers);
    var it = headers.iterator();
    while (it.next()) |h| {
        const key = core.slicify(u8, h.*.key.data, h.*.key.len);
        const value = core.slicify(u8, h.*.value.data, h.*.value.len);

        var key_buf: [256]u8 = undefined;
        const key_len = @min(key.len, key_buf.len);
        @memcpy(key_buf[0..key_len], key[0..key_len]);
        toLowerSlice(key_buf[0..key_len]);

        for (0..lccf.rule_count) |i| {
            const rule: *waf_rule = @ptrCast(&lccf.rules[i]);
            if (rule.target != WAF_TARGET_REQUEST_HEADERS or rule.phase != WAF_PHASE_REQUEST or rule.selector.len == 0) continue;
            const selector = core.slicify(u8, rule.selector.data, rule.selector.len);
            if (!std.mem.eql(u8, key_buf[0..key_len], selector)) continue;

            const single = analyzeSingleRule(rule, value, decode_buf, lower_buf);
            if (single.detected) return single;
        }
    }
    return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
}

fn analyzeCookieSelectorRules(cookie_header: []const u8, lccf: *waf_loc_conf, decode_buf: []u8, lower_buf: []u8) DetectionResult {
    var cookies = std.mem.splitScalar(u8, cookie_header, ';');
    while (cookies.next()) |cookie_raw| {
        const cookie = trimAscii(cookie_raw);
        if (cookie.len == 0) continue;
        const eq = std.mem.indexOfScalar(u8, cookie, '=') orelse continue;
        const name = trimAscii(cookie[0..eq]);
        const value = trimAscii(cookie[eq + 1 ..]);

        var name_buf: [256]u8 = undefined;
        const name_len = @min(name.len, name_buf.len);
        @memcpy(name_buf[0..name_len], name[0..name_len]);
        toLowerSlice(name_buf[0..name_len]);

        for (0..lccf.rule_count) |i| {
            const rule: *waf_rule = @ptrCast(&lccf.rules[i]);
            if (rule.target != WAF_TARGET_REQUEST_COOKIES or rule.phase != WAF_PHASE_REQUEST or rule.selector.len == 0) continue;
            const selector = core.slicify(u8, rule.selector.data, rule.selector.len);
            if (!std.mem.eql(u8, name_buf[0..name_len], selector)) continue;

            const single = analyzeSingleRule(rule, value, decode_buf, lower_buf);
            if (single.detected) return single;
        }
    }
    return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
}

fn analyzeSingleRule(rule: *waf_rule, input: []const u8, decode_buf: []u8, lower_buf: []u8) DetectionResult {
    const decoded_len = urlDecode(input, decode_buf);
    if (decoded_len == 0) return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
    const actual_len = @min(decoded_len, lower_buf.len);
    @memcpy(lower_buf[0..actual_len], decode_buf[0..actual_len]);
    toLowerSlice(lower_buf[0..actual_len]);
    const normalized = lower_buf[0..actual_len];
    var decoded_str = ngx_str_t{ .data = decode_buf.ptr, .len = actual_len };

    switch (rule.operator) {
        WAF_OPERATOR_CONTAINS => {
            const pattern = core.slicify(u8, rule.pattern.data, rule.pattern.len);
            if (std.mem.indexOf(u8, normalized, pattern) != null) {
                const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else pattern;
                return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
            }
        },
        WAF_OPERATOR_LIBINJECTION_SQLI => {
            if (libinjection.detectSqli(decode_buf[0..actual_len])) {
                const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else "libinjection_sqli";
                return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
            }
        },
        WAF_OPERATOR_LIBINJECTION_XSS => {
            if (libinjection.detectXss(decode_buf[0..actual_len])) {
                const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else "libinjection_xss";
                return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
            }
        },
        WAF_OPERATOR_EQUALS => {
            const pattern = core.slicify(u8, rule.pattern.data, rule.pattern.len);
            if (std.mem.eql(u8, normalized, pattern)) {
                const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else pattern;
                return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
            }
        },
        WAF_OPERATOR_REGEX => {
            if (rule.compiled_regex != null) {
                const rc = regex.ngx_regex_exec(rule.compiled_regex, &decoded_str, core.nullptr(c_int), 0);
                if (rc >= 0) {
                    const detail = if (rule.msg.len > 0 and rule.msg.data != null) core.slicify(u8, rule.msg.data, rule.msg.len) else core.slicify(u8, rule.pattern.data, rule.pattern.len);
                    return DetectionResult{ .detected = true, .rule_type = "rule", .pattern = detail };
                }
            }
        },
        else => {},
    }

    return DetectionResult{ .detected = false, .rule_type = "", .pattern = "" };
}

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
    const decoded = decode_buf[0..actual_len];

    // Check for SQL injection
    if (lccf.sqli_enabled == 1) {
        if (libinjection.detectSqli(decoded)) {
            return DetectionResult{ .detected = true, .rule_type = "sqli", .pattern = "libinjection" };
        }
        if (checkSqli(normalized)) |pattern| {
            return DetectionResult{ .detected = true, .rule_type = "sqli", .pattern = pattern };
        }
    }

    // Check for XSS
    if (lccf.xss_enabled == 1) {
        if (libinjection.detectXss(decoded)) {
            return DetectionResult{ .detected = true, .rule_type = "xss", .pattern = "libinjection" };
        }
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
    const custom_result = if (result.detected)
        DetectionResult{ .detected = false, .rule_type = "", .pattern = "" }
    else
        analyzeCustomRules(body[0..analyze_len], WAF_TARGET_REQUEST_BODY, WAF_PHASE_BODY, lccf, decode_buf, lower_buf);
    const final_result = if (result.detected) result else custom_result;

    if (final_result.detected) {
        recordOffense(r, lccf);
        if (lccf.*.mode == WAF_MODE_BLOCK) {
            _ = sendBlockedResponse(r, final_result.rule_type);
            http.ngx_http_finalize_request(r, http.NGX_HTTP_FORBIDDEN);
            return;
        } else {
            logDetection(r, final_result.rule_type, final_result.pattern);
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

    // Skip if neither built-in detectors nor file-driven rules are enabled
    if (lccf.*.sqli_enabled != 1 and lccf.*.xss_enabled != 1 and lccf.*.rule_count == 0) {
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

    if (isClientBanned(r, lccf)) {
        rctx.*.done = 1;
        return sendBlockedResponse(r, "ban");
    }

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
        const uri_custom_result = if (uri_result.detected)
            DetectionResult{ .detected = false, .rule_type = "", .pattern = "" }
        else
            analyzeCustomRules(uri, WAF_TARGET_REQUEST_URI, WAF_PHASE_REQUEST, lccf, decode_buf, lower_buf);
        const final_uri_result = if (uri_result.detected) uri_result else uri_custom_result;

        if (final_uri_result.detected) {
            recordOffense(r, lccf);
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, final_uri_result.rule_type);
            } else {
                logDetection(r, final_uri_result.rule_type, final_uri_result.pattern);
            }
        }
    }

    // Check query string (args)
    if (r.*.args.len > 0 and r.*.args.data != null) {
        const args = core.slicify(u8, r.*.args.data, r.*.args.len);
        const args_result = analyzeInput(args, lccf, decode_buf, lower_buf);
        const args_custom_result = if (args_result.detected)
            DetectionResult{ .detected = false, .rule_type = "", .pattern = "" }
        else
            analyzeCustomRules(args, WAF_TARGET_ARGS, WAF_PHASE_REQUEST, lccf, decode_buf, lower_buf);
        const final_args_result = if (args_result.detected) args_result else args_custom_result;

        if (final_args_result.detected) {
            recordOffense(r, lccf);
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, final_args_result.rule_type);
            } else {
                logDetection(r, final_args_result.rule_type, final_args_result.pattern);
            }
        }
    }

    if (r.*.headers_in.cookie != core.nullptr(ngx_table_elt_t)) {
        const cookie_value = r.*.headers_in.cookie.*.value;
        if (cookie_value.len > 0 and cookie_value.data != null) {
            const cookies = core.slicify(u8, cookie_value.data, cookie_value.len);
            const cookie_selector_result = analyzeCookieSelectorRules(cookies, lccf, decode_buf, lower_buf);
            if (cookie_selector_result.detected) {
                recordOffense(r, lccf);
                if (lccf.*.mode == WAF_MODE_BLOCK) {
                    rctx.*.done = 1;
                    return sendBlockedResponse(r, cookie_selector_result.rule_type);
                } else {
                    logDetection(r, cookie_selector_result.rule_type, cookie_selector_result.pattern);
                }
            }
            const cookie_result = analyzeCustomRules(cookies, WAF_TARGET_REQUEST_COOKIES, WAF_PHASE_REQUEST, lccf, decode_buf, lower_buf);
            if (cookie_result.detected) {
                recordOffense(r, lccf);
                if (lccf.*.mode == WAF_MODE_BLOCK) {
                    rctx.*.done = 1;
                    return sendBlockedResponse(r, cookie_result.rule_type);
                } else {
                    logDetection(r, cookie_result.rule_type, cookie_result.pattern);
                }
            }
        }
    }

    if (r.*.method_name.len > 0 and r.*.method_name.data != null) {
        const method_name = core.slicify(u8, r.*.method_name.data, r.*.method_name.len);
        const method_result = analyzeCustomRules(method_name, WAF_TARGET_REQUEST_METHOD, WAF_PHASE_REQUEST, lccf, decode_buf, lower_buf);
        if (method_result.detected) {
            recordOffense(r, lccf);
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, method_result.rule_type);
            } else {
                logDetection(r, method_result.rule_type, method_result.pattern);
            }
        }
    }

    if (r.*.connection != null and r.*.connection.*.addr_text.len > 0 and r.*.connection.*.addr_text.data != null) {
        const remote_addr = core.slicify(u8, r.*.connection.*.addr_text.data, r.*.connection.*.addr_text.len);
        const addr_result = analyzeCustomRules(remote_addr, WAF_TARGET_REMOTE_ADDR, WAF_PHASE_REQUEST, lccf, decode_buf, lower_buf);
        if (addr_result.detected) {
            recordOffense(r, lccf);
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, addr_result.rule_type);
            } else {
                logDetection(r, addr_result.rule_type, addr_result.pattern);
            }
        }
    }

    const header_selector_result = analyzeHeaderSelectorRules(r, lccf, decode_buf, lower_buf);
    if (header_selector_result.detected) {
        recordOffense(r, lccf);
        if (lccf.*.mode == WAF_MODE_BLOCK) {
            rctx.*.done = 1;
            return sendBlockedResponse(r, header_selector_result.rule_type);
        } else {
            logDetection(r, header_selector_result.rule_type, header_selector_result.pattern);
        }
    }

    if (collectRequestHeaders(r, r.*.pool)) |headers_text| {
        const headers_slice = core.slicify(u8, headers_text.data, headers_text.len);
        const headers_result = analyzeCustomRules(headers_slice, WAF_TARGET_REQUEST_HEADERS, WAF_PHASE_REQUEST, lccf, decode_buf, lower_buf);
        if (headers_result.detected) {
            recordOffense(r, lccf);
            if (lccf.*.mode == WAF_MODE_BLOCK) {
                rctx.*.done = 1;
                return sendBlockedResponse(r, headers_result.rule_type);
            } else {
                logDetection(r, headers_result.rule_type, headers_result.pattern);
            }
        }
    }

    // Check request body for POST/PUT/PATCH if enabled
    if (lccf.*.check_body == 1 or hasBodyRules(lccf)) {
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
        p.*.rules_file = ngx_str_t{ .len = 0, .data = core.nullptr(u8) };
        p.*.rules = core.nullptr(waf_rule);
        p.*.rule_count = 0;
        p.*.ban_threshold = conf.NGX_CONF_UNSET_UINT;
        p.*.ban_window = conf.NGX_CONF_UNSET_UINT;
        p.*.ban_duration = conf.NGX_CONF_UNSET_UINT;
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
    const child_enabled_unset = c.*.enabled == conf.NGX_CONF_UNSET;
    if (c.*.enabled == conf.NGX_CONF_UNSET) {
        c.*.enabled = if (prev.*.enabled == conf.NGX_CONF_UNSET) 0 else prev.*.enabled;
    }

    // Inherit mode if child did not explicitly set waf on/off and parent was enabled
    if (prev.*.enabled == 1 and child_enabled_unset) {
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

    if (c.*.rules_file.len == 0) {
        c.*.rules_file = prev.*.rules_file;
        c.*.rules = prev.*.rules;
        c.*.rule_count = prev.*.rule_count;
    }

    if (c.*.ban_threshold == conf.NGX_CONF_UNSET_UINT) {
        c.*.ban_threshold = if (prev.*.ban_threshold == conf.NGX_CONF_UNSET_UINT) 0 else prev.*.ban_threshold;
    }
    if (c.*.ban_window == conf.NGX_CONF_UNSET_UINT) {
        c.*.ban_window = if (prev.*.ban_window == conf.NGX_CONF_UNSET_UINT) 60 else prev.*.ban_window;
    }
    if (c.*.ban_duration == conf.NGX_CONF_UNSET_UINT) {
        c.*.ban_duration = if (prev.*.ban_duration == conf.NGX_CONF_UNSET_UINT) 300 else prev.*.ban_duration;
    }

    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_waf_rules_file(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            var path = arg.*;
            if (conf.ngx_conf_full_name(cf.*.cycle, &path, 1) != core.NGX_OK) {
                return conf.NGX_CONF_ERROR;
            }

            const contents = file.ngz_open_file(path, cf.*.log, cf.*.pool) catch return conf.NGX_CONF_ERROR;
            var rules_ptr: [*c]waf_rule = core.nullptr(waf_rule);
            var rule_count: usize = 0;
            if (!loadWafRules(contents, cf.*.pool, &rules_ptr, &rule_count)) {
                return conf.NGX_CONF_ERROR;
            }

            lccf.*.enabled = 1;
            lccf.*.rules_file = path;
            lccf.*.rules = rules_ptr;
            lccf.*.rule_count = rule_count;
        }
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

fn ngx_conf_set_waf_ban_threshold(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            lccf.*.ban_threshold = std.fmt.parseInt(ngx_uint_t, value, 10) catch return conf.NGX_CONF_ERROR;
        }
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_waf_ban_window(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            lccf.*.ban_window = std.fmt.parseInt(ngx_uint_t, value, 10) catch return conf.NGX_CONF_ERROR;
        }
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_waf_ban_duration(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(waf_loc_conf, loc)) |lccf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const value = core.slicify(u8, arg.*.data, arg.*.len);
            lccf.*.ban_duration = std.fmt.parseInt(ngx_uint_t, value, 10) catch return conf.NGX_CONF_ERROR;
        }
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    if (ngx_http_waf_ban_zone == core.nullptr(core.ngx_shm_zone_t)) {
        var zone_name = ngx_string("waf_ban_zone");
        const zone = shm.ngx_shared_memory_add(cf, &zone_name, WAF_BAN_ZONE_SIZE, @constCast(&ngx_http_waf_module));
        if (zone == core.nullptr(core.ngx_shm_zone_t)) return NGX_ERROR;
        zone.*.init = ngx_http_waf_ban_zone_init;
        ngx_http_waf_ban_zone = zone;
    }

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
    ngx_command_t{
        .name = ngx_string("waf_rules_file"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_rules_file,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_ban_threshold"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_ban_threshold,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_ban_window"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_ban_window,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("waf_ban_duration"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_waf_ban_duration,
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

test "waf module" {}

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
