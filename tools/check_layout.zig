const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const http = ngx.http;

const SizeEntry = struct { name: []const u8, zig_size: usize };
const OffsetEntry = struct { name: []const u8, field: []const u8, zig_offset: usize };

// Core structs from ngx_core.zig test
// HTTP structs from ngx_http.zig test
const sizeof_table = [_]SizeEntry{
    .{ .name = "ngx_dir_t", .zig_size = @sizeOf(core.ngx_dir_t) },
    .{ .name = "ngx_process_t", .zig_size = @sizeOf(core.ngx_process_t) },
    .{ .name = "ngx_pool_t", .zig_size = @sizeOf(core.ngx_pool_t) },
    .{ .name = "ngx_cycle_t", .zig_size = @sizeOf(core.ngx_cycle_t) },
    .{ .name = "ngx_output_chain_ctx_t", .zig_size = @sizeOf(core.ngx_output_chain_ctx_t) },
    .{ .name = "ngx_listening_t", .zig_size = @sizeOf(core.ngx_listening_t) },
    .{ .name = "ngx_connection_t", .zig_size = @sizeOf(core.ngx_connection_t) },
    .{ .name = "ngx_ext_rename_file_t", .zig_size = @sizeOf(core.ngx_ext_rename_file_t) },
    .{ .name = "ngx_url_t", .zig_size = @sizeOf(core.ngx_url_t) },
    .{ .name = "ngx_open_file_info_t", .zig_size = @sizeOf(core.ngx_open_file_info_t) },
    .{ .name = "ngx_cached_open_file_t", .zig_size = @sizeOf(core.ngx_cached_open_file_t) },
    .{ .name = "ngx_resolver_node_t", .zig_size = @sizeOf(core.ngx_resolver_node_t) },
    .{ .name = "ngx_resolver_t", .zig_size = @sizeOf(core.ngx_resolver_t) },
    .{ .name = "ngx_resolver_ctx_t", .zig_size = @sizeOf(core.ngx_resolver_ctx_t) },
    .{ .name = "ngx_slab_pool_t", .zig_size = @sizeOf(core.ngx_slab_pool_t) },
    .{ .name = "ngx_variable_value_t", .zig_size = @sizeOf(core.ngx_variable_value_t) },
    .{ .name = "ngx_syslog_peer_t", .zig_size = @sizeOf(core.ngx_syslog_peer_t) },
    .{ .name = "ngx_event_t", .zig_size = @sizeOf(core.ngx_event_t) },
    .{ .name = "ngx_peer_connection_t", .zig_size = @sizeOf(core.ngx_peer_connection_t) },
    .{ .name = "ngx_event_pipe_t", .zig_size = @sizeOf(core.ngx_event_pipe_t) },
    .{ .name = "ngx_http_file_cache_node_t", .zig_size = @sizeOf(http.ngx_http_file_cache_node_t) },
    .{ .name = "ngx_http_cache_t", .zig_size = @sizeOf(http.ngx_http_cache_t) },
    .{ .name = "ngx_http_listen_opt_t", .zig_size = @sizeOf(http.ngx_http_listen_opt_t) },
    .{ .name = "ngx_http_core_srv_conf_t", .zig_size = @sizeOf(http.ngx_http_core_srv_conf_t) },
    .{ .name = "ngx_http_addr_conf_t", .zig_size = @sizeOf(http.ngx_http_addr_conf_t) },
    .{ .name = "ngx_http_conf_addr_t", .zig_size = @sizeOf(http.ngx_http_conf_addr_t) },
    .{ .name = "ngx_http_core_loc_conf_t", .zig_size = @sizeOf(http.ngx_http_core_loc_conf_t) },
    .{ .name = "ngx_http_headers_in_t", .zig_size = @sizeOf(http.ngx_http_headers_in_t) },
    .{ .name = "ngx_http_request_body_t", .zig_size = @sizeOf(http.ngx_http_request_body_t) },
    .{ .name = "ngx_http_connection_t", .zig_size = @sizeOf(http.ngx_http_connection_t) },
    .{ .name = "ngx_http_header_out_t", .zig_size = @sizeOf(http.ngx_http_header_out_t) },
    .{ .name = "ngx_http_request_t", .zig_size = @sizeOf(http.ngx_http_request_t) },
    .{ .name = "ngx_http_script_engine_t", .zig_size = @sizeOf(http.ngx_http_script_engine_t) },
    .{ .name = "ngx_http_script_compile_t", .zig_size = @sizeOf(http.ngx_http_script_compile_t) },
    .{ .name = "ngx_http_compile_complex_value_t", .zig_size = @sizeOf(http.ngx_http_compile_complex_value_t) },
    .{ .name = "ngx_http_script_regex_code_t", .zig_size = @sizeOf(http.ngx_http_script_regex_code_t) },
    .{ .name = "ngx_http_script_regex_end_code_t", .zig_size = @sizeOf(http.ngx_http_script_regex_end_code_t) },
    .{ .name = "ngx_http_upstream_server_t", .zig_size = @sizeOf(http.ngx_http_upstream_server_t) },
    .{ .name = "ngx_http_upstream_conf_t", .zig_size = @sizeOf(http.ngx_http_upstream_conf_t) },
    .{ .name = "ngx_http_upstream_headers_in_t", .zig_size = @sizeOf(http.ngx_http_upstream_headers_in_t) },
    .{ .name = "ngx_http_upstream_t", .zig_size = @sizeOf(http.ngx_http_upstream_t) },
    .{ .name = "ngx_http_upstream_rr_peer_t", .zig_size = @sizeOf(http.ngx_http_upstream_rr_peer_t) },
    .{ .name = "ngx_http_upstream_rr_peers_t", .zig_size = @sizeOf(http.ngx_http_upstream_rr_peers_t) },
    .{ .name = "ngx_ssl_connection_t", .zig_size = @sizeOf(http.ngx_ssl_connection_t) },
    .{ .name = "ngx_ssl_ticket_key_t", .zig_size = @sizeOf(http.ngx_ssl_ticket_key_t) },
    .{ .name = "ngx_http_module_t", .zig_size = @sizeOf(http.ngx_http_module_t) },
};

const offsetof_table = [_]OffsetEntry{
    .{ .name = "ngx_http_request_t", .field = "connection", .zig_offset = @offsetOf(http.ngx_http_request_t, "connection") },
    .{ .name = "ngx_http_request_t", .field = "cleanup", .zig_offset = @offsetOf(http.ngx_http_request_t, "cleanup") },
    .{ .name = "ngx_http_request_t", .field = "state", .zig_offset = @offsetOf(http.ngx_http_request_t, "state") },
};

fn lookupZigSize(name: []const u8) ?usize {
    for (sizeof_table) |entry| {
        if (std.mem.eql(u8, entry.name, name)) return entry.zig_size;
    }
    return null;
}

fn lookupZigOffset(struct_name: []const u8, field_name: []const u8) ?usize {
    for (offsetof_table) |entry| {
        if (std.mem.eql(u8, entry.name, struct_name) and std.mem.eql(u8, entry.field, field_name)) {
            return entry.zig_offset;
        }
    }
    return null;
}

const print = std.debug.print;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        print("Usage: check_layout <c_output_file>\n", .{});
        std.process.exit(1);
    }

    const file = try std.fs.cwd().openFile(args[1], .{});
    defer file.close();
    const content = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(content);

    var mismatches: u32 = 0;
    var checked: u32 = 0;
    var lines = std.mem.splitSequence(u8, content, "\n");

    print("\n  {s:<40} {s:>6}  {s:>6}  {s}\n", .{ "struct", "C", "Zig", "status" });
    print("  {s:-<40} {s:->6}  {s:->6}  {s:-<10}\n", .{ "", "", "", "" });

    while (lines.next()) |line| {
        if (line.len == 0) continue;

        if (std.mem.startsWith(u8, line, "sizeof ")) {
            const rest = line["sizeof ".len..];
            if (parseSizeofLine(rest)) |entry| {
                if (lookupZigSize(entry.name)) |zig_size| {
                    checked += 1;
                    if (entry.size != zig_size) {
                        const diff: i64 = @as(i64, @intCast(entry.size)) - @as(i64, @intCast(zig_size));
                        const abs_diff = @abs(diff);
                        if (abs_diff % 8 == 0) {
                            print("  {s:<40} {d:>6}  {d:>6}  MISMATCH (diff={d}, {d} spare slot(s))\n", .{ entry.name, entry.size, zig_size, diff, @divExact(abs_diff, 8) });
                        } else {
                            print("  {s:<40} {d:>6}  {d:>6}  MISMATCH (diff={d})\n", .{ entry.name, entry.size, zig_size, diff });
                        }
                        mismatches += 1;
                    } else {
                        print("  {s:<40} {d:>6}  {d:>6}  OK\n", .{ entry.name, entry.size, zig_size });
                    }
                }
            }
        } else if (std.mem.startsWith(u8, line, "offsetof ")) {
            const rest = line["offsetof ".len..];
            if (parseOffsetofLine(rest)) |entry| {
                if (lookupZigOffset(entry.struct_name, entry.field_name)) |zig_offset| {
                    checked += 1;
                    if (entry.offset != zig_offset) {
                        const diff: i64 = @as(i64, @intCast(entry.offset)) - @as(i64, @intCast(zig_offset));
                        print("  {s:<40} {d:>6}  {d:>6}  MISMATCH (diff={d})\n", .{ entry.struct_name, entry.offset, zig_offset, diff });
                        mismatches += 1;
                    } else {
                        print("  {s:<40} {d:>6}  {d:>6}  OK\n", .{ entry.struct_name, entry.offset, zig_offset });
                    }
                }
            }
        }
    }

    print("\n  {d} checked, {d} mismatches\n\n", .{ checked, mismatches });

    if (mismatches > 0) {
        std.process.exit(1);
    }
}

const ParsedSizeof = struct { name: []const u8, size: usize };
const ParsedOffsetof = struct { struct_name: []const u8, field_name: []const u8, offset: usize };

fn parseSizeofLine(line: []const u8) ?ParsedSizeof {
    if (std.mem.lastIndexOfScalar(u8, line, ' ')) |sep| {
        const size = std.fmt.parseInt(usize, line[sep + 1 ..], 10) catch return null;
        return .{ .name = line[0..sep], .size = size };
    }
    return null;
}

fn parseOffsetofLine(line: []const u8) ?ParsedOffsetof {
    const first_sep = std.mem.indexOfScalar(u8, line, ' ') orelse return null;
    const rest = line[first_sep + 1 ..];
    const second_sep = std.mem.lastIndexOfScalar(u8, rest, ' ') orelse return null;
    const offset = std.fmt.parseInt(usize, rest[second_sep + 1 ..], 10) catch return null;
    return .{
        .struct_name = line[0..first_sep],
        .field_name = rest[0..second_sep],
        .offset = offset,
    };
}
