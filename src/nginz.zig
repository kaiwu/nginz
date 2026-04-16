const std = @import("std");

extern fn main_nginx(argn: c_int, args: [*c][*c]const u8) callconv(.c) void;

pub fn main(init: std.process.Init) !void {
    var args = init.minimal.args.iterate();
    defer args.deinit();

    var args_array = std.array_list.Managed([*c]const u8).init(init.gpa);
    defer args_array.deinit();

    while (args.next()) |a| {
        try args_array.append(a.ptr);
    }
    main_nginx(@intCast(args_array.items.len), @ptrCast(args_array.items));
}
