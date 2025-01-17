const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const rbtree = @import("ngx_rbtree.zig");
const expectEqual = std.testing.expectEqual;

const ngx_msec_t = core.ngx_msec_t;

extern var ngx_event_timer_rbtree: rbtree.ngx_rbtree_t;
extern var ngx_current_msec: ngx_msec_t;

pub const ngx_event_t = core.ngx_event_t;

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
