const std = @import("std");
const ngx = @import("ngx");

const pq = ngx.pq;
const buf = ngx.buf;
const core = ngx.core;
const conf = ngx.conf;
const http = ngx.http;
const file = ngx.file;

const NGX_OK = core.NGX_OK;
const NGX_ERROR = core.NGX_ERROR;
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

const ngx_pgrest_upstream_srv_t = extern struct {
    conn: ngx_str_t,
};

const ngx_pgrest_srv_conf_t = extern struct {
    servers: NArray(ngx_pgrest_upstream_srv_t),
};

const ngx_pgrest_loc_conf_t = extern struct {};

fn pgrest_create_srv_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (core.ngz_pcalloc_c(ngx_pgrest_srv_conf_t, cf.*.pool)) |srv| {
        return srv;
    }
    return null;
}

fn pgrest_create_loc_conf(cf: [*c]ngx_conf_t) callconv(.C) ?*anyopaque {
    if (core.ngz_pcalloc_c(ngx_pgrest_loc_conf_t, cf.*.pool)) |loc| {
        return loc;
    }
    return null;
}

fn ngx_conf_set_server(
    cf: [*c]ngx_conf_t,
    cmd: [*c]ngx_command_t,
    loc: ?*anyopaque,
) callconv(.C) [*c]u8 {
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

/// polling libpq state
fn ngx_pgrest_wev_handler(
    r: ngx_http_request_t,
    u: http.ngx_http_upstream_t,
) callconv(.C) void {
    _ = r;
    _ = u;
}

/// polling libpq state
fn ngx_pgrest_rev_handler(
    r: ngx_http_request_t,
    u: http.ngx_http_upstream_t,
) callconv(.C) void {
    _ = r;
    _ = u;
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
) callconv(.C) ngx_int_t {
    _ = cf;
    _ = uscf;
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
) callconv(.C) ngx_int_t {
    _ = r;
    _ = uscf;
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
) callconv(.C) ngx_int_t {
    _ = pc;
    _ = data;
    return NGX_OK;
}

fn ngx_pgrest_upstream_free_peer(
    pc: [*c]core.ngx_peer_connection_t,
    data: ?*anyopaque,
    state: ngx_uint_t,
) callconv(.C) void {
    _ = pc;
    _ = data;
    _ = state;
}

/// r->upstream->request_bufs = NULL
/// use libpq instead of raw packet
fn ngx_pgrest_upstream_create_request(
    r: [*c]ngx_http_request_t,
) callconv(.C) ngx_int_t {
    _ = r;
    return NGX_OK;
}

/// empty callback
fn ngx_pgrest_upstream_finalize_request(
    r: [*c]ngx_http_request_t,
    rc: ngx_int_t,
) callconv(.C) void {
    _ = r;
    _ = rc;
}

/// empty callback
fn ngx_pgrest_upstream_process_header(
    r: [*c]ngx_http_request_t,
) callconv(.C) ngx_int_t {
    _ = r;
    return NGX_OK;
}

/// empty callback
fn ngx_pgrest_upstream_input_filter_init(
    ctx: ?*anyopaque,
) callconv(.C) ngx_int_t {
    _ = ctx;
    return NGX_OK;
}

/// empty callback
fn ngx_pgrest_upstream_input_filter(
    ctx: ?*anyopaque,
    bytes: usize,
) callconv(.C) ngx_int_t {
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

    conf.ngx_null_command,
};

export var ngx_http_pgrest_module = ngx.module.make_module(
    @constCast(&ngx_http_pgrest_commands),
    @constCast(&ngx_http_pgrest_module_ctx),
);

const expectEqual = std.testing.expectEqual;
test "pgrest module" {}
