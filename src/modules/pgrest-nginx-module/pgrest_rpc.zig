const std = @import("std");
const ngx = @import("ngx");
const pgrest_query = @import("pgrest_query.zig");

const core = ngx.core;
const http = ngx.http;
const pq = ngx.pq;

const PGresult = pq.PGresult;
const pgNtuples = pq.pgNtuples;
const pgGetvalue = pq.pgGetvalue;

const ngx_str_t = core.ngx_str_t;
const ngx_uint_t = core.ngx_uint_t;

pub const MAX_RPC_PARAMS = 16;

pub const RequestBodyFormat = enum(u8) {
    none,
    json,
    form_urlencoded,
    csv,
    plain_text,
    xml,
    binary,
    unsupported,
};

pub const RpcParam = struct {
    name: []const u8,
    value: []const u8,
    is_null: bool = false,
    is_numeric: bool = false,
    is_boolean: bool = false,
    is_raw: bool = false,
    value_buf: [2048]u8 = std.mem.zeroes([2048]u8),
};

pub const RpcCall = struct {
    function_name: []const u8,
    params: [MAX_RPC_PARAMS]RpcParam,
    param_count: usize,
    prefer_single_object: bool = false,
    raw_body: [4096]u8 = std.mem.zeroes([4096]u8),
    raw_body_len: usize = 0,
};

pub const RpcVolatility = enum(u8) {
    volatile_fn,
    stable,
    immutable,
};

pub const RpcReturnKind = enum(u8) {
    scalar,
    composite_single,
    composite_setof,
};

pub const RpcSingleUnnamedKind = enum(u8) {
    none,
    json,
    text,
    xml,
    bytea,
};

pub const RpcMetadata = struct {
    volatility: RpcVolatility = .volatile_fn,
    return_kind: RpcReturnKind = .scalar,
    single_unnamed_kind: RpcSingleUnnamedKind = .none,
    has_variadic: bool = false,
    variadic_param_name_len: usize = 0,
    variadic_param_name_buf: [128]u8 = std.mem.zeroes([128]u8),
    input_param_names_len: usize = 0,
    input_param_names_buf: [256]u8 = std.mem.zeroes([256]u8),
    found: bool = false,
};

pub fn rpc_variadic_param_name(metadata: *const RpcMetadata) []const u8 {
    return metadata.variadic_param_name_buf[0..metadata.variadic_param_name_len];
}

pub fn rpc_input_param_names(metadata: *const RpcMetadata) []const u8 {
    return metadata.input_param_names_buf[0..metadata.input_param_names_len];
}

pub fn rpc_metadata_has_named_param(metadata: *const RpcMetadata, name: []const u8) bool {
    if (name.len == 0) return false;
    var it = std.mem.splitScalar(u8, rpc_input_param_names(metadata), ',');
    while (it.next()) |part| {
        if (std.mem.eql(u8, part, name)) return true;
    }
    return false;
}

pub fn rpc_single_unnamed_kind_media_matches(kind: RpcSingleUnnamedKind, body_format: RequestBodyFormat) bool {
    return switch (kind) {
        .json => body_format == .json,
        .text => body_format == .plain_text,
        .xml => body_format == .xml,
        .bytea => body_format == .binary,
        .none => false,
    };
}

pub fn rpc_allow_single_unnamed_fallback(body_format: RequestBodyFormat, prefer_single_object: bool) bool {
    if (prefer_single_object) return false;
    return switch (body_format) {
        .json, .plain_text, .xml, .binary => true,
        else => false,
    };
}

pub fn rpc_method_allowed(method: ngx_uint_t, metadata: RpcMetadata) bool {
    return switch (method) {
        http.NGX_HTTP_GET, http.NGX_HTTP_HEAD => metadata.volatility != .volatile_fn,
        http.NGX_HTTP_POST => true,
        else => false,
    };
}

pub fn rpc_allow_header(metadata: RpcMetadata) []const u8 {
    return if (metadata.volatility == .volatile_fn)
        "OPTIONS,POST"
    else
        "OPTIONS,GET,HEAD,POST";
}

pub fn rpc_returns_table_like(metadata: RpcMetadata) bool {
    return metadata.return_kind == .composite_single or metadata.return_kind == .composite_setof;
}

pub fn build_rpc_metadata_query(
    query_buf: []u8,
    schema_name: ?[]const u8,
    function_name: []const u8,
    requested_param_count: usize,
    allow_single_unnamed_fallback: bool,
) usize {
    var pos: usize = 0;
    const prefix =
        "SELECT p.provolatile, p.proretset, (t.typtype = 'c' OR COALESCE(p.proargmodes::text[] && '{t,b,o}', false)) AS rettype_is_composite, p.provariadic > 0 AS has_variadic, COALESCE(meta.unnamed_count, 0), COALESCE(meta.single_unnamed_kind, ''), COALESCE(meta.variadic_param_name, ''), COALESCE(meta.input_param_names, ''), CASE WHEN ";
    @memcpy(query_buf[pos..][0..prefix.len], prefix);
    pos += prefix.len;

    const requested_fit = std.fmt.bufPrint(query_buf[pos..], "{d} BETWEEN GREATEST(p.pronargs - p.pronargdefaults, 0) AND p.pronargs THEN 0 WHEN ", .{requested_param_count}) catch return pos;
    pos += requested_fit.len;

    const fallback_flag = if (allow_single_unnamed_fallback) "TRUE" else "FALSE";
    @memcpy(query_buf[pos..][0..fallback_flag.len], fallback_flag);
    pos += fallback_flag.len;

    const middle_prefix =
        " AND COALESCE(meta.unnamed_count, 0) = 1 AND COALESCE(meta.single_unnamed_kind, '') <> '' THEN 1 WHEN p.pronargs = 0 THEN 2 ELSE 3 END AS match_rank FROM pg_proc p JOIN pg_namespace pn ON pn.oid = p.pronamespace JOIN pg_type t ON t.oid = p.prorettype LEFT JOIN (SELECT p2.oid, COUNT(*) FILTER (WHERE COALESCE(a.name, '') = '') AS unnamed_count, MAX(CASE WHEN COALESCE(a.name, '') = '' THEN CASE format_type(a.type_oid, NULL) WHEN 'json' THEN 'json' WHEN 'jsonb' THEN 'json' WHEN 'text' THEN 'text' WHEN 'xml' THEN 'xml' WHEN 'bytea' THEN 'bytea' ELSE '' END ELSE '' END) AS single_unnamed_kind, MAX(CASE WHEN a.mode = 'v' THEN COALESCE(a.name, '') ELSE '' END) AS variadic_param_name, STRING_AGG(CASE WHEN COALESCE(a.name, '') <> '' THEN COALESCE(a.name, '') ELSE NULL END, ',' ORDER BY a.ord) AS input_param_names FROM pg_proc p2 LEFT JOIN LATERAL (SELECT ord, COALESCE(p2.proargnames[ord], '') AS name, COALESCE(p2.proallargtypes[ord], p2.proargtypes[ord - 1]) AS type_oid, COALESCE(p2.proargmodes[ord], 'i') AS mode FROM generate_series(1, COALESCE(array_length(p2.proallargtypes, 1), array_length(p2.proargnames, 1), p2.pronargs)) ord) a ON TRUE WHERE a.type_oid IS NOT NULL AND a.mode IN ('i','v') GROUP BY p2.oid) meta ON meta.oid = p.oid WHERE p.prokind = 'f' AND pn.nspname = ";
    @memcpy(query_buf[pos..][0..middle_prefix.len], middle_prefix);
    pos += middle_prefix.len;
    pos = pgrest_query.append_sql_quoted(query_buf, pos, schema_name orelse "public");

    const and_name = " AND p.proname = ";
    @memcpy(query_buf[pos..][0..and_name.len], and_name);
    pos += and_name.len;
    pos = pgrest_query.append_sql_quoted(query_buf, pos, function_name);

    const suffix = " ORDER BY match_rank, p.oid LIMIT 1";
    @memcpy(query_buf[pos..][0..suffix.len], suffix);
    pos += suffix.len;
    return pos;
}

fn parse_volatility(value: []const u8) RpcVolatility {
    if (std.mem.eql(u8, value, "i")) return .immutable;
    if (std.mem.eql(u8, value, "s")) return .stable;
    return .volatile_fn;
}

pub fn parse_rpc_metadata_result(result: ?*PGresult) RpcMetadata {
    var metadata = RpcMetadata{};
    if (result == null or pgNtuples(result) == 0) return metadata;

    metadata.found = true;

    const volatility = pgGetvalue(result, 0, 0);
    if (volatility != null) metadata.volatility = parse_volatility(std.mem.span(volatility));

    const proretset = pgGetvalue(result, 0, 1);
    const rettype_is_composite = pgGetvalue(result, 0, 2);
    const has_variadic = pgGetvalue(result, 0, 3);
    const unnamed_count = pgGetvalue(result, 0, 4);
    const single_unnamed_kind = pgGetvalue(result, 0, 5);
    const variadic_name = pgGetvalue(result, 0, 6);
    const input_names = pgGetvalue(result, 0, 7);

    const retset = proretset != null and std.mem.eql(u8, std.mem.span(proretset), "t");
    const composite = rettype_is_composite != null and std.mem.eql(u8, std.mem.span(rettype_is_composite), "t");
    metadata.return_kind = if (composite and retset) .composite_setof else if (composite) .composite_single else .scalar;
    metadata.has_variadic = has_variadic != null and std.mem.eql(u8, std.mem.span(has_variadic), "t");

    if (unnamed_count != null and std.mem.eql(u8, std.mem.span(unnamed_count), "1") and single_unnamed_kind != null) {
        const kind = std.mem.span(single_unnamed_kind);
        metadata.single_unnamed_kind = if (std.mem.eql(u8, kind, "json"))
            .json
        else if (std.mem.eql(u8, kind, "text"))
            .text
        else if (std.mem.eql(u8, kind, "xml"))
            .xml
        else if (std.mem.eql(u8, kind, "bytea"))
            .bytea
        else
            .none;
    }

    if (variadic_name != null) {
        const name = std.mem.span(variadic_name);
        if (name.len <= metadata.variadic_param_name_buf.len) {
            @memcpy(metadata.variadic_param_name_buf[0..name.len], name);
            metadata.variadic_param_name_len = name.len;
        }
    }

    if (input_names != null) {
        const names = std.mem.span(input_names);
        if (names.len <= metadata.input_param_names_buf.len) {
            @memcpy(metadata.input_param_names_buf[0..names.len], names);
            metadata.input_param_names_len = names.len;
        }
    }

    return metadata;
}

pub fn filter_rpc_query_args_by_metadata(args: ngx_str_t, metadata: *const RpcMetadata, include_rpc_args: bool, out: []u8) ngx_str_t {
    if (args.data == core.nullptr(u8) or args.len == 0) return .{ .data = core.nullptr(u8), .len = 0 };
    const query = core.slicify(u8, args.data, args.len);
    var start: usize = 0;
    var pos: usize = 0;

    while (start < query.len) {
        var end = start;
        while (end < query.len and query[end] != '&') : (end += 1) {}
        const pair = query[start..end];
        if (pair.len > 0) {
            const eq = std.mem.indexOfScalar(u8, pair, '=') orelse pair.len;
            const raw_name = pair[0..eq];
            const matches_rpc = rpc_metadata_has_named_param(metadata, raw_name);
            if (matches_rpc == include_rpc_args) {
                if (pos > 0) {
                    out[pos] = '&';
                    pos += 1;
                }
                @memcpy(out[pos..][0..pair.len], pair);
                pos += pair.len;
            }
        }
        if (end == query.len) break;
        start = end + 1;
    }

    return if (pos == 0)
        .{ .data = core.nullptr(u8), .len = 0 }
    else
        .{ .data = out.ptr, .len = pos };
}

fn append_variadic_scalar(buf_out: []u8, pos_in: usize, param: RpcParam) usize {
    if (param.is_null) {
        const null_str = "NULL";
        @memcpy(buf_out[pos_in..][0..null_str.len], null_str);
        return pos_in + null_str.len;
    }
    if (param.is_boolean or param.is_numeric or param.is_raw) {
        @memcpy(buf_out[pos_in..][0..param.value.len], param.value);
        return pos_in + param.value.len;
    }
    return pgrest_query.append_sql_quoted(buf_out, pos_in, param.value);
}

pub fn collapse_rpc_variadic_param(rpc_call: *RpcCall, metadata: *const RpcMetadata) void {
    const variadic_name = rpc_variadic_param_name(metadata);
    if (!metadata.has_variadic or variadic_name.len == 0) return;

    var match_indexes: [MAX_RPC_PARAMS]usize = undefined;
    var match_count: usize = 0;
    for (0..rpc_call.param_count) |i| {
        if (std.mem.eql(u8, rpc_call.params[i].name, variadic_name)) {
            match_indexes[match_count] = i;
            match_count += 1;
        }
    }
    if (match_count <= 1) return;

    const first_index = match_indexes[0];
    var pos: usize = 0;
    const prefix = "ARRAY[";
    @memcpy(rpc_call.params[first_index].value_buf[pos..][0..prefix.len], prefix);
    pos += prefix.len;

    for (match_indexes[0..match_count], 0..) |param_index, arr_i| {
        if (arr_i > 0) {
            rpc_call.params[first_index].value_buf[pos] = ',';
            pos += 1;
        }
        pos = append_variadic_scalar(rpc_call.params[first_index].value_buf[0..], pos, rpc_call.params[param_index]);
    }

    rpc_call.params[first_index].value_buf[pos] = ']';
    pos += 1;
    rpc_call.params[first_index].value = rpc_call.params[first_index].value_buf[0..pos];
    rpc_call.params[first_index].is_null = false;
    rpc_call.params[first_index].is_numeric = false;
    rpc_call.params[first_index].is_boolean = false;
    rpc_call.params[first_index].is_raw = true;
    rpc_call.params[first_index].name = variadic_name;

    var new_count: usize = 0;
    for (0..rpc_call.param_count) |i| {
        var skip = false;
        if (i != first_index) {
            for (match_indexes[1..match_count]) |matched_index| {
                if (i == matched_index) {
                    skip = true;
                    break;
                }
            }
        }
        if (skip) continue;
        if (new_count != i) rpc_call.params[new_count] = rpc_call.params[i];
        new_count += 1;
    }
    rpc_call.param_count = new_count;
}

fn write_ident_quoted(buf_out: []u8, pos_in: usize, ident: []const u8) usize {
    var pos = pos_in;
    buf_out[pos] = '"';
    pos += 1;
    for (ident) |c| {
        if (c == '"') {
            buf_out[pos] = '"';
            pos += 1;
        }
        buf_out[pos] = c;
        pos += 1;
    }
    buf_out[pos] = '"';
    pos += 1;
    return pos;
}

pub fn build_rpc_table_query(
    query_buf: []u8,
    schema_name: ?[]const u8,
    function_name: []const u8,
    rpc_params: *const RpcCall,
    where_clause: []const u8,
    select_clause: []const u8,
    order_specs: []const pgrest_query.OrderSpec,
    pagination: pgrest_query.Pagination,
) usize {
    var pos: usize = 0;
    const select_prefix = "SELECT ";
    @memcpy(query_buf[pos..][0..select_prefix.len], select_prefix);
    pos += select_prefix.len;

    if (select_clause.len > 0) {
        @memcpy(query_buf[pos..][0..select_clause.len], select_clause);
        pos += select_clause.len;
    } else {
        query_buf[pos] = '*';
        pos += 1;
    }

    const from_prefix = " FROM ";
    @memcpy(query_buf[pos..][0..from_prefix.len], from_prefix);
    pos += from_prefix.len;

    if (schema_name) |schema| {
        pos = write_ident_quoted(query_buf, pos, schema);
        query_buf[pos] = '.';
        pos += 1;
    }
    pos = write_ident_quoted(query_buf, pos, function_name);
    query_buf[pos] = '(';
    pos += 1;

    var i: usize = 0;
    while (i < rpc_params.param_count) : (i += 1) {
        if (i > 0) {
            query_buf[pos] = ',';
            pos += 1;
            query_buf[pos] = ' ';
            pos += 1;
        }

        const param = rpc_params.params[i];
        if (param.name.len > 0) {
            @memcpy(query_buf[pos..][0..param.name.len], param.name);
            pos += param.name.len;
            query_buf[pos] = ' ';
            pos += 1;
            query_buf[pos] = '=';
            pos += 1;
            query_buf[pos] = '>';
            pos += 1;
            query_buf[pos] = ' ';
            pos += 1;
        }

        if (param.is_raw) {
            @memcpy(query_buf[pos..][0..param.value.len], param.value);
            pos += param.value.len;
        } else if (param.is_null) {
            const null_str = "NULL";
            @memcpy(query_buf[pos..][0..null_str.len], null_str);
            pos += null_str.len;
        } else if (param.is_boolean or param.is_numeric) {
            @memcpy(query_buf[pos..][0..param.value.len], param.value);
            pos += param.value.len;
        } else {
            pos = pgrest_query.append_sql_quoted(query_buf, pos, param.value);
        }
    }

    query_buf[pos] = ')';
    pos += 1;

    if (where_clause.len > 0) {
        const where_prefix = " WHERE ";
        @memcpy(query_buf[pos..][0..where_prefix.len], where_prefix);
        pos += where_prefix.len;
        @memcpy(query_buf[pos..][0..where_clause.len], where_clause);
        pos += where_clause.len;
    }

    if (order_specs.len > 0) {
        const order_prefix = " ORDER BY ";
        @memcpy(query_buf[pos..][0..order_prefix.len], order_prefix);
        pos += order_prefix.len;
        for (order_specs, 0..) |spec, order_i| {
            if (order_i > 0) {
                query_buf[pos] = ',';
                pos += 1;
            }
            pos = pgrest_query.append_column_expression(query_buf, pos, spec.expr()) orelse return pos;
            if (spec.dir == .desc) {
                const desc_str = " DESC";
                @memcpy(query_buf[pos..][0..desc_str.len], desc_str);
                pos += desc_str.len;
            } else {
                const asc_str = " ASC";
                @memcpy(query_buf[pos..][0..asc_str.len], asc_str);
                pos += asc_str.len;
            }
            switch (spec.nulls) {
                .none => {},
                .first => {
                    const nulls_first = " NULLS FIRST";
                    @memcpy(query_buf[pos..][0..nulls_first.len], nulls_first);
                    pos += nulls_first.len;
                },
                .last => {
                    const nulls_last = " NULLS LAST";
                    @memcpy(query_buf[pos..][0..nulls_last.len], nulls_last);
                    pos += nulls_last.len;
                },
            }
        }
    }

    if (pagination.limit) |limit| {
        const limit_str = std.fmt.bufPrint(query_buf[pos..], " LIMIT {d}", .{limit}) catch return pos;
        pos += limit_str.len;
    }
    if (pagination.offset) |offset| {
        const offset_str = std.fmt.bufPrint(query_buf[pos..], " OFFSET {d}", .{offset}) catch return pos;
        pos += offset_str.len;
    }

    return pos;
}

test "collapse_rpc_variadic_param merges repeated variadic values into ARRAY syntax" {
    var rpc_call: RpcCall = undefined;
    rpc_call.function_name = "plus_one";
    rpc_call.param_count = 3;
    rpc_call.prefer_single_object = false;
    rpc_call.raw_body = std.mem.zeroes([4096]u8);
    rpc_call.raw_body_len = 0;

    rpc_call.params[0] = .{ .name = "v", .value = "1", .is_numeric = true };
    rpc_call.params[1] = .{ .name = "v", .value = "2", .is_numeric = true };
    rpc_call.params[2] = .{ .name = "other", .value = "x" };

    var metadata = RpcMetadata{ .found = true, .has_variadic = true };
    @memcpy(metadata.variadic_param_name_buf[0..1], "v");
    metadata.variadic_param_name_len = 1;

    collapse_rpc_variadic_param(&rpc_call, &metadata);

    try std.testing.expectEqual(@as(usize, 2), rpc_call.param_count);
    try std.testing.expectEqualStrings("v", rpc_call.params[0].name);
    try std.testing.expectEqualStrings("ARRAY[1,2]", rpc_call.params[0].value);
    try std.testing.expect(rpc_call.params[0].is_raw);
    try std.testing.expectEqualStrings("other", rpc_call.params[1].name);
}

test "build_rpc_metadata_query includes requested schema and function" {
    var buf: [4096]u8 = undefined;
    const len = build_rpc_metadata_query(&buf, "api", "best_films_2017", 2, true);
    const sql = buf[0..len];
    try std.testing.expect(std.mem.indexOf(u8, sql, "pn.nspname = 'api'") != null);
    try std.testing.expect(std.mem.indexOf(u8, sql, "p.proname = 'best_films_2017'") != null);
    try std.testing.expect(std.mem.indexOf(u8, sql, "2 BETWEEN") != null);
    try std.testing.expect(std.mem.indexOf(u8, sql, "THEN 1") != null);
}

test "build_rpc_table_query reuses table-style query shaping" {
    var query_buf: [1024]u8 = undefined;
    var rpc_call: RpcCall = undefined;
    rpc_call.function_name = "best_films_2017";
    rpc_call.param_count = 1;
    rpc_call.params[0] = .{ .name = "year", .value = "2017", .is_numeric = true };

    const spec = pgrest_query.parse_order_spec("rating.desc.nullslast") orelse return error.TestUnexpectedResult;
    const len = build_rpc_table_query(
        &query_buf,
        "public",
        "best_films_2017",
        &rpc_call,
        "id > 10",
        "title,rating",
        &.{spec},
        .{ .limit = 5, .offset = 10 },
    );

    try std.testing.expectEqualStrings(
        "SELECT title,rating FROM \"public\".\"best_films_2017\"(year => 2017) WHERE id > 10 ORDER BY rating DESC NULLS LAST LIMIT 5 OFFSET 10",
        query_buf[0..len],
    );
}
