const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const http = @import("ngx_http.zig");
const module = @import("ngx_module.zig");
const rbtree = @import("ngx_rbtree.zig");
const expectEqual = std.testing.expectEqual;

const ngx_int_t = core.ngx_int_t;
const ngx_msec_t = core.ngx_msec_t;
const ngx_http_request_t = http.ngx_http_request_t;

extern var ngx_event_timer_rbtree: rbtree.ngx_rbtree_t;
extern var ngx_current_msec: ngx_msec_t;

pub const ngx_event_t = core.ngx_event_t;
pub const ngx_event_handler_pt = ngx.ngx_event_handler_pt;

pub inline fn ngx_event_del_timer(ev: [*c]ngx_event_t) void {
    rbtree.ngx_rbtree_delete(&ngx_event_timer_rbtree, &ev.*.timer);
    ev.*.timer.left = core.nullptr(rbtree.ngx_rbtree_node_t);
    ev.*.timer.right = core.nullptr(rbtree.ngx_rbtree_node_t);
    ev.*.timer.parent = core.nullptr(rbtree.ngx_rbtree_node_t);
    ev.*.flags.timer_set = false;
}

const NGX_TIMER_LAZY_DELAY = ngx.NGX_TIMER_LAZY_DELAY;
pub inline fn ngx_event_add_timer(ev: [*c]ngx_event_t, timer: ngx_msec_t) void {
    const key: ngx_msec_t = ngx_current_msec + timer;
    if (ev.*.flags.timer_set) {
        if (@abs(key - ev.*.timer.key) < NGX_TIMER_LAZY_DELAY) {
            return;
        }
        ngx_event_del_timer(ev);
    }
    ev.*.timer.key = key;
    ev.*.flags.timer_set = true;
    rbtree.ngx_rbtree_insert(&ngx_event_timer_rbtree, &ev.*.timer);
}

pub const NTimer = extern struct {
    const Self = @This();

    request: [*c]ngx_http_request_t,
    handler: http.ngx_http_handler_pt,
    cleanup: core.ngx_flag_t,
    timer: ngx_event_t,

    fn timer_handler(ev: [*c]ngx_event_t) callconv(.C) void {
        if (core.castPtr(Self, ev.*.data)) |self| {
            const r = self.*.request;
            if (r.*.connection.*.flags.destroyed) {
                return;
            }
            if (r.*.connection.*.flags.@"error") {
                http.ngx_http_finalize_request(r, core.NGX_ERROR);
                return;
            }
            if (!self.*.timer.flags.timedout) {
                return;
            }
            self.*.timer.flags.timedout = false;
            if (self.*.timer.flags.timer_set) {
                ngx_event_del_timer(&self.*.timer);
            }

            if (core.castPtr(http.ngx_http_log_ctx_t, r.*.connection.*.log.*.data)) |ctx| {
                ctx.*.current_request = r;
            }
            // NGX_DONE already did r.*.main.*.flags0.count -= 1;
            if (self.*.handler) |handle| {
                const rc = handle(r);
                http.ngx_http_finalize_request(r, rc);
            }
        }
    }

    fn timer_cleanup(data: ?*anyopaque) callconv(.C) void {
        if (core.castPtr(Self, data)) |self| {
            if (self.*.timer.flags.timer_set) {
                ngx_event_del_timer(&self.*.timer);
            }
        }
    }

    pub fn init(r: [*c]ngx_http_request_t, handler: http.ngx_http_handler_pt) Self {
        return Self{
            .request = r,
            .handler = handler,
            .cleanup = 0,
            .timer = ngx_event_t{ .handler = timer_handler, .log = r.*.connection.*.log },
        };
    }

    pub fn activate(self: *Self, d: ngx_msec_t) !void {
        self.timer.data = self;
        self.request.*.main.*.flags0.count += 1;
        ngx_event_add_timer(&self.*.timer, d);

        if (self.cleanup == 0) {
            self.cleanup = 1;
            if (core.nonNullPtr(
                http.ngx_http_cleanup_t,
                http.ngx_http_cleanup_add(self.request, 0),
            )) |cln| {
                cln.*.data = self;
                cln.*.handler = timer_cleanup;
            } else {
                return core.NError.TIMER_ERROR;
            }
        }
    }
};
