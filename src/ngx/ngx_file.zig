const std = @import("std");
const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");
const expectEqual = std.testing.expectEqual;

const off_t = core.off_t;
const ngx_int_t = core.ngx_int_t;
const ngx_uint_t = core.ngx_uint_t;
const ngx_pool_t = core.ngx_pool_t;

pub const ngx_file_t = ngx.ngx_file_t;
pub const ngx_file_info_t = ngx.ngx_file_info_t;

const NGX_FILE_RDONLY = ngx.NGX_FILE_RDONLY;
const NGX_FILE_WRONLY = ngx.NGX_FILE_WRONLY;
const NGX_FILE_RDWR = ngx.NGX_FILE_RDWR;

pub const ngx_fd_info = ngx.ngx_fd_info;
pub const ngx_file_size = ngx.ngx_file_size;
pub const ngx_read_file = ngx.ngx_read_file;
pub const ngx_write_file = ngx.ngx_write_file;
pub const ngx_open_tempfile = ngx.ngx_open_tempfile;

test "file" {
    try expectEqual(@sizeOf(ngx_file_t), 200);
}
