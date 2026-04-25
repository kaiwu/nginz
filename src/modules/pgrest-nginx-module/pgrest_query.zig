const std = @import("std");
const ngx = @import("ngx");

const core = ngx.core;
const http = ngx.http;

const ngx_str_t = core.ngx_str_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_string = ngx.string.ngx_string;

pub const MAX_COLUMNS = 32;
pub const MAX_QUERY_SIZE = 4096;
pub const MAX_SELECT_COLUMNS = 32;
pub const MAX_ORDER_COLUMNS = 8;
pub const MAX_FILTERS = 16;

pub const JsonField = struct {
    name: []const u8,
    value: []const u8,
    is_null: bool,
    is_number: bool,
    is_boolean: bool,
    is_missing: bool,
    name_buf: [256]u8,
    value_buf: [1024]u8,
};

pub const WriteScalar = struct {
    value: []const u8 = "",
    is_null: bool = false,
    is_number: bool = false,
    is_boolean: bool = false,
    use_default: bool = false,
};

pub const PreferResolution = enum(u8) {
    none,
    merge_duplicates,
    ignore_duplicates,
};

pub const SqlOp = enum {
    select,
    insert,
    update,
    delete,

    pub fn fromMethod(method: ngx_uint_t) ?SqlOp {
        return switch (method) {
            http.NGX_HTTP_GET => .select,
            http.NGX_HTTP_HEAD => .select,
            http.NGX_HTTP_POST => .insert,
            http.NGX_HTTP_PATCH => .update,
            http.NGX_HTTP_PUT => .update,
            http.NGX_HTTP_DELETE => .delete,
            else => null,
        };
    }

    pub fn keyword(self: SqlOp) []const u8 {
        return switch (self) {
            .select => "SELECT",
            .insert => "INSERT",
            .update => "UPDATE",
            .delete => "DELETE",
        };
    }
};

pub const OrderDir = enum {
    asc,
    desc,
};

pub const OrderNulls = enum {
    none,
    first,
    last,
};

pub const OrderSpec = struct {
    expr_buf: [512]u8,
    expr_len: usize,
    dir: OrderDir,
    nulls: OrderNulls,

    pub fn expr(self: *const OrderSpec) []const u8 {
        return self.expr_buf[0..self.expr_len];
    }
};

pub const OrderParseResult = struct {
    count: usize,
    invalid: bool,
};

pub const Pagination = struct {
    limit: ?usize,
    offset: ?usize,
};

pub const FilterOp = enum {
    eq,
    neq,
    gt,
    gte,
    lt,
    lte,
    like,
    ilike,
    match,
    imatch,
    is_,
    isdistinct,
    fts,
    plfts,
    phfts,
    wfts,
    in_,
    cs,
    cd,
    ov,
    sl,
    sr,
    nxr,
    nxl,
    adj,

    pub fn toSql(self: FilterOp) []const u8 {
        return switch (self) {
            .eq => "=",
            .neq => "<>",
            .gt => ">",
            .gte => ">=",
            .lt => "<",
            .lte => "<=",
            .like => "LIKE",
            .ilike => "ILIKE",
            .match => "~",
            .imatch => "~*",
            .is_ => "IS",
            .isdistinct => "IS DISTINCT FROM",
            .fts, .plfts, .phfts, .wfts => "@@",
            .in_ => "IN",
            .cs => "@>",
            .cd => "<@",
            .ov => "&&",
            .sl => "<<",
            .sr => ">>",
            .nxr => "&<",
            .nxl => "&>",
            .adj => "-|-",
        };
    }

    pub fn fromString(s: []const u8) ?FilterOp {
        if (std.mem.eql(u8, s, "eq")) return .eq;
        if (std.mem.eql(u8, s, "neq")) return .neq;
        if (std.mem.eql(u8, s, "gt")) return .gt;
        if (std.mem.eql(u8, s, "gte")) return .gte;
        if (std.mem.eql(u8, s, "lt")) return .lt;
        if (std.mem.eql(u8, s, "lte")) return .lte;
        if (std.mem.eql(u8, s, "like")) return .like;
        if (std.mem.eql(u8, s, "ilike")) return .ilike;
        if (std.mem.eql(u8, s, "match")) return .match;
        if (std.mem.eql(u8, s, "imatch")) return .imatch;
        if (std.mem.eql(u8, s, "is")) return .is_;
        if (std.mem.eql(u8, s, "isdistinct")) return .isdistinct;
        if (std.mem.eql(u8, s, "fts")) return .fts;
        if (std.mem.eql(u8, s, "plfts")) return .plfts;
        if (std.mem.eql(u8, s, "phfts")) return .phfts;
        if (std.mem.eql(u8, s, "wfts")) return .wfts;
        if (std.mem.eql(u8, s, "in")) return .in_;
        if (std.mem.eql(u8, s, "cs")) return .cs;
        if (std.mem.eql(u8, s, "cd")) return .cd;
        if (std.mem.eql(u8, s, "ov")) return .ov;
        if (std.mem.eql(u8, s, "sl")) return .sl;
        if (std.mem.eql(u8, s, "sr")) return .sr;
        if (std.mem.eql(u8, s, "nxr")) return .nxr;
        if (std.mem.eql(u8, s, "nxl")) return .nxl;
        if (std.mem.eql(u8, s, "adj")) return .adj;
        return null;
    }
};

pub const Filter = struct {
    column: []const u8,
    op: FilterOp,
    value: []const u8,
};

pub const WhereClauseResult = struct {
    len: usize,
    invalid: bool,
};

const SelectItemRenderResult = struct {
    select_len: usize,
    group_len: usize,
    aggregate: bool,
};

const AggregateFn = enum {
    sum,
    avg,
    min,
    max,
    count,

    fn sqlName(self: AggregateFn) []const u8 {
        return switch (self) {
            .sum => "sum",
            .avg => "avg",
            .min => "min",
            .max => "max",
            .count => "count",
        };
    }
};

pub fn trim_ascii_spaces(value: []const u8) []const u8 {
    var start: usize = 0;
    var end: usize = value.len;
    while (start < end and std.ascii.isWhitespace(value[start])) : (start += 1) {}
    while (end > start and std.ascii.isWhitespace(value[end - 1])) : (end -= 1) {}
    return value[start..end];
}

pub fn append_sql_quoted(buf_out: []u8, pos_in: usize, value: []const u8) usize {
    var pos = pos_in;
    buf_out[pos] = '\'';
    pos += 1;
    for (value) |c| {
        if (c == '\'') {
            buf_out[pos] = '\'';
            pos += 1;
        }
        buf_out[pos] = c;
        pos += 1;
    }
    buf_out[pos] = '\'';
    pos += 1;
    return pos;
}

pub fn is_valid_schema_identifier(value: []const u8) bool {
    if (value.len == 0) return false;
    for (value, 0..) |c, i| {
        if (!(std.ascii.isAlphanumeric(c) or c == '_')) return false;
        if (i == 0 and std.ascii.isDigit(c)) return false;
    }
    return true;
}

pub fn build_qualified_table_name(buffer: []u8, schema: ?[]const u8, table: []const u8) usize {
    var pos: usize = 0;
    if (schema) |s| {
        if (s.len > 0) {
            @memcpy(buffer[pos..][0..s.len], s);
            pos += s.len;
            buffer[pos] = '.';
            pos += 1;
        }
    }
    @memcpy(buffer[pos..][0..table.len], table);
    pos += table.len;
    return pos;
}

pub fn is_numeric(value: []const u8) bool {
    if (value.len == 0) return false;
    var i: usize = 0;
    if (value[0] == '-') i = 1;
    if (i >= value.len) return false;
    var has_digit = false;
    var has_dot = false;
    while (i < value.len) : (i += 1) {
        const c = value[i];
        if (c >= '0' and c <= '9') {
            has_digit = true;
        } else if (c == '.' and !has_dot) {
            has_dot = true;
        } else {
            return false;
        }
    }
    return has_digit;
}

pub fn decode_query_component_into(dest: []u8, src: []const u8) ?[]const u8 {
    var pos: usize = 0;
    var i: usize = 0;
    while (i < src.len) : (i += 1) {
        if (pos >= dest.len) return null;
        if (src[i] == '%') {
            if (i + 2 >= src.len) return null;
            const hi = std.fmt.charToDigit(src[i + 1], 16) catch return null;
            const lo = std.fmt.charToDigit(src[i + 2], 16) catch return null;
            dest[pos] = @as(u8, @intCast(hi * 16 + lo));
            pos += 1;
            i += 2;
        } else {
            dest[pos] = src[i];
            pos += 1;
        }
    }
    return dest[0..pos];
}

fn unescape_wrapped_quotes_into(dest: []u8, value: []const u8) ?[]const u8 {
    const inner = if (value.len >= 2 and value[0] == '"' and value[value.len - 1] == '"') value[1 .. value.len - 1] else value;
    var pos: usize = 0;
    var i: usize = 0;
    while (i < inner.len) : (i += 1) {
        if (pos >= dest.len) return null;
        if (inner[i] == '\\' and i + 1 < inner.len) i += 1;
        dest[pos] = inner[i];
        pos += 1;
    }
    return dest[0..pos];
}

fn is_simple_identifier(value: []const u8) bool {
    if (value.len == 0) return false;
    for (value) |c| {
        if (!(std.ascii.isAlphanumeric(c) or c == '_')) return false;
    }
    return true;
}

fn append_sql_identifier(buf_out: []u8, pos_in: usize, raw_value: []const u8) usize {
    var scratch: [512]u8 = undefined;
    const value = unescape_wrapped_quotes_into(&scratch, raw_value) orelse raw_value;
    if (is_simple_identifier(value)) {
        @memcpy(buf_out[pos_in..][0..value.len], value);
        return pos_in + value.len;
    }
    var pos = pos_in;
    buf_out[pos] = '"';
    pos += 1;
    for (value) |c| {
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

fn append_castable_expression(buf_out: []u8, pos_in: usize, raw_expr: []const u8) ?usize {
    var expr = trim_ascii_spaces(raw_expr);
    if (expr.len == 0) return null;

    var cast: ?[]const u8 = null;
    if (std.mem.lastIndexOf(u8, expr, "::")) |cast_idx| {
        cast = trim_ascii_spaces(expr[cast_idx + 2 ..]);
        expr = trim_ascii_spaces(expr[0..cast_idx]);
        if (cast.?.len == 0 or expr.len == 0) return null;
    }

    var pos = append_column_expression(buf_out, pos_in, expr) orelse return null;
    if (cast) |cast_name| {
        const cast_sep = "::";
        @memcpy(buf_out[pos..][0..cast_sep.len], cast_sep);
        pos += cast_sep.len;
        pos = append_sql_identifier(buf_out, pos, cast_name);
    }
    return pos;
}

fn parse_aggregate_expression(expr_in: []const u8) ?struct {
    base_expr: []const u8,
    aggregate_fn: AggregateFn,
    output_cast: ?[]const u8,
} {
    const expr = trim_ascii_spaces(expr_in);
    if (std.mem.eql(u8, expr, "count()")) {
        return .{ .base_expr = "", .aggregate_fn = .count, .output_cast = null };
    }

    const candidates = [_]struct { suffix: []const u8, func: AggregateFn }{
        .{ .suffix = ".sum()", .func = .sum },
        .{ .suffix = ".avg()", .func = .avg },
        .{ .suffix = ".min()", .func = .min },
        .{ .suffix = ".max()", .func = .max },
        .{ .suffix = ".count()", .func = .count },
    };

    for (candidates) |candidate| {
        if (std.mem.lastIndexOf(u8, expr, candidate.suffix)) |idx| {
            const tail = expr[idx + candidate.suffix.len ..];
            var output_cast: ?[]const u8 = null;
            if (tail.len == 0) {
                // ok
            } else if (std.mem.startsWith(u8, tail, "::")) {
                const cast_name = trim_ascii_spaces(tail[2..]);
                if (cast_name.len == 0) return null;
                output_cast = cast_name;
            } else {
                continue;
            }

            const base_expr = trim_ascii_spaces(expr[0..idx]);
            if (base_expr.len == 0 and candidate.func != .count) return null;
            return .{ .base_expr = base_expr, .aggregate_fn = candidate.func, .output_cast = output_cast };
        }
    }
    return null;
}

pub fn append_column_expression(buf_out: []u8, pos_in: usize, raw_value: []const u8) ?usize {
    const arrow_idx = std.mem.indexOf(u8, raw_value, "->") orelse return append_sql_identifier(buf_out, pos_in, raw_value);
    var pos = pos_in;
    const base = raw_value[0..arrow_idx];
    const prefix = "to_jsonb(";
    @memcpy(buf_out[pos..][0..prefix.len], prefix);
    pos += prefix.len;
    pos = append_sql_identifier(buf_out, pos, base);
    buf_out[pos] = ')';
    pos += 1;

    var rest = raw_value[arrow_idx..];
    var scratch: [256]u8 = undefined;
    while (rest.len > 0) {
        const is_text = std.mem.startsWith(u8, rest, "->>");
        const op = if (is_text) "->>" else if (std.mem.startsWith(u8, rest, "->")) "->" else return null;
        @memcpy(buf_out[pos..][0..op.len], op);
        pos += op.len;
        rest = rest[op.len..];

        const next_idx = std.mem.indexOf(u8, rest, "->") orelse rest.len;
        const segment_raw = rest[0..next_idx];
        if (segment_raw.len == 0) return null;
        const segment = unescape_wrapped_quotes_into(&scratch, segment_raw) orelse return null;
        if (is_numeric(segment)) {
            @memcpy(buf_out[pos..][0..segment.len], segment);
            pos += segment.len;
        } else {
            pos = append_sql_quoted(buf_out, pos, segment);
        }
        rest = rest[next_idx..];
    }
    return pos;
}

fn find_last_top_level_separator(value: []const u8, needle: u8) ?usize {
    var depth: usize = 0;
    var in_quotes = false;
    var escaped = false;
    var last: ?usize = null;
    for (value, 0..) |c, i| {
        if (in_quotes) {
            if (escaped) {
                escaped = false;
                continue;
            }
            if (c == '\\') {
                escaped = true;
                continue;
            }
            if (c == '"') in_quotes = false;
            continue;
        }
        switch (c) {
            '"' => in_quotes = true,
            '(' => depth += 1,
            ')' => {
                if (depth > 0) depth -= 1;
            },
            else => {},
        }
        if (depth == 0 and c == needle) last = i;
    }
    return last;
}

pub fn parse_order_spec(raw_spec: []const u8) ?OrderSpec {
    if (raw_spec.len == 0) return null;
    var decoded_buf: [512]u8 = undefined;
    const spec = decode_query_component_into(&decoded_buf, trim_ascii_spaces(raw_spec)) orelse return null;
    if (spec.len == 0) return null;

    var expr_end = spec.len;
    var order = OrderSpec{ .expr_buf = undefined, .expr_len = 0, .dir = .asc, .nulls = .none };
    var saw_dir = false;
    while (find_last_top_level_separator(spec[0..expr_end], '.')) |dot| {
        const part = trim_ascii_spaces(spec[dot + 1 .. expr_end]);
        if (part.len == 0) return null;
        if (std.mem.eql(u8, part, "asc")) {
            if (saw_dir) return null;
            saw_dir = true;
            expr_end = dot;
            continue;
        }
        if (std.mem.eql(u8, part, "desc")) {
            if (saw_dir) return null;
            saw_dir = true;
            order.dir = .desc;
            expr_end = dot;
            continue;
        }
        if (std.mem.eql(u8, part, "nullsfirst")) {
            if (order.nulls != .none) return null;
            order.nulls = .first;
            expr_end = dot;
            continue;
        }
        if (std.mem.eql(u8, part, "nullslast")) {
            if (order.nulls != .none) return null;
            order.nulls = .last;
            expr_end = dot;
            continue;
        }
        return null;
    }

    const expr = trim_ascii_spaces(spec[0..expr_end]);
    if (expr.len == 0 or expr.len > order.expr_buf.len) return null;
    @memcpy(order.expr_buf[0..expr.len], expr);
    order.expr_len = expr.len;
    var expr_sql_buf: [1024]u8 = undefined;
    _ = append_column_expression(&expr_sql_buf, 0, order.expr()) orelse return null;
    return order;
}

pub fn parse_order(args: ngx_str_t, orders: *[MAX_ORDER_COLUMNS]OrderSpec) OrderParseResult {
    if (args.len == 0 or args.data == core.nullptr(u8)) return .{ .count = 0, .invalid = false };
    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;
    while (pos < query.len) {
        if (pos + 6 <= query.len and std.mem.eql(u8, query[pos .. pos + 6], "order=")) {
            pos += 6;
            var count: usize = 0;
            var col_start = pos;
            while (pos <= query.len and count < MAX_ORDER_COLUMNS) {
                if (pos == query.len or query[pos] == '&' or query[pos] == ',') {
                    if (pos > col_start) {
                        orders[count] = parse_order_spec(query[col_start..pos]) orelse return .{ .count = 0, .invalid = true };
                        count += 1;
                    } else {
                        return .{ .count = 0, .invalid = true };
                    }
                    if (pos == query.len or query[pos] == '&') return .{ .count = count, .invalid = false };
                    col_start = pos + 1;
                }
                pos += 1;
            }
            return .{ .count = count, .invalid = false };
        }
        while (pos < query.len and query[pos] != '&') : (pos += 1) {}
        pos += 1;
    }
    return .{ .count = 0, .invalid = false };
}

pub fn parse_pagination(args: ngx_str_t) Pagination {
    var result = Pagination{ .limit = null, .offset = null };
    if (args.len == 0 or args.data == core.nullptr(u8)) return result;
    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;
    while (pos < query.len) {
        if (pos + 6 <= query.len and std.mem.eql(u8, query[pos .. pos + 6], "limit=")) {
            pos += 6;
            var num: usize = 0;
            while (pos < query.len and query[pos] >= '0' and query[pos] <= '9') {
                num = num * 10 + (query[pos] - '0');
                pos += 1;
            }
            result.limit = num;
        } else if (pos + 7 <= query.len and std.mem.eql(u8, query[pos .. pos + 7], "offset=")) {
            pos += 7;
            var num: usize = 0;
            while (pos < query.len and query[pos] >= '0' and query[pos] <= '9') {
                num = num * 10 + (query[pos] - '0');
                pos += 1;
            }
            result.offset = num;
        } else {
            while (pos < query.len and query[pos] != '&') : (pos += 1) {}
            pos += 1;
        }
    }
    return result;
}

pub fn parse_columns_param(args: ngx_str_t, columns: *[MAX_COLUMNS][]const u8) ?usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) return 0;
    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;
    while (pos < query.len) {
        if (pos + 8 <= query.len and std.mem.eql(u8, query[pos .. pos + 8], "columns=")) {
            pos += 8;
            var count: usize = 0;
            var col_start = pos;
            while (pos <= query.len and count < MAX_COLUMNS) {
                if (pos == query.len or query[pos] == '&' or query[pos] == ',') {
                    if (pos <= col_start) return null;
                    var decoded_buf: [256]u8 = undefined;
                    const decoded = decode_query_component_into(&decoded_buf, query[col_start..pos]) orelse return null;
                    const name = trim_ascii_spaces(decoded);
                    if (name.len == 0 or !is_valid_schema_identifier(name)) return null;
                    columns[count] = query[col_start..pos];
                    count += 1;
                    if (pos == query.len or query[pos] == '&') return count;
                    col_start = pos + 1;
                }
                pos += 1;
            }
            if (count == MAX_COLUMNS and pos < query.len and query[pos] != '&') return null;
            return count;
        }
        while (pos < query.len and query[pos] != '&') : (pos += 1) {}
        pos += 1;
    }
    return 0;
}

pub fn parse_on_conflict_param(args: ngx_str_t, columns: *[MAX_COLUMNS][]const u8) ?usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) return 0;
    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;
    while (pos < query.len) {
        if (pos + 12 <= query.len and std.mem.eql(u8, query[pos .. pos + 12], "on_conflict=")) {
            pos += 12;
            var count: usize = 0;
            var col_start = pos;
            while (pos <= query.len and count < MAX_COLUMNS) {
                if (pos == query.len or query[pos] == '&' or query[pos] == ',') {
                    if (pos <= col_start) return null;
                    var decoded_buf: [256]u8 = undefined;
                    const decoded = decode_query_component_into(&decoded_buf, query[col_start..pos]) orelse return null;
                    const name = trim_ascii_spaces(decoded);
                    if (name.len == 0 or !is_valid_schema_identifier(name)) return null;
                    columns[count] = query[col_start..pos];
                    count += 1;
                    if (pos == query.len or query[pos] == '&') return count;
                    col_start = pos + 1;
                }
                pos += 1;
            }
            if (count == MAX_COLUMNS and pos < query.len and query[pos] != '&') return null;
            return count;
        }
        while (pos < query.len and query[pos] != '&') : (pos += 1) {}
        pos += 1;
    }
    return 0;
}

pub fn parse_filters(args: ngx_str_t, filters: *[MAX_FILTERS]Filter) usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) return 0;
    const query = core.slicify(u8, args.data, args.len);
    var count: usize = 0;
    var pos: usize = 0;
    while (pos < query.len and count < MAX_FILTERS) {
        var param_end = pos;
        while (param_end < query.len and query[param_end] != '&') param_end += 1;
        if (parse_single_filter(query[pos..param_end])) |filter| {
            filters[count] = filter;
            count += 1;
        }
        pos = param_end + 1;
    }
    return count;
}

fn parse_single_filter(param: []const u8) ?Filter {
    var eq_pos: usize = 0;
    while (eq_pos < param.len and param[eq_pos] != '=') eq_pos += 1;
    if (eq_pos == 0 or eq_pos >= param.len - 1) return null;
    const column = param[0..eq_pos];
    const rest = param[eq_pos + 1 ..];
    var dot_pos: usize = 0;
    while (dot_pos < rest.len and rest[dot_pos] != '.') dot_pos += 1;
    if (dot_pos == 0 or dot_pos >= rest.len) return null;
    const op = FilterOp.fromString(rest[0..dot_pos]) orelse return null;
    return .{ .column = column, .op = op, .value = rest[dot_pos + 1 ..] };
}

fn append_filter_value(buf_out: []u8, pos_in: usize, filter: Filter) usize {
    var pos = pos_in;
    switch (filter.op) {
        .is_ => {
            if (std.ascii.eqlIgnoreCase(filter.value, "null")) {
                const s = "NULL";
                @memcpy(buf_out[pos..][0..s.len], s);
                return pos + s.len;
            }
            if (std.ascii.eqlIgnoreCase(filter.value, "true")) {
                const s = "TRUE";
                @memcpy(buf_out[pos..][0..s.len], s);
                return pos + s.len;
            }
            if (std.ascii.eqlIgnoreCase(filter.value, "false")) {
                const s = "FALSE";
                @memcpy(buf_out[pos..][0..s.len], s);
                return pos + s.len;
            }
            return append_sql_quoted(buf_out, pos, filter.value);
        },
        .in_ => {
            if (filter.value.len >= 2 and filter.value[0] == '(' and filter.value[filter.value.len - 1] == ')') {
                buf_out[pos] = '(';
                pos += 1;
                const inner = filter.value[1 .. filter.value.len - 1];
                var item_start: usize = 0;
                var first = true;
                var i: usize = 0;
                while (i <= inner.len) : (i += 1) {
                    if (i == inner.len or inner[i] == ',') {
                        const item = inner[item_start..i];
                        if (!first) {
                            buf_out[pos] = ',';
                            pos += 1;
                        }
                        first = false;
                        if (std.ascii.eqlIgnoreCase(item, "null")) {
                            const s = "NULL";
                            @memcpy(buf_out[pos..][0..s.len], s);
                            pos += s.len;
                        } else if (std.ascii.eqlIgnoreCase(item, "true") or std.ascii.eqlIgnoreCase(item, "false") or is_numeric(item)) {
                            @memcpy(buf_out[pos..][0..item.len], item);
                            pos += item.len;
                        } else {
                            pos = append_sql_quoted(buf_out, pos, item);
                        }
                        item_start = i + 1;
                    }
                }
                buf_out[pos] = ')';
                pos += 1;
                return pos;
            }
            return append_sql_quoted(buf_out, pos, filter.value);
        },
        else => return append_sql_quoted(buf_out, pos, filter.value),
    }
}

pub fn build_where_clause_from_filters(buf_out: []u8, filters: []const Filter) usize {
    var pos: usize = 0;
    for (filters, 0..) |filter, i| {
        if (i > 0) {
            const and_str = " AND ";
            @memcpy(buf_out[pos..][0..and_str.len], and_str);
            pos += and_str.len;
        }
        @memcpy(buf_out[pos..][0..filter.column.len], filter.column);
        pos += filter.column.len;
        buf_out[pos] = ' ';
        pos += 1;
        const op_sql = filter.op.toSql();
        @memcpy(buf_out[pos..][0..op_sql.len], op_sql);
        pos += op_sql.len;
        buf_out[pos] = ' ';
        pos += 1;
        pos = append_filter_value(buf_out, pos, filter);
    }
    return pos;
}

fn find_top_level_dot(value: []const u8) ?usize {
    var depth: usize = 0;
    var in_quotes = false;
    var escaped = false;
    for (value, 0..) |c, i| {
        if (in_quotes) {
            if (escaped) {
                escaped = false;
                continue;
            }
            if (c == '\\') {
                escaped = true;
                continue;
            }
            if (c == '"') in_quotes = false;
            continue;
        }
        switch (c) {
            '"' => in_quotes = true,
            '(' => depth += 1,
            ')' => {
                if (depth > 0) depth -= 1;
            },
            '.' => if (depth == 0) return i,
            else => {},
        }
    }
    return null;
}

fn is_reserved_query_param(name: []const u8) bool {
    return std.mem.eql(u8, name, "select") or
        std.mem.eql(u8, name, "order") or
        std.mem.eql(u8, name, "columns") or
        std.mem.eql(u8, name, "on_conflict") or
        std.mem.eql(u8, name, "limit") or
        std.mem.eql(u8, name, "offset");
}

fn find_top_level_select_separator(value: []const u8, needle: u8) ?usize {
    var depth: usize = 0;
    var in_quotes = false;
    var escaped = false;
    for (value, 0..) |c, i| {
        if (in_quotes) {
            if (escaped) {
                escaped = false;
                continue;
            }
            if (c == '\\') {
                escaped = true;
                continue;
            }
            if (c == '"') in_quotes = false;
            continue;
        }
        switch (c) {
            '"' => in_quotes = true,
            '(' => depth += 1,
            ')' => {
                if (depth > 0) depth -= 1;
            },
            else => {},
        }
        if (depth == 0 and c == needle) return i;
    }
    return null;
}

fn find_top_level_alias_separator(value: []const u8) ?usize {
    var depth: usize = 0;
    var in_quotes = false;
    var escaped = false;
    for (value, 0..) |c, i| {
        if (in_quotes) {
            if (escaped) {
                escaped = false;
                continue;
            }
            if (c == '\\') {
                escaped = true;
                continue;
            }
            if (c == '"') in_quotes = false;
            continue;
        }
        switch (c) {
            '"' => in_quotes = true,
            '(' => depth += 1,
            ')' => {
                if (depth > 0) depth -= 1;
            },
            ':' => {
                const prev_is_colon = i > 0 and value[i - 1] == ':';
                const next_is_colon = i + 1 < value.len and value[i + 1] == ':';
                if (depth == 0 and !prev_is_colon and !next_is_colon) return i;
            },
            else => {},
        }
    }
    return null;
}

fn parse_select_items(args: ngx_str_t, columns: *[MAX_SELECT_COLUMNS][]const u8) usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) return 0;
    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;
    while (pos < query.len) {
        if (pos + 7 <= query.len and std.mem.eql(u8, query[pos .. pos + 7], "select=")) {
            pos += 7;
            var count: usize = 0;
            var item_start = pos;
            var depth: usize = 0;
            var in_quotes = false;
            var escaped = false;
            while (pos <= query.len and count < MAX_SELECT_COLUMNS) {
                const at_end = pos == query.len;
                if (!at_end) {
                    const c = query[pos];
                    if (in_quotes) {
                        if (escaped) {
                            escaped = false;
                        } else if (c == '\\') {
                            escaped = true;
                        } else if (c == '"') {
                            in_quotes = false;
                        }
                        pos += 1;
                        continue;
                    }
                    switch (c) {
                        '"' => {
                            in_quotes = true;
                            pos += 1;
                            continue;
                        },
                        '(' => depth += 1,
                        ')' => {
                            if (depth > 0) depth -= 1;
                        },
                        ',' => if (depth == 0) {},
                        '&' => if (depth == 0) {},
                        else => {
                            pos += 1;
                            continue;
                        },
                    }
                    if (c != ',' and c != '&') {
                        pos += 1;
                        continue;
                    }
                }
                if (pos > item_start) {
                    columns[count] = query[item_start..pos];
                    count += 1;
                }
                if (at_end or query[pos] == '&') return count;
                item_start = pos + 1;
                pos += 1;
            }
            return count;
        }
        while (pos < query.len and query[pos] != '&') : (pos += 1) {}
        pos += 1;
    }
    return 0;
}

fn render_select_item(select_out: []u8, raw_item: []const u8, group_out: []u8) ?SelectItemRenderResult {
    const trimmed_item = trim_ascii_spaces(raw_item);
    var decoded_buf: [512]u8 = undefined;
    const item = decode_query_component_into(&decoded_buf, trimmed_item) orelse return null;
    if (item.len == 0) return null;
    if (std.mem.eql(u8, item, "*")) {
        select_out[0] = '*';
        return .{ .select_len = 1, .group_len = 0, .aggregate = false };
    }

    var alias: ?[]const u8 = null;
    var expr = item;
    if (find_top_level_alias_separator(item)) |colon| {
        alias = trim_ascii_spaces(item[0..colon]);
        expr = trim_ascii_spaces(item[colon + 1 ..]);
        if (alias.?.len == 0 or expr.len == 0) return null;
    }

    if (parse_aggregate_expression(expr)) |aggregate| {
        var pos: usize = 0;
        const fn_name = aggregate.aggregate_fn.sqlName();
        @memcpy(select_out[pos..][0..fn_name.len], fn_name);
        pos += fn_name.len;
        select_out[pos] = '(';
        pos += 1;
        if (aggregate.aggregate_fn == .count and aggregate.base_expr.len == 0) {
            select_out[pos] = '*';
            pos += 1;
        } else {
            pos = append_castable_expression(select_out, pos, aggregate.base_expr) orelse return null;
        }
        select_out[pos] = ')';
        pos += 1;
        if (aggregate.output_cast) |cast_name| {
            const cast_sep = "::";
            @memcpy(select_out[pos..][0..cast_sep.len], cast_sep);
            pos += cast_sep.len;
            pos = append_sql_identifier(select_out, pos, cast_name);
        }

        if (alias) |alias_name| {
            const as_sep = " AS ";
            @memcpy(select_out[pos..][0..as_sep.len], as_sep);
            pos += as_sep.len;
            pos = append_sql_identifier(select_out, pos, alias_name);
        } else {
            const as_sep = " AS ";
            @memcpy(select_out[pos..][0..as_sep.len], as_sep);
            pos += as_sep.len;
            pos = append_sql_identifier(select_out, pos, fn_name);
        }

        return .{ .select_len = pos, .group_len = 0, .aggregate = true };
    }

    var pos: usize = 0;
    const group_len = append_castable_expression(group_out, 0, expr) orelse return null;
    pos = append_castable_expression(select_out, 0, expr) orelse return null;

    if (alias) |alias_name| {
        const as_sep = " AS ";
        @memcpy(select_out[pos..][0..as_sep.len], as_sep);
        pos += as_sep.len;
        pos = append_sql_identifier(select_out, pos, alias_name);
    } else if (std.mem.indexOf(u8, expr, "->") != null) {
        var tail = expr;
        var last_segment = expr;
        while (std.mem.indexOf(u8, tail, "->")) |idx| {
            tail = tail[idx + 2 ..];
            if (tail.len > 0 and tail[0] == '>') tail = tail[1..];
            last_segment = tail;
        }
        if (find_top_level_select_separator(last_segment, ':')) |_| return null;
        var scratch: [256]u8 = undefined;
        const alias_name = unescape_wrapped_quotes_into(&scratch, last_segment) orelse return null;
        if (alias_name.len == 0) return null;
        const as_sep = " AS ";
        @memcpy(select_out[pos..][0..as_sep.len], as_sep);
        pos += as_sep.len;
        pos = append_sql_identifier(select_out, pos, alias_name);
    }
    return .{ .select_len = pos, .group_len = group_len, .aggregate = false };
}

pub fn build_select_clause_from_args(buf_out: []u8, args: ngx_str_t) WhereClauseResult {
    var items: [MAX_SELECT_COLUMNS][]const u8 = undefined;
    const count = parse_select_items(args, &items);
    if (count == 0) return .{ .len = 0, .invalid = false };
    var pos: usize = 0;
    var scratch: [1024]u8 = undefined;
    for (items[0..count], 0..) |item, i| {
        if (i > 0) {
            buf_out[pos] = ',';
            pos += 1;
        }
        const rendered = render_select_item(buf_out[pos..], item, &scratch) orelse return .{ .len = 0, .invalid = true };
        pos += rendered.select_len;
    }
    return .{ .len = pos, .invalid = false };
}

pub fn build_group_by_clause_from_args(buf_out: []u8, args: ngx_str_t) WhereClauseResult {
    var items: [MAX_SELECT_COLUMNS][]const u8 = undefined;
    const count = parse_select_items(args, &items);
    if (count == 0) return .{ .len = 0, .invalid = false };
    var pos: usize = 0;
    var saw_aggregate = false;
    var group_count: usize = 0;
    var select_scratch: [1024]u8 = undefined;
    var group_scratch: [1024]u8 = undefined;

    for (items[0..count]) |item| {
        const rendered = render_select_item(&select_scratch, item, &group_scratch) orelse return .{ .len = 0, .invalid = true };
        if (rendered.aggregate) {
            saw_aggregate = true;
            continue;
        }
        if (group_count > 0) {
            buf_out[pos] = ',';
            pos += 1;
        }
        @memcpy(buf_out[pos..][0..rendered.group_len], group_scratch[0..rendered.group_len]);
        pos += rendered.group_len;
        group_count += 1;
    }

    return .{ .len = if (saw_aggregate) pos else 0, .invalid = false };
}

fn append_list_items_sql(buf_out: []u8, pos_in: usize, raw_value: []const u8, array_mode: bool, wildcard_mode: bool) ?usize {
    if (raw_value.len < 2) return null;
    const open = raw_value[0];
    const close = raw_value[raw_value.len - 1];
    if (!((open == '{' and close == '}') or (open == '(' and close == ')'))) return null;
    var pos = pos_in;
    if (array_mode) {
        const prefix = "ARRAY[";
        @memcpy(buf_out[pos..][0..prefix.len], prefix);
        pos += prefix.len;
    } else {
        buf_out[pos] = '(';
        pos += 1;
    }

    const inner = raw_value[1 .. raw_value.len - 1];
    var item_start: usize = 0;
    var first = true;
    var depth: usize = 0;
    var in_quotes = false;
    var escaped = false;
    var scratch: [512]u8 = undefined;
    var i: usize = 0;
    while (i <= inner.len) : (i += 1) {
        const at_end = i == inner.len;
        if (!at_end) {
            const c = inner[i];
            if (in_quotes) {
                if (escaped) {
                    escaped = false;
                } else if (c == '\\') {
                    escaped = true;
                } else if (c == '"') {
                    in_quotes = false;
                }
                continue;
            }
            switch (c) {
                '"' => {
                    in_quotes = true;
                    continue;
                },
                '(' => depth += 1,
                ')' => {
                    if (depth > 0) depth -= 1;
                },
                ',' => if (depth != 0) continue,
                else => continue,
            }
            if (c != ',' or depth != 0) continue;
        }

        const raw_item = trim_ascii_spaces(inner[item_start..i]);
        if (raw_item.len == 0) return null;
        if (!first) {
            buf_out[pos] = ',';
            pos += 1;
        }
        first = false;

        const item = unescape_wrapped_quotes_into(&scratch, raw_item) orelse return null;
        if (std.ascii.eqlIgnoreCase(item, "null")) {
            const null_str = "NULL";
            @memcpy(buf_out[pos..][0..null_str.len], null_str);
            pos += null_str.len;
        } else if (!wildcard_mode and (std.ascii.eqlIgnoreCase(item, "true") or std.ascii.eqlIgnoreCase(item, "false") or is_numeric(item))) {
            @memcpy(buf_out[pos..][0..item.len], item);
            pos += item.len;
        } else {
            var item_buf: [512]u8 = undefined;
            var item_view = item;
            if (wildcard_mode) {
                if (item.len > item_buf.len) return null;
                for (item, 0..) |c, j| item_buf[j] = if (c == '*') '%' else c;
                item_view = item_buf[0..item.len];
            }
            pos = append_sql_quoted(buf_out, pos, item_view);
        }
        item_start = i + 1;
    }

    buf_out[pos] = if (array_mode) ']' else ')';
    pos += 1;
    return pos;
}

fn append_simple_filter_sql(buf_out: []u8, pos_in: usize, expr: []const u8) ?usize {
    const first_dot = find_top_level_dot(expr) orelse return null;
    const column_raw = trim_ascii_spaces(expr[0..first_dot]);
    if (column_raw.len == 0) return null;
    var rest = expr[first_dot + 1 ..];
    var negated = false;
    if (std.mem.startsWith(u8, rest, "not.")) {
        negated = true;
        rest = rest[4..];
    }
    const second_dot = find_top_level_dot(rest) orelse return null;
    const op_token = trim_ascii_spaces(rest[0..second_dot]);
    const value_raw = rest[second_dot + 1 ..];
    if (op_token.len == 0 or value_raw.len == 0) return null;

    var modifier: ?[]const u8 = null;
    var fts_language: ?[]const u8 = null;
    var op_name = op_token;
    if (std.mem.indexOfScalar(u8, op_token, '(')) |paren| {
        if (op_token[op_token.len - 1] != ')') return null;
        op_name = op_token[0..paren];
        const inner = op_token[paren + 1 .. op_token.len - 1];
        if (std.mem.eql(u8, inner, "any") or std.mem.eql(u8, inner, "all")) {
            modifier = inner;
        } else {
            fts_language = inner;
        }
    }

    const op = FilterOp.fromString(op_name) orelse return null;
    const wildcard_mode = op == .like or op == .ilike;
    var pos = pos_in;
    if (negated) {
        const s = "NOT (";
        @memcpy(buf_out[pos..][0..s.len], s);
        pos += s.len;
    }
    pos = append_column_expression(buf_out, pos, column_raw) orelse return null;

    switch (op) {
        .fts, .plfts, .phfts, .wfts => {
            const op_sql = " @@ ";
            @memcpy(buf_out[pos..][0..op_sql.len], op_sql);
            pos += op_sql.len;
            const fn_name = switch (op) {
                .fts => "to_tsquery",
                .plfts => "plainto_tsquery",
                .phfts => "phraseto_tsquery",
                .wfts => "websearch_to_tsquery",
                else => unreachable,
            };
            @memcpy(buf_out[pos..][0..fn_name.len], fn_name);
            pos += fn_name.len;
            buf_out[pos] = '(';
            pos += 1;
            if (fts_language) |lang| {
                pos = append_sql_quoted(buf_out, pos, lang);
                const sep = ", ";
                @memcpy(buf_out[pos..][0..sep.len], sep);
                pos += sep.len;
            }
            var scratch: [512]u8 = undefined;
            const value = unescape_wrapped_quotes_into(&scratch, value_raw) orelse return null;
            pos = append_sql_quoted(buf_out, pos, value);
            buf_out[pos] = ')';
            pos += 1;
        },
        else => {
            const op_sql = op.toSql();
            buf_out[pos] = ' ';
            pos += 1;
            @memcpy(buf_out[pos..][0..op_sql.len], op_sql);
            pos += op_sql.len;
            buf_out[pos] = ' ';
            pos += 1;

            if (modifier) |mod| {
                if (!(op == .eq or op == .like or op == .ilike or op == .gt or op == .gte or op == .lt or op == .lte or op == .match or op == .imatch)) return null;
                const any_all = if (std.mem.eql(u8, mod, "any")) "ANY (" else if (std.mem.eql(u8, mod, "all")) "ALL (" else return null;
                @memcpy(buf_out[pos..][0..any_all.len], any_all);
                pos += any_all.len;
                pos = append_list_items_sql(buf_out, pos, value_raw, true, wildcard_mode) orelse return null;
                buf_out[pos] = ')';
                pos += 1;
            } else switch (op) {
                .is_ => {
                    var scratch: [256]u8 = undefined;
                    const value = unescape_wrapped_quotes_into(&scratch, value_raw) orelse return null;
                    if (std.ascii.eqlIgnoreCase(value, "null")) {
                        const s = "NULL";
                        @memcpy(buf_out[pos..][0..s.len], s);
                        pos += s.len;
                    } else if (std.ascii.eqlIgnoreCase(value, "true")) {
                        const s = "TRUE";
                        @memcpy(buf_out[pos..][0..s.len], s);
                        pos += s.len;
                    } else if (std.ascii.eqlIgnoreCase(value, "false")) {
                        const s = "FALSE";
                        @memcpy(buf_out[pos..][0..s.len], s);
                        pos += s.len;
                    } else if (std.ascii.eqlIgnoreCase(value, "unknown")) {
                        const s = "UNKNOWN";
                        @memcpy(buf_out[pos..][0..s.len], s);
                        pos += s.len;
                    } else {
                        pos = append_sql_quoted(buf_out, pos, value);
                    }
                },
                .isdistinct => {
                    var scratch: [256]u8 = undefined;
                    const value = unescape_wrapped_quotes_into(&scratch, value_raw) orelse return null;
                    if (std.ascii.eqlIgnoreCase(value, "null")) {
                        const s = "NULL";
                        @memcpy(buf_out[pos..][0..s.len], s);
                        pos += s.len;
                    } else if (std.ascii.eqlIgnoreCase(value, "true") or std.ascii.eqlIgnoreCase(value, "false") or std.ascii.eqlIgnoreCase(value, "unknown") or is_numeric(value)) {
                        @memcpy(buf_out[pos..][0..value.len], value);
                        pos += value.len;
                    } else {
                        pos = append_sql_quoted(buf_out, pos, value);
                    }
                },
                .in_ => pos = append_list_items_sql(buf_out, pos, value_raw, false, false) orelse return null,
                .cs, .cd, .ov, .sl, .sr, .nxr, .nxl, .adj, .match, .imatch => {
                    var scratch: [512]u8 = undefined;
                    const value = unescape_wrapped_quotes_into(&scratch, value_raw) orelse return null;
                    pos = append_sql_quoted(buf_out, pos, value);
                },
                .like, .ilike => {
                    var scratch: [512]u8 = undefined;
                    const value = unescape_wrapped_quotes_into(&scratch, value_raw) orelse return null;
                    var pattern_buf: [512]u8 = undefined;
                    if (value.len > pattern_buf.len) return null;
                    for (value, 0..) |c, j| pattern_buf[j] = if (c == '*') '%' else c;
                    pos = append_sql_quoted(buf_out, pos, pattern_buf[0..value.len]);
                },
                else => {
                    var scratch: [512]u8 = undefined;
                    const value = unescape_wrapped_quotes_into(&scratch, value_raw) orelse return null;
                    const path_is_numeric = std.mem.indexOf(u8, column_raw, "->") != null and !std.mem.containsAtLeast(u8, column_raw, 1, "->>") and is_numeric(value);
                    if (path_is_numeric) {
                        @memcpy(buf_out[pos..][0..value.len], value);
                        pos += value.len;
                    } else {
                        pos = append_sql_quoted(buf_out, pos, value);
                    }
                },
            }
        },
    }
    if (negated) {
        buf_out[pos] = ')';
        pos += 1;
    }
    return pos;
}

fn append_filter_expression_sql(buf_out: []u8, pos_in: usize, raw_expr: []const u8) ?usize {
    const expr = trim_ascii_spaces(raw_expr);
    if (expr.len == 0) return null;
    if (std.mem.startsWith(u8, expr, "or(") or std.mem.startsWith(u8, expr, "and(") or std.mem.startsWith(u8, expr, "not.or(") or std.mem.startsWith(u8, expr, "not.and(")) {
        var negated = false;
        var rest = expr;
        if (std.mem.startsWith(u8, rest, "not.")) {
            negated = true;
            rest = rest[4..];
        }
        const joiner = if (std.mem.startsWith(u8, rest, "or(")) " OR " else if (std.mem.startsWith(u8, rest, "and(")) " AND " else return null;
        const group_open = std.mem.indexOfScalar(u8, rest, '(') orelse return null;
        if (rest[rest.len - 1] != ')') return null;
        const inner = rest[group_open + 1 .. rest.len - 1];

        var pos = pos_in;
        if (negated) {
            const not_prefix = "NOT (";
            @memcpy(buf_out[pos..][0..not_prefix.len], not_prefix);
            pos += not_prefix.len;
        } else {
            buf_out[pos] = '(';
            pos += 1;
        }

        var start: usize = 0;
        var depth: usize = 0;
        var in_quotes = false;
        var escaped = false;
        var first = true;
        var i: usize = 0;
        while (i <= inner.len) : (i += 1) {
            const at_end = i == inner.len;
            if (!at_end) {
                const c = inner[i];
                if (in_quotes) {
                    if (escaped) {
                        escaped = false;
                    } else if (c == '\\') {
                        escaped = true;
                    } else if (c == '"') {
                        in_quotes = false;
                    }
                    continue;
                }
                switch (c) {
                    '"' => {
                        in_quotes = true;
                        continue;
                    },
                    '(' => depth += 1,
                    ')' => {
                        if (depth > 0) depth -= 1;
                    },
                    ',' => if (depth != 0) continue,
                    else => continue,
                }
                if (c != ',' or depth != 0) continue;
            }
            const item = trim_ascii_spaces(inner[start..i]);
            if (item.len == 0) return null;
            if (!first) {
                @memcpy(buf_out[pos..][0..joiner.len], joiner);
                pos += joiner.len;
            }
            first = false;
            pos = append_filter_expression_sql(buf_out, pos, item) orelse return null;
            start = i + 1;
        }
        buf_out[pos] = ')';
        pos += 1;
        return pos;
    }
    return append_simple_filter_sql(buf_out, pos_in, expr);
}

pub fn build_where_clause_from_args(buf_out: []u8, args: ngx_str_t) WhereClauseResult {
    if (args.len == 0 or args.data == core.nullptr(u8)) return .{ .len = 0, .invalid = false };
    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;
    var out_pos: usize = 0;
    var first = true;
    while (pos < query.len) {
        var param_end = pos;
        while (param_end < query.len and query[param_end] != '&') : (param_end += 1) {}
        const param = query[pos..param_end];
        if (param.len > 0) {
            const eq = std.mem.indexOfScalar(u8, param, '=') orelse return .{ .len = 0, .invalid = true };
            if (eq == 0 or eq >= param.len - 1) return .{ .len = 0, .invalid = true };
            var key_buf: [512]u8 = undefined;
            var value_buf: [2048]u8 = undefined;
            const key = decode_query_component_into(&key_buf, param[0..eq]) orelse return .{ .len = 0, .invalid = true };
            const value = decode_query_component_into(&value_buf, param[eq + 1 ..]) orelse return .{ .len = 0, .invalid = true };
            if (!is_reserved_query_param(key)) {
                var expr_buf: [3072]u8 = undefined;
                var expr_len: usize = 0;
                if (std.mem.eql(u8, key, "or") or std.mem.eql(u8, key, "and") or std.mem.eql(u8, key, "not.or") or std.mem.eql(u8, key, "not.and")) {
                    if (key.len + value.len > expr_buf.len) return .{ .len = 0, .invalid = true };
                    @memcpy(expr_buf[0..key.len], key);
                    @memcpy(expr_buf[key.len..][0..value.len], value);
                    expr_len = key.len + value.len;
                } else {
                    if (key.len + 1 + value.len > expr_buf.len) return .{ .len = 0, .invalid = true };
                    @memcpy(expr_buf[0..key.len], key);
                    expr_buf[key.len] = '.';
                    @memcpy(expr_buf[key.len + 1 ..][0..value.len], value);
                    expr_len = key.len + 1 + value.len;
                }
                if (!first) {
                    const and_str = " AND ";
                    @memcpy(buf_out[out_pos..][0..and_str.len], and_str);
                    out_pos += and_str.len;
                }
                out_pos = append_filter_expression_sql(buf_out, out_pos, expr_buf[0..expr_len]) orelse return .{ .len = 0, .invalid = true };
                first = false;
            }
        }
        pos = param_end + 1;
    }
    return .{ .len = out_pos, .invalid = false };
}

pub fn build_sql_query(query_buf: []u8, sql_op: SqlOp, table: []const u8, where_clause: []const u8, json_fields: []const JsonField, select_clause: []const u8, group_by_clause: []const u8, order_specs: []const OrderSpec, pagination: Pagination, include_returning: bool) usize {
    var pos: usize = 0;
    switch (sql_op) {
        .select => {
            const s = "SELECT ";
            @memcpy(query_buf[pos..][0..s.len], s);
            pos += s.len;
            if (select_clause.len > 0) {
                @memcpy(query_buf[pos..][0..select_clause.len], select_clause);
                pos += select_clause.len;
            } else {
                query_buf[pos] = '*';
                pos += 1;
            }
            const from = " FROM ";
            @memcpy(query_buf[pos..][0..from.len], from);
            pos += from.len;
            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
        },
        .insert => {
            const prefix = "INSERT INTO ";
            @memcpy(query_buf[pos..][0..prefix.len], prefix);
            pos += prefix.len;
            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
            if (json_fields.len > 0) {
                query_buf[pos] = ' ';
                pos += 1;
                query_buf[pos] = '(';
                pos += 1;
                for (json_fields, 0..) |field, i| {
                    if (i > 0) {
                        query_buf[pos] = ',';
                        pos += 1;
                    }
                    @memcpy(query_buf[pos..][0..field.name.len], field.name);
                    pos += field.name.len;
                }
                query_buf[pos] = ')';
                pos += 1;
                const values = " VALUES (";
                @memcpy(query_buf[pos..][0..values.len], values);
                pos += values.len;
                for (json_fields, 0..) |field, i| {
                    if (i > 0) {
                        query_buf[pos] = ',';
                        pos += 1;
                    }
                    if (field.is_null) {
                        const s = "NULL";
                        @memcpy(query_buf[pos..][0..s.len], s);
                        pos += s.len;
                    } else if (field.is_number) {
                        @memcpy(query_buf[pos..][0..field.value.len], field.value);
                        pos += field.value.len;
                    } else {
                        pos = append_sql_quoted(query_buf, pos, field.value);
                    }
                }
                query_buf[pos] = ')';
                pos += 1;
                if (include_returning) {
                    const s = " RETURNING *";
                    @memcpy(query_buf[pos..][0..s.len], s);
                    pos += s.len;
                }
            } else {
                const values = if (include_returning) " DEFAULT VALUES RETURNING *" else " DEFAULT VALUES";
                @memcpy(query_buf[pos..][0..values.len], values);
                pos += values.len;
            }
        },
        .update => {
            const prefix = "UPDATE ";
            @memcpy(query_buf[pos..][0..prefix.len], prefix);
            pos += prefix.len;
            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
            const set_str = " SET ";
            @memcpy(query_buf[pos..][0..set_str.len], set_str);
            pos += set_str.len;
            if (json_fields.len > 0) {
                for (json_fields, 0..) |field, i| {
                    if (i > 0) {
                        query_buf[pos] = ',';
                        pos += 1;
                    }
                    @memcpy(query_buf[pos..][0..field.name.len], field.name);
                    pos += field.name.len;
                    query_buf[pos] = '=';
                    pos += 1;
                    if (field.is_null) {
                        const s = "NULL";
                        @memcpy(query_buf[pos..][0..s.len], s);
                        pos += s.len;
                    } else if (field.is_number) {
                        @memcpy(query_buf[pos..][0..field.value.len], field.value);
                        pos += field.value.len;
                    } else {
                        pos = append_sql_quoted(query_buf, pos, field.value);
                    }
                }
            } else {
                const s = "updated_at=NOW()";
                @memcpy(query_buf[pos..][0..s.len], s);
                pos += s.len;
            }
        },
        .delete => {
            const prefix = "DELETE FROM ";
            @memcpy(query_buf[pos..][0..prefix.len], prefix);
            pos += prefix.len;
            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
        },
    }

    if (where_clause.len > 0) {
        const where = " WHERE ";
        @memcpy(query_buf[pos..][0..where.len], where);
        pos += where.len;
        @memcpy(query_buf[pos..][0..where_clause.len], where_clause);
        pos += where_clause.len;
    }

    if ((sql_op == .update or sql_op == .delete) and include_returning) {
        const returning = " RETURNING *";
        @memcpy(query_buf[pos..][0..returning.len], returning);
        pos += returning.len;
    }

    if (sql_op == .select and group_by_clause.len > 0) {
        const group_by = " GROUP BY ";
        @memcpy(query_buf[pos..][0..group_by.len], group_by);
        pos += group_by.len;
        @memcpy(query_buf[pos..][0..group_by_clause.len], group_by_clause);
        pos += group_by_clause.len;
    }

    if (sql_op == .select and order_specs.len > 0) {
        const order = " ORDER BY ";
        @memcpy(query_buf[pos..][0..order.len], order);
        pos += order.len;
        for (order_specs, 0..) |spec, i| {
            if (i > 0) {
                query_buf[pos] = ',';
                pos += 1;
            }
            pos = append_column_expression(query_buf, pos, spec.expr()) orelse return pos;
            const dir = if (spec.dir == .desc) " DESC" else " ASC";
            @memcpy(query_buf[pos..][0..dir.len], dir);
            pos += dir.len;
            switch (spec.nulls) {
                .none => {},
                .first => {
                    const s = " NULLS FIRST";
                    @memcpy(query_buf[pos..][0..s.len], s);
                    pos += s.len;
                },
                .last => {
                    const s = " NULLS LAST";
                    @memcpy(query_buf[pos..][0..s.len], s);
                    pos += s.len;
                },
            }
        }
    }

    if (sql_op == .select) {
        if (pagination.limit) |limit| {
            const s = " LIMIT ";
            @memcpy(query_buf[pos..][0..s.len], s);
            pos += s.len;
            var num_buf: [16]u8 = undefined;
            const num = std.fmt.bufPrint(&num_buf, "{d}", .{limit}) catch "0";
            @memcpy(query_buf[pos..][0..num.len], num);
            pos += num.len;
        }
        if (pagination.offset) |offset| {
            const s = " OFFSET ";
            @memcpy(query_buf[pos..][0..s.len], s);
            pos += s.len;
            var num_buf: [16]u8 = undefined;
            const num = std.fmt.bufPrint(&num_buf, "{d}", .{offset}) catch "0";
            @memcpy(query_buf[pos..][0..num.len], num);
            pos += num.len;
        }
    }
    return pos;
}

fn append_write_scalar(buf_out: []u8, pos_in: usize, scalar: WriteScalar) usize {
    if (scalar.use_default) {
        const s = "DEFAULT";
        @memcpy(buf_out[pos_in..][0..s.len], s);
        return pos_in + s.len;
    }
    if (scalar.is_null) {
        const s = "NULL";
        @memcpy(buf_out[pos_in..][0..s.len], s);
        return pos_in + s.len;
    }
    if (scalar.is_number or scalar.is_boolean) {
        @memcpy(buf_out[pos_in..][0..scalar.value.len], scalar.value);
        return pos_in + scalar.value.len;
    }
    return append_sql_quoted(buf_out, pos_in, scalar.value);
}

pub fn build_limited_write_query(query_buf: []u8, sql_op: SqlOp, table: []const u8, where_clause: []const u8, order_specs: []const OrderSpec, pagination: Pagination, json_fields: []const JsonField, include_returning: bool) ?usize {
    if (!(sql_op == .update or sql_op == .delete)) return null;
    const limit = pagination.limit orelse return null;
    if (order_specs.len == 0) return null;
    var pos: usize = 0;
    const with_prefix = "WITH pgrest_limited AS (SELECT ctid FROM ";
    @memcpy(query_buf[pos..][0..with_prefix.len], with_prefix);
    pos += with_prefix.len;
    @memcpy(query_buf[pos..][0..table.len], table);
    pos += table.len;
    if (where_clause.len > 0) {
        const where = " WHERE ";
        @memcpy(query_buf[pos..][0..where.len], where);
        pos += where.len;
        @memcpy(query_buf[pos..][0..where_clause.len], where_clause);
        pos += where_clause.len;
    }
    const order = " ORDER BY ";
    @memcpy(query_buf[pos..][0..order.len], order);
    pos += order.len;
    for (order_specs, 0..) |spec, i| {
        if (i > 0) {
            query_buf[pos] = ',';
            pos += 1;
        }
        pos = append_column_expression(query_buf, pos, spec.expr()) orelse return null;
        const dir = if (spec.dir == .desc) " DESC" else " ASC";
        @memcpy(query_buf[pos..][0..dir.len], dir);
        pos += dir.len;
        switch (spec.nulls) {
            .none => {},
            .first => {
                const s = " NULLS FIRST";
                @memcpy(query_buf[pos..][0..s.len], s);
                pos += s.len;
            },
            .last => {
                const s = " NULLS LAST";
                @memcpy(query_buf[pos..][0..s.len], s);
                pos += s.len;
            },
        }
    }
    const limit_str = " LIMIT ";
    @memcpy(query_buf[pos..][0..limit_str.len], limit_str);
    pos += limit_str.len;
    var num_buf: [32]u8 = undefined;
    const limit_num = std.fmt.bufPrint(&num_buf, "{d}", .{limit}) catch return null;
    @memcpy(query_buf[pos..][0..limit_num.len], limit_num);
    pos += limit_num.len;
    if (pagination.offset) |offset| {
        const offset_str = " OFFSET ";
        @memcpy(query_buf[pos..][0..offset_str.len], offset_str);
        pos += offset_str.len;
        const offset_num = std.fmt.bufPrint(&num_buf, "{d}", .{offset}) catch return null;
        @memcpy(query_buf[pos..][0..offset_num.len], offset_num);
        pos += offset_num.len;
    }
    const close_cte = ") ";
    @memcpy(query_buf[pos..][0..close_cte.len], close_cte);
    pos += close_cte.len;
    switch (sql_op) {
        .update => {
            const update_prefix = "UPDATE ";
            @memcpy(query_buf[pos..][0..update_prefix.len], update_prefix);
            pos += update_prefix.len;
            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
            const set_str = " SET ";
            @memcpy(query_buf[pos..][0..set_str.len], set_str);
            pos += set_str.len;
            if (json_fields.len == 0) return null;
            for (json_fields, 0..) |field, i| {
                if (i > 0) {
                    query_buf[pos] = ',';
                    pos += 1;
                }
                @memcpy(query_buf[pos..][0..field.name.len], field.name);
                pos += field.name.len;
                query_buf[pos] = '=';
                pos += 1;
                if (field.is_null) {
                    const s = "NULL";
                    @memcpy(query_buf[pos..][0..s.len], s);
                    pos += s.len;
                } else if (field.is_number or field.is_boolean) {
                    @memcpy(query_buf[pos..][0..field.value.len], field.value);
                    pos += field.value.len;
                } else {
                    pos = append_sql_quoted(query_buf, pos, field.value);
                }
            }
        },
        .delete => {
            const delete_prefix = "DELETE FROM ";
            @memcpy(query_buf[pos..][0..delete_prefix.len], delete_prefix);
            pos += delete_prefix.len;
            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
        },
        else => return null,
    }
    const where_ctid = " WHERE ctid IN (SELECT ctid FROM pgrest_limited)";
    @memcpy(query_buf[pos..][0..where_ctid.len], where_ctid);
    pos += where_ctid.len;
    if (include_returning) {
        const returning = " RETURNING *";
        @memcpy(query_buf[pos..][0..returning.len], returning);
        pos += returning.len;
    }
    return pos;
}

pub fn build_insert_rows_query(query_buf: []u8, table: []const u8, column_names: []const []const u8, row_values: []const []const WriteScalar, on_conflict_columns: []const []const u8, prefer_resolution: PreferResolution, include_returning: bool) usize {
    var pos: usize = 0;
    const insert_prefix = "INSERT INTO ";
    @memcpy(query_buf[pos..][0..insert_prefix.len], insert_prefix);
    pos += insert_prefix.len;
    @memcpy(query_buf[pos..][0..table.len], table);
    pos += table.len;
    query_buf[pos] = ' ';
    pos += 1;
    query_buf[pos] = '(';
    pos += 1;
    for (column_names, 0..) |name, idx| {
        if (idx > 0) {
            query_buf[pos] = ',';
            pos += 1;
        }
        @memcpy(query_buf[pos..][0..name.len], name);
        pos += name.len;
    }
    query_buf[pos] = ')';
    pos += 1;
    const values_token = " VALUES ";
    @memcpy(query_buf[pos..][0..values_token.len], values_token);
    pos += values_token.len;
    for (row_values, 0..) |row, row_idx| {
        if (row_idx > 0) {
            query_buf[pos] = ',';
            pos += 1;
        }
        query_buf[pos] = '(';
        pos += 1;
        for (row, 0..) |scalar, col_idx| {
            if (col_idx > 0) {
                query_buf[pos] = ',';
                pos += 1;
            }
            pos = append_write_scalar(query_buf, pos, scalar);
        }
        query_buf[pos] = ')';
        pos += 1;
    }
    if (on_conflict_columns.len > 0 and prefer_resolution != .none) {
        const on_conflict = " ON CONFLICT (";
        @memcpy(query_buf[pos..][0..on_conflict.len], on_conflict);
        pos += on_conflict.len;
        for (on_conflict_columns, 0..) |name, idx| {
            if (idx > 0) {
                query_buf[pos] = ',';
                pos += 1;
            }
            @memcpy(query_buf[pos..][0..name.len], name);
            pos += name.len;
        }
        query_buf[pos] = ')';
        pos += 1;
        switch (prefer_resolution) {
            .merge_duplicates => {
                const do_update = " DO UPDATE SET ";
                @memcpy(query_buf[pos..][0..do_update.len], do_update);
                pos += do_update.len;
                for (column_names, 0..) |name, idx| {
                    if (idx > 0) {
                        query_buf[pos] = ',';
                        pos += 1;
                    }
                    @memcpy(query_buf[pos..][0..name.len], name);
                    pos += name.len;
                    query_buf[pos] = '=';
                    pos += 1;
                    const excluded = "EXCLUDED.";
                    @memcpy(query_buf[pos..][0..excluded.len], excluded);
                    pos += excluded.len;
                    @memcpy(query_buf[pos..][0..name.len], name);
                    pos += name.len;
                }
            },
            .ignore_duplicates => {
                const do_nothing = " DO NOTHING";
                @memcpy(query_buf[pos..][0..do_nothing.len], do_nothing);
                pos += do_nothing.len;
            },
            .none => {},
        }
    }
    if (include_returning) {
        const returning = " RETURNING *";
        @memcpy(query_buf[pos..][0..returning.len], returning);
        pos += returning.len;
    }
    return pos;
}

test "parse_order supports null ordering modifiers" {
    const spec1 = parse_order_spec("age") orelse return error.TestUnexpectedResult;
    try std.testing.expectEqual(@as(OrderDir, .asc), spec1.dir);
    try std.testing.expectEqual(@as(OrderNulls, .none), spec1.nulls);
    try std.testing.expectEqualStrings("age", spec1.expr());

    const spec2 = parse_order_spec("age.desc.nullslast") orelse return error.TestUnexpectedResult;
    try std.testing.expectEqual(@as(OrderDir, .desc), spec2.dir);
    try std.testing.expectEqual(@as(OrderNulls, .last), spec2.nulls);
    try std.testing.expectEqualStrings("age", spec2.expr());

    const spec3 = parse_order_spec("age.nullsfirst") orelse return error.TestUnexpectedResult;
    try std.testing.expectEqual(@as(OrderDir, .asc), spec3.dir);
    try std.testing.expectEqual(@as(OrderNulls, .first), spec3.nulls);
}

test "parse_order supports json path ordering" {
    const spec = parse_order_spec("location->>lat.desc.nullslast") orelse return error.TestUnexpectedResult;
    try std.testing.expectEqualStrings("location->>lat", spec.expr());
    try std.testing.expectEqual(@as(OrderDir, .desc), spec.dir);
    try std.testing.expectEqual(@as(OrderNulls, .last), spec.nulls);
}

test "parse_order rejects malformed ordering" {
    try std.testing.expect(parse_order_spec("name.foo") == null);
    try std.testing.expect(parse_order_spec("name.desc.asc") == null);
    try std.testing.expect(parse_order_spec("name.nullsfirst.nullslast") == null);
    try std.testing.expect(parse_order_spec("name.") == null);
    try std.testing.expect(parse_order_spec(".desc") == null);
}

test "parse_order parses comma separated order clause" {
    var orders: [MAX_ORDER_COLUMNS]OrderSpec = undefined;
    const result = parse_order(ngx_string("order=age.desc.nullslast,height.asc"), &orders);
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqual(@as(usize, 2), result.count);
    try std.testing.expectEqualStrings("age", orders[0].expr());
    try std.testing.expectEqual(@as(OrderDir, .desc), orders[0].dir);
    try std.testing.expectEqual(@as(OrderNulls, .last), orders[0].nulls);
    try std.testing.expectEqualStrings("height", orders[1].expr());
    try std.testing.expectEqual(@as(OrderDir, .asc), orders[1].dir);
    try std.testing.expectEqual(@as(OrderNulls, .none), orders[1].nulls);
}

test "build_where_clause_from_filters preserves current filter semantics" {
    const filters = [_]Filter{
        .{ .column = "status", .op = .eq, .value = "active" },
        .{ .column = "deleted_at", .op = .is_, .value = "null" },
    };
    var buf_out: [256]u8 = undefined;
    const len = build_where_clause_from_filters(&buf_out, &filters);
    try std.testing.expectEqualStrings("status = 'active' AND deleted_at IS NULL", buf_out[0..len]);
}

test "build_where_clause_from_args supports logical operators and not" {
    var buf_out: [512]u8 = undefined;
    const result = build_where_clause_from_args(&buf_out, ngx_string("or=(age.lt.18,not.and(age.gte.11,age.lte.17))"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("(age < '18' OR NOT (age >= '11' AND age <= '17'))", buf_out[0..result.len]);
}

test "build_where_clause_from_args supports any modifier and wildcard like" {
    var buf_out: [512]u8 = undefined;
    const result = build_where_clause_from_args(&buf_out, ngx_string("last_name=like(any).{O*,P*}"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("last_name LIKE ANY (ARRAY['O%','P%'])", buf_out[0..result.len]);
}

test "build_where_clause_from_args supports all modifier and advanced operators" {
    var buf_out: [1024]u8 = undefined;
    const result = build_where_clause_from_args(&buf_out, ngx_string("last_name=like(all).{O*,*n}&name=match.^J.*n$&headline=fts(french).amusant&meta=isdistinct.null&tags=cs.{example,new}&range=adj.(1,10)"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("last_name LIKE ALL (ARRAY['O%','%n']) AND name ~ '^J.*n$' AND headline @@ to_tsquery('french', 'amusant') AND meta IS DISTINCT FROM NULL AND tags @> '{example,new}' AND range -|- '(1,10)'", buf_out[0..result.len]);
}

test "build_where_clause_from_args supports quoted identifiers and quoted in values" {
    var buf_out: [512]u8 = undefined;
    const result = build_where_clause_from_args(&buf_out, ngx_string("%22information.cpe%22=like.*MS*&name=in.(%22Hebdon,John%22,%22Williams,Mary%22)"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("\"information.cpe\" LIKE '%MS%' AND name IN ('Hebdon,John','Williams,Mary')", buf_out[0..result.len]);
}

test "build_where_clause_from_args supports json path filters" {
    var buf_out: [512]u8 = undefined;
    const result = build_where_clause_from_args(&buf_out, ngx_string("json_data->>blood_type=eq.A-&json_data->age=gt.20"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("to_jsonb(json_data)->>'blood_type' = 'A-' AND to_jsonb(json_data)->'age' > 20", buf_out[0..result.len]);
}

test "build_select_clause_from_args supports aliases and casts" {
    var buf_out: [512]u8 = undefined;
    const result = build_select_clause_from_args(&buf_out, ngx_string("select=fullName:full_name,birthDate:birth_date,salary::text"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("full_name AS fullName,birth_date AS birthDate,salary::text", buf_out[0..result.len]);
}

test "build_select_clause_from_args supports json and array paths" {
    var buf_out: [512]u8 = undefined;
    const result = build_select_clause_from_args(&buf_out, ngx_string("select=id,json_data->>blood_type,json_data->phones,primary_language:languages->0"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("id,to_jsonb(json_data)->>'blood_type' AS blood_type,to_jsonb(json_data)->'phones' AS phones,to_jsonb(languages)->0 AS primary_language", buf_out[0..result.len]);
}

test "build_select_clause_from_args decodes encoded path operators" {
    var buf_out: [512]u8 = undefined;
    const result = build_select_clause_from_args(&buf_out, ngx_string("select=id,json_data-%3E%3Eblood_type,json_data-%3Ephones,primary_language:languages-%3E0"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("id,to_jsonb(json_data)->>'blood_type' AS blood_type,to_jsonb(json_data)->'phones' AS phones,to_jsonb(languages)->0 AS primary_language", buf_out[0..result.len]);
}

test "build_sql_query renders json path ordering" {
    var query_buf: [1024]u8 = undefined;
    const spec = parse_order_spec("location->>lat.desc.nullslast") orelse return error.TestUnexpectedResult;
    const len = build_sql_query(&query_buf, .select, "countries", "", &.{}, "*", "", &.{spec}, .{ .limit = null, .offset = null }, false);
    try std.testing.expectEqualStrings("SELECT * FROM countries ORDER BY to_jsonb(location)->>'lat' DESC NULLS LAST", query_buf[0..len]);
}

test "build_select_clause_from_args supports aggregate functions and casts" {
    var buf_out: [512]u8 = undefined;
    const result = build_select_clause_from_args(&buf_out, ngx_string("select=amount.sum(),avg_amount:amount.avg()::int,order_details->tax_amount::numeric.sum(),count()"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("sum(amount) AS sum,avg(amount)::int AS avg_amount,sum(to_jsonb(order_details)->'tax_amount'::numeric) AS sum,count(*) AS count", buf_out[0..result.len]);
}

test "build_group_by_clause_from_args groups by non aggregate select items" {
    var buf_out: [512]u8 = undefined;
    const result = build_group_by_clause_from_args(&buf_out, ngx_string("select=amount.sum(),amount.avg(),order_date"));
    try std.testing.expect(!result.invalid);
    try std.testing.expectEqualStrings("order_date", buf_out[0..result.len]);
}

test "build_sql_query renders grouped aggregate query" {
    var query_buf: [1024]u8 = undefined;
    const len = build_sql_query(&query_buf, .select, "orders", "status = 'paid'", &.{}, "sum(amount) AS sum,order_date", "order_date", &.{}, .{ .limit = null, .offset = null }, false);
    try std.testing.expectEqualStrings("SELECT sum(amount) AS sum,order_date FROM orders WHERE status = 'paid' GROUP BY order_date", query_buf[0..len]);
}

test "parse_on_conflict_param parses unique column list" {
    var columns: [MAX_COLUMNS][]const u8 = undefined;
    const count = parse_on_conflict_param(ngx_string("on_conflict=id,name"), &columns) orelse return error.TestUnexpectedResult;
    try std.testing.expectEqual(@as(usize, 2), count);
    try std.testing.expectEqualStrings("id", columns[0]);
    try std.testing.expectEqualStrings("name", columns[1]);
}

test "build_insert_rows_query renders merge duplicates upsert" {
    var query_buf: [1024]u8 = undefined;
    const row = [_]WriteScalar{
        .{ .value = "1", .is_null = false, .is_number = true, .is_boolean = false, .use_default = false },
        .{ .value = "Sara B.", .is_null = false, .is_number = false, .is_boolean = false, .use_default = false },
    };
    const rows = [_][]const WriteScalar{row[0..]};
    const len = build_insert_rows_query(&query_buf, "users", &.{ "id", "name" }, rows[0..], &.{ "id" }, .merge_duplicates, true);
    try std.testing.expectEqualStrings("INSERT INTO users (id,name) VALUES (1,'Sara B.') ON CONFLICT (id) DO UPDATE SET id=EXCLUDED.id,name=EXCLUDED.name RETURNING *", query_buf[0..len]);
}

test "build_limited_write_query renders update with limit and order" {
    var query_buf: [1024]u8 = undefined;
    const spec = parse_order_spec("id") orelse return error.TestUnexpectedResult;
    const fields = [_]JsonField{.{
        .name = "status",
        .value = "inactive",
        .name_buf = [_]u8{0} ** 256,
        .value_buf = [_]u8{0} ** 1024,
        .is_null = false,
        .is_number = false,
        .is_boolean = false,
        .is_missing = false,
    }};
    const len = build_limited_write_query(&query_buf, .update, "users", "last_login < '2020-01-01'", &.{spec}, .{ .limit = 10, .offset = null }, &fields, true) orelse return error.TestUnexpectedResult;
    try std.testing.expectEqualStrings("WITH pgrest_limited AS (SELECT ctid FROM users WHERE last_login < '2020-01-01' ORDER BY id ASC LIMIT 10) UPDATE users SET status='inactive' WHERE ctid IN (SELECT ctid FROM pgrest_limited) RETURNING *", query_buf[0..len]);
}
