const std = @import("std");
const ngx = @import("ngx");

const pq = ngx.pq;
const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const file = ngx.file;
const cjson = ngx.cjson;

// libpq types and functions (re-exported from ngx_pq.zig)
const PGconn = pq.PGconn;
const PGresult = pq.PGresult;
const pgConnectdb = pq.pgConnectdb;
const pgFinish = pq.pgFinish;
const pgStatus = pq.pgStatus;
const pgExec = pq.pgExec;
const pgResultStatus = pq.pgResultStatus;
const pgNtuples = pq.pgNtuples;
const pgNfields = pq.pgNfields;
const pgFname = pq.pgFname;
const pgGetvalue = pq.pgGetvalue;
const pgGetisnull = pq.pgGetisnull;
const pgGetlength = pq.pgGetlength;
const pgClear = pq.pgClear;
const pgErrorMessage = pq.pgErrorMessage;
const CONNECTION_OK = pq.CONNECTION_OK;
const PGRES_TUPLES_OK = pq.PGRES_TUPLES_OK;
const PGRES_COMMAND_OK = pq.PGRES_COMMAND_OK;

// Non-blocking libpq functions
const pgConnectStart = pq.pgConnectStart;
const pgConnectPoll = pq.pgConnectPoll;
const pgSetnonblocking = pq.pgSetnonblocking;
const pgSocket = pq.pgSocket;
const pgFlush = pq.pgFlush;
const pgSendQuery = pq.pgSendQuery;
const pgConsumeInput = pq.pgConsumeInput;
const pgIsBusy = pq.pgIsBusy;
const pgGetResult = pq.pgGetResult;
const PGRES_POLLING_FAILED = pq.PGRES_POLLING_FAILED;
const PGRES_POLLING_READING = pq.PGRES_POLLING_READING;
const PGRES_POLLING_WRITING = pq.PGRES_POLLING_WRITING;
const PGRES_POLLING_OK = pq.PGRES_POLLING_OK;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
const NGX_AGAIN = core.NGX_AGAIN;
const NGX_DECLINED = core.NGX_DECLINED;

const NGX_CONF_OK = conf.NGX_CONF_OK;
const NGX_CONF_ERROR = conf.NGX_CONF_ERROR;

const ngx_str_t = core.ngx_str_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_flag_t = core.ngx_flag_t;
const ngx_msec_t = core.ngx_msec_t;
const ngx_pool_t = core.ngx_pool_t;
const ngx_conf_t = conf.ngx_conf_t;
const ngx_buf_t = ngx.buf.ngx_buf_t;
const ngx_event_t = core.ngx_event_t;
const ngx_chain_t = ngx.buf.ngx_chain_t;
const ngx_command_t = conf.ngx_command_t;
const ngx_array_t = ngx.array.ngx_array_t;
const ngx_module_t = ngx.module.ngx_module_t;
const ngx_http_module_t = http.ngx_http_module_t;
const ngx_table_elt_t = ngx.hash.ngx_table_elt_t;
const ngx_http_request_t = http.ngx_http_request_t;

const ngx_string = ngx.string.ngx_string;
const NList = ngx.list.NList;
const NChain = ngx.buf.NChain;
const NArray = ngx.array.NArray;

extern var ngx_http_upstream_module: ngx_module_t;
extern var ngx_http_core_module: ngx_module_t;

const ngx_pgrest_upstream_srv_t = extern struct {
    conn: ngx_str_t,
};

const ngx_pgrest_srv_conf_t = extern struct {
    servers: NArray(ngx_pgrest_upstream_srv_t),
};

const ngx_pgrest_loc_conf_t = extern struct {
    upstream: ngx_str_t,
    conninfo: ngx_str_t, // PostgreSQL connection string
    pooling: ngx_flag_t, // Enable connection pooling (non-blocking mode)
};

// ============================================================================
// Connection Pool Data Structures
// ============================================================================

/// Maximum connections in the pool
const POOL_MAX_CONNECTIONS = 16;

/// Connection state in the pool
const PgConnState = enum(c_int) {
    free, // Available for use
    connecting, // Non-blocking connect in progress
    idle, // Connected and idle, ready for queries
    busy, // Executing a query
    conn_error, // Connection failed
};

/// Query execution state
const PgQueryState = enum(c_int) {
    none, // No query
    sending, // Sending query to server
    waiting, // Waiting for result
    reading, // Reading result
    done, // Query complete
    failed, // Query failed
};

/// A single connection in the pool
const PgPoolConn = extern struct {
    conn: ?*PGconn, // libpq connection handle
    state: PgConnState, // Current connection state
    fd: c_int, // Socket file descriptor for event registration
    ngx_conn: ?*core.ngx_connection_t, // nginx connection wrapper
};

/// Connection pool for an upstream
const PgConnPool = struct {
    connections: [POOL_MAX_CONNECTIONS]PgPoolConn,
    conninfo: [512]u8, // Null-terminated connection string
    conninfo_len: usize,
    active_count: usize, // Number of active connections
    max_connections: usize, // Maximum allowed connections
    initialized: bool,

    pub fn init(self: *PgConnPool) void {
        self.initialized = false;
        self.active_count = 0;
        self.max_connections = POOL_MAX_CONNECTIONS;
        self.conninfo_len = 0;
        for (&self.connections) |*c| {
            c.conn = null;
            c.state = .free;
            c.fd = -1;
            c.ngx_conn = null;
        }
    }

    /// Find a free connection slot
    pub fn getFreeSlot(self: *PgConnPool) ?*PgPoolConn {
        for (&self.connections) |*c| {
            if (c.state == .free) {
                return c;
            }
        }
        return null;
    }

    /// Find an idle connection ready for use
    pub fn getIdleConn(self: *PgConnPool) ?*PgPoolConn {
        for (&self.connections) |*c| {
            if (c.state == .idle and c.conn != null) {
                return c;
            }
        }
        return null;
    }

    /// Release a connection back to pool
    pub fn releaseConn(self: *PgConnPool, pc: *PgPoolConn) void {
        if (pc.state == .conn_error or pc.conn == null) {
            // Close failed connections
            if (pc.conn != null) {
                pgFinish(pc.conn);
                pc.conn = null;
            }
            pc.state = .free;
            if (self.active_count > 0) self.active_count -= 1;
        } else {
            // Return to idle state for reuse
            pc.state = .idle;
        }
    }
};

/// Per-request context for PostgreSQL operations
const PgRequestCtx = extern struct {
    pool_conn: ?*PgPoolConn, // Assigned connection from pool
    query_state: PgQueryState, // Current query execution state
    query: [MAX_QUERY_SIZE]u8, // Query buffer
    query_len: usize, // Query length
    result: ?*PGresult, // Query result
    request: ?*ngx_http_request_t, // Back-reference to HTTP request
};

/// Global connection pool (one per upstream)
var g_conn_pool: PgConnPool = undefined;
var g_pool_initialized: bool = false;

/// Result of executing a PostgreSQL query
const PgQueryResult = struct {
    success: bool,
    ntuples: i32,
    nfields: i32,
    result: ?*PGresult,
    error_msg: ?[*:0]u8,
};

/// Maximum size for JSON result buffer
const MAX_JSON_SIZE = 65536;

/// Maximum number of columns for INSERT/UPDATE
const MAX_COLUMNS = 32;

/// Parsed JSON field for INSERT/UPDATE
const JsonField = struct {
    name: []const u8,
    value: []const u8,
    is_null: bool,
    is_number: bool,
};

/// Parse JSON object into field array for INSERT/UPDATE
fn parse_json_body(
    pool: [*c]core.ngx_pool_t,
    body: []const u8,
    fields: *[MAX_COLUMNS]JsonField,
) usize {
    if (body.len == 0) return 0;

    // Initialize cJSON with pool allocator
    var json_parser = cjson.CJSON.init(pool);

    // Copy body to null-terminated buffer
    var body_buf: [4096]u8 = undefined;
    if (body.len >= body_buf.len) return 0;
    @memcpy(body_buf[0..body.len], body);
    body_buf[body.len] = 0;

    const body_str = ngx_str_t{ .data = &body_buf, .len = body.len };

    // Parse JSON
    const json = json_parser.decode(body_str) catch return 0;
    if (json == core.nullptr(cjson.cJSON)) return 0;

    // Iterate over object fields
    var it = cjson.CJSON.Iterator.init(json);
    var count: usize = 0;

    while (it.next()) |item| {
        if (count >= MAX_COLUMNS) break;

        // Get field name
        if (item.*.string != core.nullptr(u8)) {
            var name_len: usize = 0;
            while (item.*.string[name_len] != 0 and name_len < 256) : (name_len += 1) {}
            fields[count].name = item.*.string[0..name_len];

            // Get field value
            if (cjson.cJSON_IsNull(item) == 1) {
                fields[count].is_null = true;
                fields[count].is_number = false;
                fields[count].value = "";
            } else if (cjson.cJSON_IsNumber(item) == 1) {
                fields[count].is_null = false;
                fields[count].is_number = true;
                // Number value will be formatted later
                fields[count].value = "";
            } else if (cjson.cJSON_IsString(item) == 1) {
                fields[count].is_null = false;
                fields[count].is_number = false;
                if (cjson.cJSON_GetStringValue(item)) |str| {
                    var str_len: usize = 0;
                    while (str[str_len] != 0 and str_len < 1024) : (str_len += 1) {}
                    fields[count].value = str[0..str_len];
                } else {
                    fields[count].value = "";
                }
            } else if (cjson.cJSON_IsBool(item) == 1) {
                fields[count].is_null = false;
                fields[count].is_number = false;
                fields[count].value = if (cjson.cJSON_IsTrue(item) == 1) "true" else "false";
            } else {
                continue; // Skip unsupported types
            }

            count += 1;
        }
    }

    return count;
}

/// Format PostgreSQL result as JSON array
/// Parse Accept header to check for singular object format
/// Returns true if Accept header contains "application/vnd.pgrst.object+json"
fn should_format_as_singular_object(r: [*c]ngx_http_request_t) bool {
    if (extract_header_value(r, "accept")) |accept_val| {
        return std.mem.containsAtLeast(u8, accept_val, 1, "application/vnd.pgrst.object+json");
    }
    return false;
}

/// Parse Accept header to check for stripped nulls format
/// Returns true if Accept header contains "nulls=stripped"
fn should_strip_nulls(r: [*c]ngx_http_request_t) bool {
    if (extract_header_value(r, "accept")) |accept_val| {
        return std.mem.containsAtLeast(u8, accept_val, 1, "nulls=stripped");
    }
    return false;
}

/// Format a single row as a JSON object
/// Used when singular object format is requested
/// If strip_nulls is true, skips null values
fn format_row_as_json_object_impl(
    result: ?*PGresult,
    row: i32,
    nfields: i32,
    json_buf: []u8,
    strip_nulls: bool,
) usize {
    if (result == null) return 0;

    var pos: usize = 0;

    // Start object
    json_buf[pos] = '{';
    pos += 1;

    var col: i32 = 0;
    var first_field: bool = true;
    while (col < nfields) : (col += 1) {
        // Check if value is null and we're stripping nulls
        const is_null = pgGetisnull(result, row, col) != 0;
        if (strip_nulls and is_null) {
            // Skip null fields when stripping nulls
            continue;
        }

        if (!first_field) {
            json_buf[pos] = ',';
            pos += 1;
        }
        first_field = false;

        // Get column name
        const fname = pgFname(result, col);
        if (fname != null) {
            // "column_name":
            json_buf[pos] = '"';
            pos += 1;

            var i: usize = 0;
            while (fname[i] != 0 and pos < json_buf.len - 10) : (i += 1) {
                json_buf[pos] = fname[i];
                pos += 1;
            }

            json_buf[pos] = '"';
            pos += 1;
            json_buf[pos] = ':';
            pos += 1;
        }

        // Check if value is null
        if (is_null) {
            const null_str = "null";
            @memcpy(json_buf[pos..][0..null_str.len], null_str);
            pos += null_str.len;
        } else {
            // Get value
            const value = pgGetvalue(result, row, col);
            if (value != null) {
                // Quote string values
                json_buf[pos] = '"';
                pos += 1;

                var i: usize = 0;
                while (value[i] != 0 and pos < json_buf.len - 10) : (i += 1) {
                    const c = value[i];
                    // Escape special JSON characters
                    if (c == '"' or c == '\\') {
                        json_buf[pos] = '\\';
                        pos += 1;
                    }
                    if (c == '\n') {
                        json_buf[pos] = '\\';
                        pos += 1;
                        json_buf[pos] = 'n';
                        pos += 1;
                    } else if (c == '\r') {
                        json_buf[pos] = '\\';
                        pos += 1;
                        json_buf[pos] = 'r';
                        pos += 1;
                    } else if (c == '\t') {
                        json_buf[pos] = '\\';
                        pos += 1;
                        json_buf[pos] = 't';
                        pos += 1;
                    } else {
                        json_buf[pos] = c;
                        pos += 1;
                    }
                }

                json_buf[pos] = '"';
                pos += 1;
            } else {
                const null_str = "null";
                @memcpy(json_buf[pos..][0..null_str.len], null_str);
                pos += null_str.len;
            }
        }
    }

    // End object
    json_buf[pos] = '}';
    pos += 1;

    return pos;
}

/// Format a single row as a JSON object
/// Used when singular object format is requested
fn format_row_as_json_object(
    result: ?*PGresult,
    row: i32,
    nfields: i32,
    json_buf: []u8,
) usize {
    return format_row_as_json_object_impl(result, row, nfields, json_buf, false);
}

/// Returns the length of JSON written to buffer
fn format_result_as_json(
    result: ?*PGresult,
    ntuples: i32,
    nfields: i32,
    json_buf: []u8,
) usize {
    var pos: usize = 0;

    // Start array
    json_buf[pos] = '[';
    pos += 1;

    var row: i32 = 0;
    while (row < ntuples) : (row += 1) {
        if (row > 0) {
            json_buf[pos] = ',';
            pos += 1;
        }

        // Start object
        json_buf[pos] = '{';
        pos += 1;

        var col: i32 = 0;
        while (col < nfields) : (col += 1) {
            if (col > 0) {
                json_buf[pos] = ',';
                pos += 1;
            }

            // Get column name
            const fname = pgFname(result, col);
            if (fname != null) {
                // "column_name":
                json_buf[pos] = '"';
                pos += 1;

                var i: usize = 0;
                while (fname[i] != 0 and pos < json_buf.len - 10) : (i += 1) {
                    json_buf[pos] = fname[i];
                    pos += 1;
                }

                json_buf[pos] = '"';
                pos += 1;
                json_buf[pos] = ':';
                pos += 1;
            }

            // Check if value is null
            if (pgGetisnull(result, row, col) != 0) {
                const null_str = "null";
                @memcpy(json_buf[pos..][0..null_str.len], null_str);
                pos += null_str.len;
            } else {
                // Get value
                const value = pgGetvalue(result, row, col);
                if (value != null) {
                    // Quote string values
                    json_buf[pos] = '"';
                    pos += 1;

                    var i: usize = 0;
                    while (value[i] != 0 and pos < json_buf.len - 10) : (i += 1) {
                        const c = value[i];
                        // Escape special JSON characters
                        if (c == '"' or c == '\\') {
                            json_buf[pos] = '\\';
                            pos += 1;
                        }
                        if (c == '\n') {
                            json_buf[pos] = '\\';
                            pos += 1;
                            json_buf[pos] = 'n';
                            pos += 1;
                        } else if (c == '\r') {
                            json_buf[pos] = '\\';
                            pos += 1;
                            json_buf[pos] = 'r';
                            pos += 1;
                        } else if (c == '\t') {
                            json_buf[pos] = '\\';
                            pos += 1;
                            json_buf[pos] = 't';
                            pos += 1;
                        } else {
                            json_buf[pos] = c;
                            pos += 1;
                        }
                    }

                    json_buf[pos] = '"';
                    pos += 1;
                } else {
                    const null_str = "null";
                    @memcpy(json_buf[pos..][0..null_str.len], null_str);
                    pos += null_str.len;
                }
            }
        }

        // End object
        json_buf[pos] = '}';
        pos += 1;
    }

    // End array
    json_buf[pos] = ']';
    pos += 1;

    return pos;
}

/// Format query results as JSON array with optional null stripping
fn format_result_as_json_with_options(
    result: ?*PGresult,
    ntuples: i32,
    nfields: i32,
    json_buf: []u8,
    strip_nulls: bool,
) usize {
    var pos: usize = 0;

    // Start array
    json_buf[pos] = '[';
    pos += 1;

    var row: i32 = 0;
    while (row < ntuples) : (row += 1) {
        if (row > 0) {
            json_buf[pos] = ',';
            pos += 1;
        }

        // Use the implementation with null stripping option
        const row_len = format_row_as_json_object_impl(result, row, nfields, json_buf[pos..], strip_nulls);
        pos += row_len;
    }

    // End array
    json_buf[pos] = ']';
    pos += 1;

    return pos;
}

/// Format query results as JSON, respecting singular object preference and null stripping
/// If Accept header contains "application/vnd.pgrst.object+json" and there's exactly one row,
/// returns that row as a single object instead of an array
fn format_result_as_json_smart(
    r: [*c]ngx_http_request_t,
    result: ?*PGresult,
    ntuples: i32,
    nfields: i32,
    json_buf: []u8,
) usize {
    const strip_nulls = should_strip_nulls(r);

    // Check if singular object format is requested
    if (should_format_as_singular_object(r)) {
        // For singular object format, return first row if it exists
        if (ntuples >= 1) {
            return format_row_as_json_object_impl(result, 0, nfields, json_buf, strip_nulls);
        }
        // If no rows, return empty object
        json_buf[0] = '{';
        json_buf[1] = '}';
        return 2;
    }

    // Default: return array format (with optional null stripping)
    return format_result_as_json_with_options(result, ntuples, nfields, json_buf, strip_nulls);
}

/// Execute a SQL query against PostgreSQL (blocking)
fn execute_pg_query(conninfo: []const u8, query: []const u8) PgQueryResult {
    // Need null-terminated strings for libpq
    var conn_buf: [512]u8 = undefined;
    var query_buf: [MAX_QUERY_SIZE + 1]u8 = undefined;

    if (conninfo.len >= conn_buf.len or query.len >= query_buf.len) {
        return PgQueryResult{
            .success = false,
            .ntuples = 0,
            .nfields = 0,
            .result = null,
            .error_msg = null,
        };
    }

    @memcpy(conn_buf[0..conninfo.len], conninfo);
    conn_buf[conninfo.len] = 0;

    @memcpy(query_buf[0..query.len], query);
    query_buf[query.len] = 0;

    // Connect to PostgreSQL
    const conn = pgConnectdb(&conn_buf);
    if (conn == null) {
        return PgQueryResult{
            .success = false,
            .ntuples = 0,
            .nfields = 0,
            .result = null,
            .error_msg = null,
        };
    }

    // Check connection status
    if (pgStatus(conn) != CONNECTION_OK) {
        const err = pgErrorMessage(conn);
        pgFinish(conn);
        return PgQueryResult{
            .success = false,
            .ntuples = 0,
            .nfields = 0,
            .result = null,
            .error_msg = err,
        };
    }

    // Execute query
    const result = pgExec(conn, &query_buf);
    const status = pgResultStatus(result);

    if (status != PGRES_TUPLES_OK and status != PGRES_COMMAND_OK) {
        const err = pgErrorMessage(conn);
        if (result != null) pgClear(result);
        pgFinish(conn);
        return PgQueryResult{
            .success = false,
            .ntuples = 0,
            .nfields = 0,
            .result = null,
            .error_msg = err,
        };
    }

    const ntuples = pgNtuples(result);
    const nfields = pgNfields(result);

    // Note: We're not closing the connection here - caller must handle cleanup
    // In production, this should use connection pooling
    pgFinish(conn);

    return PgQueryResult{
        .success = true,
        .ntuples = ntuples,
        .nfields = nfields,
        .result = result,
        .error_msg = null,
    };
}

fn pgrest_create_srv_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(ngx_pgrest_srv_conf_t, cf.*.pool)) |srv| {
        return srv;
    }
    return null;
}

fn pgrest_create_loc_conf(cf: [*c]ngx_conf_t) callconv(.c) ?*anyopaque {
    if (core.ngz_pcalloc_c(ngx_pgrest_loc_conf_t, cf.*.pool)) |loc| {
        loc.*.pooling = 0; // Disabled by default (blocking mode)
        return loc;
    }
    return null;
}

fn ngx_conf_set_server(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(ngx_pgrest_srv_conf_t, loc)) |srv| {
        if (srv.*.servers.ready == 0) {
            srv.*.servers = NArray(ngx_pgrest_upstream_srv_t).init(
                cf.*.pool,
                4,
            ) catch return NGX_CONF_ERROR;
        }
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            const pgs = srv.*.servers.append() catch return NGX_CONF_ERROR;
            pgs.*.conn = arg.*;
            const err: [*c]u8 = core.nullptr(u8);
            if (pq.is_valid_pq_conn(pgs.*.conn, err)) {
                return NGX_CONF_OK;
            }
            if (err != core.nullptr(u8)) {
                return err;
            }
        }
    }
    return NGX_CONF_ERROR;
}

fn ngx_conf_set_pgrest_pass(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    data: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cmd;
    if (core.castPtr(ngx_pgrest_loc_conf_t, data)) |loc| {
        // Get the connection string argument
        var i: ngx_uint_t = 1;
        if (ngx.array.ngx_array_next(ngx_str_t, cf.*.args, &i)) |arg| {
            loc.*.conninfo = arg.*;

            // Register the content handler
            if (core.castPtr(
                http.ngx_http_core_loc_conf_t,
                conf.ngx_http_conf_get_module_loc_conf(cf, &ngx_http_core_module),
            )) |clcf| {
                // Use pooling handler if enabled, otherwise blocking handler
                if (loc.*.pooling == 1) {
                    clcf.*.handler = ngx_http_pgrest_upstream_handler;
                } else {
                    clcf.*.handler = ngx_http_pgrest_handler;
                }
                return NGX_CONF_OK;
            }
        }
    }
    return NGX_CONF_ERROR;
}

fn ngx_conf_set_pgrest_pooling(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    data: ?*anyopaque,
) callconv(.c) [*c]u8 {
    _ = cf;
    _ = cmd;
    if (core.castPtr(ngx_pgrest_loc_conf_t, data)) |loc| {
        loc.*.pooling = 1;
        return NGX_CONF_OK;
    }
    return NGX_CONF_ERROR;
}

/// SQL operation types based on HTTP method
const SqlOp = enum {
    select,
    insert,
    update,
    delete,

    pub fn fromMethod(method: ngx_uint_t) ?SqlOp {
        return switch (method) {
            http.NGX_HTTP_GET => .select,
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

/// Maximum SQL query buffer size
const MAX_QUERY_SIZE = 4096;

/// Build SQL query from request components
/// Returns the length of the query written to the buffer
fn build_sql_query(
    query_buf: []u8,
    sql_op: SqlOp,
    table: []const u8,
    filters: []const Filter,
    json_fields: []const JsonField,
    select_cols: []const []const u8,
    order_specs: []const OrderSpec,
    pagination: Pagination,
) usize {
    var pos: usize = 0;

    switch (sql_op) {
        .select => {
            // SELECT columns FROM table
            const select_str = "SELECT ";
            @memcpy(query_buf[pos..][0..select_str.len], select_str);
            pos += select_str.len;

            if (select_cols.len > 0) {
                // Use specified columns
                for (select_cols, 0..) |col, i| {
                    if (i > 0) {
                        query_buf[pos] = ',';
                        pos += 1;
                    }
                    @memcpy(query_buf[pos..][0..col.len], col);
                    pos += col.len;
                }
            } else {
                // Select all columns
                query_buf[pos] = '*';
                pos += 1;
            }

            const from_str = " FROM ";
            @memcpy(query_buf[pos..][0..from_str.len], from_str);
            pos += from_str.len;

            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
        },
        .insert => {
            // INSERT INTO table (cols) VALUES (vals)
            const insert_prefix = "INSERT INTO ";
            @memcpy(query_buf[pos..][0..insert_prefix.len], insert_prefix);
            pos += insert_prefix.len;

            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;

            if (json_fields.len > 0) {
                // Column names
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

                // VALUES
                const values_str = " VALUES (";
                @memcpy(query_buf[pos..][0..values_str.len], values_str);
                pos += values_str.len;

                for (json_fields, 0..) |field, i| {
                    if (i > 0) {
                        query_buf[pos] = ',';
                        pos += 1;
                    }

                    if (field.is_null) {
                        const null_str = "NULL";
                        @memcpy(query_buf[pos..][0..null_str.len], null_str);
                        pos += null_str.len;
                    } else if (field.is_number) {
                        @memcpy(query_buf[pos..][0..field.value.len], field.value);
                        pos += field.value.len;
                    } else {
                        // String value - quote it
                        query_buf[pos] = '\'';
                        pos += 1;
                        @memcpy(query_buf[pos..][0..field.value.len], field.value);
                        pos += field.value.len;
                        query_buf[pos] = '\'';
                        pos += 1;
                    }
                }

                query_buf[pos] = ')';
                pos += 1;

                const returning = " RETURNING *";
                @memcpy(query_buf[pos..][0..returning.len], returning);
                pos += returning.len;
            } else {
                const values = " DEFAULT VALUES RETURNING *";
                @memcpy(query_buf[pos..][0..values.len], values);
                pos += values.len;
            }
        },
        .update => {
            // UPDATE table SET col1=val1, col2=val2
            const update_prefix = "UPDATE ";
            @memcpy(query_buf[pos..][0..update_prefix.len], update_prefix);
            pos += update_prefix.len;

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
                        const null_str = "NULL";
                        @memcpy(query_buf[pos..][0..null_str.len], null_str);
                        pos += null_str.len;
                    } else if (field.is_number) {
                        @memcpy(query_buf[pos..][0..field.value.len], field.value);
                        pos += field.value.len;
                    } else {
                        query_buf[pos] = '\'';
                        pos += 1;
                        @memcpy(query_buf[pos..][0..field.value.len], field.value);
                        pos += field.value.len;
                        query_buf[pos] = '\'';
                        pos += 1;
                    }
                }
            } else {
                const default_set = "updated_at=NOW()";
                @memcpy(query_buf[pos..][0..default_set.len], default_set);
                pos += default_set.len;
            }
        },
        .delete => {
            // DELETE FROM table
            const delete_prefix = "DELETE FROM ";
            @memcpy(query_buf[pos..][0..delete_prefix.len], delete_prefix);
            pos += delete_prefix.len;

            @memcpy(query_buf[pos..][0..table.len], table);
            pos += table.len;
        },
    }

    // Add WHERE clause if filters exist
    if (filters.len > 0) {
        const where = " WHERE ";
        @memcpy(query_buf[pos..][0..where.len], where);
        pos += where.len;

        for (filters, 0..) |filter, i| {
            if (i > 0) {
                const and_str = " AND ";
                @memcpy(query_buf[pos..][0..and_str.len], and_str);
                pos += and_str.len;
            }

            // column
            @memcpy(query_buf[pos..][0..filter.column.len], filter.column);
            pos += filter.column.len;

            // operator
            query_buf[pos] = ' ';
            pos += 1;
            const op_sql = filter.op.toSql();
            @memcpy(query_buf[pos..][0..op_sql.len], op_sql);
            pos += op_sql.len;
            query_buf[pos] = ' ';
            pos += 1;

            // value (quoted for safety - real impl needs proper escaping)
            query_buf[pos] = '\'';
            pos += 1;
            @memcpy(query_buf[pos..][0..filter.value.len], filter.value);
            pos += filter.value.len;
            query_buf[pos] = '\'';
            pos += 1;
        }
    }

    // Add RETURNING for UPDATE/DELETE
    if (sql_op == .update or sql_op == .delete) {
        const returning = " RETURNING *";
        @memcpy(query_buf[pos..][0..returning.len], returning);
        pos += returning.len;
    }

    // Add ORDER BY for SELECT
    if (sql_op == .select and order_specs.len > 0) {
        const order_str = " ORDER BY ";
        @memcpy(query_buf[pos..][0..order_str.len], order_str);
        pos += order_str.len;

        for (order_specs, 0..) |spec, i| {
            if (i > 0) {
                query_buf[pos] = ',';
                pos += 1;
            }
            @memcpy(query_buf[pos..][0..spec.column.len], spec.column);
            pos += spec.column.len;

            if (spec.dir == .desc) {
                const desc_str = " DESC";
                @memcpy(query_buf[pos..][0..desc_str.len], desc_str);
                pos += desc_str.len;
            } else {
                const asc_str = " ASC";
                @memcpy(query_buf[pos..][0..asc_str.len], asc_str);
                pos += asc_str.len;
            }
        }
    }

    // Add LIMIT/OFFSET for SELECT
    if (sql_op == .select) {
        if (pagination.limit) |limit| {
            const limit_str = " LIMIT ";
            @memcpy(query_buf[pos..][0..limit_str.len], limit_str);
            pos += limit_str.len;

            // Format number
            var num_buf: [16]u8 = undefined;
            const num_str = std.fmt.bufPrint(&num_buf, "{d}", .{limit}) catch "0";
            @memcpy(query_buf[pos..][0..num_str.len], num_str);
            pos += num_str.len;
        }

        if (pagination.offset) |offset| {
            const offset_str = " OFFSET ";
            @memcpy(query_buf[pos..][0..offset_str.len], offset_str);
            pos += offset_str.len;

            var num_buf: [16]u8 = undefined;
            const num_str = std.fmt.bufPrint(&num_buf, "{d}", .{offset}) catch "0";
            @memcpy(query_buf[pos..][0..num_str.len], num_str);
            pos += num_str.len;
        }
    }

    return pos;
}

/// Column selection for SELECT queries
const MAX_SELECT_COLUMNS = 32;

/// Parse ?select=col1,col2,col3 parameter
fn parse_select_columns(args: ngx_str_t, columns: *[MAX_SELECT_COLUMNS][]const u8) usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) {
        return 0;
    }

    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;

    // Find select= parameter
    while (pos < query.len) {
        // Check for "select="
        if (pos + 7 <= query.len and std.mem.eql(u8, query[pos .. pos + 7], "select=")) {
            pos += 7;

            // Parse comma-separated column names
            var count: usize = 0;
            var col_start = pos;

            while (pos <= query.len and count < MAX_SELECT_COLUMNS) {
                if (pos == query.len or query[pos] == '&' or query[pos] == ',') {
                    if (pos > col_start) {
                        columns[count] = query[col_start..pos];
                        count += 1;
                    }
                    if (pos == query.len or query[pos] == '&') {
                        return count;
                    }
                    col_start = pos + 1;
                }
                pos += 1;
            }
            return count;
        }
        // Skip to next parameter
        while (pos < query.len and query[pos] != '&') : (pos += 1) {}
        pos += 1;
    }
    return 0;
}

/// Order direction
const OrderDir = enum {
    asc,
    desc,
};

/// Order specification
const OrderSpec = struct {
    column: []const u8,
    dir: OrderDir,
};

const MAX_ORDER_COLUMNS = 8;

/// Parse ?order=col1.desc,col2.asc parameter
fn parse_order(args: ngx_str_t, orders: *[MAX_ORDER_COLUMNS]OrderSpec) usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) {
        return 0;
    }

    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;

    // Find order= parameter
    while (pos < query.len) {
        if (pos + 6 <= query.len and std.mem.eql(u8, query[pos .. pos + 6], "order=")) {
            pos += 6;

            var count: usize = 0;
            var col_start = pos;

            while (pos <= query.len and count < MAX_ORDER_COLUMNS) {
                if (pos == query.len or query[pos] == '&' or query[pos] == ',') {
                    if (pos > col_start) {
                        const spec = query[col_start..pos];
                        // Parse col.dir format
                        var dot_pos: usize = 0;
                        while (dot_pos < spec.len and spec[dot_pos] != '.') : (dot_pos += 1) {}

                        if (dot_pos < spec.len) {
                            orders[count].column = spec[0..dot_pos];
                            const dir_str = spec[dot_pos + 1 ..];
                            orders[count].dir = if (std.mem.eql(u8, dir_str, "desc")) .desc else .asc;
                        } else {
                            orders[count].column = spec;
                            orders[count].dir = .asc;
                        }
                        count += 1;
                    }
                    if (pos == query.len or query[pos] == '&') {
                        return count;
                    }
                    col_start = pos + 1;
                }
                pos += 1;
            }
            return count;
        }
        while (pos < query.len and query[pos] != '&') : (pos += 1) {}
        pos += 1;
    }
    return 0;
}

/// Pagination parameters
const Pagination = struct {
    limit: ?usize,
    offset: ?usize,
};

/// Parse ?limit=N&offset=M parameters
fn parse_pagination(args: ngx_str_t) Pagination {
    var result = Pagination{ .limit = null, .offset = null };

    if (args.len == 0 or args.data == core.nullptr(u8)) {
        return result;
    }

    const query = core.slicify(u8, args.data, args.len);
    var pos: usize = 0;

    while (pos < query.len) {
        // Check for limit=
        if (pos + 6 <= query.len and std.mem.eql(u8, query[pos .. pos + 6], "limit=")) {
            pos += 6;
            var num: usize = 0;
            while (pos < query.len and query[pos] >= '0' and query[pos] <= '9') {
                num = num * 10 + (query[pos] - '0');
                pos += 1;
            }
            result.limit = num;
        }
        // Check for offset=
        else if (pos + 7 <= query.len and std.mem.eql(u8, query[pos .. pos + 7], "offset=")) {
            pos += 7;
            var num: usize = 0;
            while (pos < query.len and query[pos] >= '0' and query[pos] <= '9') {
                num = num * 10 + (query[pos] - '0');
                pos += 1;
            }
            result.offset = num;
        } else {
            // Skip to next parameter
            while (pos < query.len and query[pos] != '&') : (pos += 1) {}
            pos += 1;
        }
    }

    return result;
}

/// PostgREST filter operators
const FilterOp = enum {
    eq, // equals
    neq, // not equals
    gt, // greater than
    gte, // greater than or equal
    lt, // less than
    lte, // less than or equal
    like, // LIKE pattern match
    ilike, // case-insensitive LIKE
    is_, // IS (for null checks)
    in_, // IN (list of values)

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
            .is_ => "IS",
            .in_ => "IN",
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
        if (std.mem.eql(u8, s, "is")) return .is_;
        if (std.mem.eql(u8, s, "in")) return .in_;
        return null;
    }
};

/// A single filter condition parsed from query string
const Filter = struct {
    column: []const u8,
    op: FilterOp,
    value: []const u8,
};

/// Maximum number of filters we support
const MAX_FILTERS = 16;

/// Parse query string into filters
/// Format: column=op.value&column2=op2.value2
fn parse_filters(args: ngx_str_t, filters: *[MAX_FILTERS]Filter) usize {
    if (args.len == 0 or args.data == core.nullptr(u8)) {
        return 0;
    }

    const query = core.slicify(u8, args.data, args.len);
    var count: usize = 0;
    var pos: usize = 0;

    while (pos < query.len and count < MAX_FILTERS) {
        // Find end of this parameter (& or end of string)
        var param_end = pos;
        while (param_end < query.len and query[param_end] != '&') {
            param_end += 1;
        }

        const param = query[pos..param_end];

        // Parse column=op.value
        if (parse_single_filter(param)) |filter| {
            filters[count] = filter;
            count += 1;
        }

        pos = param_end + 1; // Skip the '&'
    }

    return count;
}

/// Parse a single filter parameter: column=op.value
fn parse_single_filter(param: []const u8) ?Filter {
    // Find '=' separator
    var eq_pos: usize = 0;
    while (eq_pos < param.len and param[eq_pos] != '=') {
        eq_pos += 1;
    }

    if (eq_pos == 0 or eq_pos >= param.len - 1) {
        return null; // No column name or no value
    }

    const column = param[0..eq_pos];
    const rest = param[eq_pos + 1 ..];

    // Find '.' separator between operator and value
    var dot_pos: usize = 0;
    while (dot_pos < rest.len and rest[dot_pos] != '.') {
        dot_pos += 1;
    }

    if (dot_pos == 0 or dot_pos >= rest.len) {
        return null; // No operator or no value
    }

    const op_str = rest[0..dot_pos];
    const value = rest[dot_pos + 1 ..];

    const op = FilterOp.fromString(op_str) orelse return null;

    return Filter{
        .column = column,
        .op = op,
        .value = value,
    };
}

/// ============================================================================
/// HTTP Header Parsing
/// ============================================================================
/// Supported response formats
const ResponseFormat = enum {
    json, // application/json (default)
    csv, // text/csv
    plain_text, // text/plain (for scalar functions)
    xml, // text/xml (for XML functions)
    binary, // application/octet-stream (for bytea)
};

/// Parse Accept header to determine response format from request
/// For now, defaults to JSON since headers list navigation is complex in C structs
/// TODO: Implement full header traversal when needed
fn parse_accept_header_from_request(r: [*c]ngx_http_request_t) ResponseFormat {
    _ = r; // Currently unused - defaults to JSON
    // Default to JSON - Accept header support can be enhanced later
    // when full HTTP header parsing infrastructure is added
    return .json;
}

/// Extract a header value from HTTP request headers
/// Searches through all headers for a case-insensitive match
/// Returns the header value if found, otherwise returns null
fn extract_header_value(r: [*c]ngx_http_request_t, header_name: []const u8) ?[]const u8 {
    if (r == null) return null;

    // Search in the headers list for the requested header
    const headers_list = &r.*.headers_in.headers;

    // Get a pointer to the list part structure
    var part = &headers_list.*.part;

    var search_limit: usize = 100; // Prevent infinite loops
    while (search_limit > 0) : (search_limit -= 1) {
        const elts = core.castPtr(ngx_table_elt_t, part.*.elts) orelse {
            // Move to next part if no elements
            if (part.*.next) |next_part| {
                part = next_part;
                continue;
            } else {
                break;
            }
        };

        var i: usize = 0;
        while (i < part.*.nelts) : (i += 1) {
            const elt = elts[i];
            if (elt.key.len > 0 and elt.key.data != core.nullptr(u8)) {
                const key = core.slicify(u8, elt.key.data, elt.key.len);

                // Check if this matches the requested header (case-insensitive)
                if (std.mem.eql(u8, key, header_name) or
                    std.ascii.eqlIgnoreCase(key, header_name))
                {
                    if (elt.value.len > 0 and elt.value.data != core.nullptr(u8)) {
                        return core.slicify(u8, elt.value.data, elt.value.len);
                    }
                }
            }
        }
        // Move to next part
        if (part.*.next) |next_part| {
            part = next_part;
        } else {
            break;
        }
    }

    return null;
}

/// Extract schema name from Accept-Profile or Content-Profile header
/// Returns the schema name if found, otherwise returns null
fn extract_schema_name(r: [*c]ngx_http_request_t, method: ngx_uint_t) ?[]const u8 {
    // For GET/HEAD/DELETE requests, use Accept-Profile
    if (method == http.NGX_HTTP_GET or method == http.NGX_HTTP_HEAD or method == http.NGX_HTTP_DELETE) {
        if (extract_header_value(r, "accept-profile")) |schema| {
            return schema;
        }
    }
    // For POST/PATCH/PUT requests, use Content-Profile
    else if (method == http.NGX_HTTP_POST or method == http.NGX_HTTP_PATCH or method == http.NGX_HTTP_PUT) {
        if (extract_header_value(r, "content-profile")) |schema| {
            return schema;
        }
    }
    return null;
}

/// Build a schema-qualified table name
/// If schema is provided, returns "schema.table", otherwise just "table"
fn build_qualified_table_name(
    buffer: []u8,
    schema: ?[]const u8,
    table: []const u8,
) usize {
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

/// Check if Prefer header contains "params=single-object"
/// Used for RPC functions that expect a single JSON object parameter
fn prefer_single_object_param(r: [*c]ngx_http_request_t) bool {
    if (extract_header_value(r, "prefer")) |prefer_val| {
        return std.mem.containsAtLeast(u8, prefer_val, 1, "params=single-object");
    }
    return false;
}

/// ============================================================================
/// Smart Response Formatting
/// ============================================================================
/// Detect the result format based on query results
/// Returns:
///   0 = scalar/single value (e.g., count result)
///   1 = single row object
///   2 = multiple rows (array)
fn detect_result_format(result: ?*PGresult, ntuples: i32, nfields: i32) u8 {
    if (result == null) return 0;

    // Single field with multiple rows = array of scalars
    if (nfields == 1 and ntuples > 1) return 0;

    // Single field with one row = scalar
    if (nfields == 1 and ntuples == 1) return 0;

    // Single row = object
    if (ntuples == 1) return 1;

    // Multiple rows = array
    if (ntuples > 1) return 2;

    // No rows
    return 2;
}

/// Format result as scalar value (for functions returning single value)
fn format_result_as_scalar(
    result: ?*PGresult,
    json_buf: []u8,
) usize {
    if (result == null or pgNtuples(result) == 0) {
        const null_str = "null";
        @memcpy(json_buf[0..null_str.len], null_str);
        return null_str.len;
    }

    const value = pgGetvalue(result, 0, 0);
    if (value == null) {
        const null_str = "null";
        @memcpy(json_buf[0..null_str.len], null_str);
        return null_str.len;
    }

    // Check if value is numeric or string
    var is_number = true;
    var i: usize = 0;
    while (value[i] != 0) {
        const c = value[i];
        if ((c < '0' or c > '9') and c != '.' and c != '-' and c != '+' and c != 'e' and c != 'E') {
            is_number = false;
            break;
        }
        i += 1;
    }

    if (is_number) {
        // Output as number (no quotes)
        while (value[i] != 0) {
            i += 1;
        }
        @memcpy(json_buf[0..i], value[0..i]);
        return i;
    } else {
        // Output as quoted string
        var pos: usize = 0;
        json_buf[pos] = '"';
        pos += 1;
        i = 0;
        while (value[i] != 0) {
            const c = value[i];
            if (c == '"' or c == '\\') {
                json_buf[pos] = '\\';
                pos += 1;
            }
            json_buf[pos] = c;
            pos += 1;
            i += 1;
        }
        json_buf[pos] = '"';
        pos += 1;
        return pos;
    }
}

/// Format PostgreSQL result as CSV
fn format_result_as_csv(
    result: ?*PGresult,
    ntuples: i32,
    nfields: i32,
    csv_buf: []u8,
) usize {
    if (result == null) return 0;

    var pos: usize = 0;

    // Write header row with column names
    var col: i32 = 0;
    while (col < nfields) : (col += 1) {
        if (col > 0) {
            csv_buf[pos] = ',';
            pos += 1;
        }

        const fname = pgFname(result, col);
        if (fname != null) {
            // Quote field if it contains comma or quote
            var i: usize = 0;
            var needs_quote = false;
            while (fname[i] != 0) : (i += 1) {
                if (fname[i] == ',' or fname[i] == '"' or fname[i] == '\n') {
                    needs_quote = true;
                    break;
                }
            }

            if (needs_quote) {
                csv_buf[pos] = '"';
                pos += 1;
            }

            i = 0;
            while (fname[i] != 0) {
                if (fname[i] == '"') {
                    csv_buf[pos] = '"';
                    pos += 1;
                }
                csv_buf[pos] = fname[i];
                pos += 1;
                i += 1;
            }

            if (needs_quote) {
                csv_buf[pos] = '"';
                pos += 1;
            }
        }
    }
    csv_buf[pos] = '\n';
    pos += 1;

    // Write data rows
    var row: i32 = 0;
    while (row < ntuples) : (row += 1) {
        col = 0;
        while (col < nfields) : (col += 1) {
            if (col > 0) {
                csv_buf[pos] = ',';
                pos += 1;
            }

            if (pgGetisnull(result, row, col) != 0) {
                // Empty field for NULL
            } else {
                const value = pgGetvalue(result, row, col);
                if (value != null) {
                    // Quote field if it contains comma or quote
                    var i: usize = 0;
                    var needs_quote = false;
                    while (value[i] != 0) : (i += 1) {
                        if (value[i] == ',' or value[i] == '"' or value[i] == '\n') {
                            needs_quote = true;
                            break;
                        }
                    }

                    if (needs_quote) {
                        csv_buf[pos] = '"';
                        pos += 1;
                    }

                    i = 0;
                    while (value[i] != 0) {
                        if (value[i] == '"') {
                            csv_buf[pos] = '"';
                            pos += 1;
                        }
                        csv_buf[pos] = value[i];
                        pos += 1;
                        i += 1;
                    }

                    if (needs_quote) {
                        csv_buf[pos] = '"';
                        pos += 1;
                    }
                }
            }
        }
        csv_buf[pos] = '\n';
        pos += 1;
    }

    return pos;
}

/// Format result as single object (for queries returning one row)
fn format_result_as_object(
    result: ?*PGresult,
    nfields: i32,
    json_buf: []u8,
) usize {
    if (result == null or pgNtuples(result) == 0) {
        const empty_obj = "{}";
        @memcpy(json_buf[0..empty_obj.len], empty_obj);
        return empty_obj.len;
    }

    var pos: usize = 0;
    json_buf[pos] = '{';
    pos += 1;

    var col: i32 = 0;
    while (col < nfields) : (col += 1) {
        if (col > 0) {
            json_buf[pos] = ',';
            pos += 1;
        }

        const fname = pgFname(result, col);
        if (fname != null) {
            json_buf[pos] = '"';
            pos += 1;

            var i: usize = 0;
            while (fname[i] != 0) {
                json_buf[pos] = fname[i];
                pos += 1;
                i += 1;
            }

            json_buf[pos] = '"';
            pos += 1;
            json_buf[pos] = ':';
            pos += 1;
        }

        if (pgGetisnull(result, 0, col) != 0) {
            const null_str = "null";
            @memcpy(json_buf[pos..][0..null_str.len], null_str);
            pos += null_str.len;
        } else {
            const value = pgGetvalue(result, 0, col);
            if (value != null) {
                json_buf[pos] = '"';
                pos += 1;

                var i: usize = 0;
                while (value[i] != 0) {
                    const c = value[i];
                    if (c == '"' or c == '\\') {
                        json_buf[pos] = '\\';
                        pos += 1;
                    }
                    json_buf[pos] = c;
                    pos += 1;
                    i += 1;
                }

                json_buf[pos] = '"';
                pos += 1;
            } else {
                const null_str = "null";
                @memcpy(json_buf[pos..][0..null_str.len], null_str);
                pos += null_str.len;
            }
        }
    }

    json_buf[pos] = '}';
    pos += 1;

    return pos;
}

/// ============================================================================
/// RPC (Remote Procedure Call) - Stored Procedure Support
/// ============================================================================
/// Maximum number of RPC parameters
const MAX_RPC_PARAMS = 16;

/// RPC parameter for function call
const RpcParam = struct {
    name: []const u8,
    value: []const u8,
};

/// Parsed RPC call information
const RpcCall = struct {
    function_name: []const u8,
    params: [MAX_RPC_PARAMS]RpcParam,
    param_count: usize,
    prefer_single_object: bool = false, // Wrap parameters in single JSON object
};

/// Detect if URI path points to RPC endpoint (/rpc/function_name)
/// Returns true if path starts with /rpc/
fn is_rpc_endpoint(uri: ngx_str_t) bool {
    if (uri.len < 5 or uri.data == core.nullptr(u8)) {
        return false;
    }
    const path = core.slicify(u8, uri.data, uri.len);
    if (path.len >= 5 and std.mem.eql(u8, path[0..4], "/rpc")) {
        // Check that next char is either / or end of string
        if (path.len == 4) return true;
        if (path.len > 4 and path[4] == '/') return true;
    }
    return false;
}

/// Extract RPC function name from URI path
/// URI format: /rpc/function_name
/// Returns the function name after /rpc/
fn extract_rpc_function_name(uri: ngx_str_t) ?[]const u8 {
    if (uri.len == 0 or uri.data == core.nullptr(u8)) {
        return null;
    }

    const path = core.slicify(u8, uri.data, uri.len);

    // Find /rpc/ prefix
    if (path.len < 5 or !std.mem.eql(u8, path[0..4], "/rpc")) {
        return null;
    }

    // Skip /rpc/
    const start: usize = 5;
    if (start >= path.len) {
        return null;
    }

    // Find end of function name (next slash or end of string)
    var end: usize = start;
    while (end < path.len and path[end] != '/') {
        end += 1;
    }

    if (end == start) {
        return null;
    }

    return path[start..end];
}

/// Parse JSON POST body as RPC function arguments
/// Format: { "param1": "value1", "param2": "value2" }
fn parse_rpc_json_body(
    pool: [*c]core.ngx_pool_t,
    body: []const u8,
    rpc_call: *RpcCall,
) void {
    if (body.len == 0) return;

    // Initialize cJSON with pool allocator
    var json_parser = cjson.CJSON.init(pool);

    // Copy body to null-terminated buffer
    var body_buf: [4096]u8 = undefined;
    if (body.len >= body_buf.len) return;
    @memcpy(body_buf[0..body.len], body);
    body_buf[body.len] = 0;

    const body_str = ngx_str_t{ .data = &body_buf, .len = body.len };

    // Parse JSON
    const json = json_parser.decode(body_str) catch return;
    if (json == core.nullptr(cjson.cJSON)) return;

    // Iterate over object fields
    var it = cjson.CJSON.Iterator.init(json);
    var count: usize = 0;

    while (it.next()) |item| {
        if (count >= MAX_RPC_PARAMS) break;

        // Get field name
        if (item.*.string != core.nullptr(u8)) {
            var name_len: usize = 0;
            while (item.*.string[name_len] != 0 and name_len < 256) : (name_len += 1) {}
            rpc_call.params[count].name = item.*.string[0..name_len];

            // Get field value
            if (cjson.cJSON_IsNull(item) == 1) {
                rpc_call.params[count].value = "NULL";
            } else if (cjson.cJSON_IsNumber(item) == 1) {
                // For numbers, we'll use the string representation from cJSON
                if (cjson.cJSON_GetStringValue(item)) |str| {
                    var str_len: usize = 0;
                    while (str[str_len] != 0 and str_len < 1024) : (str_len += 1) {}
                    rpc_call.params[count].value = str[0..str_len];
                } else {
                    rpc_call.params[count].value = "0";
                }
            } else if (cjson.cJSON_IsString(item) == 1) {
                if (cjson.cJSON_GetStringValue(item)) |str| {
                    var str_len: usize = 0;
                    while (str[str_len] != 0 and str_len < 1024) : (str_len += 1) {}
                    rpc_call.params[count].value = str[0..str_len];
                } else {
                    rpc_call.params[count].value = "";
                }
            } else if (cjson.cJSON_IsBool(item) == 1) {
                rpc_call.params[count].value = if (cjson.cJSON_IsTrue(item) == 1) "true" else "false";
            } else if (cjson.cJSON_IsArray(item) == 1) {
                // Support for array parameters - store as ARRAY constructor syntax
                // Convert array elements into ARRAY[...] format
                var arr_pos: usize = 0;
                var arr_buf: [2048]u8 = undefined;

                // Start with ARRAY[
                const arr_prefix = "ARRAY[";
                @memcpy(arr_buf[arr_pos..][0..arr_prefix.len], arr_prefix);
                arr_pos += arr_prefix.len;

                // Iterate array elements
                var arr_item = item.*.child;
                var arr_index: i32 = 0;
                while (arr_item != null and arr_pos < arr_buf.len - 10) {
                    if (arr_index > 0) {
                        arr_buf[arr_pos] = ',';
                        arr_pos += 1;
                    }

                    if (cjson.cJSON_IsNumber(arr_item) == 1) {
                        if (cjson.cJSON_GetStringValue(arr_item)) |str| {
                            var s_len: usize = 0;
                            while (str[s_len] != 0 and s_len < 64) : (s_len += 1) {}
                            if (arr_pos + s_len < arr_buf.len) {
                                @memcpy(arr_buf[arr_pos..][0..s_len], str[0..s_len]);
                                arr_pos += s_len;
                            }
                        }
                    } else if (cjson.cJSON_IsString(arr_item) == 1) {
                        arr_buf[arr_pos] = '\'';
                        arr_pos += 1;
                        if (cjson.cJSON_GetStringValue(arr_item)) |str| {
                            var s_len: usize = 0;
                            while (str[s_len] != 0 and s_len < 256) : (s_len += 1) {}
                            if (arr_pos + s_len < arr_buf.len) {
                                @memcpy(arr_buf[arr_pos..][0..s_len], str[0..s_len]);
                                arr_pos += s_len;
                            }
                        }
                        arr_buf[arr_pos] = '\'';
                        arr_pos += 1;
                    }

                    arr_item = arr_item.*.next;
                    arr_index += 1;
                }

                // Close with ]
                arr_buf[arr_pos] = ']';
                arr_pos += 1;

                rpc_call.params[count].value = arr_buf[0..arr_pos];
            } else {
                continue; // Skip unsupported types (nested objects)
            }

            count += 1;
        }
    }

    rpc_call.param_count = count;
}

/// Parse query string parameters as RPC function arguments
/// Format: ?param1=value1&param2=value2
fn parse_rpc_params(args: ngx_str_t, rpc_call: *RpcCall) void {
    if (args.len == 0 or args.data == core.nullptr(u8)) {
        return;
    }

    const query = core.slicify(u8, args.data, args.len);
    var count: usize = 0;
    var pos: usize = 0;

    while (pos < query.len and count < MAX_RPC_PARAMS) {
        // Find end of this parameter (& or end of string)
        var param_end = pos;
        while (param_end < query.len and query[param_end] != '&') {
            param_end += 1;
        }

        const param = query[pos..param_end];

        // Parse param_name=value
        var eq_pos: usize = 0;
        while (eq_pos < param.len and param[eq_pos] != '=') {
            eq_pos += 1;
        }

        if (eq_pos > 0 and eq_pos < param.len - 1) {
            rpc_call.params[count].name = param[0..eq_pos];
            rpc_call.params[count].value = param[eq_pos + 1 ..];
            count += 1;
        }

        pos = param_end + 1; // Skip the '&'
    }

    rpc_call.param_count = count;
}

/// Check if a parameter value is a JSON array
/// JSON arrays start with '[' and end with ']'
fn is_json_array(value: []const u8) bool {
    return value.len >= 2 and value[0] == '[' and value[value.len - 1] == ']';
}

/// Check if a parameter value is JSON (array or object)
fn is_json_value(value: []const u8) bool {
    if (value.len < 2) return false;
    const first = value[0];
    const last = value[value.len - 1];
    return (first == '[' and last == ']') or (first == '{' and last == '}');
}

/// Build SQL function call from RPC parameters
/// Format: SELECT function_name(param1 => value1, param2 => value2)
/// Handles JSON arrays without quotes, regular strings with quotes
fn build_rpc_call_query(
    query_buf: []u8,
    function_name: []const u8,
    rpc_params: *const RpcCall,
) usize {
    var pos: usize = 0;

    const select_str = "SELECT ";
    @memcpy(query_buf[pos..][0..select_str.len], select_str);
    pos += select_str.len;

    // Function name
    @memcpy(query_buf[pos..][0..function_name.len], function_name);
    pos += function_name.len;

    // Opening paren
    query_buf[pos] = '(';
    pos += 1;

    // Parameters as named arguments (PostgreSQL syntax)
    var i: usize = 0;
    while (i < rpc_params.param_count) : (i += 1) {
        if (i > 0) {
            query_buf[pos] = ',';
            pos += 1;
            query_buf[pos] = ' ';
            pos += 1;
        }

        const param = rpc_params.params[i];

        // Parameter name
        @memcpy(query_buf[pos..][0..param.name.len], param.name);
        pos += param.name.len;

        // =>
        query_buf[pos] = ' ';
        pos += 1;
        query_buf[pos] = '=';
        pos += 1;
        query_buf[pos] = '>';
        pos += 1;
        query_buf[pos] = ' ';
        pos += 1;

        // Parameter value handling
        // JSON arrays/objects are passed without quotes
        // Regular strings and other values are quoted
        if (is_json_value(param.value)) {
            // JSON array or object - pass as is without quotes
            @memcpy(query_buf[pos..][0..param.value.len], param.value);
            pos += param.value.len;
        } else if (std.mem.eql(u8, param.value, "NULL")) {
            // NULL values - pass without quotes
            const null_str = "NULL";
            @memcpy(query_buf[pos..][0..null_str.len], null_str);
            pos += null_str.len;
        } else if (std.mem.eql(u8, param.value, "true") or std.mem.eql(u8, param.value, "false")) {
            // Boolean values - pass without quotes
            @memcpy(query_buf[pos..][0..param.value.len], param.value);
            pos += param.value.len;
        } else if (is_numeric(param.value)) {
            // Numeric values - pass without quotes
            @memcpy(query_buf[pos..][0..param.value.len], param.value);
            pos += param.value.len;
        } else {
            // String values - quote them
            query_buf[pos] = '\'';
            pos += 1;
            @memcpy(query_buf[pos..][0..param.value.len], param.value);
            pos += param.value.len;
            query_buf[pos] = '\'';
            pos += 1;
        }
    }

    // Closing paren
    query_buf[pos] = ')';
    pos += 1;

    return pos;
}

/// Check if a string represents a number
fn is_numeric(value: []const u8) bool {
    if (value.len == 0) return false;

    var i: usize = 0;
    // Allow leading minus sign
    if (value[0] == '-') {
        i = 1;
    }

    if (i >= value.len) return false;

    // Must have at least one digit
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

/// Extract table name from URI path
/// URI format: /prefix/tablename or /tablename
/// Returns the first path segment after any leading slash
fn extract_table_name(uri: ngx_str_t) ?[]const u8 {
    if (uri.len == 0 or uri.data == core.nullptr(u8)) {
        return null;
    }

    const path = core.slicify(u8, uri.data, uri.len);

    // Skip leading slash
    var start: usize = 0;
    if (path.len > 0 and path[0] == '/') {
        start = 1;
    }

    if (start >= path.len) {
        return null;
    }

    // Find end of table name (next slash or end of string)
    var end: usize = start;
    while (end < path.len and path[end] != '/') {
        end += 1;
    }

    if (end == start) {
        return null;
    }

    return path[start..end];
}

/// Handle RPC (stored procedure) call in blocking mode
fn handle_rpc_call(r: [*c]ngx_http_request_t, conninfo: []const u8) ngx_int_t {
    // Extract function name from URI
    const function_name = extract_rpc_function_name(r.*.uri) orelse {
        r.*.headers_out.status = http.NGX_HTTP_BAD_REQUEST;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        return http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
    };

    // Parse RPC parameters from query string or POST body
    var rpc_call: RpcCall = undefined;
    rpc_call.param_count = 0;
    rpc_call.function_name = function_name;
    rpc_call.prefer_single_object = prefer_single_object_param(r);

    // Try to parse POST body first (if present)
    if (r.*.request_body != null and r.*.request_body.*.bufs != null) {
        const body_chain = r.*.request_body.*.bufs;
        if (body_chain.*.buf != null) {
            const body_buf = body_chain.*.buf;
            const body_len = @intFromPtr(body_buf.*.last) - @intFromPtr(body_buf.*.pos);
            if (body_len > 0 and body_buf.*.pos != core.nullptr(u8)) {
                const body_data = body_buf.*.pos[0..body_len];
                parse_rpc_json_body(r.*.pool, body_data, &rpc_call);
            }
        }
    }

    // If no body parameters, parse query string
    if (rpc_call.param_count == 0) {
        parse_rpc_params(r.*.args, &rpc_call);
    }

    // Build RPC query
    var query_buf: [MAX_QUERY_SIZE]u8 = undefined;
    const query_len = build_rpc_call_query(&query_buf, function_name, &rpc_call);
    const query = query_buf[0..query_len];

    // Execute RPC against PostgreSQL
    const pg_result = execute_pg_query(conninfo, query);
    defer if (pg_result.result != null) pgClear(pg_result.result);

    // Build JSON response based on query result
    if (!pg_result.success) {
        // Return error response
        const err_prefix = "{\"error\": \"RPC call failed\", \"function\": \"";
        const err_suffix = "\"}";
        const err_len = err_prefix.len + function_name.len + err_suffix.len;

        const b = buf.ngx_create_temp_buf(r.*.pool, err_len) orelse {
            return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        };

        @memcpy(b.*.last[0..err_prefix.len], err_prefix);
        b.*.last += err_prefix.len;
        @memcpy(b.*.last[0..function_name.len], function_name);
        b.*.last += function_name.len;
        @memcpy(b.*.last[0..err_suffix.len], err_suffix);
        b.*.last += err_suffix.len;

        b.*.flags.last_buf = true;
        b.*.flags.last_in_chain = true;

        var out: ngx_chain_t = std.mem.zeroes(ngx_chain_t);
        out.buf = b;
        out.next = null;

        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = @intCast(err_len);

        const header_rc = http.ngx_http_send_header(r);
        if (header_rc == NGX_ERROR or header_rc > http.NGX_HTTP_SPECIAL_RESPONSE) {
            return header_rc;
        }
        return http.ngx_http_output_filter(r, &out);
    }

    // Parse Accept header to determine response format
    const response_format = parse_accept_header_from_request(r);

    // Format query results according to requested format
    var response_buf: [MAX_JSON_SIZE]u8 = undefined;
    var response_len: usize = 0;
    var content_type: [*:0]const u8 = "application/json";

    switch (response_format) {
        .json => {
            response_len = format_result_as_json_smart(
                r,
                pg_result.result,
                pg_result.ntuples,
                pg_result.nfields,
                &response_buf,
            );
            content_type = "application/json";
        },
        .csv => {
            response_len = format_result_as_csv(
                pg_result.result,
                pg_result.ntuples,
                pg_result.nfields,
                &response_buf,
            );
            content_type = "text/csv; charset=utf-8";
        },
        .plain_text => {
            // For plain text, only return first field as text
            if (pg_result.ntuples > 0 and pg_result.nfields > 0) {
                response_len = format_result_as_scalar(pg_result.result, &response_buf);
            }
            content_type = "text/plain; charset=utf-8";
        },
        .xml => {
            content_type = "text/xml; charset=utf-8";
            // XML would require special handling - for now return as JSON
            response_len = format_result_as_json_smart(
                r,
                pg_result.result,
                pg_result.ntuples,
                pg_result.nfields,
                &response_buf,
            );
        },
        .binary => {
            content_type = "application/octet-stream";
            // Binary would require special handling - for now return as JSON
            response_len = format_result_as_json_smart(
                r,
                pg_result.result,
                pg_result.ntuples,
                pg_result.nfields,
                &response_buf,
            );
        },
    }

    const response_data = response_buf[0..response_len];

    // Allocate buffer
    const b = buf.ngx_create_temp_buf(r.*.pool, response_len) orelse {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    };

    // Copy response
    @memcpy(b.*.last[0..response_len], response_data);
    b.*.last += response_len;

    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    // Build output chain
    var out: ngx_chain_t = std.mem.zeroes(ngx_chain_t);
    out.buf = b;
    out.next = null;

    // Set content length and status
    r.*.headers_out.status = http.NGX_HTTP_OK;
    const len = std.mem.len(content_type);
    r.*.headers_out.content_type = ngx_str_t{ .data = @constCast(content_type), .len = len };
    r.*.headers_out.content_type_len = len;
    r.*.headers_out.content_length_n = @intCast(response_len);

    // Send headers
    const header_rc = http.ngx_http_send_header(r);
    if (header_rc == NGX_ERROR or header_rc > http.NGX_HTTP_SPECIAL_RESPONSE) {
        return header_rc;
    }

    // Send body
    return http.ngx_http_output_filter(r, &out);
}

/// Content handler for pgrest_pass locations
fn ngx_http_pgrest_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    // Set response content type to JSON
    r.*.headers_out.content_type = ngx_string("application/json");
    r.*.headers_out.content_type_len = 16;

    // Get location config to retrieve connection string
    const loc_conf = core.castPtr(
        ngx_pgrest_loc_conf_t,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_pgrest_module),
    ) orelse {
        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        return http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
    };

    // Get connection string
    const conninfo = core.slicify(u8, loc_conf.*.conninfo.data, loc_conf.*.conninfo.len);
    if (conninfo.len == 0) {
        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        return http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
    }

    // Check if this is an RPC (stored procedure) call
    if (is_rpc_endpoint(r.*.uri)) {
        return handle_rpc_call(r, conninfo);
    }

    // Extract table name from URI
    const table_name = extract_table_name(r.*.uri) orelse {
        // No table specified - return error
        r.*.headers_out.status = http.NGX_HTTP_BAD_REQUEST;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        return http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
    };

    // Extract schema name from Profile header if present
    const schema_name = extract_schema_name(r, r.*.method);

    // Build qualified table name (schema.table or just table)
    var qualified_table_buf: [512]u8 = undefined;
    const qualified_table_len = build_qualified_table_name(
        qualified_table_buf[0..],
        schema_name,
        table_name,
    );
    const qualified_table = qualified_table_buf[0..qualified_table_len];

    // Map HTTP method to SQL operation
    const sql_op = SqlOp.fromMethod(r.*.method) orelse {
        // Unsupported method
        r.*.headers_out.status = http.NGX_HTTP_NOT_ALLOWED;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        return http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
    };

    // Parse query string filters
    var filters: [MAX_FILTERS]Filter = undefined;
    const filter_count = parse_filters(r.*.args, &filters);

    // Parse column selection (?select=col1,col2)
    var select_cols: [MAX_SELECT_COLUMNS][]const u8 = undefined;
    const select_count = parse_select_columns(r.*.args, &select_cols);

    // Parse ordering (?order=col.desc)
    var order_specs: [MAX_ORDER_COLUMNS]OrderSpec = undefined;
    const order_count = parse_order(r.*.args, &order_specs);

    // Parse pagination (?limit=N&offset=M)
    const pagination = parse_pagination(r.*.args);

    // Parse request body for POST/PATCH
    var json_fields: [MAX_COLUMNS]JsonField = undefined;
    var json_field_count: usize = 0;

    if (sql_op == .insert or sql_op == .update) {
        // Get request body if available
        if (r.*.request_body != null and r.*.request_body.*.bufs != null) {
            const body_chain = r.*.request_body.*.bufs;
            if (body_chain.*.buf != null) {
                const body_buf = body_chain.*.buf;
                const body_len = @intFromPtr(body_buf.*.last) - @intFromPtr(body_buf.*.pos);
                if (body_len > 0 and body_buf.*.pos != core.nullptr(u8)) {
                    const body_data = body_buf.*.pos[0..body_len];
                    json_field_count = parse_json_body(r.*.pool, body_data, &json_fields);
                }
            }
        }
    }

    // Build SQL query
    var query_buf: [MAX_QUERY_SIZE]u8 = undefined;
    const query_len = build_sql_query(
        &query_buf,
        sql_op,
        qualified_table,
        filters[0..filter_count],
        json_fields[0..json_field_count],
        select_cols[0..select_count],
        order_specs[0..order_count],
        pagination,
    );
    const query = query_buf[0..query_len];

    // Execute query against PostgreSQL
    const pg_result = execute_pg_query(conninfo, query);
    defer if (pg_result.result != null) pgClear(pg_result.result);

    // Build JSON response based on query result
    if (!pg_result.success) {
        // Return error response
        const err_prefix = "{\"error\": \"Query failed\", \"sql\": \"";
        const err_suffix = "\"}";
        const err_len = err_prefix.len + query.len + err_suffix.len;

        const b = buf.ngx_create_temp_buf(r.*.pool, err_len) orelse {
            return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        };

        @memcpy(b.*.last[0..err_prefix.len], err_prefix);
        b.*.last += err_prefix.len;
        @memcpy(b.*.last[0..query.len], query);
        b.*.last += query.len;
        @memcpy(b.*.last[0..err_suffix.len], err_suffix);
        b.*.last += err_suffix.len;

        b.*.flags.last_buf = true;
        b.*.flags.last_in_chain = true;

        var out: ngx_chain_t = std.mem.zeroes(ngx_chain_t);
        out.buf = b;
        out.next = null;

        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = @intCast(err_len);

        const header_rc = http.ngx_http_send_header(r);
        if (header_rc == NGX_ERROR or header_rc > http.NGX_HTTP_SPECIAL_RESPONSE) {
            return header_rc;
        }
        return http.ngx_http_output_filter(r, &out);
    }

    // Format query results as JSON array (or single object if requested)
    var json_buf: [MAX_JSON_SIZE]u8 = undefined;
    const json_len = format_result_as_json_smart(
        r,
        pg_result.result,
        pg_result.ntuples,
        pg_result.nfields,
        &json_buf,
    );
    const json_data = json_buf[0..json_len];

    const total_len = json_len;

    // Allocate buffer
    const b = buf.ngx_create_temp_buf(r.*.pool, total_len) orelse {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    };

    // Copy JSON response
    @memcpy(b.*.last[0..json_len], json_data);
    b.*.last += json_len;

    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    // Build output chain
    var out: ngx_chain_t = std.mem.zeroes(ngx_chain_t);
    out.buf = b;
    out.next = null;

    // Set content length and status
    r.*.headers_out.status = http.NGX_HTTP_OK;
    r.*.headers_out.content_length_n = @intCast(total_len);

    // Send headers
    const header_rc = http.ngx_http_send_header(r);
    if (header_rc == NGX_ERROR or header_rc > http.NGX_HTTP_SPECIAL_RESPONSE) {
        return header_rc;
    }

    // Send body
    return http.ngx_http_output_filter(r, &out);
}

/// Handle RPC (stored procedure) call in non-blocking mode with connection pooling
fn handle_rpc_call_upstream(r: [*c]ngx_http_request_t) ngx_int_t {
    // Extract function name from URI
    const function_name = extract_rpc_function_name(r.*.uri) orelse {
        return http.NGX_HTTP_BAD_REQUEST;
    };

    // Allocate request context
    const ctx = core.ngz_pcalloc_c(PgRequestCtx, r.*.pool) orelse {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    };

    // Parse RPC parameters from query string or POST body
    var rpc_call: RpcCall = undefined;
    rpc_call.param_count = 0;
    rpc_call.function_name = function_name;

    // Try to parse POST body first (if present)
    if (r.*.request_body != null and r.*.request_body.*.bufs != null) {
        const body_chain = r.*.request_body.*.bufs;
        if (body_chain.*.buf != null) {
            const body_buf = body_chain.*.buf;
            const body_len = @intFromPtr(body_buf.*.last) - @intFromPtr(body_buf.*.pos);
            if (body_len > 0 and body_buf.*.pos != core.nullptr(u8)) {
                const body_data = body_buf.*.pos[0..body_len];
                parse_rpc_json_body(r.*.pool, body_data, &rpc_call);
            }
        }
    }

    // If no body parameters, parse query string
    if (rpc_call.param_count == 0) {
        parse_rpc_params(r.*.args, &rpc_call);
    }

    // Build RPC query into the context
    ctx.*.query_len = build_rpc_call_query(&ctx.*.query, function_name, &rpc_call);
    ctx.*.query[ctx.*.query_len] = 0; // null terminate

    ctx.*.pool_conn = null;
    ctx.*.query_state = .none;
    ctx.*.result = null;
    ctx.*.request = r;

    // Create upstream
    if (http.ngx_http_upstream_create(r) != NGX_OK) {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    }

    const u = r.*.upstream orelse return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

    // Configure upstream callbacks
    u.*.create_request = ngx_pgrest_upstream_create_request;
    u.*.process_header = ngx_pgrest_upstream_process_header;
    u.*.finalize_request = ngx_pgrest_upstream_finalize_request;
    u.*.input_filter_init = ngx_pgrest_upstream_input_filter_init;
    u.*.input_filter = ngx_pgrest_upstream_input_filter;

    // Set up peer callbacks
    u.*.peer.get = ngx_pgrest_upstream_get_peer;
    u.*.peer.free = ngx_pgrest_upstream_free_peer;
    u.*.peer.data = ctx;

    // Increase reference count
    r.*.main.*.flags0.count += 1;

    // Start the upstream process
    http.ngx_http_upstream_init(r);

    return NGX_AGAIN;
}

/// Non-blocking content handler that uses upstream mechanism with connection pooling
fn ngx_http_pgrest_upstream_handler(r: [*c]ngx_http_request_t) callconv(.c) ngx_int_t {
    // Set response content type to JSON
    r.*.headers_out.content_type = ngx_string("application/json");
    r.*.headers_out.content_type_len = 16;

    // Get location config to retrieve connection string
    const loc_conf = core.castPtr(
        ngx_pgrest_loc_conf_t,
        conf.ngx_http_get_module_loc_conf(r, &ngx_http_pgrest_module),
    ) orelse {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    };

    // Initialize pool with connection string if not already done
    if (!g_pool_initialized) {
        g_conn_pool.init();
        g_pool_initialized = true;
    }

    if (!g_conn_pool.initialized) {
        const conninfo = core.slicify(u8, loc_conf.*.conninfo.data, loc_conf.*.conninfo.len);
        if (conninfo.len > 0 and conninfo.len < g_conn_pool.conninfo.len) {
            @memcpy(g_conn_pool.conninfo[0..conninfo.len], conninfo);
            g_conn_pool.conninfo[conninfo.len] = 0;
            g_conn_pool.conninfo_len = conninfo.len;
            g_conn_pool.initialized = true;
        }
    }

    // Check if this is an RPC (stored procedure) call
    if (is_rpc_endpoint(r.*.uri)) {
        return handle_rpc_call_upstream(r);
    }

    // Extract table name from URI
    const table_name = extract_table_name(r.*.uri) orelse {
        return http.NGX_HTTP_BAD_REQUEST;
    };

    // Map HTTP method to SQL operation
    const sql_op = SqlOp.fromMethod(r.*.method) orelse {
        return http.NGX_HTTP_NOT_ALLOWED;
    };

    // Parse query string filters
    var filters: [MAX_FILTERS]Filter = undefined;
    const filter_count = parse_filters(r.*.args, &filters);

    // Parse column selection
    var select_cols: [MAX_SELECT_COLUMNS][]const u8 = undefined;
    const select_count = parse_select_columns(r.*.args, &select_cols);

    // Parse ordering
    var order_specs: [MAX_ORDER_COLUMNS]OrderSpec = undefined;
    const order_count = parse_order(r.*.args, &order_specs);

    // Parse pagination
    const pagination = parse_pagination(r.*.args);

    // Parse request body for POST/PATCH
    var json_fields: [MAX_COLUMNS]JsonField = undefined;
    var json_field_count: usize = 0;

    if (sql_op == .insert or sql_op == .update) {
        if (r.*.request_body != null and r.*.request_body.*.bufs != null) {
            const body_chain = r.*.request_body.*.bufs;
            if (body_chain.*.buf != null) {
                const body_buf = body_chain.*.buf;
                const body_len = @intFromPtr(body_buf.*.last) - @intFromPtr(body_buf.*.pos);
                if (body_len > 0 and body_buf.*.pos != core.nullptr(u8)) {
                    const body_data = body_buf.*.pos[0..body_len];
                    json_field_count = parse_json_body(r.*.pool, body_data, &json_fields);
                }
            }
        }
    }

    // Allocate request context
    const ctx = core.ngz_pcalloc_c(PgRequestCtx, r.*.pool) orelse {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    };

    // Build SQL query into the context
    ctx.*.query_len = build_sql_query(
        &ctx.*.query,
        sql_op,
        table_name,
        filters[0..filter_count],
        json_fields[0..json_field_count],
        select_cols[0..select_count],
        order_specs[0..order_count],
        pagination,
    );
    ctx.*.query[ctx.*.query_len] = 0; // null terminate

    ctx.*.pool_conn = null;
    ctx.*.query_state = .none;
    ctx.*.result = null;
    ctx.*.request = r;

    // Create upstream
    if (http.ngx_http_upstream_create(r) != NGX_OK) {
        return http.NGX_HTTP_INTERNAL_SERVER_ERROR;
    }

    const u = r.*.upstream orelse return http.NGX_HTTP_INTERNAL_SERVER_ERROR;

    // Configure upstream callbacks
    u.*.create_request = ngx_pgrest_upstream_create_request;
    u.*.process_header = ngx_pgrest_upstream_process_header;
    u.*.finalize_request = ngx_pgrest_upstream_finalize_request;
    u.*.input_filter_init = ngx_pgrest_upstream_input_filter_init;
    u.*.input_filter = ngx_pgrest_upstream_input_filter;

    // Set up peer callbacks
    u.*.peer.get = ngx_pgrest_upstream_get_peer;
    u.*.peer.free = ngx_pgrest_upstream_free_peer;
    u.*.peer.data = ctx;

    // Increase reference count
    r.*.main.*.flags0.count += 1;

    // Start the upstream process
    http.ngx_http_upstream_init(r);

    return NGX_AGAIN;
}

/// Connection-level write event handler
/// Called when the socket is ready for writing
fn ngx_pgrest_conn_write_handler(ev: [*c]core.ngx_event_t) callconv(.c) void {
    const c = core.castPtr(core.ngx_connection_t, ev.*.data) orelse return;
    const ctx = core.castPtr(PgRequestCtx, c.*.data) orelse return;
    const pool_conn = ctx.*.pool_conn orelse return;

    if (pool_conn.state == .connecting) {
        // Continue connection polling
        poll_pg_connection(ctx, pool_conn);
    } else if (pool_conn.state == .busy and ctx.*.query_state == .sending) {
        // Continue sending query
        if (pool_conn.conn != null) {
            const flush_result = pgFlush(pool_conn.conn);
            if (flush_result == 0) {
                // Flushed successfully, wait for result
                ctx.*.query_state = .waiting;
            } else if (flush_result < 0) {
                // Error
                ctx.*.query_state = .failed;
            }
            // flush_result > 0 means more data to write, wait for next event
        }
    }
}

/// Connection-level read event handler
/// Called when the socket is ready for reading
fn ngx_pgrest_conn_read_handler(ev: [*c]core.ngx_event_t) callconv(.c) void {
    const c = core.castPtr(core.ngx_connection_t, ev.*.data) orelse return;
    const ctx = core.castPtr(PgRequestCtx, c.*.data) orelse return;
    const pool_conn = ctx.*.pool_conn orelse return;

    if (pool_conn.state == .connecting) {
        // Continue connection polling
        poll_pg_connection(ctx, pool_conn);
    } else if (pool_conn.state == .busy and ctx.*.query_state == .waiting) {
        // Read query result
        if (pool_conn.conn != null) {
            // Consume input from socket
            if (pgConsumeInput(pool_conn.conn) == 0) {
                ctx.*.query_state = .failed;
                return;
            }

            // Check if we can get a result
            if (pgIsBusy(pool_conn.conn) == 0) {
                // Get the result
                ctx.*.result = pgGetResult(pool_conn.conn);
                ctx.*.query_state = .done;

                // Need to drain remaining NULL results
                while (pgGetResult(pool_conn.conn) != null) {}

                // Now we can finalize the response
                finalize_pg_response(ctx);
            }
        }
    }
}

/// Poll libpq connection during async connect
fn poll_pg_connection(ctx: *PgRequestCtx, pool_conn: *PgPoolConn) void {
    const conn = pool_conn.conn orelse return;

    const poll_status = pgConnectPoll(conn);

    switch (poll_status) {
        PGRES_POLLING_OK => {
            // Connection established!
            pool_conn.state = .idle;

            // If we have a pending query, send it now
            if (ctx.*.query_len > 0) {
                if (pgSendQuery(conn, &ctx.*.query) != 0) {
                    ctx.*.query_state = .sending;
                    pool_conn.state = .busy;

                    // Try to flush immediately
                    const flush_result = pgFlush(conn);
                    if (flush_result == 0) {
                        ctx.*.query_state = .waiting;
                    } else if (flush_result < 0) {
                        ctx.*.query_state = .failed;
                    }
                } else {
                    ctx.*.query_state = .failed;
                }
            }
        },
        PGRES_POLLING_FAILED => {
            // Connection failed
            pool_conn.state = .conn_error;
            ctx.*.query_state = .failed;
        },
        PGRES_POLLING_READING, PGRES_POLLING_WRITING => {
            // Still connecting, wait for next event
        },
        else => {},
    }
}

/// Finalize the PostgreSQL response and send to client
fn finalize_pg_response(ctx: *PgRequestCtx) void {
    const r = ctx.*.request orelse return;

    if (ctx.*.query_state != .done or ctx.*.result == null) {
        // Query failed - send error response
        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        _ = http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
        return;
    }

    const result = ctx.*.result.?;
    const status = pgResultStatus(result);

    if (status != PGRES_TUPLES_OK and status != PGRES_COMMAND_OK) {
        // Query error
        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        _ = http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
        return;
    }

    // Format result as JSON
    var json_buf: [MAX_JSON_SIZE]u8 = undefined;
    const ntuples = pgNtuples(result);
    const nfields = pgNfields(result);
    const json_len = format_result_as_json(result, ntuples, nfields, &json_buf);

    // Create response buffer
    const b = buf.ngx_create_temp_buf(r.*.pool, json_len) orelse {
        r.*.headers_out.status = http.NGX_HTTP_INTERNAL_SERVER_ERROR;
        r.*.headers_out.content_length_n = 0;
        _ = http.ngx_http_send_header(r);
        _ = http.ngx_http_send_special(r, http.NGX_HTTP_LAST);
        return;
    };

    @memcpy(b.*.last[0..json_len], json_buf[0..json_len]);
    b.*.last += json_len;
    b.*.flags.last_buf = true;
    b.*.flags.last_in_chain = true;

    var out: ngx_chain_t = std.mem.zeroes(ngx_chain_t);
    out.buf = b;
    out.next = null;

    // Set response headers
    r.*.headers_out.status = http.NGX_HTTP_OK;
    r.*.headers_out.content_type = ngx_string("application/json");
    r.*.headers_out.content_type_len = 16;
    r.*.headers_out.content_length_n = @intCast(json_len);

    _ = http.ngx_http_send_header(r);
    _ = http.ngx_http_output_filter(r, &out);
}

/// polling libpq state (upstream read event handler)
fn ngx_pgrest_wev_handler(
    r: [*c]ngx_http_request_t,
    u: [*c]http.ngx_http_upstream_t,
) callconv(.c) void {
    _ = r;
    _ = u;
    // Write events are handled by connection-level handler
}

/// polling libpq state (upstream write event handler)
fn ngx_pgrest_rev_handler(
    r: [*c]ngx_http_request_t,
    u: [*c]http.ngx_http_upstream_t,
) callconv(.c) void {
    _ = r;
    _ = u;
    // Read events are handled by connection-level handler
}

/// callback for uscf->peer.init_upstream
/// every upstream block has an uscf
/// the callback get called in ngx_http_upstream_init_main_conf
/// the callback is assigned in pgrest_server directive setting
///
/// each upstream block has *N* servers, and each server can have *M* peers
/// it appears to init every peer in every server directive
/// the init provisions all connection specifics, sockaddr, dbname etc
/// the init also setups peer selection algorithm
/// all peers together form a connection pool to the database
/// all peers should be interchangable to execute queries
fn ngx_pgrest_upstream_init(
    cf: [*c]ngx_conf_t,
    uscf: [*c]http.ngx_http_upstream_srv_conf_t,
) callconv(.c) ngx_int_t {
    _ = cf;

    // Initialize global connection pool if not already done
    if (!g_pool_initialized) {
        g_conn_pool.init();
        g_pool_initialized = true;
    }

    // Get server config to extract connection string
    if (core.castPtr(ngx_pgrest_srv_conf_t, uscf.*.srv_conf)) |srv_conf| {
        // Copy first server's connection info to pool
        if (srv_conf.*.servers.ready == 1) {
            if (srv_conf.*.servers.get(0)) |server| {
                const conninfo = core.slicify(u8, server.conn.data, server.conn.len);
                if (conninfo.len < g_conn_pool.conninfo.len) {
                    @memcpy(g_conn_pool.conninfo[0..conninfo.len], conninfo);
                    g_conn_pool.conninfo[conninfo.len] = 0; // null terminate
                    g_conn_pool.conninfo_len = conninfo.len;
                    g_conn_pool.initialized = true;
                }
            }
        }
    }

    // Set peer init callback
    uscf.*.peer.init = ngx_pgrest_upstream_init_peer;

    return NGX_OK;
}

/// callback for uscf->peer.init
/// the callback get called by the end of ngx_http_upstream_init
/// the callback get called before ngx_http_upstream_connect
/// the callback is assigned in ngx_pgrest_upstream_init
/// the callback should return NGX_OK for upstream to proceed
///
/// it prepares the selected peer for the specific request
/// it inits the r->upstream.peer which is a ngx_peer_connection_t
/// which has
/// ngx_event_get_peer_pt            get;
/// ngx_event_free_peer_pt           free;
/// void *                           data;
/// the *data* field will be given to get/free callbacks
/// these callbacks controls the upstream connection process
/// so that the upstream is taken by libpq but appears to be connecting
fn ngx_pgrest_upstream_init_peer(
    r: [*c]ngx_http_request_t,
    uscf: [*c]http.ngx_http_upstream_srv_conf_t,
) callconv(.c) ngx_int_t {
    _ = uscf;

    // Allocate per-request context
    const ctx = core.ngz_pcalloc_c(PgRequestCtx, r.*.pool) orelse {
        return NGX_ERROR;
    };

    // Initialize request context
    ctx.*.pool_conn = null;
    ctx.*.query_state = .none;
    ctx.*.query_len = 0;
    ctx.*.result = null;
    ctx.*.request = r;

    // Get upstream from request
    const u = r.*.upstream orelse return NGX_ERROR;

    // Set up peer callbacks
    u.*.peer.get = ngx_pgrest_upstream_get_peer;
    u.*.peer.free = ngx_pgrest_upstream_free_peer;
    u.*.peer.data = ctx;

    return NGX_OK;
}

/// the callback is assigned in ngx_pgrest_upstream_init_peer
/// the callback is called in ngx_event_connect_peer
/// which is at the start of ngx_http_upstream_connect
/// it should always return NGX_AGAIN when everything is good
/// so that there is no actual socket connection to be made to the peer
///
/// libpq literally kicks in from here and execute PQconnectStart
/// the nonblocking way of connecting to the database. But...
///
/// before another db connection is made, it checks if an existing
/// connection to the db can be reused in the pool, otherwise
/// new connection is made and managed by the pool and handles
/// accordingly if no connection can be made with the pool policy
///
/// state is saved in pc->data field
///
/// libpq returns fd by PQsocket
/// a ngx_connection_t pgxc is given by ngx_get_connection(fd, pc->log)
/// pc->connection is set to this paricular connection too.
/// pgxc->read and pgxc->write get registed in the nginx event model
/// by ngx_add_event
///
/// libpq might go wrong, registing nginx connection model might go wrong
/// in case something is wrong, manages the corresponding cleanups.
///
/// when everything is good, and NGX_AGAIN is returned
/// ngx_http_upstream_init
///     -> ngx_http_upstream_init_request
///         -> ngx_http_upstream_connect
/// does following
///
/// ngx_add_timer(c->write, u->connect_timeout);
/// and return, without sending to upstream any data.
///
/// right after this, the upstream handlers are replaced with
///    u->write_event_handler = ngx_pgrest_wev_handler;
///    u->read_event_handler = ngx_pgrest_rev_handler;
/// the upstream process is completely taken over by libpq
fn ngx_pgrest_upstream_get_peer(
    pc: [*c]core.ngx_peer_connection_t,
    data: ?*anyopaque,
) callconv(.c) ngx_int_t {
    const ctx = core.castPtr(PgRequestCtx, data) orelse return NGX_ERROR;

    // Check if pool is initialized
    if (!g_pool_initialized or !g_conn_pool.initialized) {
        return NGX_ERROR;
    }

    // Try to get an idle connection from the pool first
    if (g_conn_pool.getIdleConn()) |pool_conn| {
        // Reuse existing idle connection
        ctx.*.pool_conn = pool_conn;
        pool_conn.state = .busy;

        // Set the nginx connection
        pc.*.connection = pool_conn.ngx_conn;

        // Connection is ready - return NGX_AGAIN to prevent upstream from
        // making its own connection
        return NGX_AGAIN;
    }

    // No idle connection available - try to create a new one
    const pool_conn = g_conn_pool.getFreeSlot() orelse {
        // Pool is full - could queue the request or return error
        return NGX_ERROR;
    };

    // Start non-blocking connection via libpq
    const conn = pgConnectStart(&g_conn_pool.conninfo);
    if (conn == null) {
        return NGX_ERROR;
    }

    // Check if connection start failed immediately
    if (pgStatus(conn) == pq.CONNECTION_BAD) {
        pgFinish(conn);
        return NGX_ERROR;
    }

    // Set connection to non-blocking mode
    if (pgSetnonblocking(conn, 1) != 0) {
        pgFinish(conn);
        return NGX_ERROR;
    }

    // Get the socket fd from libpq
    const fd = pgSocket(conn);
    if (fd < 0) {
        pgFinish(conn);
        return NGX_ERROR;
    }

    // Get an nginx connection wrapper for the socket
    const ngx_conn = http.ngx_get_connection(fd, pc.*.log);
    if (ngx_conn == core.nullptr(core.ngx_connection_t)) {
        pgFinish(conn);
        return NGX_ERROR;
    }

    // Initialize pool connection entry
    pool_conn.conn = conn;
    pool_conn.state = .connecting;
    pool_conn.fd = fd;
    pool_conn.ngx_conn = ngx_conn;
    g_conn_pool.active_count += 1;

    // Link request context to pool connection
    ctx.*.pool_conn = pool_conn;

    // Set up nginx connection read/write handlers
    ngx_conn.*.data = ctx;

    // Register read event for connection polling
    if (ngx_conn.*.read != core.nullptr(core.ngx_event_t)) {
        ngx_conn.*.read.*.handler = ngx_pgrest_conn_read_handler;
        if (http.ngx_handle_read_event(ngx_conn.*.read, 0) != NGX_OK) {
            cleanup_pool_conn(pool_conn);
            return NGX_ERROR;
        }
    }

    // Register write event for connection polling
    if (ngx_conn.*.write != core.nullptr(core.ngx_event_t)) {
        ngx_conn.*.write.*.handler = ngx_pgrest_conn_write_handler;
        if (http.ngx_handle_write_event(ngx_conn.*.write, 0) != NGX_OK) {
            cleanup_pool_conn(pool_conn);
            return NGX_ERROR;
        }
    }

    // Set pc->connection to our libpq-managed connection
    pc.*.connection = ngx_conn;

    // Return NGX_AGAIN - connection is in progress
    // The event handlers will be called when the socket is ready
    return NGX_AGAIN;
}

/// Clean up a pool connection entry
fn cleanup_pool_conn(pool_conn: *PgPoolConn) void {
    if (pool_conn.conn != null) {
        pgFinish(pool_conn.conn);
        pool_conn.conn = null;
    }
    if (pool_conn.ngx_conn != core.nullptr(core.ngx_connection_t)) {
        // Note: nginx connection should be freed separately
        pool_conn.ngx_conn = null;
    }
    pool_conn.state = .free;
    pool_conn.fd = -1;
    if (g_conn_pool.active_count > 0) {
        g_conn_pool.active_count -= 1;
    }
}

/// the callback is assigned in ngx_postgres_upstream_init_peer
/// the callback is called in ngx_http_upstream_finalize_request
/// it is to cleanup the libpq connection when the specific request
/// gets finalized
///
/// *NOTE* ngx_http_upstream_finalize_request is declared static and
/// servers as internal cleanup function
fn ngx_pgrest_upstream_free_peer(
    pc: [*c]core.ngx_peer_connection_t,
    data: ?*anyopaque,
    state: ngx_uint_t,
) callconv(.c) void {
    _ = pc;

    const ctx = core.castPtr(PgRequestCtx, data) orelse return;

    // Free any pending result
    if (ctx.*.result != null) {
        pgClear(ctx.*.result);
        ctx.*.result = null;
    }

    // Release the pool connection
    const pool_conn = ctx.*.pool_conn orelse return;

    // Check if the connection should be kept alive or discarded
    // NGX_PEER_FAILED indicates the connection had an error
    const NGX_PEER_FAILED: ngx_uint_t = 0x0002;
    const NGX_PEER_NEXT: ngx_uint_t = 0x0004;

    if ((state & NGX_PEER_FAILED) != 0 or (state & NGX_PEER_NEXT) != 0) {
        // Connection failed - close and mark as free
        pool_conn.state = .conn_error;
        g_conn_pool.releaseConn(pool_conn);
    } else {
        // Connection succeeded - return to idle state for reuse
        g_conn_pool.releaseConn(pool_conn);
    }

    ctx.*.pool_conn = null;
}

/// r->upstream->request_bufs = NULL
/// use libpq instead of raw packet
fn ngx_pgrest_upstream_create_request(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    _ = r;
    return NGX_OK;
}

/// empty callback
fn ngx_pgrest_upstream_finalize_request(
    r: [*c]ngx_http_request_t,
    rc: ngx_int_t,
) callconv(.c) void {
    _ = r;
    _ = rc;
}

/// empty callback
fn ngx_pgrest_upstream_process_header(
    r: [*c]ngx_http_request_t,
) callconv(.c) ngx_int_t {
    _ = r;
    return NGX_OK;
}

/// empty callback
fn ngx_pgrest_upstream_input_filter_init(
    ctx: ?*anyopaque,
) callconv(.c) ngx_int_t {
    _ = ctx;
    return NGX_OK;
}

/// empty callback
fn ngx_pgrest_upstream_input_filter(
    ctx: ?*anyopaque,
    bytes: isize,
) callconv(.c) ngx_int_t {
    _ = ctx;
    _ = bytes;
    return NGX_OK;
}

export const ngx_http_pgrest_module_ctx = ngx_http_module_t{
    .preconfiguration = null,
    .postconfiguration = null,
    .create_main_conf = null,
    .init_main_conf = null,
    .create_srv_conf = pgrest_create_srv_conf,
    .merge_srv_conf = null,
    .create_loc_conf = pgrest_create_loc_conf,
    .merge_loc_conf = null,
};

export const ngx_http_pgrest_commands = [_]ngx_command_t{
    ngx_command_t{
        .name = ngx_string("pgrest_server"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_server,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("pgrest_keepalive"),
        .type = conf.NGX_HTTP_UPS_CONF | conf.NGX_CONF_1MORE,
        .set = conf.ngx_conf_set_num_slot,
        .conf = conf.NGX_HTTP_SRV_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("pgrest_pooling"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_NOARGS,
        .set = ngx_conf_set_pgrest_pooling,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },
    ngx_command_t{
        .name = ngx_string("pgrest_pass"),
        .type = conf.NGX_HTTP_LOC_CONF | conf.NGX_CONF_TAKE1,
        .set = ngx_conf_set_pgrest_pass,
        .conf = conf.NGX_HTTP_LOC_CONF_OFFSET,
        .offset = 0,
        .post = null,
    },

    conf.ngx_null_command,
};

export var ngx_http_pgrest_module = ngx.module.make_module(
    @constCast(&ngx_http_pgrest_commands),
    @constCast(&ngx_http_pgrest_module_ctx),
);

const expectEqual = std.testing.expectEqual;
test "pgrest module" {}
