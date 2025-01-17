const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const Deque = @import("deque.zig").Deque;
const expectEqual = std.testing.expectEqual;

pub const ngx_rbtree_t = ngx.ngx_rbtree_t;
pub const ngx_rbtree_key_t = ngx.ngx_rbtree_key_t;
pub const ngx_rbtree_node_t = ngx.ngx_rbtree_node_t;

const nullptr = core.nullptr;
const ngx_uint_t = core.ngx_uint_t;
const ngx_pool_t = core.ngx_pool_t;

pub inline fn ngx_rbtree_init(tree: [*c]ngx_rbtree_t, s: [*c]ngx_rbtree_node_t, i: ngx_rbtree_insert_pt) void {
    ngx_rbtree_sentinel_init(s);
    tree.*.root = s;
    tree.*.sentinel = s;
    tree.*.insert = i;
}

pub inline fn ngz_rbtree_data(comptime T: type, comptime field: []const u8, n: [*c]ngx_rbtree_node_t) [*c]T {
    return @as(
        [*c]T,
        @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(n))) - @offsetOf(T, field))),
    );
}

pub inline fn ngx_rbt_red(node: [*c]ngx_rbtree_node_t) void {
    node.*.color = 1;
}

pub inline fn ngx_rbt_black(node: [*c]ngx_rbtree_node_t) void {
    node.*.color = 0;
}

pub inline fn ngx_rbt_is_red(node: [*c]ngx_rbtree_node_t) bool {
    return node.*.color == 1;
}

pub inline fn ngx_rbt_is_black(node: [*c]ngx_rbtree_node_t) bool {
    return node.*.color == 0;
}

pub inline fn ngx_rbt_copy_color(n1: [*c]ngx_rbtree_node_t, n2: [*c]ngx_rbtree_node_t) void {
    n1.*.color = n2.*.color;
}

pub inline fn ngx_rbtree_sentinel_init(node: [*c]ngx_rbtree_node_t) void {
    ngx_rbt_black(node);
}

pub inline fn ngx_rbtree_min(node: [*c]ngx_rbtree_node_t, sentinel: [*c]ngx_rbtree_node_t) [*c]ngx_rbtree_node_t {
    var n: [*c]ngx_rbtree_node_t = node;
    while (n.*.left != sentinel) {
        n = n.*.left;
    }
    return n;
}

pub const ngx_rbtree_insert_pt = ngx.ngx_rbtree_insert_pt;
pub const ngx_rbtree_insert = ngx.ngx_rbtree_insert;
pub const ngx_rbtree_delete = ngx.ngx_rbtree_delete;
pub fn NRBTree(
    comptime T: type,
    comptime field: []const u8,
    comptime Context: anytype,
    comptime KeyFn: fn (Context, [*c]T) ngx_rbtree_key_t,
) type {
    const OFFSET = @offsetOf(T, field);
    const Node = ngx_rbtree_node_t;
    const Tree = struct {
        pub fn isRoot(n: [*c]Node) bool {
            return n.*.parent == nullptr(Node);
        }
        pub fn isLeft(n: [*c]Node) bool {
            return !isRoot(n) and n.*.parent.*.left == n;
        }
        pub fn isRight(n: [*c]Node) bool {
            return !isRoot(n) and n.*.parent.*.right == n;
        }
        pub fn isLeaf(n: [*c]Node, s: [*c]Node) bool {
            return n.*.left == s and n.*.right == s;
        }
        pub fn sibling(n: [*c]Node) [*c]Node {
            if (isRoot(n)) {
                // unreachable;
                return nullptr(Node);
            }
            return if (isLeft(n)) n.*.parent.*.right else n.*.parent.*.left;
        }
        pub fn downLeft(n: [*c]Node, s: [*c]Node) [*c]Node {
            if (n.*.left != s) {
                return downLeft(n.*.left, s);
            }
            return n;
        }
        pub fn downBottom(n: [*c]Node, s: [*c]Node) [*c]Node {
            if (n.*.left != s) {
                return downBottom(n.*.left, s);
            }
            if (n.*.right != s) {
                return downBottom(n.*.right, s);
            }
            return n;
        }
        pub fn upRight(n: [*c]Node, s: [*c]Node) [*c]Node {
            if (isRoot(n)) {
                return nullptr(Node);
            }
            if (isLeft(n)) {
                const r = sibling(n);
                if (r != s) {
                    return r;
                }
            }
            return upRight(n.*.parent, s);
        }
        pub fn upLeft(n: [*c]Node) [*c]Node {
            if (isRoot(n)) {
                return nullptr(Node);
            }
            return if (isLeft(n)) n.*.parent else upLeft(n.*.parent);
        }

        pub fn depth(n: [*c]Node, s: [*c]Node, d: ngx_uint_t) ngx_uint_t {
            if (n == s) {
                return d;
            }
            return @max(depth(n.*.left, s, d + 1), depth(n.*.right, s, d + 1));
        }

        fn insertFn(parent: [*c]Node, n: [*c]Node, sentinel: [*c]Node) callconv(.C) void {
            var pp: *[*c]Node = @constCast(&parent);
            var p: [*c]Node = parent;
            while (pp.* != sentinel) {
                p = pp.*;
                pp = if (n.*.key < p.*.key) &p.*.left else &p.*.right;
            }
            pp.* = n;
            n.*.parent = p;
            n.*.left = sentinel;
            n.*.right = sentinel;
            ngx_rbt_red(n);
        }
    };

    const TraverseOrder = enum(u8) {
        PreOrder,
        InOrder,
        PostOrder,
    };

    const BfsIterator = struct {
        const Self = @This();
        tree: [*c]ngx_rbtree_t,
        queue: Deque([*c]Node),

        pub fn next(it: *Self) ?[*c]Node {
            if (it.queue.popFront()) |n| {
                if (n.*.left != it.tree.*.sentinel) {
                    it.queue.pushBack(n.*.left) catch unreachable;
                }
                if (n.*.right != it.tree.*.sentinel) {
                    it.queue.pushBack(n.*.right) catch unreachable;
                }
                return n;
            }
            return null;
        }
    };

    const Iterator = struct {
        const Self = @This();
        order: TraverseOrder,
        tree: [*c]ngx_rbtree_t,
        node: [*c]ngx_rbtree_node_t,

        fn nextPre(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            if (x.*.left != it.tree.*.sentinel) {
                it.node = x.*.left;
            }
            if (x.*.left == it.tree.*.sentinel) {
                if (x.*.right != it.tree.*.sentinel) {
                    it.node = x.*.right;
                } else {
                    it.node = Tree.upRight(x, it.tree.*.sentinel);
                }
            }
            return x;
        }

        fn nextIn(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            if (x.*.right != it.tree.*.sentinel) {
                it.node = Tree.downLeft(x.*.right, it.tree.*.sentinel);
            } else {
                it.node = Tree.upLeft(x);
            }
            return x;
        }

        fn nextPost(it: *Self) ?[*c]Node {
            if (it.node == nullptr(Node)) {
                return null;
            }
            const x = it.node;
            it.node = x.*.parent;

            if (Tree.isLeft(x)) {
                const s = Tree.sibling(x);
                if (s != it.tree.*.sentinel) {
                    it.node = Tree.downBottom(s, it.tree.*.sentinel);
                }
            }
            return x;
        }

        fn next(it: *Self) ?[*c]Node {
            return switch (it.order) {
                .PreOrder => nextPre(it),
                .InOrder => nextIn(it),
                .PostOrder => nextPost(it),
            };
        }
    };

    return extern struct {
        const Self = @This();
        const TraverseOrderType = TraverseOrder;

        tree: [*c]ngx_rbtree_t,

        pub inline fn node(pt: [*c]T) [*c]Node {
            return @as(
                [*c]Node,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(pt))) + OFFSET)),
            );
        }

        pub inline fn data(n: [*c]Node) [*c]T {
            return @as(
                [*c]T,
                @alignCast(@ptrCast(@as([*c]u8, @alignCast(@ptrCast(n))) - OFFSET)),
            );
        }

        pub fn init(
            t: [*c]ngx_rbtree_t,
            p: [*c]ngx_pool_t,
            pt: ?ngx_rbtree_insert_pt,
        ) !Self {
            if (core.ngz_pcalloc_c(Node, p)) |sentinel| {
                const pt0 = pt orelse &Tree.insertFn;
                ngx_rbtree_init(t, sentinel, pt0);
                return Self{ .tree = t };
            }
            return core.NError.OOM;
        }

        pub fn find(self: *Self, key: ngx_rbtree_key_t) ?[*c]T {
            var n: ?[*c]Node = null;
            var p: [*c]Node = self.tree.*.root;
            while (p != self.tree.*.sentinel) {
                if (p.*.key == key) {
                    n = p;
                    break;
                }
                p = if (key < p.*.key) p.*.left else p.*.right;
            }
            return if (n == null) null else data(n.?);
        }

        pub fn depth(self: *Self) ngx_uint_t {
            return Tree.depth(self.tree.*.root, self.tree.*.sentinel, 0);
        }

        pub fn bfs(self: *Self, p: [*c]ngx_pool_t) !BfsIterator {
            var fba = try core.NAllocator(1024).init(p);
            const allocator = fba.allocator();

            var q = try Deque([*c]Node).init(allocator);
            if (self.tree.*.root != self.tree.*.sentinel) {
                try q.pushBack(self.tree.*.root);
            }
            return BfsIterator{ .queue = q, .tree = self.tree };
        }

        pub fn iterator(self: *Self, order: TraverseOrderType) Iterator {
            var it = Iterator{
                .tree = self.tree,
                .node = self.tree.*.root,
                .order = order,
            };

            if (it.node == self.tree.*.sentinel) { //empty tree
                it.node = nullptr(Node);
                return it;
            }

            if (order == .InOrder) {
                it.node = Tree.downLeft(self.tree.*.root, self.tree.*.sentinel);
            }
            if (order == .PostOrder) {
                it.node = Tree.downBottom(self.tree.*.root, self.tree.*.sentinel);
            }
            return it;
        }

        pub fn insert(self: *Self, pt: [*c]T, ctx: Context) void {
            const n = node(pt);
            n.*.key = KeyFn(ctx, pt);
            ngx_rbtree_insert(self.tree, n);
        }

        pub fn delete(self: *Self, pt: [*c]T) void {
            const n = node(pt);
            ngx_rbtree_delete(self.tree, n);
        }
    };
}

const ngx_log_init = ngx.ngx_log_init;
const ngx_time_init = ngx.ngx_time_init;
const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;
test "rbtree" {
    try expectEqual(@sizeOf(ngx_rbtree_t), 24);
    const RBT = extern struct {
        const Self = @This();
        c: u8,
        n: ngx_uint_t,
        node: ngx_rbtree_node_t = undefined,

        pub fn key(ctx: void, p: [*c]Self) ngx_rbtree_key_t {
            _ = ctx;
            return p.*.n;
        }
    };

    var rs = [_]RBT{
        RBT{ .n = 0, .c = 'E' },
        RBT{ .n = 1, .c = 'X' },
        RBT{ .n = 2, .c = 'M' },
        RBT{ .n = 3, .c = 'B' },
        RBT{ .n = 4, .c = 'S' },
        RBT{ .n = 5, .c = 'A' },
        RBT{ .n = 6, .c = 'P' },
        RBT{ .n = 7, .c = 'T' },
        RBT{ .n = 8, .c = 'N' },
        RBT{ .n = 9, .c = 'W' },
        RBT{ .n = 10, .c = 'H' },
        RBT{ .n = 11, .c = 'C' },
        RBT{ .n = 12, .c = 'Y' },
    };

    const log = ngx_log_init(core.c_str(""), core.c_str(""));
    ngx_time_init();

    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    const RBTree = NRBTree(RBT, "node", void, RBT.key);
    var t: ngx_rbtree_t = undefined;
    var tree = try RBTree.init(&t, pool, null);
    for (&rs) |*r0| {
        tree.insert(r0, {});
    }
    try expectEqual(tree.depth(), 5);

    while (tree.find(6)) |r0| {
        tree.delete(r0);
    }

    var bfs = try tree.bfs(pool);
    while (bfs.next()) |n| {
        const r0 = RBTree.data(n);
        std.debug.print("{c} ", .{r0.*.c});
    }

    std.debug.print("\n", .{});

    var it = tree.iterator(RBTree.TraverseOrderType.PostOrder);
    while (it.next()) |n| {
        const r0 = RBTree.data(n);
        std.debug.print("{c} ", .{r0.*.c});
    }
}
