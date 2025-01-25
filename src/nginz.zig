const std = @import("std");

extern fn main_nginx(argn: c_int, args: [*c][*c]const u8) callconv(.C) void;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var args = try std.process.argsWithAllocator(allocator);
    defer args.deinit();

    var args_array = std.ArrayList([*c]const u8).init(allocator);
    defer args_array.deinit();

    while (args.next()) |a| {
        try args_array.append(a.ptr);
    }
    main_nginx(@intCast(args_array.items.len), @ptrCast(args_array.items));
}
