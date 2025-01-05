const std = @import("std");
const ngx = @import("ngx.zig");
const expectEqual = std.testing.expectEqual;

pub const ngx_array_t = ngx.ngx_array_t;

test "ngx array" {
    try expectEqual(@sizeOf(ngx_array_t), 40);
}
