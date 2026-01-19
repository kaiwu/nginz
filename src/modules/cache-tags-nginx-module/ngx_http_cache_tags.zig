const std = @import("std");
const ngx = @import("ngx");

const buf = ngx.buf;
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
const ngx_buf_t = buf.ngx_buf_t;
const ngx_chain_t = buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;

extern var ngx_http_core_module: ngx_module_t;

// Configuration
const cache_tags_main_conf = extern struct {
    tag_header: ngx_str_t,
};

const cache_tags_loc_conf = extern struct {
    enabled: ngx_flag_t,
    purge_enabled: ngx_flag_t,
};

// Per-worker storage for tag → URI mappings
// Simple implementation: fixed arrays for demo purposes
const MAX_TAGS = 256;
const MAX_URIS_PER_TAG = 64;
const MAX_TAG_LEN = 64;
const MAX_URI_LEN = 256;

const TagEntry = struct {
    tag: [MAX_TAG_LEN]u8,
    tag_len: usize,
    uris: [MAX_URIS_PER_TAG][MAX_URI_LEN]u8,
    uri_lens: [MAX_URIS_PER_TAG]usize,
    uri_count: usize,
};

var tag_store: [MAX_TAGS]?TagEntry = [_]?TagEntry{null} ** MAX_TAGS;
var tag_count: usize = 0;

// Default header name
const default_tag_header = ngx_string("Cache-Tag");

// Find or create a tag entry
fn findOrCreateTag(tag: []const u8) ?*TagEntry {
    // First, look for existing tag
    for (&tag_store) |*entry| {
        if (entry.*) |*e| {
            if (e.tag_len == tag.len and std.mem.eql(u8, e.tag[0..e.tag_len], tag)) {
                return e;
            }
        }
    }

    // Create new tag entry
    if (tag_count >= MAX_TAGS) return null;

    for (&tag_store) |*entry| {
        if (entry.* == null) {
            entry.* = TagEntry{
                .tag = undefined,
                .tag_len = @min(tag.len, MAX_TAG_LEN),
                .uris = undefined,
                .uri_lens = [_]usize{0} ** MAX_URIS_PER_TAG,
                .uri_count = 0,
            };
            const len = @min(tag.len, MAX_TAG_LEN);
            @memcpy(entry.*.?.tag[0..len], tag[0..len]);
            tag_count += 1;
            return &entry.*.?;
        }
    }
    return null;
}

// Find a tag entry (read-only)
fn findTag(tag: []const u8) ?*TagEntry {
    for (&tag_store) |*entry| {
        if (entry.*) |*e| {
            if (e.tag_len == tag.len and std.mem.eql(u8, e.tag[0..e.tag_len], tag)) {
                return e;
            }
        }
    }
    return null;
}

// Add a URI to a tag
fn addUriToTag(tag_entry: *TagEntry, uri: []const u8) void {
    // Check if URI already exists
    for (0..tag_entry.uri_count) |i| {
        if (tag_entry.uri_lens[i] == uri.len and
            std.mem.eql(u8, tag_entry.uris[i][0..tag_entry.uri_lens[i]], uri))
        {
            return; // Already exists
        }
    }

    // Add new URI
    if (tag_entry.uri_count >= MAX_URIS_PER_TAG) return;

    const len = @min(uri.len, MAX_URI_LEN);
    @memcpy(tag_entry.uris[tag_entry.uri_count][0..len], uri[0..len]);
    tag_entry.uri_lens[tag_entry.uri_count] = len;
    tag_entry.uri_count += 1;
}

// Parse comma-separated tags and associate with URI
fn associateTagsWithUri(tags_str: []const u8, uri: []const u8) void {
    var start: usize = 0;
    for (tags_str, 0..) |c, i| {
        if (c == ',') {
            const tag = std.mem.trim(u8, tags_str[start..i], " \t");
            if (tag.len > 0) {
                if (findOrCreateTag(tag)) |entry| {
                    addUriToTag(entry, uri);
                }
            }
            start = i + 1;
        }
    }
    // Handle last tag
    const tag = std.mem.trim(u8, tags_str[start..], " \t");
    if (tag.len > 0) {
        if (findOrCreateTag(tag)) |entry| {
            addUriToTag(entry, uri);
        }
    }
}

// Purge all URIs associated with a tag, returns count
fn purgeByTag(tag: []const u8) usize {
    for (&tag_store, 0..) |*entry, i| {
        if (entry.*) |*e| {
            if (e.tag_len == tag.len and std.mem.eql(u8, e.tag[0..e.tag_len], tag)) {
                const count = e.uri_count;
                entry.* = null;
                tag_count -= 1;
                _ = i;
                return count;
            }
        }
    }
    return 0;
}

// Get header value by name from response headers
fn getResponseHeader(r: [*c]ngx_http_request_t, header_name: ngx_str_t) ?[]const u8 {
    const name_slice = core.slicify(u8, header_name.data, header_name.len);

    // Use NList to iterate over response headers
    var headers = ngx.list.NList(ngx.hash.ngx_table_elt_t).init0(&r.*.headers_out.headers);
    var it = headers.iterator();
    while (it.next()) |h| {
        const key_slice = core.slicify(u8, h.*.key.data, h.*.key.len);
        if (std.ascii.eqlIgnoreCase(key_slice, name_slice)) {
            return core.slicify(u8, h.*.value.data, h.*.value.len);
        }
    }
    return null;
}

// Header filter to capture Cache-Tag header
var ngx_http_cache_tags_next_header_filter: http.ngx_http_output_header_filter_pt = null;

export fn ngx_http_cache_tags_header_filter(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    const lccf = core.castPtr(
        cache_tags_loc_conf,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_cache_tags_filter_module),
    );

    if (lccf == null or lccf.?.*.enabled != 1) {
        if (ngx_http_cache_tags_next_header_filter) |next| {
            return next(r);
        }
        return NGX_OK;
    }

    // Get main conf for header name
    const mcf = core.castPtr(
        cache_tags_main_conf,
        conf.ngx_http_get_module_main_conf(r, &ngx_http_cache_tags_filter_module),
    );

    const header_name = if (mcf != null and mcf.?.*.tag_header.len > 0)
        mcf.?.*.tag_header
    else
        default_tag_header;

    // Get URI for this request
    const uri = core.slicify(u8, r.*.uri.data, r.*.uri.len);

    // Look for Cache-Tag header in response
    if (getResponseHeader(r, header_name)) |tags_value| {
        // Associate tags with this URI
        associateTagsWithUri(tags_value, uri);
    }

    if (ngx_http_cache_tags_next_header_filter) |next| {
        return next(r);
    }
    return NGX_OK;
}

// Content handler for purge endpoint
export fn ngx_http_cache_tags_purge_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    // Only allow PURGE or DELETE methods
    if (r.*.method != http.NGX_HTTP_DELETE and r.*.method != http.NGX_HTTP_GET) {
        return http.NGX_HTTP_NOT_ALLOWED;
    }

    // Get tag from query string: ?tag=mytag
    var tag_to_purge: ?[]const u8 = null;

    if (r.*.args.len > 0) {
        const args = core.slicify(u8, r.*.args.data, r.*.args.len);
        if (std.mem.indexOf(u8, args, "tag=")) |idx| {
            const start = idx + 4;
            var end = start;
            while (end < args.len and args[end] != '&') : (end += 1) {}
            if (end > start) {
                tag_to_purge = args[start..end];
            }
        }
    }

    // Build response
    var response_buf: [1024]u8 = undefined;
    var response_len: usize = 0;

    if (tag_to_purge) |tag| {
        const purged = purgeByTag(tag);
        const result = std.fmt.bufPrint(&response_buf, "{{\"tag\":\"{s}\",\"purged\":{d}}}\n", .{ tag, purged }) catch {
            return NGX_ERROR;
        };
        response_len = result.len;
    } else {
        // List all tags
        var written: usize = 0;
        written += (std.fmt.bufPrint(response_buf[written..], "{{\"tags\":[", .{}) catch return NGX_ERROR).len;

        var first = true;
        for (&tag_store) |*entry| {
            if (entry.*) |*e| {
                if (!first) {
                    written += (std.fmt.bufPrint(response_buf[written..], ",", .{}) catch return NGX_ERROR).len;
                }
                written += (std.fmt.bufPrint(response_buf[written..], "{{\"tag\":\"{s}\",\"uris\":{d}}}", .{
                    e.tag[0..e.tag_len],
                    e.uri_count,
                }) catch return NGX_ERROR).len;
                first = false;
            }
        }
        written += (std.fmt.bufPrint(response_buf[written..], "]}}\n", .{}) catch return NGX_ERROR).len;
        response_len = written;
    }

    // Set response headers
    const content_type = ngx_string("application/json");
    r.*.headers_out.content_type = content_type;
    r.*.headers_out.content_type_len = content_type.len;
    r.*.headers_out.status = 200;
    r.*.headers_out.content_length_n = @intCast(response_len);

    // Send headers
    const rc = http.ngx_http_send_header(r);
    if (rc == NGX_ERROR or rc > NGX_OK) {
        return rc;
    }

    // Allocate and send body
    const b = core.castPtr(ngx_buf_t, core.ngx_pcalloc(r.*.pool, @sizeOf(ngx_buf_t))) orelse return NGX_ERROR;
    const data = core.castPtr(u8, core.ngx_pnalloc(r.*.pool, response_len)) orelse return NGX_ERROR;

    @memcpy(core.slicify(u8, data, response_len), response_buf[0..response_len]);

    b.*.pos = data;
    b.*.last = data + response_len;
    b.*.flags.memory = true;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    var out: ngx_chain_t = undefined;
    out.buf = b;
    out.next = null;

    return http.ngx_http_output_filter(r, &out);
}

fn create_main_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(cache_tags_main_conf, cf.*.pool)) |p| {
        p.*.tag_header = ngx_str_t{ .len = 0, .data = null };
        return p;
    }
    return null;
}

fn create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(cache_tags_loc_conf, cf.*.pool)) |p| {
        p.*.enabled = 0;
        p.*.purge_enabled = 0;
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
    const prev = core.castPtr(cache_tags_loc_conf, parent) orelse return conf.NGX_CONF_OK;
    const c = core.castPtr(cache_tags_loc_conf, child) orelse return conf.NGX_CONF_OK;

    if (c.*.enabled == 0) {
        c.*.enabled = prev.*.enabled;
    }
    if (c.*.purge_enabled == 0) {
        c.*.purge_enabled = prev.*.purge_enabled;
    }

    return conf.NGX_CONF_OK;
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

fn ngx_conf_set_cache_tags_purge(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(cache_tags_loc_conf, loc)) |lccf| {
        lccf.*.purge_enabled = 1;

        // Register content handler for purge endpoint
        const clcf = core.castPtr(
            http.ngx_http_core_loc_conf_t,
            conf.ngx_http_conf_get_module_loc_conf(cf, &ngx_http_core_module),
        ) orelse return conf.NGX_CONF_OK;

        clcf.*.handler = ngx_http_cache_tags_purge_handler;
    }
    return conf.NGX_CONF_OK;
}

fn ngx_conf_set_cache_tags_header(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    mc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(cache_tags_main_conf, mc)) |mcf| {
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            mcf.*.tag_header = arg.*;
        }
    }
    return conf.NGX_CONF_OK;
}

fn postconfiguration(cf: [*c]ngx_conf_t) callconv(.c) ngx_int_t {
    _ = cf;
    // Install header filter
    ngx_http_cache_tags_next_header_filter = http.ngx_http_top_header_filter;
    http.ngx_http_top_header_filter = ngx_http_cache_tags_header_filter;
    return NGX_OK;
}

export const ngx_http_cache_tags_filter_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = postconfiguration,
    .create_main_conf = create_main_conf,
    .init_main_conf = null,
    .create_srv_conf = null,
    .merge_srv_conf = null,
    .create_loc_conf = create_loc_conf,
    .merge_loc_conf = merge_loc_conf,
};

export const ngx_http_cache_tags_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("cache_tags"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_cache_tags,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("cache_tags_header"),
        .type = conf.NGX_HTTP_MAIN_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_cache_tags_header,
        .conf = conf.NGX_HTTP_MAIN_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("cache_tags_purge"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_cache_tags_purge,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    conf.ngx_null_command,
};

export var ngx_http_cache_tags_filter_module = ngx.module.make_module(
    @constCast(&ngx_http_cache_tags_commands),
    @constCast(&ngx_http_cache_tags_filter_module_ctx),
);

// Tests
const expectEqual = std.testing.expectEqual;
const expectEqualStrings = std.testing.expectEqualStrings;

test "cache_tags module" {
    try expectEqual(ngx_http_cache_tags_filter_module.version, 1027004);
}

test "tag parsing" {
    // Reset state
    tag_store = [_]?TagEntry{null} ** MAX_TAGS;
    tag_count = 0;

    associateTagsWithUri("product, category, featured", "/api/products/123");
    associateTagsWithUri("category", "/api/products/456");

    try expectEqual(tag_count, 3);

    const product_tag = findTag("product");
    try expectEqual(product_tag != null, true);
    try expectEqual(product_tag.?.uri_count, 1);

    const category_tag = findTag("category");
    try expectEqual(category_tag != null, true);
    try expectEqual(category_tag.?.uri_count, 2);

    // Test purge
    const purged = purgeByTag("category");
    try expectEqual(purged, 2);
    try expectEqual(tag_count, 2);
    try expectEqual(findTag("category") == null, true);
}
