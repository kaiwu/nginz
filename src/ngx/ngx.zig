pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_labs = @import("std").zig.c_builtins.__builtin_labs;
pub const __builtin_llabs = @import("std").zig.c_builtins.__builtin_llabs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const u_char = __u_char;
pub const u_short = __u_short;
pub const u_int = __u_int;
pub const u_long = __u_long;
pub const quad_t = __quad_t;
pub const u_quad_t = __u_quad_t;
pub const fsid_t = __fsid_t;
pub const loff_t = __loff_t;
pub const ino_t = __ino64_t;
pub const ino64_t = __ino64_t;
pub const dev_t = __dev_t;
pub const gid_t = __gid_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const uid_t = __uid_t;
pub const off_t = __off64_t;
pub const off64_t = __off64_t;
pub const pid_t = __pid_t;
pub const id_t = __id_t;
pub const daddr_t = __daddr_t;
pub const caddr_t = __caddr_t;
pub const key_t = __key_t;
pub const clock_t = __clock_t;
pub const clockid_t = __clockid_t;
pub const time_t = __time_t;
pub const timer_t = __timer_t;
pub const useconds_t = __useconds_t;
pub const suseconds_t = __suseconds_t;
pub const ulong = c_ulong;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const register_t = c_long;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.C) __uint16_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @as(__uint16_t, @bitCast(@as(c_short, @truncate(((@as(c_int, @bitCast(@as(c_uint, __bsx))) >> @intCast(8)) & @as(c_int, 255)) | ((@as(c_int, @bitCast(@as(c_uint, __bsx))) & @as(c_int, 255)) << @intCast(8))))));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.C) __uint32_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return ((((__bsx & @as(c_uint, 4278190080)) >> @intCast(24)) | ((__bsx & @as(c_uint, 16711680)) >> @intCast(8))) | ((__bsx & @as(c_uint, 65280)) << @intCast(8))) | ((__bsx & @as(c_uint, 255)) << @intCast(24));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.C) __uint64_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @as(__uint64_t, @bitCast(@as(c_ulong, @truncate(((((((((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 18374686479671623680)) >> @intCast(56)) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 71776119061217280)) >> @intCast(40))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 280375465082880)) >> @intCast(24))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 1095216660480)) >> @intCast(8))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 4278190080)) << @intCast(8))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 16711680)) << @intCast(24))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 65280)) << @intCast(40))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 255)) << @intCast(56))))));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.C) __uint16_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.C) __uint32_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.C) __uint64_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub const __sigset_t = extern struct {
    __val: [16]c_ulong = @import("std").mem.zeroes([16]c_ulong),
};
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t = @import("std").mem.zeroes(__time_t),
    tv_usec: __suseconds_t = @import("std").mem.zeroes(__suseconds_t),
};
pub const struct_timespec = extern struct {
    tv_sec: __time_t = @import("std").mem.zeroes(__time_t),
    tv_nsec: __syscall_slong_t = @import("std").mem.zeroes(__syscall_slong_t),
};
pub const __fd_mask = c_long;
pub const fd_set = extern struct {
    fds_bits: [16]__fd_mask = @import("std").mem.zeroes([16]__fd_mask),
};
pub const fd_mask = __fd_mask;
pub extern fn select(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]struct_timeval) c_int;
pub extern fn pselect(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]const struct_timespec, noalias __sigmask: [*c]const __sigset_t) c_int;
pub const blksize_t = __blksize_t;
pub const blkcnt_t = __blkcnt64_t;
pub const fsblkcnt_t = __fsblkcnt64_t;
pub const fsfilcnt_t = __fsfilcnt64_t;
pub const blkcnt64_t = __blkcnt64_t;
pub const fsblkcnt64_t = __fsblkcnt64_t;
pub const fsfilcnt64_t = __fsfilcnt64_t;
const struct_unnamed_1 = extern struct {
    __low: c_uint = @import("std").mem.zeroes(c_uint),
    __high: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const __atomic_wide_counter = extern union {
    __value64: c_ulonglong,
    __value32: struct_unnamed_1,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list = @import("std").mem.zeroes([*c]struct___pthread_internal_list),
    __next: [*c]struct___pthread_internal_list = @import("std").mem.zeroes([*c]struct___pthread_internal_list),
};
pub const __pthread_list_t = struct___pthread_internal_list;
pub const struct___pthread_internal_slist = extern struct {
    __next: [*c]struct___pthread_internal_slist = @import("std").mem.zeroes([*c]struct___pthread_internal_slist),
};
pub const __pthread_slist_t = struct___pthread_internal_slist;
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int = @import("std").mem.zeroes(c_int),
    __count: c_uint = @import("std").mem.zeroes(c_uint),
    __owner: c_int = @import("std").mem.zeroes(c_int),
    __nusers: c_uint = @import("std").mem.zeroes(c_uint),
    __kind: c_int = @import("std").mem.zeroes(c_int),
    __spins: c_short = @import("std").mem.zeroes(c_short),
    __elision: c_short = @import("std").mem.zeroes(c_short),
    __list: __pthread_list_t = @import("std").mem.zeroes(__pthread_list_t),
};
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint = @import("std").mem.zeroes(c_uint),
    __writers: c_uint = @import("std").mem.zeroes(c_uint),
    __wrphase_futex: c_uint = @import("std").mem.zeroes(c_uint),
    __writers_futex: c_uint = @import("std").mem.zeroes(c_uint),
    __pad3: c_uint = @import("std").mem.zeroes(c_uint),
    __pad4: c_uint = @import("std").mem.zeroes(c_uint),
    __cur_writer: c_int = @import("std").mem.zeroes(c_int),
    __shared: c_int = @import("std").mem.zeroes(c_int),
    __rwelision: i8 = @import("std").mem.zeroes(i8),
    __pad1: [7]u8 = @import("std").mem.zeroes([7]u8),
    __pad2: c_ulong = @import("std").mem.zeroes(c_ulong),
    __flags: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const struct___pthread_cond_s = extern struct {
    __wseq: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g1_start: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g_refs: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g_size: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g1_orig_size: c_uint = @import("std").mem.zeroes(c_uint),
    __wrefs: c_uint = @import("std").mem.zeroes(c_uint),
    __g_signals: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
};
pub const __tss_t = c_uint;
pub const __thrd_t = c_ulong;
pub const __once_flag = extern struct {
    __data: c_int = @import("std").mem.zeroes(c_int),
};
pub const pthread_t = c_ulong;
pub const pthread_mutexattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_condattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_attr_t = union_pthread_attr_t;
pub const pthread_mutex_t = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
};
pub const pthread_cond_t = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
};
pub const pthread_rwlock_t = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_rwlockattr_t = extern union {
    __size: [8]u8,
    __align: c_long,
};
pub const pthread_spinlock_t = c_int;
pub const pthread_barrier_t = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub const pthread_barrierattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const struct_timezone = extern struct {
    tz_minuteswest: c_int = @import("std").mem.zeroes(c_int),
    tz_dsttime: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn gettimeofday(noalias __tv: [*c]struct_timeval, noalias __tz: ?*anyopaque) c_int;
pub extern fn settimeofday(__tv: [*c]const struct_timeval, __tz: [*c]const struct_timezone) c_int;
pub extern fn adjtime(__delta: [*c]const struct_timeval, __olddelta: [*c]struct_timeval) c_int;
pub const ITIMER_REAL: c_int = 0;
pub const ITIMER_VIRTUAL: c_int = 1;
pub const ITIMER_PROF: c_int = 2;
pub const enum___itimer_which = c_uint;
pub const struct_itimerval = extern struct {
    it_interval: struct_timeval = @import("std").mem.zeroes(struct_timeval),
    it_value: struct_timeval = @import("std").mem.zeroes(struct_timeval),
};
pub const __itimer_which_t = enum___itimer_which;
pub extern fn getitimer(__which: __itimer_which_t, __value: [*c]struct_itimerval) c_int;
pub extern fn setitimer(__which: __itimer_which_t, noalias __new: [*c]const struct_itimerval, noalias __old: [*c]struct_itimerval) c_int;
pub extern fn utimes(__file: [*c]const u8, __tvp: [*c]const struct_timeval) c_int;
pub extern fn lutimes(__file: [*c]const u8, __tvp: [*c]const struct_timeval) c_int;
pub extern fn futimes(__fd: c_int, __tvp: [*c]const struct_timeval) c_int;
pub extern fn futimesat(__fd: c_int, __file: [*c]const u8, __tvp: [*c]const struct_timeval) c_int;
pub const socklen_t = __socklen_t;
pub extern fn access(__name: [*c]const u8, __type: c_int) c_int;
pub extern fn euidaccess(__name: [*c]const u8, __type: c_int) c_int;
pub extern fn eaccess(__name: [*c]const u8, __type: c_int) c_int;
pub extern fn execveat(__fd: c_int, __path: [*c]const u8, __argv: [*c]const [*c]u8, __envp: [*c]const [*c]u8, __flags: c_int) c_int;
pub extern fn faccessat(__fd: c_int, __file: [*c]const u8, __type: c_int, __flag: c_int) c_int;
pub extern fn lseek(__fd: c_int, __offset: __off64_t, __whence: c_int) __off64_t;
pub extern fn lseek64(__fd: c_int, __offset: __off64_t, __whence: c_int) __off64_t;
pub extern fn close(__fd: c_int) c_int;
pub extern fn closefrom(__lowfd: c_int) void;
pub extern fn read(__fd: c_int, __buf: ?*anyopaque, __nbytes: usize) isize;
pub extern fn write(__fd: c_int, __buf: ?*const anyopaque, __n: usize) isize;
pub extern fn pread(__fd: c_int, __buf: ?*anyopaque, __nbytes: usize, __offset: __off64_t) isize;
pub extern fn pwrite(__fd: c_int, __buf: ?*const anyopaque, __nbytes: usize, __offset: __off64_t) isize;
pub extern fn pread64(__fd: c_int, __buf: ?*anyopaque, __nbytes: usize, __offset: __off64_t) isize;
pub extern fn pwrite64(__fd: c_int, __buf: ?*const anyopaque, __n: usize, __offset: __off64_t) isize;
pub extern fn pipe(__pipedes: [*c]c_int) c_int;
pub extern fn pipe2(__pipedes: [*c]c_int, __flags: c_int) c_int;
pub extern fn alarm(__seconds: c_uint) c_uint;
pub extern fn sleep(__seconds: c_uint) c_uint;
pub extern fn ualarm(__value: __useconds_t, __interval: __useconds_t) __useconds_t;
pub extern fn usleep(__useconds: __useconds_t) c_int;
pub extern fn pause() c_int;
pub extern fn chown(__file: [*c]const u8, __owner: __uid_t, __group: __gid_t) c_int;
pub extern fn fchown(__fd: c_int, __owner: __uid_t, __group: __gid_t) c_int;
pub extern fn lchown(__file: [*c]const u8, __owner: __uid_t, __group: __gid_t) c_int;
pub extern fn fchownat(__fd: c_int, __file: [*c]const u8, __owner: __uid_t, __group: __gid_t, __flag: c_int) c_int;
pub extern fn chdir(__path: [*c]const u8) c_int;
pub extern fn fchdir(__fd: c_int) c_int;
pub extern fn getcwd(__buf: [*c]u8, __size: usize) [*c]u8;
pub extern fn get_current_dir_name() [*c]u8;
pub extern fn getwd(__buf: [*c]u8) [*c]u8;
pub extern fn dup(__fd: c_int) c_int;
pub extern fn dup2(__fd: c_int, __fd2: c_int) c_int;
pub extern fn dup3(__fd: c_int, __fd2: c_int, __flags: c_int) c_int;
pub extern var __environ: [*c][*c]u8;
pub extern var environ: [*c][*c]u8;
pub extern fn execve(__path: [*c]const u8, __argv: [*c]const [*c]u8, __envp: [*c]const [*c]u8) c_int;
pub extern fn fexecve(__fd: c_int, __argv: [*c]const [*c]u8, __envp: [*c]const [*c]u8) c_int;
pub extern fn execv(__path: [*c]const u8, __argv: [*c]const [*c]u8) c_int;
pub extern fn execle(__path: [*c]const u8, __arg: [*c]const u8, ...) c_int;
pub extern fn execl(__path: [*c]const u8, __arg: [*c]const u8, ...) c_int;
pub extern fn execvp(__file: [*c]const u8, __argv: [*c]const [*c]u8) c_int;
pub extern fn execlp(__file: [*c]const u8, __arg: [*c]const u8, ...) c_int;
pub extern fn execvpe(__file: [*c]const u8, __argv: [*c]const [*c]u8, __envp: [*c]const [*c]u8) c_int;
pub extern fn nice(__inc: c_int) c_int;
pub extern fn _exit(__status: c_int) noreturn;
pub const _PC_LINK_MAX: c_int = 0;
pub const _PC_MAX_CANON: c_int = 1;
pub const _PC_MAX_INPUT: c_int = 2;
pub const _PC_NAME_MAX: c_int = 3;
pub const _PC_PATH_MAX: c_int = 4;
pub const _PC_PIPE_BUF: c_int = 5;
pub const _PC_CHOWN_RESTRICTED: c_int = 6;
pub const _PC_NO_TRUNC: c_int = 7;
pub const _PC_VDISABLE: c_int = 8;
pub const _PC_SYNC_IO: c_int = 9;
pub const _PC_ASYNC_IO: c_int = 10;
pub const _PC_PRIO_IO: c_int = 11;
pub const _PC_SOCK_MAXBUF: c_int = 12;
pub const _PC_FILESIZEBITS: c_int = 13;
pub const _PC_REC_INCR_XFER_SIZE: c_int = 14;
pub const _PC_REC_MAX_XFER_SIZE: c_int = 15;
pub const _PC_REC_MIN_XFER_SIZE: c_int = 16;
pub const _PC_REC_XFER_ALIGN: c_int = 17;
pub const _PC_ALLOC_SIZE_MIN: c_int = 18;
pub const _PC_SYMLINK_MAX: c_int = 19;
pub const _PC_2_SYMLINKS: c_int = 20;
const enum_unnamed_2 = c_uint;
pub const _SC_ARG_MAX: c_int = 0;
pub const _SC_CHILD_MAX: c_int = 1;
pub const _SC_CLK_TCK: c_int = 2;
pub const _SC_NGROUPS_MAX: c_int = 3;
pub const _SC_OPEN_MAX: c_int = 4;
pub const _SC_STREAM_MAX: c_int = 5;
pub const _SC_TZNAME_MAX: c_int = 6;
pub const _SC_JOB_CONTROL: c_int = 7;
pub const _SC_SAVED_IDS: c_int = 8;
pub const _SC_REALTIME_SIGNALS: c_int = 9;
pub const _SC_PRIORITY_SCHEDULING: c_int = 10;
pub const _SC_TIMERS: c_int = 11;
pub const _SC_ASYNCHRONOUS_IO: c_int = 12;
pub const _SC_PRIORITIZED_IO: c_int = 13;
pub const _SC_SYNCHRONIZED_IO: c_int = 14;
pub const _SC_FSYNC: c_int = 15;
pub const _SC_MAPPED_FILES: c_int = 16;
pub const _SC_MEMLOCK: c_int = 17;
pub const _SC_MEMLOCK_RANGE: c_int = 18;
pub const _SC_MEMORY_PROTECTION: c_int = 19;
pub const _SC_MESSAGE_PASSING: c_int = 20;
pub const _SC_SEMAPHORES: c_int = 21;
pub const _SC_SHARED_MEMORY_OBJECTS: c_int = 22;
pub const _SC_AIO_LISTIO_MAX: c_int = 23;
pub const _SC_AIO_MAX: c_int = 24;
pub const _SC_AIO_PRIO_DELTA_MAX: c_int = 25;
pub const _SC_DELAYTIMER_MAX: c_int = 26;
pub const _SC_MQ_OPEN_MAX: c_int = 27;
pub const _SC_MQ_PRIO_MAX: c_int = 28;
pub const _SC_VERSION: c_int = 29;
pub const _SC_PAGESIZE: c_int = 30;
pub const _SC_RTSIG_MAX: c_int = 31;
pub const _SC_SEM_NSEMS_MAX: c_int = 32;
pub const _SC_SEM_VALUE_MAX: c_int = 33;
pub const _SC_SIGQUEUE_MAX: c_int = 34;
pub const _SC_TIMER_MAX: c_int = 35;
pub const _SC_BC_BASE_MAX: c_int = 36;
pub const _SC_BC_DIM_MAX: c_int = 37;
pub const _SC_BC_SCALE_MAX: c_int = 38;
pub const _SC_BC_STRING_MAX: c_int = 39;
pub const _SC_COLL_WEIGHTS_MAX: c_int = 40;
pub const _SC_EQUIV_CLASS_MAX: c_int = 41;
pub const _SC_EXPR_NEST_MAX: c_int = 42;
pub const _SC_LINE_MAX: c_int = 43;
pub const _SC_RE_DUP_MAX: c_int = 44;
pub const _SC_CHARCLASS_NAME_MAX: c_int = 45;
pub const _SC_2_VERSION: c_int = 46;
pub const _SC_2_C_BIND: c_int = 47;
pub const _SC_2_C_DEV: c_int = 48;
pub const _SC_2_FORT_DEV: c_int = 49;
pub const _SC_2_FORT_RUN: c_int = 50;
pub const _SC_2_SW_DEV: c_int = 51;
pub const _SC_2_LOCALEDEF: c_int = 52;
pub const _SC_PII: c_int = 53;
pub const _SC_PII_XTI: c_int = 54;
pub const _SC_PII_SOCKET: c_int = 55;
pub const _SC_PII_INTERNET: c_int = 56;
pub const _SC_PII_OSI: c_int = 57;
pub const _SC_POLL: c_int = 58;
pub const _SC_SELECT: c_int = 59;
pub const _SC_UIO_MAXIOV: c_int = 60;
pub const _SC_IOV_MAX: c_int = 60;
pub const _SC_PII_INTERNET_STREAM: c_int = 61;
pub const _SC_PII_INTERNET_DGRAM: c_int = 62;
pub const _SC_PII_OSI_COTS: c_int = 63;
pub const _SC_PII_OSI_CLTS: c_int = 64;
pub const _SC_PII_OSI_M: c_int = 65;
pub const _SC_T_IOV_MAX: c_int = 66;
pub const _SC_THREADS: c_int = 67;
pub const _SC_THREAD_SAFE_FUNCTIONS: c_int = 68;
pub const _SC_GETGR_R_SIZE_MAX: c_int = 69;
pub const _SC_GETPW_R_SIZE_MAX: c_int = 70;
pub const _SC_LOGIN_NAME_MAX: c_int = 71;
pub const _SC_TTY_NAME_MAX: c_int = 72;
pub const _SC_THREAD_DESTRUCTOR_ITERATIONS: c_int = 73;
pub const _SC_THREAD_KEYS_MAX: c_int = 74;
pub const _SC_THREAD_STACK_MIN: c_int = 75;
pub const _SC_THREAD_THREADS_MAX: c_int = 76;
pub const _SC_THREAD_ATTR_STACKADDR: c_int = 77;
pub const _SC_THREAD_ATTR_STACKSIZE: c_int = 78;
pub const _SC_THREAD_PRIORITY_SCHEDULING: c_int = 79;
pub const _SC_THREAD_PRIO_INHERIT: c_int = 80;
pub const _SC_THREAD_PRIO_PROTECT: c_int = 81;
pub const _SC_THREAD_PROCESS_SHARED: c_int = 82;
pub const _SC_NPROCESSORS_CONF: c_int = 83;
pub const _SC_NPROCESSORS_ONLN: c_int = 84;
pub const _SC_PHYS_PAGES: c_int = 85;
pub const _SC_AVPHYS_PAGES: c_int = 86;
pub const _SC_ATEXIT_MAX: c_int = 87;
pub const _SC_PASS_MAX: c_int = 88;
pub const _SC_XOPEN_VERSION: c_int = 89;
pub const _SC_XOPEN_XCU_VERSION: c_int = 90;
pub const _SC_XOPEN_UNIX: c_int = 91;
pub const _SC_XOPEN_CRYPT: c_int = 92;
pub const _SC_XOPEN_ENH_I18N: c_int = 93;
pub const _SC_XOPEN_SHM: c_int = 94;
pub const _SC_2_CHAR_TERM: c_int = 95;
pub const _SC_2_C_VERSION: c_int = 96;
pub const _SC_2_UPE: c_int = 97;
pub const _SC_XOPEN_XPG2: c_int = 98;
pub const _SC_XOPEN_XPG3: c_int = 99;
pub const _SC_XOPEN_XPG4: c_int = 100;
pub const _SC_CHAR_BIT: c_int = 101;
pub const _SC_CHAR_MAX: c_int = 102;
pub const _SC_CHAR_MIN: c_int = 103;
pub const _SC_INT_MAX: c_int = 104;
pub const _SC_INT_MIN: c_int = 105;
pub const _SC_LONG_BIT: c_int = 106;
pub const _SC_WORD_BIT: c_int = 107;
pub const _SC_MB_LEN_MAX: c_int = 108;
pub const _SC_NZERO: c_int = 109;
pub const _SC_SSIZE_MAX: c_int = 110;
pub const _SC_SCHAR_MAX: c_int = 111;
pub const _SC_SCHAR_MIN: c_int = 112;
pub const _SC_SHRT_MAX: c_int = 113;
pub const _SC_SHRT_MIN: c_int = 114;
pub const _SC_UCHAR_MAX: c_int = 115;
pub const _SC_UINT_MAX: c_int = 116;
pub const _SC_ULONG_MAX: c_int = 117;
pub const _SC_USHRT_MAX: c_int = 118;
pub const _SC_NL_ARGMAX: c_int = 119;
pub const _SC_NL_LANGMAX: c_int = 120;
pub const _SC_NL_MSGMAX: c_int = 121;
pub const _SC_NL_NMAX: c_int = 122;
pub const _SC_NL_SETMAX: c_int = 123;
pub const _SC_NL_TEXTMAX: c_int = 124;
pub const _SC_XBS5_ILP32_OFF32: c_int = 125;
pub const _SC_XBS5_ILP32_OFFBIG: c_int = 126;
pub const _SC_XBS5_LP64_OFF64: c_int = 127;
pub const _SC_XBS5_LPBIG_OFFBIG: c_int = 128;
pub const _SC_XOPEN_LEGACY: c_int = 129;
pub const _SC_XOPEN_REALTIME: c_int = 130;
pub const _SC_XOPEN_REALTIME_THREADS: c_int = 131;
pub const _SC_ADVISORY_INFO: c_int = 132;
pub const _SC_BARRIERS: c_int = 133;
pub const _SC_BASE: c_int = 134;
pub const _SC_C_LANG_SUPPORT: c_int = 135;
pub const _SC_C_LANG_SUPPORT_R: c_int = 136;
pub const _SC_CLOCK_SELECTION: c_int = 137;
pub const _SC_CPUTIME: c_int = 138;
pub const _SC_THREAD_CPUTIME: c_int = 139;
pub const _SC_DEVICE_IO: c_int = 140;
pub const _SC_DEVICE_SPECIFIC: c_int = 141;
pub const _SC_DEVICE_SPECIFIC_R: c_int = 142;
pub const _SC_FD_MGMT: c_int = 143;
pub const _SC_FIFO: c_int = 144;
pub const _SC_PIPE: c_int = 145;
pub const _SC_FILE_ATTRIBUTES: c_int = 146;
pub const _SC_FILE_LOCKING: c_int = 147;
pub const _SC_FILE_SYSTEM: c_int = 148;
pub const _SC_MONOTONIC_CLOCK: c_int = 149;
pub const _SC_MULTI_PROCESS: c_int = 150;
pub const _SC_SINGLE_PROCESS: c_int = 151;
pub const _SC_NETWORKING: c_int = 152;
pub const _SC_READER_WRITER_LOCKS: c_int = 153;
pub const _SC_SPIN_LOCKS: c_int = 154;
pub const _SC_REGEXP: c_int = 155;
pub const _SC_REGEX_VERSION: c_int = 156;
pub const _SC_SHELL: c_int = 157;
pub const _SC_SIGNALS: c_int = 158;
pub const _SC_SPAWN: c_int = 159;
pub const _SC_SPORADIC_SERVER: c_int = 160;
pub const _SC_THREAD_SPORADIC_SERVER: c_int = 161;
pub const _SC_SYSTEM_DATABASE: c_int = 162;
pub const _SC_SYSTEM_DATABASE_R: c_int = 163;
pub const _SC_TIMEOUTS: c_int = 164;
pub const _SC_TYPED_MEMORY_OBJECTS: c_int = 165;
pub const _SC_USER_GROUPS: c_int = 166;
pub const _SC_USER_GROUPS_R: c_int = 167;
pub const _SC_2_PBS: c_int = 168;
pub const _SC_2_PBS_ACCOUNTING: c_int = 169;
pub const _SC_2_PBS_LOCATE: c_int = 170;
pub const _SC_2_PBS_MESSAGE: c_int = 171;
pub const _SC_2_PBS_TRACK: c_int = 172;
pub const _SC_SYMLOOP_MAX: c_int = 173;
pub const _SC_STREAMS: c_int = 174;
pub const _SC_2_PBS_CHECKPOINT: c_int = 175;
pub const _SC_V6_ILP32_OFF32: c_int = 176;
pub const _SC_V6_ILP32_OFFBIG: c_int = 177;
pub const _SC_V6_LP64_OFF64: c_int = 178;
pub const _SC_V6_LPBIG_OFFBIG: c_int = 179;
pub const _SC_HOST_NAME_MAX: c_int = 180;
pub const _SC_TRACE: c_int = 181;
pub const _SC_TRACE_EVENT_FILTER: c_int = 182;
pub const _SC_TRACE_INHERIT: c_int = 183;
pub const _SC_TRACE_LOG: c_int = 184;
pub const _SC_LEVEL1_ICACHE_SIZE: c_int = 185;
pub const _SC_LEVEL1_ICACHE_ASSOC: c_int = 186;
pub const _SC_LEVEL1_ICACHE_LINESIZE: c_int = 187;
pub const _SC_LEVEL1_DCACHE_SIZE: c_int = 188;
pub const _SC_LEVEL1_DCACHE_ASSOC: c_int = 189;
pub const _SC_LEVEL1_DCACHE_LINESIZE: c_int = 190;
pub const _SC_LEVEL2_CACHE_SIZE: c_int = 191;
pub const _SC_LEVEL2_CACHE_ASSOC: c_int = 192;
pub const _SC_LEVEL2_CACHE_LINESIZE: c_int = 193;
pub const _SC_LEVEL3_CACHE_SIZE: c_int = 194;
pub const _SC_LEVEL3_CACHE_ASSOC: c_int = 195;
pub const _SC_LEVEL3_CACHE_LINESIZE: c_int = 196;
pub const _SC_LEVEL4_CACHE_SIZE: c_int = 197;
pub const _SC_LEVEL4_CACHE_ASSOC: c_int = 198;
pub const _SC_LEVEL4_CACHE_LINESIZE: c_int = 199;
pub const _SC_IPV6: c_int = 235;
pub const _SC_RAW_SOCKETS: c_int = 236;
pub const _SC_V7_ILP32_OFF32: c_int = 237;
pub const _SC_V7_ILP32_OFFBIG: c_int = 238;
pub const _SC_V7_LP64_OFF64: c_int = 239;
pub const _SC_V7_LPBIG_OFFBIG: c_int = 240;
pub const _SC_SS_REPL_MAX: c_int = 241;
pub const _SC_TRACE_EVENT_NAME_MAX: c_int = 242;
pub const _SC_TRACE_NAME_MAX: c_int = 243;
pub const _SC_TRACE_SYS_MAX: c_int = 244;
pub const _SC_TRACE_USER_EVENT_MAX: c_int = 245;
pub const _SC_XOPEN_STREAMS: c_int = 246;
pub const _SC_THREAD_ROBUST_PRIO_INHERIT: c_int = 247;
pub const _SC_THREAD_ROBUST_PRIO_PROTECT: c_int = 248;
pub const _SC_MINSIGSTKSZ: c_int = 249;
pub const _SC_SIGSTKSZ: c_int = 250;
const enum_unnamed_3 = c_uint;
pub const _CS_PATH: c_int = 0;
pub const _CS_V6_WIDTH_RESTRICTED_ENVS: c_int = 1;
pub const _CS_GNU_LIBC_VERSION: c_int = 2;
pub const _CS_GNU_LIBPTHREAD_VERSION: c_int = 3;
pub const _CS_V5_WIDTH_RESTRICTED_ENVS: c_int = 4;
pub const _CS_V7_WIDTH_RESTRICTED_ENVS: c_int = 5;
pub const _CS_LFS_CFLAGS: c_int = 1000;
pub const _CS_LFS_LDFLAGS: c_int = 1001;
pub const _CS_LFS_LIBS: c_int = 1002;
pub const _CS_LFS_LINTFLAGS: c_int = 1003;
pub const _CS_LFS64_CFLAGS: c_int = 1004;
pub const _CS_LFS64_LDFLAGS: c_int = 1005;
pub const _CS_LFS64_LIBS: c_int = 1006;
pub const _CS_LFS64_LINTFLAGS: c_int = 1007;
pub const _CS_XBS5_ILP32_OFF32_CFLAGS: c_int = 1100;
pub const _CS_XBS5_ILP32_OFF32_LDFLAGS: c_int = 1101;
pub const _CS_XBS5_ILP32_OFF32_LIBS: c_int = 1102;
pub const _CS_XBS5_ILP32_OFF32_LINTFLAGS: c_int = 1103;
pub const _CS_XBS5_ILP32_OFFBIG_CFLAGS: c_int = 1104;
pub const _CS_XBS5_ILP32_OFFBIG_LDFLAGS: c_int = 1105;
pub const _CS_XBS5_ILP32_OFFBIG_LIBS: c_int = 1106;
pub const _CS_XBS5_ILP32_OFFBIG_LINTFLAGS: c_int = 1107;
pub const _CS_XBS5_LP64_OFF64_CFLAGS: c_int = 1108;
pub const _CS_XBS5_LP64_OFF64_LDFLAGS: c_int = 1109;
pub const _CS_XBS5_LP64_OFF64_LIBS: c_int = 1110;
pub const _CS_XBS5_LP64_OFF64_LINTFLAGS: c_int = 1111;
pub const _CS_XBS5_LPBIG_OFFBIG_CFLAGS: c_int = 1112;
pub const _CS_XBS5_LPBIG_OFFBIG_LDFLAGS: c_int = 1113;
pub const _CS_XBS5_LPBIG_OFFBIG_LIBS: c_int = 1114;
pub const _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS: c_int = 1115;
pub const _CS_POSIX_V6_ILP32_OFF32_CFLAGS: c_int = 1116;
pub const _CS_POSIX_V6_ILP32_OFF32_LDFLAGS: c_int = 1117;
pub const _CS_POSIX_V6_ILP32_OFF32_LIBS: c_int = 1118;
pub const _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS: c_int = 1119;
pub const _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS: c_int = 1120;
pub const _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS: c_int = 1121;
pub const _CS_POSIX_V6_ILP32_OFFBIG_LIBS: c_int = 1122;
pub const _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS: c_int = 1123;
pub const _CS_POSIX_V6_LP64_OFF64_CFLAGS: c_int = 1124;
pub const _CS_POSIX_V6_LP64_OFF64_LDFLAGS: c_int = 1125;
pub const _CS_POSIX_V6_LP64_OFF64_LIBS: c_int = 1126;
pub const _CS_POSIX_V6_LP64_OFF64_LINTFLAGS: c_int = 1127;
pub const _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS: c_int = 1128;
pub const _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS: c_int = 1129;
pub const _CS_POSIX_V6_LPBIG_OFFBIG_LIBS: c_int = 1130;
pub const _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS: c_int = 1131;
pub const _CS_POSIX_V7_ILP32_OFF32_CFLAGS: c_int = 1132;
pub const _CS_POSIX_V7_ILP32_OFF32_LDFLAGS: c_int = 1133;
pub const _CS_POSIX_V7_ILP32_OFF32_LIBS: c_int = 1134;
pub const _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS: c_int = 1135;
pub const _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS: c_int = 1136;
pub const _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS: c_int = 1137;
pub const _CS_POSIX_V7_ILP32_OFFBIG_LIBS: c_int = 1138;
pub const _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS: c_int = 1139;
pub const _CS_POSIX_V7_LP64_OFF64_CFLAGS: c_int = 1140;
pub const _CS_POSIX_V7_LP64_OFF64_LDFLAGS: c_int = 1141;
pub const _CS_POSIX_V7_LP64_OFF64_LIBS: c_int = 1142;
pub const _CS_POSIX_V7_LP64_OFF64_LINTFLAGS: c_int = 1143;
pub const _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS: c_int = 1144;
pub const _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS: c_int = 1145;
pub const _CS_POSIX_V7_LPBIG_OFFBIG_LIBS: c_int = 1146;
pub const _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS: c_int = 1147;
pub const _CS_V6_ENV: c_int = 1148;
pub const _CS_V7_ENV: c_int = 1149;
const enum_unnamed_4 = c_uint;
pub extern fn pathconf(__path: [*c]const u8, __name: c_int) c_long;
pub extern fn fpathconf(__fd: c_int, __name: c_int) c_long;
pub extern fn sysconf(__name: c_int) c_long;
pub extern fn confstr(__name: c_int, __buf: [*c]u8, __len: usize) usize;
pub extern fn getpid() __pid_t;
pub extern fn getppid() __pid_t;
pub extern fn getpgrp() __pid_t;
pub extern fn __getpgid(__pid: __pid_t) __pid_t;
pub extern fn getpgid(__pid: __pid_t) __pid_t;
pub extern fn setpgid(__pid: __pid_t, __pgid: __pid_t) c_int;
pub extern fn setpgrp() c_int;
pub extern fn setsid() __pid_t;
pub extern fn getsid(__pid: __pid_t) __pid_t;
pub extern fn getuid() __uid_t;
pub extern fn geteuid() __uid_t;
pub extern fn getgid() __gid_t;
pub extern fn getegid() __gid_t;
pub extern fn getgroups(__size: c_int, __list: [*c]__gid_t) c_int;
pub extern fn group_member(__gid: __gid_t) c_int;
pub extern fn setuid(__uid: __uid_t) c_int;
pub extern fn setreuid(__ruid: __uid_t, __euid: __uid_t) c_int;
pub extern fn seteuid(__uid: __uid_t) c_int;
pub extern fn setgid(__gid: __gid_t) c_int;
pub extern fn setregid(__rgid: __gid_t, __egid: __gid_t) c_int;
pub extern fn setegid(__gid: __gid_t) c_int;
pub extern fn getresuid(__ruid: [*c]__uid_t, __euid: [*c]__uid_t, __suid: [*c]__uid_t) c_int;
pub extern fn getresgid(__rgid: [*c]__gid_t, __egid: [*c]__gid_t, __sgid: [*c]__gid_t) c_int;
pub extern fn setresuid(__ruid: __uid_t, __euid: __uid_t, __suid: __uid_t) c_int;
pub extern fn setresgid(__rgid: __gid_t, __egid: __gid_t, __sgid: __gid_t) c_int;
pub extern fn fork() __pid_t;
pub extern fn vfork() c_int;
pub extern fn _Fork() __pid_t;
pub extern fn ttyname(__fd: c_int) [*c]u8;
pub extern fn ttyname_r(__fd: c_int, __buf: [*c]u8, __buflen: usize) c_int;
pub extern fn isatty(__fd: c_int) c_int;
pub extern fn ttyslot() c_int;
pub extern fn link(__from: [*c]const u8, __to: [*c]const u8) c_int;
pub extern fn linkat(__fromfd: c_int, __from: [*c]const u8, __tofd: c_int, __to: [*c]const u8, __flags: c_int) c_int;
pub extern fn symlink(__from: [*c]const u8, __to: [*c]const u8) c_int;
pub extern fn readlink(noalias __path: [*c]const u8, noalias __buf: [*c]u8, __len: usize) isize;
pub extern fn symlinkat(__from: [*c]const u8, __tofd: c_int, __to: [*c]const u8) c_int;
pub extern fn readlinkat(__fd: c_int, noalias __path: [*c]const u8, noalias __buf: [*c]u8, __len: usize) isize;
pub extern fn unlink(__name: [*c]const u8) c_int;
pub extern fn unlinkat(__fd: c_int, __name: [*c]const u8, __flag: c_int) c_int;
pub extern fn rmdir(__path: [*c]const u8) c_int;
pub extern fn tcgetpgrp(__fd: c_int) __pid_t;
pub extern fn tcsetpgrp(__fd: c_int, __pgrp_id: __pid_t) c_int;
pub extern fn getlogin() [*c]u8;
pub extern fn getlogin_r(__name: [*c]u8, __name_len: usize) c_int;
pub extern fn setlogin(__name: [*c]const u8) c_int;
pub extern var optarg: [*c]u8;
pub extern var optind: c_int;
pub extern var opterr: c_int;
pub extern var optopt: c_int;
pub extern fn getopt(___argc: c_int, ___argv: [*c]const [*c]u8, __shortopts: [*c]const u8) c_int;
pub extern fn gethostname(__name: [*c]u8, __len: usize) c_int;
pub extern fn sethostname(__name: [*c]const u8, __len: usize) c_int;
pub extern fn sethostid(__id: c_long) c_int;
pub extern fn getdomainname(__name: [*c]u8, __len: usize) c_int;
pub extern fn setdomainname(__name: [*c]const u8, __len: usize) c_int;
pub extern fn vhangup() c_int;
pub extern fn revoke(__file: [*c]const u8) c_int;
pub extern fn profil(__sample_buffer: [*c]c_ushort, __size: usize, __offset: usize, __scale: c_uint) c_int;
pub extern fn acct(__name: [*c]const u8) c_int;
pub extern fn getusershell() [*c]u8;
pub extern fn endusershell() void;
pub extern fn setusershell() void;
pub extern fn daemon(__nochdir: c_int, __noclose: c_int) c_int;
pub extern fn chroot(__path: [*c]const u8) c_int;
pub extern fn getpass(__prompt: [*c]const u8) [*c]u8;
pub extern fn fsync(__fd: c_int) c_int;
pub extern fn syncfs(__fd: c_int) c_int;
pub extern fn gethostid() c_long;
pub extern fn sync() void;
pub extern fn getpagesize() c_int;
pub extern fn getdtablesize() c_int;
pub extern fn truncate(__file: [*c]const u8, __length: __off64_t) c_int;
pub extern fn truncate64(__file: [*c]const u8, __length: __off64_t) c_int;
pub extern fn ftruncate(__fd: c_int, __length: __off64_t) c_int;
pub extern fn ftruncate64(__fd: c_int, __length: __off64_t) c_int;
pub extern fn brk(__addr: ?*anyopaque) c_int;
pub extern fn sbrk(__delta: isize) ?*anyopaque;
pub extern fn syscall(__sysno: c_long, ...) c_long;
pub extern fn lockf(__fd: c_int, __cmd: c_int, __len: __off64_t) c_int;
pub extern fn lockf64(__fd: c_int, __cmd: c_int, __len: __off64_t) c_int;
pub extern fn copy_file_range(__infd: c_int, __pinoff: [*c]__off64_t, __outfd: c_int, __poutoff: [*c]__off64_t, __length: usize, __flags: c_uint) isize;
pub extern fn fdatasync(__fildes: c_int) c_int;
pub extern fn crypt(__key: [*c]const u8, __salt: [*c]const u8) [*c]u8;
pub extern fn swab(noalias __from: ?*const anyopaque, noalias __to: ?*anyopaque, __n: isize) void;
pub extern fn getentropy(__buffer: ?*anyopaque, __length: usize) c_int;
pub extern fn close_range(__fd: c_uint, __max_fd: c_uint, __flags: c_int) c_int;
pub extern fn gettid() __pid_t;
pub const struct___va_list_tag_5 = extern struct {
    gp_offset: c_uint = @import("std").mem.zeroes(c_uint),
    fp_offset: c_uint = @import("std").mem.zeroes(c_uint),
    overflow_arg_area: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    reg_save_area: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const __builtin_va_list = [1]struct___va_list_tag_5;
pub const __gnuc_va_list = __builtin_va_list;
pub const va_list = __builtin_va_list;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong align(8) = @import("std").mem.zeroes(c_longlong),
    __clang_max_align_nonce2: c_longdouble align(16) = @import("std").mem.zeroes(c_longdouble),
};
const union_unnamed_6 = extern union {
    __wch: c_uint,
    __wchb: [4]u8,
};
pub const __mbstate_t = extern struct {
    __count: c_int = @import("std").mem.zeroes(c_int),
    __value: union_unnamed_6 = @import("std").mem.zeroes(union_unnamed_6),
};
pub const struct__G_fpos_t = extern struct {
    __pos: __off_t = @import("std").mem.zeroes(__off_t),
    __state: __mbstate_t = @import("std").mem.zeroes(__mbstate_t),
};
pub const __fpos_t = struct__G_fpos_t;
pub const struct__G_fpos64_t = extern struct {
    __pos: __off64_t = @import("std").mem.zeroes(__off64_t),
    __state: __mbstate_t = @import("std").mem.zeroes(__mbstate_t),
};
pub const __fpos64_t = struct__G_fpos64_t;
pub const struct__IO_marker = opaque {};
pub const _IO_lock_t = anyopaque;
pub const struct__IO_codecvt = opaque {};
pub const struct__IO_wide_data = opaque {};
pub const struct__IO_FILE = extern struct {
    _flags: c_int = @import("std").mem.zeroes(c_int),
    _IO_read_ptr: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_read_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_read_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_write_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_write_ptr: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_write_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_buf_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_buf_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_save_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_backup_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_save_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _markers: ?*struct__IO_marker = @import("std").mem.zeroes(?*struct__IO_marker),
    _chain: [*c]struct__IO_FILE = @import("std").mem.zeroes([*c]struct__IO_FILE),
    _fileno: c_int = @import("std").mem.zeroes(c_int),
    _flags2: c_int = @import("std").mem.zeroes(c_int),
    _old_offset: __off_t = @import("std").mem.zeroes(__off_t),
    _cur_column: c_ushort = @import("std").mem.zeroes(c_ushort),
    _vtable_offset: i8 = @import("std").mem.zeroes(i8),
    _shortbuf: [1]u8 = @import("std").mem.zeroes([1]u8),
    _lock: ?*_IO_lock_t = @import("std").mem.zeroes(?*_IO_lock_t),
    _offset: __off64_t = @import("std").mem.zeroes(__off64_t),
    _codecvt: ?*struct__IO_codecvt = @import("std").mem.zeroes(?*struct__IO_codecvt),
    _wide_data: ?*struct__IO_wide_data = @import("std").mem.zeroes(?*struct__IO_wide_data),
    _freeres_list: [*c]struct__IO_FILE = @import("std").mem.zeroes([*c]struct__IO_FILE),
    _freeres_buf: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    _prevchain: [*c][*c]struct__IO_FILE = @import("std").mem.zeroes([*c][*c]struct__IO_FILE),
    _mode: c_int = @import("std").mem.zeroes(c_int),
    _unused2: [20]u8 = @import("std").mem.zeroes([20]u8),
};
pub const __FILE = struct__IO_FILE;
pub const FILE = struct__IO_FILE;
pub const cookie_read_function_t = fn (?*anyopaque, [*c]u8, usize) callconv(.C) __ssize_t;
pub const cookie_write_function_t = fn (?*anyopaque, [*c]const u8, usize) callconv(.C) __ssize_t;
pub const cookie_seek_function_t = fn (?*anyopaque, [*c]__off64_t, c_int) callconv(.C) c_int;
pub const cookie_close_function_t = fn (?*anyopaque) callconv(.C) c_int;
pub const struct__IO_cookie_io_functions_t = extern struct {
    read: ?*const cookie_read_function_t = @import("std").mem.zeroes(?*const cookie_read_function_t),
    write: ?*const cookie_write_function_t = @import("std").mem.zeroes(?*const cookie_write_function_t),
    seek: ?*const cookie_seek_function_t = @import("std").mem.zeroes(?*const cookie_seek_function_t),
    close: ?*const cookie_close_function_t = @import("std").mem.zeroes(?*const cookie_close_function_t),
};
pub const cookie_io_functions_t = struct__IO_cookie_io_functions_t;
pub const fpos_t = __fpos64_t;
pub const fpos64_t = __fpos64_t;
pub extern var stdin: [*c]FILE;
pub extern var stdout: [*c]FILE;
pub extern var stderr: [*c]FILE;
pub extern fn remove(__filename: [*c]const u8) c_int;
pub extern fn rename(__old: [*c]const u8, __new: [*c]const u8) c_int;
pub extern fn renameat(__oldfd: c_int, __old: [*c]const u8, __newfd: c_int, __new: [*c]const u8) c_int;
pub extern fn renameat2(__oldfd: c_int, __old: [*c]const u8, __newfd: c_int, __new: [*c]const u8, __flags: c_uint) c_int;
pub extern fn fclose(__stream: [*c]FILE) c_int;
pub extern fn tmpfile() [*c]FILE;
pub extern fn tmpfile64() [*c]FILE;
pub extern fn tmpnam([*c]u8) [*c]u8;
pub extern fn tmpnam_r(__s: [*c]u8) [*c]u8;
pub extern fn tempnam(__dir: [*c]const u8, __pfx: [*c]const u8) [*c]u8;
pub extern fn fflush(__stream: [*c]FILE) c_int;
pub extern fn fflush_unlocked(__stream: [*c]FILE) c_int;
pub extern fn fcloseall() c_int;
pub extern fn fopen(__filename: [*c]const u8, __modes: [*c]const u8) [*c]FILE;
pub extern fn freopen(noalias __filename: [*c]const u8, noalias __modes: [*c]const u8, noalias __stream: [*c]FILE) [*c]FILE;
pub extern fn fopen64(noalias __filename: [*c]const u8, noalias __modes: [*c]const u8) [*c]FILE;
pub extern fn freopen64(noalias __filename: [*c]const u8, noalias __modes: [*c]const u8, noalias __stream: [*c]FILE) [*c]FILE;
pub extern fn fdopen(__fd: c_int, __modes: [*c]const u8) [*c]FILE;
pub extern fn fopencookie(noalias __magic_cookie: ?*anyopaque, noalias __modes: [*c]const u8, __io_funcs: cookie_io_functions_t) [*c]FILE;
pub extern fn fmemopen(__s: ?*anyopaque, __len: usize, __modes: [*c]const u8) [*c]FILE;
pub extern fn open_memstream(__bufloc: [*c][*c]u8, __sizeloc: [*c]usize) [*c]FILE;
pub extern fn setbuf(noalias __stream: [*c]FILE, noalias __buf: [*c]u8) void;
pub extern fn setvbuf(noalias __stream: [*c]FILE, noalias __buf: [*c]u8, __modes: c_int, __n: usize) c_int;
pub extern fn setbuffer(noalias __stream: [*c]FILE, noalias __buf: [*c]u8, __size: usize) void;
pub extern fn setlinebuf(__stream: [*c]FILE) void;
pub extern fn fprintf(__stream: [*c]FILE, __format: [*c]const u8, ...) c_int;
pub extern fn printf(__format: [*c]const u8, ...) c_int;
pub extern fn sprintf(__s: [*c]u8, __format: [*c]const u8, ...) c_int;
pub extern fn vfprintf(__s: [*c]FILE, __format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn vprintf(__format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn vsprintf(__s: [*c]u8, __format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn snprintf(__s: [*c]u8, __maxlen: c_ulong, __format: [*c]const u8, ...) c_int;
pub extern fn vsnprintf(__s: [*c]u8, __maxlen: c_ulong, __format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn vasprintf(noalias __ptr: [*c][*c]u8, noalias __f: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn __asprintf(noalias __ptr: [*c][*c]u8, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn asprintf(noalias __ptr: [*c][*c]u8, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn vdprintf(__fd: c_int, noalias __fmt: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn dprintf(__fd: c_int, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn fscanf(noalias __stream: [*c]FILE, noalias __format: [*c]const u8, ...) c_int;
pub extern fn scanf(noalias __format: [*c]const u8, ...) c_int;
pub extern fn sscanf(noalias __s: [*c]const u8, noalias __format: [*c]const u8, ...) c_int;
pub const _Float32 = f32;
pub const _Float64 = f64;
pub const _Float32x = f64;
pub const _Float64x = c_longdouble;
pub extern fn vfscanf(noalias __s: [*c]FILE, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn vscanf(noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn vsscanf(noalias __s: [*c]const u8, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_5) c_int;
pub extern fn fgetc(__stream: [*c]FILE) c_int;
pub extern fn getc(__stream: [*c]FILE) c_int;
pub extern fn getchar() c_int;
pub extern fn getc_unlocked(__stream: [*c]FILE) c_int;
pub extern fn getchar_unlocked() c_int;
pub extern fn fgetc_unlocked(__stream: [*c]FILE) c_int;
pub extern fn fputc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putchar(__c: c_int) c_int;
pub extern fn fputc_unlocked(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putc_unlocked(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putchar_unlocked(__c: c_int) c_int;
pub extern fn getw(__stream: [*c]FILE) c_int;
pub extern fn putw(__w: c_int, __stream: [*c]FILE) c_int;
pub extern fn fgets(noalias __s: [*c]u8, __n: c_int, noalias __stream: [*c]FILE) [*c]u8;
pub extern fn fgets_unlocked(noalias __s: [*c]u8, __n: c_int, noalias __stream: [*c]FILE) [*c]u8;
pub extern fn __getdelim(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, __delimiter: c_int, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn getdelim(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, __delimiter: c_int, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn getline(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn fputs(noalias __s: [*c]const u8, noalias __stream: [*c]FILE) c_int;
pub extern fn puts(__s: [*c]const u8) c_int;
pub extern fn ungetc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn fread(__ptr: ?*anyopaque, __size: c_ulong, __n: c_ulong, __stream: [*c]FILE) c_ulong;
pub extern fn fwrite(__ptr: ?*const anyopaque, __size: c_ulong, __n: c_ulong, __s: [*c]FILE) c_ulong;
pub extern fn fputs_unlocked(noalias __s: [*c]const u8, noalias __stream: [*c]FILE) c_int;
pub extern fn fread_unlocked(noalias __ptr: ?*anyopaque, __size: usize, __n: usize, noalias __stream: [*c]FILE) usize;
pub extern fn fwrite_unlocked(noalias __ptr: ?*const anyopaque, __size: usize, __n: usize, noalias __stream: [*c]FILE) usize;
pub extern fn fseek(__stream: [*c]FILE, __off: c_long, __whence: c_int) c_int;
pub extern fn ftell(__stream: [*c]FILE) c_long;
pub extern fn rewind(__stream: [*c]FILE) void;
pub extern fn fseeko(__stream: [*c]FILE, __off: __off64_t, __whence: c_int) c_int;
pub extern fn ftello(__stream: [*c]FILE) __off64_t;
pub extern fn fgetpos(noalias __stream: [*c]FILE, noalias __pos: [*c]fpos_t) c_int;
pub extern fn fsetpos(__stream: [*c]FILE, __pos: [*c]const fpos_t) c_int;
pub extern fn fseeko64(__stream: [*c]FILE, __off: __off64_t, __whence: c_int) c_int;
pub extern fn ftello64(__stream: [*c]FILE) __off64_t;
pub extern fn fgetpos64(noalias __stream: [*c]FILE, noalias __pos: [*c]fpos64_t) c_int;
pub extern fn fsetpos64(__stream: [*c]FILE, __pos: [*c]const fpos64_t) c_int;
pub extern fn clearerr(__stream: [*c]FILE) void;
pub extern fn feof(__stream: [*c]FILE) c_int;
pub extern fn ferror(__stream: [*c]FILE) c_int;
pub extern fn clearerr_unlocked(__stream: [*c]FILE) void;
pub extern fn feof_unlocked(__stream: [*c]FILE) c_int;
pub extern fn ferror_unlocked(__stream: [*c]FILE) c_int;
pub extern fn perror(__s: [*c]const u8) void;
pub extern fn fileno(__stream: [*c]FILE) c_int;
pub extern fn fileno_unlocked(__stream: [*c]FILE) c_int;
pub extern fn pclose(__stream: [*c]FILE) c_int;
pub extern fn popen(__command: [*c]const u8, __modes: [*c]const u8) [*c]FILE;
pub extern fn ctermid(__s: [*c]u8) [*c]u8;
pub extern fn cuserid(__s: [*c]u8) [*c]u8;
pub const struct_obstack = opaque {};
pub extern fn obstack_printf(noalias __obstack: ?*struct_obstack, noalias __format: [*c]const u8, ...) c_int;
pub extern fn obstack_vprintf(noalias __obstack: ?*struct_obstack, noalias __format: [*c]const u8, __args: [*c]struct___va_list_tag_5) c_int;
pub extern fn flockfile(__stream: [*c]FILE) void;
pub extern fn ftrylockfile(__stream: [*c]FILE) c_int;
pub extern fn funlockfile(__stream: [*c]FILE) void;
pub extern fn __uflow([*c]FILE) c_int;
pub extern fn __overflow([*c]FILE, c_int) c_int;
pub const div_t = extern struct {
    quot: c_int = @import("std").mem.zeroes(c_int),
    rem: c_int = @import("std").mem.zeroes(c_int),
};
pub const ldiv_t = extern struct {
    quot: c_long = @import("std").mem.zeroes(c_long),
    rem: c_long = @import("std").mem.zeroes(c_long),
};
pub const lldiv_t = extern struct {
    quot: c_longlong = @import("std").mem.zeroes(c_longlong),
    rem: c_longlong = @import("std").mem.zeroes(c_longlong),
};
pub extern fn __ctype_get_mb_cur_max() usize;
pub extern fn atof(__nptr: [*c]const u8) f64;
pub extern fn atoi(__nptr: [*c]const u8) c_int;
pub extern fn atol(__nptr: [*c]const u8) c_long;
pub extern fn atoll(__nptr: [*c]const u8) c_longlong;
pub extern fn strtod(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f64;
pub extern fn strtof(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f32;
pub extern fn strtold(__nptr: [*c]const u8, __endptr: [*c][*c]u8) c_longdouble;
pub extern fn strtof32(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) _Float32;
pub extern fn strtof64(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) _Float64;
pub extern fn strtof32x(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) _Float32x;
pub extern fn strtof64x(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8) _Float64x;
pub extern fn strtol(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_long;
pub extern fn strtoul(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulong;
pub extern fn strtoq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtouq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn strtoll(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtoull(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn strfromd(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: f64) c_int;
pub extern fn strfromf(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: f32) c_int;
pub extern fn strfroml(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: c_longdouble) c_int;
pub extern fn strfromf32(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: _Float32) c_int;
pub extern fn strfromf64(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: _Float64) c_int;
pub extern fn strfromf32x(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: _Float32x) c_int;
pub extern fn strfromf64x(__dest: [*c]u8, __size: usize, __format: [*c]const u8, __f: _Float64x) c_int;
pub const struct___locale_data_7 = opaque {};
pub const struct___locale_struct = extern struct {
    __locales: [13]?*struct___locale_data_7 = @import("std").mem.zeroes([13]?*struct___locale_data_7),
    __ctype_b: [*c]const c_ushort = @import("std").mem.zeroes([*c]const c_ushort),
    __ctype_tolower: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    __ctype_toupper: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    __names: [13][*c]const u8 = @import("std").mem.zeroes([13][*c]const u8),
};
pub const __locale_t = [*c]struct___locale_struct;
pub const locale_t = __locale_t;
pub extern fn strtol_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int, __loc: locale_t) c_long;
pub extern fn strtoul_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int, __loc: locale_t) c_ulong;
pub extern fn strtoll_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int, __loc: locale_t) c_longlong;
pub extern fn strtoull_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int, __loc: locale_t) c_ulonglong;
pub extern fn strtod_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) f64;
pub extern fn strtof_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) f32;
pub extern fn strtold_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) c_longdouble;
pub extern fn strtof32_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) _Float32;
pub extern fn strtof64_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) _Float64;
pub extern fn strtof32x_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) _Float32x;
pub extern fn strtof64x_l(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __loc: locale_t) _Float64x;
pub extern fn l64a(__n: c_long) [*c]u8;
pub extern fn a64l(__s: [*c]const u8) c_long;
pub extern fn random() c_long;
pub extern fn srandom(__seed: c_uint) void;
pub extern fn initstate(__seed: c_uint, __statebuf: [*c]u8, __statelen: usize) [*c]u8;
pub extern fn setstate(__statebuf: [*c]u8) [*c]u8;
pub const struct_random_data = extern struct {
    fptr: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    rptr: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    state: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    rand_type: c_int = @import("std").mem.zeroes(c_int),
    rand_deg: c_int = @import("std").mem.zeroes(c_int),
    rand_sep: c_int = @import("std").mem.zeroes(c_int),
    end_ptr: [*c]i32 = @import("std").mem.zeroes([*c]i32),
};
pub extern fn random_r(noalias __buf: [*c]struct_random_data, noalias __result: [*c]i32) c_int;
pub extern fn srandom_r(__seed: c_uint, __buf: [*c]struct_random_data) c_int;
pub extern fn initstate_r(__seed: c_uint, noalias __statebuf: [*c]u8, __statelen: usize, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn setstate_r(noalias __statebuf: [*c]u8, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn rand() c_int;
pub extern fn srand(__seed: c_uint) void;
pub extern fn rand_r(__seed: [*c]c_uint) c_int;
pub extern fn drand48() f64;
pub extern fn erand48(__xsubi: [*c]c_ushort) f64;
pub extern fn lrand48() c_long;
pub extern fn nrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn mrand48() c_long;
pub extern fn jrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn srand48(__seedval: c_long) void;
pub extern fn seed48(__seed16v: [*c]c_ushort) [*c]c_ushort;
pub extern fn lcong48(__param: [*c]c_ushort) void;
pub const struct_drand48_data = extern struct {
    __x: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
    __old_x: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
    __c: c_ushort = @import("std").mem.zeroes(c_ushort),
    __init: c_ushort = @import("std").mem.zeroes(c_ushort),
    __a: c_ulonglong = @import("std").mem.zeroes(c_ulonglong),
};
pub extern fn drand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn erand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn lrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn nrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn mrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn jrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn srand48_r(__seedval: c_long, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn seed48_r(__seed16v: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn lcong48_r(__param: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn arc4random() __uint32_t;
pub extern fn arc4random_buf(__buf: ?*anyopaque, __size: usize) void;
pub extern fn arc4random_uniform(__upper_bound: __uint32_t) __uint32_t;
pub extern fn malloc(__size: c_ulong) ?*anyopaque;
pub extern fn calloc(__nmemb: c_ulong, __size: c_ulong) ?*anyopaque;
pub extern fn realloc(__ptr: ?*anyopaque, __size: c_ulong) ?*anyopaque;
pub extern fn free(__ptr: ?*anyopaque) void;
pub extern fn reallocarray(__ptr: ?*anyopaque, __nmemb: usize, __size: usize) ?*anyopaque;
pub extern fn alloca(__size: c_ulong) ?*anyopaque;
pub extern fn valloc(__size: usize) ?*anyopaque;
pub extern fn posix_memalign(__memptr: [*c]?*anyopaque, __alignment: usize, __size: usize) c_int;
pub extern fn aligned_alloc(__alignment: c_ulong, __size: c_ulong) ?*anyopaque;
pub extern fn abort() noreturn;
pub extern fn atexit(__func: ?*const fn () callconv(.C) void) c_int;
pub extern fn at_quick_exit(__func: ?*const fn () callconv(.C) void) c_int;
pub extern fn on_exit(__func: ?*const fn (c_int, ?*anyopaque) callconv(.C) void, __arg: ?*anyopaque) c_int;
pub extern fn exit(__status: c_int) noreturn;
pub extern fn quick_exit(__status: c_int) noreturn;
pub extern fn _Exit(__status: c_int) noreturn;
pub extern fn getenv(__name: [*c]const u8) [*c]u8;
pub extern fn secure_getenv(__name: [*c]const u8) [*c]u8;
pub extern fn putenv(__string: [*c]u8) c_int;
pub extern fn setenv(__name: [*c]const u8, __value: [*c]const u8, __replace: c_int) c_int;
pub extern fn unsetenv(__name: [*c]const u8) c_int;
pub extern fn clearenv() c_int;
pub extern fn mktemp(__template: [*c]u8) [*c]u8;
pub extern fn mkstemp(__template: [*c]u8) c_int;
pub extern fn mkstemp64(__template: [*c]u8) c_int;
pub extern fn mkstemps(__template: [*c]u8, __suffixlen: c_int) c_int;
pub extern fn mkstemps64(__template: [*c]u8, __suffixlen: c_int) c_int;
pub extern fn mkdtemp(__template: [*c]u8) [*c]u8;
pub extern fn mkostemp(__template: [*c]u8, __flags: c_int) c_int;
pub extern fn mkostemp64(__template: [*c]u8, __flags: c_int) c_int;
pub extern fn mkostemps(__template: [*c]u8, __suffixlen: c_int, __flags: c_int) c_int;
pub extern fn mkostemps64(__template: [*c]u8, __suffixlen: c_int, __flags: c_int) c_int;
pub extern fn system(__command: [*c]const u8) c_int;
pub extern fn canonicalize_file_name(__name: [*c]const u8) [*c]u8;
pub extern fn realpath(noalias __name: [*c]const u8, noalias __resolved: [*c]u8) [*c]u8;
pub const __compar_fn_t = ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.C) c_int;
pub const comparison_fn_t = __compar_fn_t;
pub const __compar_d_fn_t = ?*const fn (?*const anyopaque, ?*const anyopaque, ?*anyopaque) callconv(.C) c_int;
pub extern fn bsearch(__key: ?*const anyopaque, __base: ?*const anyopaque, __nmemb: usize, __size: usize, __compar: __compar_fn_t) ?*anyopaque;
pub extern fn qsort(__base: ?*anyopaque, __nmemb: usize, __size: usize, __compar: __compar_fn_t) void;
pub extern fn qsort_r(__base: ?*anyopaque, __nmemb: usize, __size: usize, __compar: __compar_d_fn_t, __arg: ?*anyopaque) void;
pub extern fn abs(__x: c_int) c_int;
pub extern fn labs(__x: c_long) c_long;
pub extern fn llabs(__x: c_longlong) c_longlong;
pub extern fn div(__numer: c_int, __denom: c_int) div_t;
pub extern fn ldiv(__numer: c_long, __denom: c_long) ldiv_t;
pub extern fn lldiv(__numer: c_longlong, __denom: c_longlong) lldiv_t;
pub extern fn ecvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn fcvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn gcvt(__value: f64, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn qecvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qfcvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qgcvt(__value: c_longdouble, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn ecvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn fcvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qecvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qfcvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn mblen(__s: [*c]const u8, __n: usize) c_int;
pub extern fn mbtowc(noalias __pwc: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) c_int;
pub extern fn wctomb(__s: [*c]u8, __wchar: wchar_t) c_int;
pub extern fn mbstowcs(noalias __pwcs: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) usize;
pub extern fn wcstombs(noalias __s: [*c]u8, noalias __pwcs: [*c]const wchar_t, __n: usize) usize;
pub extern fn rpmatch(__response: [*c]const u8) c_int;
pub extern fn getsubopt(noalias __optionp: [*c][*c]u8, noalias __tokens: [*c]const [*c]u8, noalias __valuep: [*c][*c]u8) c_int;
pub extern fn posix_openpt(__oflag: c_int) c_int;
pub extern fn grantpt(__fd: c_int) c_int;
pub extern fn unlockpt(__fd: c_int) c_int;
pub extern fn ptsname(__fd: c_int) [*c]u8;
pub extern fn ptsname_r(__fd: c_int, __buf: [*c]u8, __buflen: usize) c_int;
pub extern fn getpt() c_int;
pub extern fn getloadavg(__loadavg: [*c]f64, __nelem: c_int) c_int;
pub const _ISupper: c_int = 256;
pub const _ISlower: c_int = 512;
pub const _ISalpha: c_int = 1024;
pub const _ISdigit: c_int = 2048;
pub const _ISxdigit: c_int = 4096;
pub const _ISspace: c_int = 8192;
pub const _ISprint: c_int = 16384;
pub const _ISgraph: c_int = 32768;
pub const _ISblank: c_int = 1;
pub const _IScntrl: c_int = 2;
pub const _ISpunct: c_int = 4;
pub const _ISalnum: c_int = 8;
const enum_unnamed_8 = c_uint;
pub extern fn __ctype_b_loc() [*c][*c]const c_ushort;
pub extern fn __ctype_tolower_loc() [*c][*c]const __int32_t;
pub extern fn __ctype_toupper_loc() [*c][*c]const __int32_t;
pub extern fn isalnum(c_int) c_int;
pub extern fn isalpha(c_int) c_int;
pub extern fn iscntrl(c_int) c_int;
pub extern fn isdigit(c_int) c_int;
pub extern fn islower(c_int) c_int;
pub extern fn isgraph(c_int) c_int;
pub extern fn isprint(c_int) c_int;
pub extern fn ispunct(c_int) c_int;
pub extern fn isspace(c_int) c_int;
pub extern fn isupper(c_int) c_int;
pub extern fn isxdigit(c_int) c_int;
pub extern fn tolower(__c: c_int) c_int;
pub extern fn toupper(__c: c_int) c_int;
pub extern fn isblank(c_int) c_int;
pub extern fn isctype(__c: c_int, __mask: c_int) c_int;
pub extern fn isascii(__c: c_int) c_int;
pub extern fn toascii(__c: c_int) c_int;
pub extern fn _toupper(c_int) c_int;
pub extern fn _tolower(c_int) c_int;
pub extern fn isalnum_l(c_int, locale_t) c_int;
pub extern fn isalpha_l(c_int, locale_t) c_int;
pub extern fn iscntrl_l(c_int, locale_t) c_int;
pub extern fn isdigit_l(c_int, locale_t) c_int;
pub extern fn islower_l(c_int, locale_t) c_int;
pub extern fn isgraph_l(c_int, locale_t) c_int;
pub extern fn isprint_l(c_int, locale_t) c_int;
pub extern fn ispunct_l(c_int, locale_t) c_int;
pub extern fn isspace_l(c_int, locale_t) c_int;
pub extern fn isupper_l(c_int, locale_t) c_int;
pub extern fn isxdigit_l(c_int, locale_t) c_int;
pub extern fn isblank_l(c_int, locale_t) c_int;
pub extern fn __tolower_l(__c: c_int, __l: locale_t) c_int;
pub extern fn tolower_l(__c: c_int, __l: locale_t) c_int;
pub extern fn __toupper_l(__c: c_int, __l: locale_t) c_int;
pub extern fn toupper_l(__c: c_int, __l: locale_t) c_int;
pub extern fn __errno_location() [*c]c_int;
pub extern var program_invocation_name: [*c]u8;
pub extern var program_invocation_short_name: [*c]u8;
pub const error_t = c_int;
pub extern fn memcpy(__dest: ?*anyopaque, __src: ?*const anyopaque, __n: c_ulong) ?*anyopaque;
pub extern fn memmove(__dest: ?*anyopaque, __src: ?*const anyopaque, __n: c_ulong) ?*anyopaque;
pub extern fn memccpy(__dest: ?*anyopaque, __src: ?*const anyopaque, __c: c_int, __n: c_ulong) ?*anyopaque;
pub extern fn memset(__s: ?*anyopaque, __c: c_int, __n: c_ulong) ?*anyopaque;
pub extern fn memcmp(__s1: ?*const anyopaque, __s2: ?*const anyopaque, __n: c_ulong) c_int;
pub extern fn __memcmpeq(__s1: ?*const anyopaque, __s2: ?*const anyopaque, __n: usize) c_int;
pub extern fn memchr(__s: ?*const anyopaque, __c: c_int, __n: c_ulong) ?*anyopaque;
pub extern fn rawmemchr(__s: ?*const anyopaque, __c: c_int) ?*anyopaque;
pub extern fn memrchr(__s: ?*const anyopaque, __c: c_int, __n: usize) ?*anyopaque;
pub extern fn strcpy(__dest: [*c]u8, __src: [*c]const u8) [*c]u8;
pub extern fn strncpy(__dest: [*c]u8, __src: [*c]const u8, __n: c_ulong) [*c]u8;
pub extern fn strcat(__dest: [*c]u8, __src: [*c]const u8) [*c]u8;
pub extern fn strncat(__dest: [*c]u8, __src: [*c]const u8, __n: c_ulong) [*c]u8;
pub extern fn strcmp(__s1: [*c]const u8, __s2: [*c]const u8) c_int;
pub extern fn strncmp(__s1: [*c]const u8, __s2: [*c]const u8, __n: c_ulong) c_int;
pub extern fn strcoll(__s1: [*c]const u8, __s2: [*c]const u8) c_int;
pub extern fn strxfrm(__dest: [*c]u8, __src: [*c]const u8, __n: c_ulong) c_ulong;
pub extern fn strcoll_l(__s1: [*c]const u8, __s2: [*c]const u8, __l: locale_t) c_int;
pub extern fn strxfrm_l(__dest: [*c]u8, __src: [*c]const u8, __n: usize, __l: locale_t) usize;
pub extern fn strdup(__s: [*c]const u8) [*c]u8;
pub extern fn strndup(__string: [*c]const u8, __n: c_ulong) [*c]u8;
pub extern fn strchr(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn strrchr(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn strchrnul(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn strcspn(__s: [*c]const u8, __reject: [*c]const u8) c_ulong;
pub extern fn strspn(__s: [*c]const u8, __accept: [*c]const u8) c_ulong;
pub extern fn strpbrk(__s: [*c]const u8, __accept: [*c]const u8) [*c]u8;
pub extern fn strstr(__haystack: [*c]const u8, __needle: [*c]const u8) [*c]u8;
pub extern fn strtok(__s: [*c]u8, __delim: [*c]const u8) [*c]u8;
pub extern fn __strtok_r(noalias __s: [*c]u8, noalias __delim: [*c]const u8, noalias __save_ptr: [*c][*c]u8) [*c]u8;
pub extern fn strtok_r(noalias __s: [*c]u8, noalias __delim: [*c]const u8, noalias __save_ptr: [*c][*c]u8) [*c]u8;
pub extern fn strcasestr(__haystack: [*c]const u8, __needle: [*c]const u8) [*c]u8;
pub extern fn memmem(__haystack: ?*const anyopaque, __haystacklen: usize, __needle: ?*const anyopaque, __needlelen: usize) ?*anyopaque;
pub extern fn __mempcpy(noalias __dest: ?*anyopaque, noalias __src: ?*const anyopaque, __n: usize) ?*anyopaque;
pub extern fn mempcpy(__dest: ?*anyopaque, __src: ?*const anyopaque, __n: c_ulong) ?*anyopaque;
pub extern fn strlen(__s: [*c]const u8) c_ulong;
pub extern fn strnlen(__string: [*c]const u8, __maxlen: usize) usize;
pub extern fn strerror(__errnum: c_int) [*c]u8;
pub extern fn strerror_r(__errnum: c_int, __buf: [*c]u8, __buflen: usize) [*c]u8;
pub extern fn strerrordesc_np(__err: c_int) [*c]const u8;
pub extern fn strerrorname_np(__err: c_int) [*c]const u8;
pub extern fn strerror_l(__errnum: c_int, __l: locale_t) [*c]u8;
pub extern fn bcmp(__s1: ?*const anyopaque, __s2: ?*const anyopaque, __n: c_ulong) c_int;
pub extern fn bcopy(__src: ?*const anyopaque, __dest: ?*anyopaque, __n: c_ulong) void;
pub extern fn bzero(__s: ?*anyopaque, __n: c_ulong) void;
pub extern fn index(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn rindex(__s: [*c]const u8, __c: c_int) [*c]u8;
pub extern fn ffs(__i: c_int) c_int;
pub extern fn ffsl(__l: c_long) c_int;
pub extern fn ffsll(__ll: c_longlong) c_int;
pub extern fn strcasecmp(__s1: [*c]const u8, __s2: [*c]const u8) c_int;
pub extern fn strncasecmp(__s1: [*c]const u8, __s2: [*c]const u8, __n: c_ulong) c_int;
pub extern fn strcasecmp_l(__s1: [*c]const u8, __s2: [*c]const u8, __loc: locale_t) c_int;
pub extern fn strncasecmp_l(__s1: [*c]const u8, __s2: [*c]const u8, __n: usize, __loc: locale_t) c_int;
pub extern fn explicit_bzero(__s: ?*anyopaque, __n: usize) void;
pub extern fn strsep(noalias __stringp: [*c][*c]u8, noalias __delim: [*c]const u8) [*c]u8;
pub extern fn strsignal(__sig: c_int) [*c]u8;
pub extern fn sigabbrev_np(__sig: c_int) [*c]const u8;
pub extern fn sigdescr_np(__sig: c_int) [*c]const u8;
pub extern fn __stpcpy(noalias __dest: [*c]u8, noalias __src: [*c]const u8) [*c]u8;
pub extern fn stpcpy(__dest: [*c]u8, __src: [*c]const u8) [*c]u8;
pub extern fn __stpncpy(noalias __dest: [*c]u8, noalias __src: [*c]const u8, __n: usize) [*c]u8;
pub extern fn stpncpy(__dest: [*c]u8, __src: [*c]const u8, __n: c_ulong) [*c]u8;
pub extern fn strlcpy(__dest: [*c]u8, __src: [*c]const u8, __n: c_ulong) c_ulong;
pub extern fn strlcat(__dest: [*c]u8, __src: [*c]const u8, __n: c_ulong) c_ulong;
pub extern fn strverscmp(__s1: [*c]const u8, __s2: [*c]const u8) c_int;
pub extern fn strfry(__string: [*c]u8) [*c]u8;
pub extern fn memfrob(__s: ?*anyopaque, __n: usize) ?*anyopaque;
pub extern fn basename(__filename: [*c]const u8) [*c]u8;
pub const sig_atomic_t = __sig_atomic_t;
pub const union_sigval = extern union {
    sival_int: c_int,
    sival_ptr: ?*anyopaque,
};
pub const __sigval_t = union_sigval;
const struct_unnamed_10 = extern struct {
    si_pid: __pid_t = @import("std").mem.zeroes(__pid_t),
    si_uid: __uid_t = @import("std").mem.zeroes(__uid_t),
};
const struct_unnamed_11 = extern struct {
    si_tid: c_int = @import("std").mem.zeroes(c_int),
    si_overrun: c_int = @import("std").mem.zeroes(c_int),
    si_sigval: __sigval_t = @import("std").mem.zeroes(__sigval_t),
};
const struct_unnamed_12 = extern struct {
    si_pid: __pid_t = @import("std").mem.zeroes(__pid_t),
    si_uid: __uid_t = @import("std").mem.zeroes(__uid_t),
    si_sigval: __sigval_t = @import("std").mem.zeroes(__sigval_t),
};
const struct_unnamed_13 = extern struct {
    si_pid: __pid_t = @import("std").mem.zeroes(__pid_t),
    si_uid: __uid_t = @import("std").mem.zeroes(__uid_t),
    si_status: c_int = @import("std").mem.zeroes(c_int),
    si_utime: __clock_t = @import("std").mem.zeroes(__clock_t),
    si_stime: __clock_t = @import("std").mem.zeroes(__clock_t),
};
const struct_unnamed_16 = extern struct {
    _lower: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    _upper: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
const union_unnamed_15 = extern union {
    _addr_bnd: struct_unnamed_16,
    _pkey: __uint32_t,
};
const struct_unnamed_14 = extern struct {
    si_addr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    si_addr_lsb: c_short = @import("std").mem.zeroes(c_short),
    _bounds: union_unnamed_15 = @import("std").mem.zeroes(union_unnamed_15),
};
const struct_unnamed_17 = extern struct {
    si_band: c_long = @import("std").mem.zeroes(c_long),
    si_fd: c_int = @import("std").mem.zeroes(c_int),
};
const struct_unnamed_18 = extern struct {
    _call_addr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    _syscall: c_int = @import("std").mem.zeroes(c_int),
    _arch: c_uint = @import("std").mem.zeroes(c_uint),
};
const union_unnamed_9 = extern union {
    _pad: [28]c_int,
    _kill: struct_unnamed_10,
    _timer: struct_unnamed_11,
    _rt: struct_unnamed_12,
    _sigchld: struct_unnamed_13,
    _sigfault: struct_unnamed_14,
    _sigpoll: struct_unnamed_17,
    _sigsys: struct_unnamed_18,
};
pub const siginfo_t = extern struct {
    si_signo: c_int = @import("std").mem.zeroes(c_int),
    si_errno: c_int = @import("std").mem.zeroes(c_int),
    si_code: c_int = @import("std").mem.zeroes(c_int),
    __pad0: c_int = @import("std").mem.zeroes(c_int),
    _sifields: union_unnamed_9 = @import("std").mem.zeroes(union_unnamed_9),
};
pub const SI_ASYNCNL: c_int = -60;
pub const SI_DETHREAD: c_int = -7;
pub const SI_TKILL: c_int = -6;
pub const SI_SIGIO: c_int = -5;
pub const SI_ASYNCIO: c_int = -4;
pub const SI_MESGQ: c_int = -3;
pub const SI_TIMER: c_int = -2;
pub const SI_QUEUE: c_int = -1;
pub const SI_USER: c_int = 0;
pub const SI_KERNEL: c_int = 128;
const enum_unnamed_19 = c_int;
pub const ILL_ILLOPC: c_int = 1;
pub const ILL_ILLOPN: c_int = 2;
pub const ILL_ILLADR: c_int = 3;
pub const ILL_ILLTRP: c_int = 4;
pub const ILL_PRVOPC: c_int = 5;
pub const ILL_PRVREG: c_int = 6;
pub const ILL_COPROC: c_int = 7;
pub const ILL_BADSTK: c_int = 8;
pub const ILL_BADIADDR: c_int = 9;
const enum_unnamed_20 = c_uint;
pub const FPE_INTDIV: c_int = 1;
pub const FPE_INTOVF: c_int = 2;
pub const FPE_FLTDIV: c_int = 3;
pub const FPE_FLTOVF: c_int = 4;
pub const FPE_FLTUND: c_int = 5;
pub const FPE_FLTRES: c_int = 6;
pub const FPE_FLTINV: c_int = 7;
pub const FPE_FLTSUB: c_int = 8;
pub const FPE_FLTUNK: c_int = 14;
pub const FPE_CONDTRAP: c_int = 15;
const enum_unnamed_21 = c_uint;
pub const SEGV_MAPERR: c_int = 1;
pub const SEGV_ACCERR: c_int = 2;
pub const SEGV_BNDERR: c_int = 3;
pub const SEGV_PKUERR: c_int = 4;
pub const SEGV_ACCADI: c_int = 5;
pub const SEGV_ADIDERR: c_int = 6;
pub const SEGV_ADIPERR: c_int = 7;
pub const SEGV_MTEAERR: c_int = 8;
pub const SEGV_MTESERR: c_int = 9;
pub const SEGV_CPERR: c_int = 10;
const enum_unnamed_22 = c_uint;
pub const BUS_ADRALN: c_int = 1;
pub const BUS_ADRERR: c_int = 2;
pub const BUS_OBJERR: c_int = 3;
pub const BUS_MCEERR_AR: c_int = 4;
pub const BUS_MCEERR_AO: c_int = 5;
const enum_unnamed_23 = c_uint;
pub const TRAP_BRKPT: c_int = 1;
pub const TRAP_TRACE: c_int = 2;
pub const TRAP_BRANCH: c_int = 3;
pub const TRAP_HWBKPT: c_int = 4;
pub const TRAP_UNK: c_int = 5;
const enum_unnamed_24 = c_uint;
pub const CLD_EXITED: c_int = 1;
pub const CLD_KILLED: c_int = 2;
pub const CLD_DUMPED: c_int = 3;
pub const CLD_TRAPPED: c_int = 4;
pub const CLD_STOPPED: c_int = 5;
pub const CLD_CONTINUED: c_int = 6;
const enum_unnamed_25 = c_uint;
pub const POLL_IN: c_int = 1;
pub const POLL_OUT: c_int = 2;
pub const POLL_MSG: c_int = 3;
pub const POLL_ERR: c_int = 4;
pub const POLL_PRI: c_int = 5;
pub const POLL_HUP: c_int = 6;
const enum_unnamed_26 = c_uint;
pub const sigval_t = __sigval_t;
const struct_unnamed_28 = extern struct {
    _function: ?*const fn (__sigval_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn (__sigval_t) callconv(.C) void),
    _attribute: [*c]pthread_attr_t = @import("std").mem.zeroes([*c]pthread_attr_t),
};
const union_unnamed_27 = extern union {
    _pad: [12]c_int,
    _tid: __pid_t,
    _sigev_thread: struct_unnamed_28,
};
pub const struct_sigevent = extern struct {
    sigev_value: __sigval_t = @import("std").mem.zeroes(__sigval_t),
    sigev_signo: c_int = @import("std").mem.zeroes(c_int),
    sigev_notify: c_int = @import("std").mem.zeroes(c_int),
    _sigev_un: union_unnamed_27 = @import("std").mem.zeroes(union_unnamed_27),
};
pub const sigevent_t = struct_sigevent;
pub const SIGEV_SIGNAL: c_int = 0;
pub const SIGEV_NONE: c_int = 1;
pub const SIGEV_THREAD: c_int = 2;
pub const SIGEV_THREAD_ID: c_int = 4;
const enum_unnamed_29 = c_uint;
pub const __sighandler_t = ?*const fn (c_int) callconv(.C) void;
pub extern fn __sysv_signal(__sig: c_int, __handler: __sighandler_t) __sighandler_t;
pub extern fn sysv_signal(__sig: c_int, __handler: __sighandler_t) __sighandler_t;
pub extern fn signal(__sig: c_int, __handler: __sighandler_t) __sighandler_t;
pub extern fn kill(__pid: __pid_t, __sig: c_int) c_int;
pub extern fn killpg(__pgrp: __pid_t, __sig: c_int) c_int;
pub extern fn raise(__sig: c_int) c_int;
pub extern fn ssignal(__sig: c_int, __handler: __sighandler_t) __sighandler_t;
pub extern fn gsignal(__sig: c_int) c_int;
pub extern fn psignal(__sig: c_int, __s: [*c]const u8) void;
pub extern fn psiginfo(__pinfo: [*c]const siginfo_t, __s: [*c]const u8) void;
pub extern fn sigpause(__sig: c_int) c_int;
pub extern fn sigblock(__mask: c_int) c_int;
pub extern fn sigsetmask(__mask: c_int) c_int;
pub extern fn siggetmask() c_int;
pub const sighandler_t = __sighandler_t;
pub const sig_t = __sighandler_t;
pub extern fn sigemptyset(__set: [*c]sigset_t) c_int;
pub extern fn sigfillset(__set: [*c]sigset_t) c_int;
pub extern fn sigaddset(__set: [*c]sigset_t, __signo: c_int) c_int;
pub extern fn sigdelset(__set: [*c]sigset_t, __signo: c_int) c_int;
pub extern fn sigismember(__set: [*c]const sigset_t, __signo: c_int) c_int;
pub extern fn sigisemptyset(__set: [*c]const sigset_t) c_int;
pub extern fn sigandset(__set: [*c]sigset_t, __left: [*c]const sigset_t, __right: [*c]const sigset_t) c_int;
pub extern fn sigorset(__set: [*c]sigset_t, __left: [*c]const sigset_t, __right: [*c]const sigset_t) c_int;
const union_unnamed_30 = extern union {
    sa_handler: __sighandler_t,
    sa_sigaction: ?*const fn (c_int, [*c]siginfo_t, ?*anyopaque) callconv(.C) void,
};
pub const struct_sigaction = extern struct {
    __sigaction_handler: union_unnamed_30 = @import("std").mem.zeroes(union_unnamed_30),
    sa_mask: __sigset_t = @import("std").mem.zeroes(__sigset_t),
    sa_flags: c_int = @import("std").mem.zeroes(c_int),
    sa_restorer: ?*const fn () callconv(.C) void = @import("std").mem.zeroes(?*const fn () callconv(.C) void),
};
pub extern fn sigprocmask(__how: c_int, noalias __set: [*c]const sigset_t, noalias __oset: [*c]sigset_t) c_int;
pub extern fn sigsuspend(__set: [*c]const sigset_t) c_int;
pub extern fn sigaction(__sig: c_int, noalias __act: [*c]const struct_sigaction, noalias __oact: [*c]struct_sigaction) c_int;
pub extern fn sigpending(__set: [*c]sigset_t) c_int;
pub extern fn sigwait(noalias __set: [*c]const sigset_t, noalias __sig: [*c]c_int) c_int;
pub extern fn sigwaitinfo(noalias __set: [*c]const sigset_t, noalias __info: [*c]siginfo_t) c_int;
pub extern fn sigtimedwait(noalias __set: [*c]const sigset_t, noalias __info: [*c]siginfo_t, noalias __timeout: [*c]const struct_timespec) c_int;
pub extern fn sigqueue(__pid: __pid_t, __sig: c_int, __val: union_sigval) c_int;
pub const struct__fpx_sw_bytes = extern struct {
    magic1: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    extended_size: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    xstate_bv: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    xstate_size: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    __glibc_reserved1: [7]__uint32_t = @import("std").mem.zeroes([7]__uint32_t),
};
pub const struct__fpreg = extern struct {
    significand: [4]c_ushort = @import("std").mem.zeroes([4]c_ushort),
    exponent: c_ushort = @import("std").mem.zeroes(c_ushort),
};
pub const struct__fpxreg = extern struct {
    significand: [4]c_ushort = @import("std").mem.zeroes([4]c_ushort),
    exponent: c_ushort = @import("std").mem.zeroes(c_ushort),
    __glibc_reserved1: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
};
pub const struct__xmmreg = extern struct {
    element: [4]__uint32_t = @import("std").mem.zeroes([4]__uint32_t),
};
pub const struct__fpstate = extern struct {
    cwd: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    swd: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    ftw: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    fop: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    rip: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rdp: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    mxcsr: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    mxcr_mask: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    _st: [8]struct__fpxreg = @import("std").mem.zeroes([8]struct__fpxreg),
    _xmm: [16]struct__xmmreg = @import("std").mem.zeroes([16]struct__xmmreg),
    __glibc_reserved1: [24]__uint32_t = @import("std").mem.zeroes([24]__uint32_t),
};
const union_unnamed_31 = extern union {
    fpstate: [*c]struct__fpstate,
    __fpstate_word: __uint64_t,
};
pub const struct_sigcontext = extern struct {
    r8: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r9: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r10: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r11: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r12: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r13: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r14: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    r15: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rdi: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rsi: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rbp: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rbx: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rdx: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rax: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rcx: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rsp: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rip: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    eflags: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    cs: c_ushort = @import("std").mem.zeroes(c_ushort),
    gs: c_ushort = @import("std").mem.zeroes(c_ushort),
    fs: c_ushort = @import("std").mem.zeroes(c_ushort),
    __pad0: c_ushort = @import("std").mem.zeroes(c_ushort),
    err: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    trapno: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    oldmask: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    cr2: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    unnamed_0: union_unnamed_31 = @import("std").mem.zeroes(union_unnamed_31),
    __reserved1: [8]__uint64_t = @import("std").mem.zeroes([8]__uint64_t),
};
pub const struct__xsave_hdr = extern struct {
    xstate_bv: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    __glibc_reserved1: [2]__uint64_t = @import("std").mem.zeroes([2]__uint64_t),
    __glibc_reserved2: [5]__uint64_t = @import("std").mem.zeroes([5]__uint64_t),
};
pub const struct__ymmh_state = extern struct {
    ymmh_space: [64]__uint32_t = @import("std").mem.zeroes([64]__uint32_t),
};
pub const struct__xstate = extern struct {
    fpstate: struct__fpstate = @import("std").mem.zeroes(struct__fpstate),
    xstate_hdr: struct__xsave_hdr = @import("std").mem.zeroes(struct__xsave_hdr),
    ymmh: struct__ymmh_state = @import("std").mem.zeroes(struct__ymmh_state),
};
pub extern fn sigreturn(__scp: [*c]struct_sigcontext) c_int;
pub const stack_t = extern struct {
    ss_sp: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ss_flags: c_int = @import("std").mem.zeroes(c_int),
    ss_size: usize = @import("std").mem.zeroes(usize),
};
pub const greg_t = c_longlong;
pub const gregset_t = [23]greg_t;
pub const REG_R8: c_int = 0;
pub const REG_R9: c_int = 1;
pub const REG_R10: c_int = 2;
pub const REG_R11: c_int = 3;
pub const REG_R12: c_int = 4;
pub const REG_R13: c_int = 5;
pub const REG_R14: c_int = 6;
pub const REG_R15: c_int = 7;
pub const REG_RDI: c_int = 8;
pub const REG_RSI: c_int = 9;
pub const REG_RBP: c_int = 10;
pub const REG_RBX: c_int = 11;
pub const REG_RDX: c_int = 12;
pub const REG_RAX: c_int = 13;
pub const REG_RCX: c_int = 14;
pub const REG_RSP: c_int = 15;
pub const REG_RIP: c_int = 16;
pub const REG_EFL: c_int = 17;
pub const REG_CSGSFS: c_int = 18;
pub const REG_ERR: c_int = 19;
pub const REG_TRAPNO: c_int = 20;
pub const REG_OLDMASK: c_int = 21;
pub const REG_CR2: c_int = 22;
const enum_unnamed_32 = c_uint;
pub const struct__libc_fpxreg = extern struct {
    significand: [4]c_ushort = @import("std").mem.zeroes([4]c_ushort),
    exponent: c_ushort = @import("std").mem.zeroes(c_ushort),
    __glibc_reserved1: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
};
pub const struct__libc_xmmreg = extern struct {
    element: [4]__uint32_t = @import("std").mem.zeroes([4]__uint32_t),
};
pub const struct__libc_fpstate = extern struct {
    cwd: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    swd: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    ftw: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    fop: __uint16_t = @import("std").mem.zeroes(__uint16_t),
    rip: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    rdp: __uint64_t = @import("std").mem.zeroes(__uint64_t),
    mxcsr: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    mxcr_mask: __uint32_t = @import("std").mem.zeroes(__uint32_t),
    _st: [8]struct__libc_fpxreg = @import("std").mem.zeroes([8]struct__libc_fpxreg),
    _xmm: [16]struct__libc_xmmreg = @import("std").mem.zeroes([16]struct__libc_xmmreg),
    __glibc_reserved1: [24]__uint32_t = @import("std").mem.zeroes([24]__uint32_t),
};
pub const fpregset_t = [*c]struct__libc_fpstate;
pub const mcontext_t = extern struct {
    gregs: gregset_t = @import("std").mem.zeroes(gregset_t),
    fpregs: fpregset_t = @import("std").mem.zeroes(fpregset_t),
    __reserved1: [8]c_ulonglong = @import("std").mem.zeroes([8]c_ulonglong),
};
pub const struct_ucontext_t = extern struct {
    uc_flags: c_ulong = @import("std").mem.zeroes(c_ulong),
    uc_link: [*c]struct_ucontext_t = @import("std").mem.zeroes([*c]struct_ucontext_t),
    uc_stack: stack_t = @import("std").mem.zeroes(stack_t),
    uc_mcontext: mcontext_t = @import("std").mem.zeroes(mcontext_t),
    uc_sigmask: sigset_t = @import("std").mem.zeroes(sigset_t),
    __fpregs_mem: struct__libc_fpstate = @import("std").mem.zeroes(struct__libc_fpstate),
    __ssp: [4]c_ulonglong = @import("std").mem.zeroes([4]c_ulonglong),
};
pub const ucontext_t = struct_ucontext_t;
pub extern fn siginterrupt(__sig: c_int, __interrupt: c_int) c_int;
pub const SS_ONSTACK: c_int = 1;
pub const SS_DISABLE: c_int = 2;
const enum_unnamed_33 = c_uint;
pub extern fn sigaltstack(noalias __ss: [*c]const stack_t, noalias __oss: [*c]stack_t) c_int;
pub const struct_sigstack = extern struct {
    ss_sp: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    ss_onstack: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn sigstack(__ss: [*c]struct_sigstack, __oss: [*c]struct_sigstack) c_int;
pub extern fn sighold(__sig: c_int) c_int;
pub extern fn sigrelse(__sig: c_int) c_int;
pub extern fn sigignore(__sig: c_int) c_int;
pub extern fn sigset(__sig: c_int, __disp: __sighandler_t) __sighandler_t;
pub extern fn pthread_sigmask(__how: c_int, noalias __newmask: [*c]const __sigset_t, noalias __oldmask: [*c]__sigset_t) c_int;
pub extern fn pthread_kill(__threadid: pthread_t, __signo: c_int) c_int;
pub extern fn pthread_sigqueue(__threadid: pthread_t, __signo: c_int, __value: union_sigval) c_int;
pub extern fn __libc_current_sigrtmin() c_int;
pub extern fn __libc_current_sigrtmax() c_int;
pub extern fn tgkill(__tgid: __pid_t, __tid: __pid_t, __signal: c_int) c_int;
pub const struct_passwd = extern struct {
    pw_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    pw_passwd: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    pw_uid: __uid_t = @import("std").mem.zeroes(__uid_t),
    pw_gid: __gid_t = @import("std").mem.zeroes(__gid_t),
    pw_gecos: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    pw_dir: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    pw_shell: [*c]u8 = @import("std").mem.zeroes([*c]u8),
};
pub extern fn setpwent() void;
pub extern fn endpwent() void;
pub extern fn getpwent() [*c]struct_passwd;
pub extern fn fgetpwent(__stream: [*c]FILE) [*c]struct_passwd;
pub extern fn putpwent(noalias __p: [*c]const struct_passwd, noalias __f: [*c]FILE) c_int;
pub extern fn getpwuid(__uid: __uid_t) [*c]struct_passwd;
pub extern fn getpwnam(__name: [*c]const u8) [*c]struct_passwd;
pub extern fn getpwent_r(noalias __resultbuf: [*c]struct_passwd, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_passwd) c_int;
pub extern fn getpwuid_r(__uid: __uid_t, noalias __resultbuf: [*c]struct_passwd, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_passwd) c_int;
pub extern fn getpwnam_r(noalias __name: [*c]const u8, noalias __resultbuf: [*c]struct_passwd, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_passwd) c_int;
pub extern fn fgetpwent_r(noalias __stream: [*c]FILE, noalias __resultbuf: [*c]struct_passwd, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_passwd) c_int;
pub extern fn getpw(__uid: __uid_t, __buffer: [*c]u8) c_int;
pub const struct_group = extern struct {
    gr_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    gr_passwd: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    gr_gid: __gid_t = @import("std").mem.zeroes(__gid_t),
    gr_mem: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
};
pub extern fn setgrent() void;
pub extern fn endgrent() void;
pub extern fn getgrent() [*c]struct_group;
pub extern fn fgetgrent(__stream: [*c]FILE) [*c]struct_group;
pub extern fn putgrent(noalias __p: [*c]const struct_group, noalias __f: [*c]FILE) c_int;
pub extern fn getgrgid(__gid: __gid_t) [*c]struct_group;
pub extern fn getgrnam(__name: [*c]const u8) [*c]struct_group;
pub extern fn getgrent_r(noalias __resultbuf: [*c]struct_group, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_group) c_int;
pub extern fn getgrgid_r(__gid: __gid_t, noalias __resultbuf: [*c]struct_group, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_group) c_int;
pub extern fn getgrnam_r(noalias __name: [*c]const u8, noalias __resultbuf: [*c]struct_group, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_group) c_int;
pub extern fn fgetgrent_r(noalias __stream: [*c]FILE, noalias __resultbuf: [*c]struct_group, noalias __buffer: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_group) c_int;
pub extern fn setgroups(__n: usize, __groups: [*c]const __gid_t) c_int;
pub extern fn getgrouplist(__user: [*c]const u8, __group: __gid_t, __groups: [*c]__gid_t, __ngroups: [*c]c_int) c_int;
pub extern fn initgroups(__user: [*c]const u8, __group: __gid_t) c_int;
pub const struct_dirent = extern struct {
    d_ino: __ino64_t = @import("std").mem.zeroes(__ino64_t),
    d_off: __off64_t = @import("std").mem.zeroes(__off64_t),
    d_reclen: c_ushort = @import("std").mem.zeroes(c_ushort),
    d_type: u8 = @import("std").mem.zeroes(u8),
    d_name: [256]u8 = @import("std").mem.zeroes([256]u8),
};
pub const struct_dirent64 = extern struct {
    d_ino: __ino64_t = @import("std").mem.zeroes(__ino64_t),
    d_off: __off64_t = @import("std").mem.zeroes(__off64_t),
    d_reclen: c_ushort = @import("std").mem.zeroes(c_ushort),
    d_type: u8 = @import("std").mem.zeroes(u8),
    d_name: [256]u8 = @import("std").mem.zeroes([256]u8),
};
pub const DT_UNKNOWN: c_int = 0;
pub const DT_FIFO: c_int = 1;
pub const DT_CHR: c_int = 2;
pub const DT_DIR: c_int = 4;
pub const DT_BLK: c_int = 6;
pub const DT_REG: c_int = 8;
pub const DT_LNK: c_int = 10;
pub const DT_SOCK: c_int = 12;
pub const DT_WHT: c_int = 14;
const enum_unnamed_34 = c_uint;
pub const struct___dirstream = opaque {};
pub const DIR = struct___dirstream;
pub extern fn closedir(__dirp: ?*DIR) c_int;
pub extern fn opendir(__name: [*c]const u8) ?*DIR;
pub extern fn fdopendir(__fd: c_int) ?*DIR;
pub extern fn readdir(__dirp: ?*DIR) [*c]struct_dirent;
pub extern fn readdir64(__dirp: ?*DIR) [*c]struct_dirent64;
pub extern fn readdir_r(noalias __dirp: ?*DIR, noalias __entry: [*c]struct_dirent, noalias __result: [*c][*c]struct_dirent) c_int;
pub extern fn readdir64_r(noalias __dirp: ?*DIR, noalias __entry: [*c]struct_dirent64, noalias __result: [*c][*c]struct_dirent64) c_int;
pub extern fn rewinddir(__dirp: ?*DIR) void;
pub extern fn seekdir(__dirp: ?*DIR, __pos: c_long) void;
pub extern fn telldir(__dirp: ?*DIR) c_long;
pub extern fn dirfd(__dirp: ?*DIR) c_int;
pub extern fn __sysconf(__name: c_int) c_long;
pub extern fn scandir(noalias __dir: [*c]const u8, noalias __namelist: [*c][*c][*c]struct_dirent, __selector: ?*const fn ([*c]const struct_dirent) callconv(.C) c_int, __cmp: ?*const fn ([*c][*c]const struct_dirent, [*c][*c]const struct_dirent) callconv(.C) c_int) c_int;
pub extern fn scandir64(noalias __dir: [*c]const u8, noalias __namelist: [*c][*c][*c]struct_dirent64, __selector: ?*const fn ([*c]const struct_dirent64) callconv(.C) c_int, __cmp: ?*const fn ([*c][*c]const struct_dirent64, [*c][*c]const struct_dirent64) callconv(.C) c_int) c_int;
pub extern fn scandirat(__dfd: c_int, noalias __dir: [*c]const u8, noalias __namelist: [*c][*c][*c]struct_dirent, __selector: ?*const fn ([*c]const struct_dirent) callconv(.C) c_int, __cmp: ?*const fn ([*c][*c]const struct_dirent, [*c][*c]const struct_dirent) callconv(.C) c_int) c_int;
pub extern fn scandirat64(__dfd: c_int, noalias __dir: [*c]const u8, noalias __namelist: [*c][*c][*c]struct_dirent64, __selector: ?*const fn ([*c]const struct_dirent64) callconv(.C) c_int, __cmp: ?*const fn ([*c][*c]const struct_dirent64, [*c][*c]const struct_dirent64) callconv(.C) c_int) c_int;
pub extern fn alphasort(__e1: [*c][*c]const struct_dirent, __e2: [*c][*c]const struct_dirent) c_int;
pub extern fn alphasort64(__e1: [*c][*c]const struct_dirent64, __e2: [*c][*c]const struct_dirent64) c_int;
pub extern fn getdirentries(__fd: c_int, noalias __buf: [*c]u8, __nbytes: usize, noalias __basep: [*c]__off64_t) __ssize_t;
pub extern fn getdirentries64(__fd: c_int, noalias __buf: [*c]u8, __nbytes: usize, noalias __basep: [*c]__off64_t) __ssize_t;
pub extern fn versionsort(__e1: [*c][*c]const struct_dirent, __e2: [*c][*c]const struct_dirent) c_int;
pub extern fn versionsort64(__e1: [*c][*c]const struct_dirent64, __e2: [*c][*c]const struct_dirent64) c_int;
pub extern fn getdents64(__fd: c_int, __buffer: ?*anyopaque, __length: usize) __ssize_t;
pub const __size_t = c_ulong;
pub const struct_stat = extern struct {
    st_dev: __dev_t = @import("std").mem.zeroes(__dev_t),
    st_ino: __ino_t = @import("std").mem.zeroes(__ino_t),
    st_nlink: __nlink_t = @import("std").mem.zeroes(__nlink_t),
    st_mode: __mode_t = @import("std").mem.zeroes(__mode_t),
    st_uid: __uid_t = @import("std").mem.zeroes(__uid_t),
    st_gid: __gid_t = @import("std").mem.zeroes(__gid_t),
    __pad0: c_int = @import("std").mem.zeroes(c_int),
    st_rdev: __dev_t = @import("std").mem.zeroes(__dev_t),
    st_size: __off_t = @import("std").mem.zeroes(__off_t),
    st_blksize: __blksize_t = @import("std").mem.zeroes(__blksize_t),
    st_blocks: __blkcnt_t = @import("std").mem.zeroes(__blkcnt_t),
    st_atim: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    st_mtim: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    st_ctim: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    __glibc_reserved: [3]__syscall_slong_t = @import("std").mem.zeroes([3]__syscall_slong_t),
};
pub const glob_t = extern struct {
    gl_pathc: __size_t = @import("std").mem.zeroes(__size_t),
    gl_pathv: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    gl_offs: __size_t = @import("std").mem.zeroes(__size_t),
    gl_flags: c_int = @import("std").mem.zeroes(c_int),
    gl_closedir: ?*const fn (?*anyopaque) callconv(.C) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) void),
    gl_readdir: ?*const fn (?*anyopaque) callconv(.C) [*c]struct_dirent = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) [*c]struct_dirent),
    gl_opendir: ?*const fn ([*c]const u8) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]const u8) callconv(.C) ?*anyopaque),
    gl_lstat: ?*const fn (noalias [*c]const u8, noalias [*c]struct_stat) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn (noalias [*c]const u8, noalias [*c]struct_stat) callconv(.C) c_int),
    gl_stat: ?*const fn (noalias [*c]const u8, noalias [*c]struct_stat) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn (noalias [*c]const u8, noalias [*c]struct_stat) callconv(.C) c_int),
};
pub const struct_stat64 = extern struct {
    st_dev: __dev_t = @import("std").mem.zeroes(__dev_t),
    st_ino: __ino64_t = @import("std").mem.zeroes(__ino64_t),
    st_nlink: __nlink_t = @import("std").mem.zeroes(__nlink_t),
    st_mode: __mode_t = @import("std").mem.zeroes(__mode_t),
    st_uid: __uid_t = @import("std").mem.zeroes(__uid_t),
    st_gid: __gid_t = @import("std").mem.zeroes(__gid_t),
    __pad0: c_int = @import("std").mem.zeroes(c_int),
    st_rdev: __dev_t = @import("std").mem.zeroes(__dev_t),
    st_size: __off_t = @import("std").mem.zeroes(__off_t),
    st_blksize: __blksize_t = @import("std").mem.zeroes(__blksize_t),
    st_blocks: __blkcnt64_t = @import("std").mem.zeroes(__blkcnt64_t),
    st_atim: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    st_mtim: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    st_ctim: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    __glibc_reserved: [3]__syscall_slong_t = @import("std").mem.zeroes([3]__syscall_slong_t),
};
pub const glob64_t = extern struct {
    gl_pathc: __size_t = @import("std").mem.zeroes(__size_t),
    gl_pathv: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    gl_offs: __size_t = @import("std").mem.zeroes(__size_t),
    gl_flags: c_int = @import("std").mem.zeroes(c_int),
    gl_closedir: ?*const fn (?*anyopaque) callconv(.C) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) void),
    gl_readdir: ?*const fn (?*anyopaque) callconv(.C) [*c]struct_dirent64 = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) [*c]struct_dirent64),
    gl_opendir: ?*const fn ([*c]const u8) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]const u8) callconv(.C) ?*anyopaque),
    gl_lstat: ?*const fn (noalias [*c]const u8, noalias [*c]struct_stat64) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn (noalias [*c]const u8, noalias [*c]struct_stat64) callconv(.C) c_int),
    gl_stat: ?*const fn (noalias [*c]const u8, noalias [*c]struct_stat64) callconv(.C) c_int = @import("std").mem.zeroes(?*const fn (noalias [*c]const u8, noalias [*c]struct_stat64) callconv(.C) c_int),
};
pub extern fn glob(noalias __pattern: [*c]const u8, __flags: c_int, __errfunc: ?*const fn ([*c]const u8, c_int) callconv(.C) c_int, noalias __pglob: [*c]glob_t) c_int;
pub extern fn globfree(__pglob: [*c]glob_t) void;
pub extern fn glob64(noalias __pattern: [*c]const u8, __flags: c_int, __errfunc: ?*const fn ([*c]const u8, c_int) callconv(.C) c_int, noalias __pglob: [*c]glob64_t) c_int;
pub extern fn globfree64(__pglob: [*c]glob64_t) void;
pub extern fn glob_pattern_p(__pattern: [*c]const u8, __quote: c_int) c_int;
pub const struct_statfs = extern struct {
    f_type: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_bsize: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_blocks: __fsblkcnt64_t = @import("std").mem.zeroes(__fsblkcnt64_t),
    f_bfree: __fsblkcnt64_t = @import("std").mem.zeroes(__fsblkcnt64_t),
    f_bavail: __fsblkcnt64_t = @import("std").mem.zeroes(__fsblkcnt64_t),
    f_files: __fsfilcnt64_t = @import("std").mem.zeroes(__fsfilcnt64_t),
    f_ffree: __fsfilcnt64_t = @import("std").mem.zeroes(__fsfilcnt64_t),
    f_fsid: __fsid_t = @import("std").mem.zeroes(__fsid_t),
    f_namelen: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_frsize: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_flags: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_spare: [4]__fsword_t = @import("std").mem.zeroes([4]__fsword_t),
};
pub const struct_statfs64 = extern struct {
    f_type: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_bsize: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_blocks: __fsblkcnt64_t = @import("std").mem.zeroes(__fsblkcnt64_t),
    f_bfree: __fsblkcnt64_t = @import("std").mem.zeroes(__fsblkcnt64_t),
    f_bavail: __fsblkcnt64_t = @import("std").mem.zeroes(__fsblkcnt64_t),
    f_files: __fsfilcnt64_t = @import("std").mem.zeroes(__fsfilcnt64_t),
    f_ffree: __fsfilcnt64_t = @import("std").mem.zeroes(__fsfilcnt64_t),
    f_fsid: __fsid_t = @import("std").mem.zeroes(__fsid_t),
    f_namelen: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_frsize: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_flags: __fsword_t = @import("std").mem.zeroes(__fsword_t),
    f_spare: [4]__fsword_t = @import("std").mem.zeroes([4]__fsword_t),
};
pub extern fn statfs(__file: [*c]const u8, __buf: [*c]struct_statfs) c_int;
pub extern fn statfs64(__file: [*c]const u8, __buf: [*c]struct_statfs64) c_int;
pub extern fn fstatfs(__fildes: c_int, __buf: [*c]struct_statfs) c_int;
pub extern fn fstatfs64(__fildes: c_int, __buf: [*c]struct_statfs64) c_int;
pub const struct_iovec = extern struct {
    iov_base: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    iov_len: usize = @import("std").mem.zeroes(usize),
};
pub extern fn readv(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int) isize;
pub extern fn writev(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int) isize;
pub extern fn preadv(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t) isize;
pub extern fn pwritev(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t) isize;
pub extern fn preadv64(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t) isize;
pub extern fn pwritev64(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t) isize;
pub extern fn pwritev2(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t, __flags: c_int) isize;
pub extern fn preadv2(__fd: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t, __flags: c_int) isize;
pub extern fn preadv64v2(__fp: c_int, __iovec: [*c]const struct_iovec, __count: c_int, __offset: __off64_t, ___flags: c_int) isize;
pub extern fn pwritev64v2(__fd: c_int, __iodev: [*c]const struct_iovec, __count: c_int, __offset: __off64_t, __flags: c_int) isize;
pub extern fn process_vm_readv(__pid: pid_t, __lvec: [*c]const struct_iovec, __liovcnt: c_ulong, __rvec: [*c]const struct_iovec, __riovcnt: c_ulong, __flags: c_ulong) isize;
pub extern fn process_vm_writev(__pid: pid_t, __lvec: [*c]const struct_iovec, __liovcnt: c_ulong, __rvec: [*c]const struct_iovec, __riovcnt: c_ulong, __flags: c_ulong) isize;
pub extern fn stat(noalias __file: [*c]const u8, noalias __buf: [*c]struct_stat) c_int;
pub extern fn fstat(__fd: c_int, __buf: [*c]struct_stat) c_int;
pub extern fn stat64(noalias __file: [*c]const u8, noalias __buf: [*c]struct_stat64) c_int;
pub extern fn fstat64(__fd: c_int, __buf: [*c]struct_stat64) c_int;
pub extern fn fstatat(__fd: c_int, noalias __file: [*c]const u8, noalias __buf: [*c]struct_stat, __flag: c_int) c_int;
pub extern fn fstatat64(__fd: c_int, noalias __file: [*c]const u8, noalias __buf: [*c]struct_stat64, __flag: c_int) c_int;
pub extern fn lstat(noalias __file: [*c]const u8, noalias __buf: [*c]struct_stat) c_int;
pub extern fn lstat64(noalias __file: [*c]const u8, noalias __buf: [*c]struct_stat64) c_int;
pub extern fn chmod(__file: [*c]const u8, __mode: __mode_t) c_int;
pub extern fn lchmod(__file: [*c]const u8, __mode: __mode_t) c_int;
pub extern fn fchmod(__fd: c_int, __mode: __mode_t) c_int;
pub extern fn fchmodat(__fd: c_int, __file: [*c]const u8, __mode: __mode_t, __flag: c_int) c_int;
pub extern fn umask(__mask: __mode_t) __mode_t;
pub extern fn getumask() __mode_t;
pub extern fn mkdir(__path: [*c]const u8, __mode: __mode_t) c_int;
pub extern fn mkdirat(__fd: c_int, __path: [*c]const u8, __mode: __mode_t) c_int;
pub extern fn mknod(__path: [*c]const u8, __mode: __mode_t, __dev: __dev_t) c_int;
pub extern fn mknodat(__fd: c_int, __path: [*c]const u8, __mode: __mode_t, __dev: __dev_t) c_int;
pub extern fn mkfifo(__path: [*c]const u8, __mode: __mode_t) c_int;
pub extern fn mkfifoat(__fd: c_int, __path: [*c]const u8, __mode: __mode_t) c_int;
pub extern fn utimensat(__fd: c_int, __path: [*c]const u8, __times: [*c]const struct_timespec, __flags: c_int) c_int;
pub extern fn futimens(__fd: c_int, __times: [*c]const struct_timespec) c_int;
pub const __s8 = i8;
pub const __u8 = u8;
pub const __s16 = c_short;
pub const __u16 = c_ushort;
pub const __s32 = c_int;
pub const __u32 = c_uint;
pub const __s64 = c_longlong;
pub const __u64 = c_ulonglong;
pub const __kernel_fd_set = extern struct {
    fds_bits: [16]c_ulong = @import("std").mem.zeroes([16]c_ulong),
};
pub const __kernel_sighandler_t = ?*const fn (c_int) callconv(.C) void;
pub const __kernel_key_t = c_int;
pub const __kernel_mqd_t = c_int;
pub const __kernel_old_uid_t = c_ushort;
pub const __kernel_old_gid_t = c_ushort;
pub const __kernel_old_dev_t = c_ulong;
pub const __kernel_long_t = c_long;
pub const __kernel_ulong_t = c_ulong;
pub const __kernel_ino_t = __kernel_ulong_t;
pub const __kernel_mode_t = c_uint;
pub const __kernel_pid_t = c_int;
pub const __kernel_ipc_pid_t = c_int;
pub const __kernel_uid_t = c_uint;
pub const __kernel_gid_t = c_uint;
pub const __kernel_suseconds_t = __kernel_long_t;
pub const __kernel_daddr_t = c_int;
pub const __kernel_uid32_t = c_uint;
pub const __kernel_gid32_t = c_uint;
pub const __kernel_size_t = __kernel_ulong_t;
pub const __kernel_ssize_t = __kernel_long_t;
pub const __kernel_ptrdiff_t = __kernel_long_t;
pub const __kernel_fsid_t = extern struct {
    val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __kernel_off_t = __kernel_long_t;
pub const __kernel_loff_t = c_longlong;
pub const __kernel_old_time_t = __kernel_long_t;
pub const __kernel_time_t = __kernel_long_t;
pub const __kernel_time64_t = c_longlong;
pub const __kernel_clock_t = __kernel_long_t;
pub const __kernel_timer_t = c_int;
pub const __kernel_clockid_t = c_int;
pub const __kernel_caddr_t = [*c]u8;
pub const __kernel_uid16_t = c_ushort;
pub const __kernel_gid16_t = c_ushort;
pub const __s128 = i128;
pub const __u128 = u128;
pub const __le16 = __u16;
pub const __be16 = __u16;
pub const __le32 = __u32;
pub const __be32 = __u32;
pub const __le64 = __u64;
pub const __be64 = __u64;
pub const __sum16 = __u16;
pub const __wsum = __u32;
pub const __poll_t = c_uint;
pub const struct_statx_timestamp = extern struct {
    tv_sec: __s64 = @import("std").mem.zeroes(__s64),
    tv_nsec: __u32 = @import("std").mem.zeroes(__u32),
    __reserved: __s32 = @import("std").mem.zeroes(__s32),
};
pub const struct_statx = extern struct {
    stx_mask: __u32 = @import("std").mem.zeroes(__u32),
    stx_blksize: __u32 = @import("std").mem.zeroes(__u32),
    stx_attributes: __u64 = @import("std").mem.zeroes(__u64),
    stx_nlink: __u32 = @import("std").mem.zeroes(__u32),
    stx_uid: __u32 = @import("std").mem.zeroes(__u32),
    stx_gid: __u32 = @import("std").mem.zeroes(__u32),
    stx_mode: __u16 = @import("std").mem.zeroes(__u16),
    __spare0: [1]__u16 = @import("std").mem.zeroes([1]__u16),
    stx_ino: __u64 = @import("std").mem.zeroes(__u64),
    stx_size: __u64 = @import("std").mem.zeroes(__u64),
    stx_blocks: __u64 = @import("std").mem.zeroes(__u64),
    stx_attributes_mask: __u64 = @import("std").mem.zeroes(__u64),
    stx_atime: struct_statx_timestamp = @import("std").mem.zeroes(struct_statx_timestamp),
    stx_btime: struct_statx_timestamp = @import("std").mem.zeroes(struct_statx_timestamp),
    stx_ctime: struct_statx_timestamp = @import("std").mem.zeroes(struct_statx_timestamp),
    stx_mtime: struct_statx_timestamp = @import("std").mem.zeroes(struct_statx_timestamp),
    stx_rdev_major: __u32 = @import("std").mem.zeroes(__u32),
    stx_rdev_minor: __u32 = @import("std").mem.zeroes(__u32),
    stx_dev_major: __u32 = @import("std").mem.zeroes(__u32),
    stx_dev_minor: __u32 = @import("std").mem.zeroes(__u32),
    stx_mnt_id: __u64 = @import("std").mem.zeroes(__u64),
    stx_dio_mem_align: __u32 = @import("std").mem.zeroes(__u32),
    stx_dio_offset_align: __u32 = @import("std").mem.zeroes(__u32),
    stx_subvol: __u64 = @import("std").mem.zeroes(__u64),
    __spare3: [11]__u64 = @import("std").mem.zeroes([11]__u64),
};
pub extern fn statx(__dirfd: c_int, noalias __path: [*c]const u8, __flags: c_int, __mask: c_uint, noalias __buf: [*c]struct_statx) c_int;
pub const struct_flock = extern struct {
    l_type: c_short = @import("std").mem.zeroes(c_short),
    l_whence: c_short = @import("std").mem.zeroes(c_short),
    l_start: __off64_t = @import("std").mem.zeroes(__off64_t),
    l_len: __off64_t = @import("std").mem.zeroes(__off64_t),
    l_pid: __pid_t = @import("std").mem.zeroes(__pid_t),
};
pub const struct_flock64 = extern struct {
    l_type: c_short = @import("std").mem.zeroes(c_short),
    l_whence: c_short = @import("std").mem.zeroes(c_short),
    l_start: __off64_t = @import("std").mem.zeroes(__off64_t),
    l_len: __off64_t = @import("std").mem.zeroes(__off64_t),
    l_pid: __pid_t = @import("std").mem.zeroes(__pid_t),
};
pub const F_OWNER_TID: c_int = 0;
pub const F_OWNER_PID: c_int = 1;
pub const F_OWNER_PGRP: c_int = 2;
pub const F_OWNER_GID: c_int = 2;
pub const enum___pid_type = c_uint;
pub const struct_f_owner_ex = extern struct {
    type: enum___pid_type = @import("std").mem.zeroes(enum___pid_type),
    pid: __pid_t = @import("std").mem.zeroes(__pid_t),
};
pub const struct_file_handle = extern struct {
    handle_bytes: c_uint align(4) = @import("std").mem.zeroes(c_uint),
    handle_type: c_int = @import("std").mem.zeroes(c_int),
    pub fn f_handle(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 8)));
    }
};
pub extern fn readahead(__fd: c_int, __offset: __off64_t, __count: usize) __ssize_t;
pub extern fn sync_file_range(__fd: c_int, __offset: __off64_t, __count: __off64_t, __flags: c_uint) c_int;
pub extern fn vmsplice(__fdout: c_int, __iov: [*c]const struct_iovec, __count: usize, __flags: c_uint) __ssize_t;
pub extern fn splice(__fdin: c_int, __offin: [*c]__off64_t, __fdout: c_int, __offout: [*c]__off64_t, __len: usize, __flags: c_uint) __ssize_t;
pub extern fn tee(__fdin: c_int, __fdout: c_int, __len: usize, __flags: c_uint) __ssize_t;
pub extern fn fallocate(__fd: c_int, __mode: c_int, __offset: __off64_t, __len: __off64_t) c_int;
pub extern fn fallocate64(__fd: c_int, __mode: c_int, __offset: __off64_t, __len: __off64_t) c_int;
pub extern fn name_to_handle_at(__dfd: c_int, __name: [*c]const u8, __handle: [*c]struct_file_handle, __mnt_id: [*c]c_int, __flags: c_int) c_int;
pub extern fn open_by_handle_at(__mountdirfd: c_int, __handle: [*c]struct_file_handle, __flags: c_int) c_int;
pub extern fn fcntl(__fd: c_int, __cmd: c_int, ...) c_int;
pub extern fn fcntl64(__fd: c_int, __cmd: c_int, ...) c_int;
pub extern fn open(__file: [*c]const u8, __oflag: c_int, ...) c_int;
pub extern fn open64(__file: [*c]const u8, __oflag: c_int, ...) c_int;
pub extern fn openat(__fd: c_int, __file: [*c]const u8, __oflag: c_int, ...) c_int;
pub extern fn openat64(__fd: c_int, __file: [*c]const u8, __oflag: c_int, ...) c_int;
pub extern fn creat(__file: [*c]const u8, __mode: mode_t) c_int;
pub extern fn creat64(__file: [*c]const u8, __mode: mode_t) c_int;
pub extern fn posix_fadvise(__fd: c_int, __offset: __off64_t, __len: __off64_t, __advise: c_int) c_int;
pub extern fn posix_fadvise64(__fd: c_int, __offset: off64_t, __len: off64_t, __advise: c_int) c_int;
pub extern fn posix_fallocate(__fd: c_int, __offset: __off64_t, __len: __off64_t) c_int;
pub extern fn posix_fallocate64(__fd: c_int, __offset: off64_t, __len: off64_t) c_int;
pub const P_ALL: c_int = 0;
pub const P_PID: c_int = 1;
pub const P_PGID: c_int = 2;
pub const P_PIDFD: c_int = 3;
pub const idtype_t = c_uint;
pub extern fn wait(__stat_loc: [*c]c_int) __pid_t;
pub extern fn waitpid(__pid: __pid_t, __stat_loc: [*c]c_int, __options: c_int) __pid_t;
pub extern fn waitid(__idtype: idtype_t, __id: __id_t, __infop: [*c]siginfo_t, __options: c_int) c_int;
const union_unnamed_35 = extern union {
    ru_maxrss: c_long,
    __ru_maxrss_word: __syscall_slong_t,
};
const union_unnamed_36 = extern union {
    ru_ixrss: c_long,
    __ru_ixrss_word: __syscall_slong_t,
};
const union_unnamed_37 = extern union {
    ru_idrss: c_long,
    __ru_idrss_word: __syscall_slong_t,
};
const union_unnamed_38 = extern union {
    ru_isrss: c_long,
    __ru_isrss_word: __syscall_slong_t,
};
const union_unnamed_39 = extern union {
    ru_minflt: c_long,
    __ru_minflt_word: __syscall_slong_t,
};
const union_unnamed_40 = extern union {
    ru_majflt: c_long,
    __ru_majflt_word: __syscall_slong_t,
};
const union_unnamed_41 = extern union {
    ru_nswap: c_long,
    __ru_nswap_word: __syscall_slong_t,
};
const union_unnamed_42 = extern union {
    ru_inblock: c_long,
    __ru_inblock_word: __syscall_slong_t,
};
const union_unnamed_43 = extern union {
    ru_oublock: c_long,
    __ru_oublock_word: __syscall_slong_t,
};
const union_unnamed_44 = extern union {
    ru_msgsnd: c_long,
    __ru_msgsnd_word: __syscall_slong_t,
};
const union_unnamed_45 = extern union {
    ru_msgrcv: c_long,
    __ru_msgrcv_word: __syscall_slong_t,
};
const union_unnamed_46 = extern union {
    ru_nsignals: c_long,
    __ru_nsignals_word: __syscall_slong_t,
};
const union_unnamed_47 = extern union {
    ru_nvcsw: c_long,
    __ru_nvcsw_word: __syscall_slong_t,
};
const union_unnamed_48 = extern union {
    ru_nivcsw: c_long,
    __ru_nivcsw_word: __syscall_slong_t,
};
pub const struct_rusage = extern struct {
    ru_utime: struct_timeval = @import("std").mem.zeroes(struct_timeval),
    ru_stime: struct_timeval = @import("std").mem.zeroes(struct_timeval),
    unnamed_0: union_unnamed_35 = @import("std").mem.zeroes(union_unnamed_35),
    unnamed_1: union_unnamed_36 = @import("std").mem.zeroes(union_unnamed_36),
    unnamed_2: union_unnamed_37 = @import("std").mem.zeroes(union_unnamed_37),
    unnamed_3: union_unnamed_38 = @import("std").mem.zeroes(union_unnamed_38),
    unnamed_4: union_unnamed_39 = @import("std").mem.zeroes(union_unnamed_39),
    unnamed_5: union_unnamed_40 = @import("std").mem.zeroes(union_unnamed_40),
    unnamed_6: union_unnamed_41 = @import("std").mem.zeroes(union_unnamed_41),
    unnamed_7: union_unnamed_42 = @import("std").mem.zeroes(union_unnamed_42),
    unnamed_8: union_unnamed_43 = @import("std").mem.zeroes(union_unnamed_43),
    unnamed_9: union_unnamed_44 = @import("std").mem.zeroes(union_unnamed_44),
    unnamed_10: union_unnamed_45 = @import("std").mem.zeroes(union_unnamed_45),
    unnamed_11: union_unnamed_46 = @import("std").mem.zeroes(union_unnamed_46),
    unnamed_12: union_unnamed_47 = @import("std").mem.zeroes(union_unnamed_47),
    unnamed_13: union_unnamed_48 = @import("std").mem.zeroes(union_unnamed_48),
};
pub extern fn wait3(__stat_loc: [*c]c_int, __options: c_int, __usage: [*c]struct_rusage) __pid_t;
pub extern fn wait4(__pid: __pid_t, __stat_loc: [*c]c_int, __options: c_int, __usage: [*c]struct_rusage) __pid_t;
pub extern fn memfd_create(__name: [*c]const u8, __flags: c_uint) c_int;
pub extern fn mlock2(__addr: ?*const anyopaque, __length: usize, __flags: c_uint) c_int;
pub extern fn pkey_alloc(__flags: c_uint, __access_rights: c_uint) c_int;
pub extern fn pkey_set(__key: c_int, __access_rights: c_uint) c_int;
pub extern fn pkey_get(__key: c_int) c_int;
pub extern fn pkey_free(__key: c_int) c_int;
pub extern fn pkey_mprotect(__addr: ?*anyopaque, __len: usize, __prot: c_int, __pkey: c_int) c_int;
pub extern fn mmap(__addr: ?*anyopaque, __len: usize, __prot: c_int, __flags: c_int, __fd: c_int, __offset: __off64_t) ?*anyopaque;
pub extern fn mmap64(__addr: ?*anyopaque, __len: usize, __prot: c_int, __flags: c_int, __fd: c_int, __offset: __off64_t) ?*anyopaque;
pub extern fn munmap(__addr: ?*anyopaque, __len: usize) c_int;
pub extern fn mprotect(__addr: ?*anyopaque, __len: usize, __prot: c_int) c_int;
pub extern fn msync(__addr: ?*anyopaque, __len: usize, __flags: c_int) c_int;
pub extern fn madvise(__addr: ?*anyopaque, __len: usize, __advice: c_int) c_int;
pub extern fn posix_madvise(__addr: ?*anyopaque, __len: usize, __advice: c_int) c_int;
pub extern fn mlock(__addr: ?*const anyopaque, __len: usize) c_int;
pub extern fn munlock(__addr: ?*const anyopaque, __len: usize) c_int;
pub extern fn mlockall(__flags: c_int) c_int;
pub extern fn munlockall() c_int;
pub extern fn mincore(__start: ?*anyopaque, __len: usize, __vec: [*c]u8) c_int;
pub extern fn mremap(__addr: ?*anyopaque, __old_len: usize, __new_len: usize, __flags: c_int, ...) ?*anyopaque;
pub extern fn remap_file_pages(__start: ?*anyopaque, __size: usize, __prot: c_int, __pgoff: usize, __flags: c_int) c_int;
pub extern fn shm_open(__name: [*c]const u8, __oflag: c_int, __mode: mode_t) c_int;
pub extern fn shm_unlink(__name: [*c]const u8) c_int;
pub extern fn process_madvise(__pid_fd: c_int, __iov: [*c]const struct_iovec, __count: usize, __advice: c_int, __flags: c_uint) __ssize_t;
pub extern fn process_mrelease(pidfd: c_int, flags: c_uint) c_int;
pub const RLIMIT_CPU: c_int = 0;
pub const RLIMIT_FSIZE: c_int = 1;
pub const RLIMIT_DATA: c_int = 2;
pub const RLIMIT_STACK: c_int = 3;
pub const RLIMIT_CORE: c_int = 4;
pub const __RLIMIT_RSS: c_int = 5;
pub const RLIMIT_NOFILE: c_int = 7;
pub const __RLIMIT_OFILE: c_int = 7;
pub const RLIMIT_AS: c_int = 9;
pub const __RLIMIT_NPROC: c_int = 6;
pub const __RLIMIT_MEMLOCK: c_int = 8;
pub const __RLIMIT_LOCKS: c_int = 10;
pub const __RLIMIT_SIGPENDING: c_int = 11;
pub const __RLIMIT_MSGQUEUE: c_int = 12;
pub const __RLIMIT_NICE: c_int = 13;
pub const __RLIMIT_RTPRIO: c_int = 14;
pub const __RLIMIT_RTTIME: c_int = 15;
pub const __RLIMIT_NLIMITS: c_int = 16;
pub const __RLIM_NLIMITS: c_int = 16;
pub const enum___rlimit_resource = c_uint;
pub const rlim_t = __rlim64_t;
pub const rlim64_t = __rlim64_t;
pub const struct_rlimit = extern struct {
    rlim_cur: rlim_t = @import("std").mem.zeroes(rlim_t),
    rlim_max: rlim_t = @import("std").mem.zeroes(rlim_t),
};
pub const struct_rlimit64 = extern struct {
    rlim_cur: rlim64_t = @import("std").mem.zeroes(rlim64_t),
    rlim_max: rlim64_t = @import("std").mem.zeroes(rlim64_t),
};
pub const RUSAGE_SELF: c_int = 0;
pub const RUSAGE_CHILDREN: c_int = -1;
pub const RUSAGE_THREAD: c_int = 1;
pub const enum___rusage_who = c_int;
pub const PRIO_PROCESS: c_int = 0;
pub const PRIO_PGRP: c_int = 1;
pub const PRIO_USER: c_int = 2;
pub const enum___priority_which = c_uint;
pub extern fn prlimit(__pid: __pid_t, __resource: enum___rlimit_resource, __new_limit: [*c]const struct_rlimit, __old_limit: [*c]struct_rlimit) c_int;
pub extern fn prlimit64(__pid: __pid_t, __resource: enum___rlimit_resource, __new_limit: [*c]const struct_rlimit64, __old_limit: [*c]struct_rlimit64) c_int;
pub const __rlimit_resource_t = enum___rlimit_resource;
pub const __rusage_who_t = enum___rusage_who;
pub const __priority_which_t = enum___priority_which;
pub extern fn getrlimit(__resource: __rlimit_resource_t, __rlimits: [*c]struct_rlimit) c_int;
pub extern fn getrlimit64(__resource: __rlimit_resource_t, __rlimits: [*c]struct_rlimit64) c_int;
pub extern fn setrlimit(__resource: __rlimit_resource_t, __rlimits: [*c]const struct_rlimit) c_int;
pub extern fn setrlimit64(__resource: __rlimit_resource_t, __rlimits: [*c]const struct_rlimit64) c_int;
pub extern fn getrusage(__who: __rusage_who_t, __usage: [*c]struct_rusage) c_int;
pub extern fn getpriority(__which: __priority_which_t, __who: id_t) c_int;
pub extern fn setpriority(__which: __priority_which_t, __who: id_t, __prio: c_int) c_int;
pub const struct_sched_param = extern struct {
    sched_priority: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn clone(__fn: ?*const fn (?*anyopaque) callconv(.C) c_int, __child_stack: ?*anyopaque, __flags: c_int, __arg: ?*anyopaque, ...) c_int;
pub extern fn unshare(__flags: c_int) c_int;
pub extern fn sched_getcpu() c_int;
pub extern fn getcpu([*c]c_uint, [*c]c_uint) c_int;
pub extern fn setns(__fd: c_int, __nstype: c_int) c_int;
pub const __cpu_mask = c_ulong;
pub const cpu_set_t = extern struct {
    __bits: [16]__cpu_mask = @import("std").mem.zeroes([16]__cpu_mask),
};
pub extern fn __sched_cpucount(__setsize: usize, __setp: [*c]const cpu_set_t) c_int;
pub extern fn __sched_cpualloc(__count: usize) [*c]cpu_set_t;
pub extern fn __sched_cpufree(__set: [*c]cpu_set_t) void;
pub extern fn sched_setparam(__pid: __pid_t, __param: [*c]const struct_sched_param) c_int;
pub extern fn sched_getparam(__pid: __pid_t, __param: [*c]struct_sched_param) c_int;
pub extern fn sched_setscheduler(__pid: __pid_t, __policy: c_int, __param: [*c]const struct_sched_param) c_int;
pub extern fn sched_getscheduler(__pid: __pid_t) c_int;
pub extern fn sched_yield() c_int;
pub extern fn sched_get_priority_max(__algorithm: c_int) c_int;
pub extern fn sched_get_priority_min(__algorithm: c_int) c_int;
pub extern fn sched_rr_get_interval(__pid: __pid_t, __t: [*c]struct_timespec) c_int;
pub extern fn sched_setaffinity(__pid: __pid_t, __cpusetsize: usize, __cpuset: [*c]const cpu_set_t) c_int;
pub extern fn sched_getaffinity(__pid: __pid_t, __cpusetsize: usize, __cpuset: [*c]cpu_set_t) c_int;
pub const SOCK_STREAM: c_int = 1;
pub const SOCK_DGRAM: c_int = 2;
pub const SOCK_RAW: c_int = 3;
pub const SOCK_RDM: c_int = 4;
pub const SOCK_SEQPACKET: c_int = 5;
pub const SOCK_DCCP: c_int = 6;
pub const SOCK_PACKET: c_int = 10;
pub const SOCK_CLOEXEC: c_int = 524288;
pub const SOCK_NONBLOCK: c_int = 2048;
pub const enum___socket_type = c_uint;
pub const sa_family_t = c_ushort;
pub const struct_sockaddr = extern struct {
    sa_family: sa_family_t = @import("std").mem.zeroes(sa_family_t),
    sa_data: [14]u8 = @import("std").mem.zeroes([14]u8),
};
pub const struct_sockaddr_storage = extern struct {
    ss_family: sa_family_t = @import("std").mem.zeroes(sa_family_t),
    __ss_padding: [118]u8 = @import("std").mem.zeroes([118]u8),
    __ss_align: c_ulong = @import("std").mem.zeroes(c_ulong),
};
pub const MSG_OOB: c_int = 1;
pub const MSG_PEEK: c_int = 2;
pub const MSG_DONTROUTE: c_int = 4;
pub const MSG_TRYHARD: c_int = 4;
pub const MSG_CTRUNC: c_int = 8;
pub const MSG_PROXY: c_int = 16;
pub const MSG_TRUNC: c_int = 32;
pub const MSG_DONTWAIT: c_int = 64;
pub const MSG_EOR: c_int = 128;
pub const MSG_WAITALL: c_int = 256;
pub const MSG_FIN: c_int = 512;
pub const MSG_SYN: c_int = 1024;
pub const MSG_CONFIRM: c_int = 2048;
pub const MSG_RST: c_int = 4096;
pub const MSG_ERRQUEUE: c_int = 8192;
pub const MSG_NOSIGNAL: c_int = 16384;
pub const MSG_MORE: c_int = 32768;
pub const MSG_WAITFORONE: c_int = 65536;
pub const MSG_BATCH: c_int = 262144;
pub const MSG_ZEROCOPY: c_int = 67108864;
pub const MSG_FASTOPEN: c_int = 536870912;
pub const MSG_CMSG_CLOEXEC: c_int = 1073741824;
const enum_unnamed_49 = c_uint;
pub const struct_msghdr = extern struct {
    msg_name: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    msg_namelen: socklen_t = @import("std").mem.zeroes(socklen_t),
    msg_iov: [*c]struct_iovec = @import("std").mem.zeroes([*c]struct_iovec),
    msg_iovlen: usize = @import("std").mem.zeroes(usize),
    msg_control: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    msg_controllen: usize = @import("std").mem.zeroes(usize),
    msg_flags: c_int = @import("std").mem.zeroes(c_int),
};
pub const struct_cmsghdr = extern struct {
    cmsg_len: usize align(8) = @import("std").mem.zeroes(usize),
    cmsg_level: c_int = @import("std").mem.zeroes(c_int),
    cmsg_type: c_int = @import("std").mem.zeroes(c_int),
    pub fn __cmsg_data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 16)));
    }
};
pub extern fn __cmsg_nxthdr(__mhdr: [*c]struct_msghdr, __cmsg: [*c]struct_cmsghdr) [*c]struct_cmsghdr;
pub const SCM_RIGHTS: c_int = 1;
pub const SCM_CREDENTIALS: c_int = 2;
pub const SCM_SECURITY: c_int = 3;
pub const SCM_PIDFD: c_int = 4;
const enum_unnamed_50 = c_uint;
pub const struct_ucred = extern struct {
    pid: pid_t = @import("std").mem.zeroes(pid_t),
    uid: uid_t = @import("std").mem.zeroes(uid_t),
    gid: gid_t = @import("std").mem.zeroes(gid_t),
};
pub const struct_linger = extern struct {
    l_onoff: c_int = @import("std").mem.zeroes(c_int),
    l_linger: c_int = @import("std").mem.zeroes(c_int),
};
pub const struct_osockaddr = extern struct {
    sa_family: c_ushort = @import("std").mem.zeroes(c_ushort),
    sa_data: [14]u8 = @import("std").mem.zeroes([14]u8),
};
pub const SHUT_RD: c_int = 0;
pub const SHUT_WR: c_int = 1;
pub const SHUT_RDWR: c_int = 2;
const enum_unnamed_51 = c_uint;
pub const struct_sockaddr_at_52 = opaque {};
pub const struct_sockaddr_ax25_53 = opaque {};
pub const struct_sockaddr_dl_54 = opaque {};
pub const struct_sockaddr_eon_55 = opaque {};
pub const in_port_t = u16;
pub const in_addr_t = u32;
pub const struct_in_addr = extern struct {
    s_addr: in_addr_t = @import("std").mem.zeroes(in_addr_t),
};
pub const struct_sockaddr_in = extern struct {
    sin_family: sa_family_t = @import("std").mem.zeroes(sa_family_t),
    sin_port: in_port_t = @import("std").mem.zeroes(in_port_t),
    sin_addr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    sin_zero: [8]u8 = @import("std").mem.zeroes([8]u8),
};
const union_unnamed_56 = extern union {
    __u6_addr8: [16]u8,
    __u6_addr16: [8]u16,
    __u6_addr32: [4]u32,
};
pub const struct_in6_addr = extern struct {
    __in6_u: union_unnamed_56 = @import("std").mem.zeroes(union_unnamed_56),
};
pub const struct_sockaddr_in6 = extern struct {
    sin6_family: sa_family_t = @import("std").mem.zeroes(sa_family_t),
    sin6_port: in_port_t = @import("std").mem.zeroes(in_port_t),
    sin6_flowinfo: u32 = @import("std").mem.zeroes(u32),
    sin6_addr: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
    sin6_scope_id: u32 = @import("std").mem.zeroes(u32),
};
pub const struct_sockaddr_inarp_57 = opaque {};
pub const struct_sockaddr_ipx_58 = opaque {};
pub const struct_sockaddr_iso_59 = opaque {};
pub const struct_sockaddr_ns_60 = opaque {};
pub const struct_sockaddr_un = extern struct {
    sun_family: sa_family_t = @import("std").mem.zeroes(sa_family_t),
    sun_path: [108]u8 = @import("std").mem.zeroes([108]u8),
};
pub const struct_sockaddr_x25_61 = opaque {};
pub const __SOCKADDR_ARG = extern union {
    __sockaddr__: [*c]struct_sockaddr,
    __sockaddr_at__: ?*struct_sockaddr_at_52,
    __sockaddr_ax25__: ?*struct_sockaddr_ax25_53,
    __sockaddr_dl__: ?*struct_sockaddr_dl_54,
    __sockaddr_eon__: ?*struct_sockaddr_eon_55,
    __sockaddr_in__: [*c]struct_sockaddr_in,
    __sockaddr_in6__: [*c]struct_sockaddr_in6,
    __sockaddr_inarp__: ?*struct_sockaddr_inarp_57,
    __sockaddr_ipx__: ?*struct_sockaddr_ipx_58,
    __sockaddr_iso__: ?*struct_sockaddr_iso_59,
    __sockaddr_ns__: ?*struct_sockaddr_ns_60,
    __sockaddr_un__: [*c]struct_sockaddr_un,
    __sockaddr_x25__: ?*struct_sockaddr_x25_61,
};
pub const __CONST_SOCKADDR_ARG = extern union {
    __sockaddr__: [*c]const struct_sockaddr,
    __sockaddr_at__: ?*const struct_sockaddr_at_52,
    __sockaddr_ax25__: ?*const struct_sockaddr_ax25_53,
    __sockaddr_dl__: ?*const struct_sockaddr_dl_54,
    __sockaddr_eon__: ?*const struct_sockaddr_eon_55,
    __sockaddr_in__: [*c]const struct_sockaddr_in,
    __sockaddr_in6__: [*c]const struct_sockaddr_in6,
    __sockaddr_inarp__: ?*const struct_sockaddr_inarp_57,
    __sockaddr_ipx__: ?*const struct_sockaddr_ipx_58,
    __sockaddr_iso__: ?*const struct_sockaddr_iso_59,
    __sockaddr_ns__: ?*const struct_sockaddr_ns_60,
    __sockaddr_un__: [*c]const struct_sockaddr_un,
    __sockaddr_x25__: ?*const struct_sockaddr_x25_61,
};
pub const struct_mmsghdr = extern struct {
    msg_hdr: struct_msghdr = @import("std").mem.zeroes(struct_msghdr),
    msg_len: c_uint = @import("std").mem.zeroes(c_uint),
};
pub extern fn socket(__domain: c_int, __type: c_int, __protocol: c_int) c_int;
pub extern fn socketpair(__domain: c_int, __type: c_int, __protocol: c_int, __fds: [*c]c_int) c_int;
pub extern fn bind(__fd: c_int, __addr: __CONST_SOCKADDR_ARG, __len: socklen_t) c_int;
pub extern fn getsockname(__fd: c_int, __addr: __SOCKADDR_ARG, noalias __len: [*c]socklen_t) c_int;
pub extern fn connect(__fd: c_int, __addr: __CONST_SOCKADDR_ARG, __len: socklen_t) c_int;
pub extern fn getpeername(__fd: c_int, __addr: __SOCKADDR_ARG, noalias __len: [*c]socklen_t) c_int;
pub extern fn send(__fd: c_int, __buf: ?*const anyopaque, __n: usize, __flags: c_int) isize;
pub extern fn recv(__fd: c_int, __buf: ?*anyopaque, __n: usize, __flags: c_int) isize;
pub extern fn sendto(__fd: c_int, __buf: ?*const anyopaque, __n: usize, __flags: c_int, __addr: __CONST_SOCKADDR_ARG, __addr_len: socklen_t) isize;
pub extern fn recvfrom(__fd: c_int, noalias __buf: ?*anyopaque, __n: usize, __flags: c_int, __addr: __SOCKADDR_ARG, noalias __addr_len: [*c]socklen_t) isize;
pub extern fn sendmsg(__fd: c_int, __message: [*c]const struct_msghdr, __flags: c_int) isize;
pub extern fn sendmmsg(__fd: c_int, __vmessages: [*c]struct_mmsghdr, __vlen: c_uint, __flags: c_int) c_int;
pub extern fn recvmsg(__fd: c_int, __message: [*c]struct_msghdr, __flags: c_int) isize;
pub extern fn recvmmsg(__fd: c_int, __vmessages: [*c]struct_mmsghdr, __vlen: c_uint, __flags: c_int, __tmo: [*c]struct_timespec) c_int;
pub extern fn getsockopt(__fd: c_int, __level: c_int, __optname: c_int, noalias __optval: ?*anyopaque, noalias __optlen: [*c]socklen_t) c_int;
pub extern fn setsockopt(__fd: c_int, __level: c_int, __optname: c_int, __optval: ?*const anyopaque, __optlen: socklen_t) c_int;
pub extern fn listen(__fd: c_int, __n: c_int) c_int;
pub extern fn accept(__fd: c_int, __addr: __SOCKADDR_ARG, noalias __addr_len: [*c]socklen_t) c_int;
pub extern fn accept4(__fd: c_int, __addr: __SOCKADDR_ARG, noalias __addr_len: [*c]socklen_t, __flags: c_int) c_int;
pub extern fn shutdown(__fd: c_int, __how: c_int) c_int;
pub extern fn sockatmark(__fd: c_int) c_int;
pub extern fn isfdtype(__fd: c_int, __fdtype: c_int) c_int;
pub const struct_ip_opts = extern struct {
    ip_dst: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    ip_opts: [40]u8 = @import("std").mem.zeroes([40]u8),
};
pub const struct_in_pktinfo = extern struct {
    ipi_ifindex: c_int = @import("std").mem.zeroes(c_int),
    ipi_spec_dst: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    ipi_addr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
};
pub const IPPROTO_IP: c_int = 0;
pub const IPPROTO_ICMP: c_int = 1;
pub const IPPROTO_IGMP: c_int = 2;
pub const IPPROTO_IPIP: c_int = 4;
pub const IPPROTO_TCP: c_int = 6;
pub const IPPROTO_EGP: c_int = 8;
pub const IPPROTO_PUP: c_int = 12;
pub const IPPROTO_UDP: c_int = 17;
pub const IPPROTO_IDP: c_int = 22;
pub const IPPROTO_TP: c_int = 29;
pub const IPPROTO_DCCP: c_int = 33;
pub const IPPROTO_IPV6: c_int = 41;
pub const IPPROTO_RSVP: c_int = 46;
pub const IPPROTO_GRE: c_int = 47;
pub const IPPROTO_ESP: c_int = 50;
pub const IPPROTO_AH: c_int = 51;
pub const IPPROTO_MTP: c_int = 92;
pub const IPPROTO_BEETPH: c_int = 94;
pub const IPPROTO_ENCAP: c_int = 98;
pub const IPPROTO_PIM: c_int = 103;
pub const IPPROTO_COMP: c_int = 108;
pub const IPPROTO_L2TP: c_int = 115;
pub const IPPROTO_SCTP: c_int = 132;
pub const IPPROTO_UDPLITE: c_int = 136;
pub const IPPROTO_MPLS: c_int = 137;
pub const IPPROTO_ETHERNET: c_int = 143;
pub const IPPROTO_RAW: c_int = 255;
pub const IPPROTO_MPTCP: c_int = 262;
pub const IPPROTO_MAX: c_int = 263;
const enum_unnamed_62 = c_uint;
pub const IPPROTO_HOPOPTS: c_int = 0;
pub const IPPROTO_ROUTING: c_int = 43;
pub const IPPROTO_FRAGMENT: c_int = 44;
pub const IPPROTO_ICMPV6: c_int = 58;
pub const IPPROTO_NONE: c_int = 59;
pub const IPPROTO_DSTOPTS: c_int = 60;
pub const IPPROTO_MH: c_int = 135;
const enum_unnamed_63 = c_uint;
pub const IPPORT_ECHO: c_int = 7;
pub const IPPORT_DISCARD: c_int = 9;
pub const IPPORT_SYSTAT: c_int = 11;
pub const IPPORT_DAYTIME: c_int = 13;
pub const IPPORT_NETSTAT: c_int = 15;
pub const IPPORT_FTP: c_int = 21;
pub const IPPORT_TELNET: c_int = 23;
pub const IPPORT_SMTP: c_int = 25;
pub const IPPORT_TIMESERVER: c_int = 37;
pub const IPPORT_NAMESERVER: c_int = 42;
pub const IPPORT_WHOIS: c_int = 43;
pub const IPPORT_MTP: c_int = 57;
pub const IPPORT_TFTP: c_int = 69;
pub const IPPORT_RJE: c_int = 77;
pub const IPPORT_FINGER: c_int = 79;
pub const IPPORT_TTYLINK: c_int = 87;
pub const IPPORT_SUPDUP: c_int = 95;
pub const IPPORT_EXECSERVER: c_int = 512;
pub const IPPORT_LOGINSERVER: c_int = 513;
pub const IPPORT_CMDSERVER: c_int = 514;
pub const IPPORT_EFSSERVER: c_int = 520;
pub const IPPORT_BIFFUDP: c_int = 512;
pub const IPPORT_WHOSERVER: c_int = 513;
pub const IPPORT_ROUTESERVER: c_int = 520;
pub const IPPORT_RESERVED: c_int = 1024;
pub const IPPORT_USERRESERVED: c_int = 5000;
const enum_unnamed_64 = c_uint;
pub extern const in6addr_any: struct_in6_addr;
pub extern const in6addr_loopback: struct_in6_addr;
pub const struct_ip_mreq = extern struct {
    imr_multiaddr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imr_interface: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
};
pub const struct_ip_mreqn = extern struct {
    imr_multiaddr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imr_address: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imr_ifindex: c_int = @import("std").mem.zeroes(c_int),
};
pub const struct_ip_mreq_source = extern struct {
    imr_multiaddr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imr_interface: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imr_sourceaddr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
};
pub const struct_ipv6_mreq = extern struct {
    ipv6mr_multiaddr: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
    ipv6mr_interface: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const struct_group_req = extern struct {
    gr_interface: u32 = @import("std").mem.zeroes(u32),
    gr_group: struct_sockaddr_storage = @import("std").mem.zeroes(struct_sockaddr_storage),
};
pub const struct_group_source_req = extern struct {
    gsr_interface: u32 = @import("std").mem.zeroes(u32),
    gsr_group: struct_sockaddr_storage = @import("std").mem.zeroes(struct_sockaddr_storage),
    gsr_source: struct_sockaddr_storage = @import("std").mem.zeroes(struct_sockaddr_storage),
};
pub const struct_ip_msfilter = extern struct {
    imsf_multiaddr: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imsf_interface: struct_in_addr = @import("std").mem.zeroes(struct_in_addr),
    imsf_fmode: u32 = @import("std").mem.zeroes(u32),
    imsf_numsrc: u32 = @import("std").mem.zeroes(u32),
    imsf_slist: [1]struct_in_addr = @import("std").mem.zeroes([1]struct_in_addr),
};
pub const struct_group_filter = extern struct {
    gf_interface: u32 = @import("std").mem.zeroes(u32),
    gf_group: struct_sockaddr_storage = @import("std").mem.zeroes(struct_sockaddr_storage),
    gf_fmode: u32 = @import("std").mem.zeroes(u32),
    gf_numsrc: u32 = @import("std").mem.zeroes(u32),
    gf_slist: [1]struct_sockaddr_storage = @import("std").mem.zeroes([1]struct_sockaddr_storage),
};
pub extern fn ntohl(__netlong: u32) u32;
pub extern fn ntohs(__netshort: u16) u16;
pub extern fn htonl(__hostlong: u32) u32;
pub extern fn htons(__hostshort: u16) u16;
pub extern fn bindresvport(__sockfd: c_int, __sock_in: [*c]struct_sockaddr_in) c_int;
pub extern fn bindresvport6(__sockfd: c_int, __sock_in: [*c]struct_sockaddr_in6) c_int;
pub const struct_in6_pktinfo = extern struct {
    ipi6_addr: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
    ipi6_ifindex: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const struct_ip6_mtuinfo = extern struct {
    ip6m_addr: struct_sockaddr_in6 = @import("std").mem.zeroes(struct_sockaddr_in6),
    ip6m_mtu: u32 = @import("std").mem.zeroes(u32),
};
pub extern fn inet6_option_space(__nbytes: c_int) c_int;
pub extern fn inet6_option_init(__bp: ?*anyopaque, __cmsgp: [*c][*c]struct_cmsghdr, __type: c_int) c_int;
pub extern fn inet6_option_append(__cmsg: [*c]struct_cmsghdr, __typep: [*c]const u8, __multx: c_int, __plusy: c_int) c_int;
pub extern fn inet6_option_alloc(__cmsg: [*c]struct_cmsghdr, __datalen: c_int, __multx: c_int, __plusy: c_int) [*c]u8;
pub extern fn inet6_option_next(__cmsg: [*c]const struct_cmsghdr, __tptrp: [*c][*c]u8) c_int;
pub extern fn inet6_option_find(__cmsg: [*c]const struct_cmsghdr, __tptrp: [*c][*c]u8, __type: c_int) c_int;
pub extern fn inet6_opt_init(__extbuf: ?*anyopaque, __extlen: socklen_t) c_int;
pub extern fn inet6_opt_append(__extbuf: ?*anyopaque, __extlen: socklen_t, __offset: c_int, __type: u8, __len: socklen_t, __align: u8, __databufp: [*c]?*anyopaque) c_int;
pub extern fn inet6_opt_finish(__extbuf: ?*anyopaque, __extlen: socklen_t, __offset: c_int) c_int;
pub extern fn inet6_opt_set_val(__databuf: ?*anyopaque, __offset: c_int, __val: ?*anyopaque, __vallen: socklen_t) c_int;
pub extern fn inet6_opt_next(__extbuf: ?*anyopaque, __extlen: socklen_t, __offset: c_int, __typep: [*c]u8, __lenp: [*c]socklen_t, __databufp: [*c]?*anyopaque) c_int;
pub extern fn inet6_opt_find(__extbuf: ?*anyopaque, __extlen: socklen_t, __offset: c_int, __type: u8, __lenp: [*c]socklen_t, __databufp: [*c]?*anyopaque) c_int;
pub extern fn inet6_opt_get_val(__databuf: ?*anyopaque, __offset: c_int, __val: ?*anyopaque, __vallen: socklen_t) c_int;
pub extern fn inet6_rth_space(__type: c_int, __segments: c_int) socklen_t;
pub extern fn inet6_rth_init(__bp: ?*anyopaque, __bp_len: socklen_t, __type: c_int, __segments: c_int) ?*anyopaque;
pub extern fn inet6_rth_add(__bp: ?*anyopaque, __addr: [*c]const struct_in6_addr) c_int;
pub extern fn inet6_rth_reverse(__in: ?*const anyopaque, __out: ?*anyopaque) c_int;
pub extern fn inet6_rth_segments(__bp: ?*const anyopaque) c_int;
pub extern fn inet6_rth_getaddr(__bp: ?*const anyopaque, __index: c_int) [*c]struct_in6_addr;
pub extern fn getipv4sourcefilter(__s: c_int, __interface_addr: struct_in_addr, __group: struct_in_addr, __fmode: [*c]u32, __numsrc: [*c]u32, __slist: [*c]struct_in_addr) c_int;
pub extern fn setipv4sourcefilter(__s: c_int, __interface_addr: struct_in_addr, __group: struct_in_addr, __fmode: u32, __numsrc: u32, __slist: [*c]const struct_in_addr) c_int;
pub extern fn getsourcefilter(__s: c_int, __interface_addr: u32, __group: [*c]const struct_sockaddr, __grouplen: socklen_t, __fmode: [*c]u32, __numsrc: [*c]u32, __slist: [*c]struct_sockaddr_storage) c_int;
pub extern fn setsourcefilter(__s: c_int, __interface_addr: u32, __group: [*c]const struct_sockaddr, __grouplen: socklen_t, __fmode: u32, __numsrc: u32, __slist: [*c]const struct_sockaddr_storage) c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const tcp_seq = u32;
// /usr/include/netinet/tcp.h:109:10: warning: struct demoted to opaque type - has bitfield
const struct_unnamed_66 = opaque {};
// /usr/include/netinet/tcp.h:134:11: warning: struct demoted to opaque type - has bitfield
const struct_unnamed_67 = opaque {};
const union_unnamed_65 = extern union {
    unnamed_0: struct_unnamed_66,
    unnamed_1: struct_unnamed_67,
};
pub const struct_tcphdr = extern struct {
    unnamed_0: union_unnamed_65 = @import("std").mem.zeroes(union_unnamed_65),
};
pub const TCP_ESTABLISHED: c_int = 1;
pub const TCP_SYN_SENT: c_int = 2;
pub const TCP_SYN_RECV: c_int = 3;
pub const TCP_FIN_WAIT1: c_int = 4;
pub const TCP_FIN_WAIT2: c_int = 5;
pub const TCP_TIME_WAIT: c_int = 6;
pub const TCP_CLOSE: c_int = 7;
pub const TCP_CLOSE_WAIT: c_int = 8;
pub const TCP_LAST_ACK: c_int = 9;
pub const TCP_LISTEN: c_int = 10;
pub const TCP_CLOSING: c_int = 11;
const enum_unnamed_68 = c_uint;
pub const TCP_CA_Open: c_int = 0;
pub const TCP_CA_Disorder: c_int = 1;
pub const TCP_CA_CWR: c_int = 2;
pub const TCP_CA_Recovery: c_int = 3;
pub const TCP_CA_Loss: c_int = 4;
pub const enum_tcp_ca_state = c_uint;
// /usr/include/netinet/tcp.h:234:11: warning: struct demoted to opaque type - has bitfield
pub const struct_tcp_info = opaque {};
pub const struct_tcp_md5sig = extern struct {
    tcpm_addr: struct_sockaddr_storage = @import("std").mem.zeroes(struct_sockaddr_storage),
    tcpm_flags: u8 = @import("std").mem.zeroes(u8),
    tcpm_prefixlen: u8 = @import("std").mem.zeroes(u8),
    tcpm_keylen: u16 = @import("std").mem.zeroes(u16),
    tcpm_ifindex: c_int = @import("std").mem.zeroes(c_int),
    tcpm_key: [80]u8 = @import("std").mem.zeroes([80]u8),
};
pub const struct_tcp_repair_opt = extern struct {
    opt_code: u32 = @import("std").mem.zeroes(u32),
    opt_val: u32 = @import("std").mem.zeroes(u32),
};
pub const TCP_NO_QUEUE: c_int = 0;
pub const TCP_RECV_QUEUE: c_int = 1;
pub const TCP_SEND_QUEUE: c_int = 2;
pub const TCP_QUEUES_NR: c_int = 3;
const enum_unnamed_69 = c_uint;
pub const struct_tcp_cookie_transactions = extern struct {
    tcpct_flags: u16 = @import("std").mem.zeroes(u16),
    __tcpct_pad1: u8 = @import("std").mem.zeroes(u8),
    tcpct_cookie_desired: u8 = @import("std").mem.zeroes(u8),
    tcpct_s_data_desired: u16 = @import("std").mem.zeroes(u16),
    tcpct_used: u16 = @import("std").mem.zeroes(u16),
    tcpct_value: [536]u8 = @import("std").mem.zeroes([536]u8),
};
pub const struct_tcp_repair_window = extern struct {
    snd_wl1: u32 = @import("std").mem.zeroes(u32),
    snd_wnd: u32 = @import("std").mem.zeroes(u32),
    max_window: u32 = @import("std").mem.zeroes(u32),
    rcv_wnd: u32 = @import("std").mem.zeroes(u32),
    rcv_wup: u32 = @import("std").mem.zeroes(u32),
};
pub const struct_tcp_zerocopy_receive = extern struct {
    address: u64 = @import("std").mem.zeroes(u64),
    length: u32 = @import("std").mem.zeroes(u32),
    recv_skip_hint: u32 = @import("std").mem.zeroes(u32),
};
pub extern fn inet_addr(__cp: [*c]const u8) in_addr_t;
pub extern fn inet_lnaof(__in: struct_in_addr) in_addr_t;
pub extern fn inet_makeaddr(__net: in_addr_t, __host: in_addr_t) struct_in_addr;
pub extern fn inet_netof(__in: struct_in_addr) in_addr_t;
pub extern fn inet_network(__cp: [*c]const u8) in_addr_t;
pub extern fn inet_ntoa(__in: struct_in_addr) [*c]u8;
pub extern fn inet_pton(__af: c_int, noalias __cp: [*c]const u8, noalias __buf: ?*anyopaque) c_int;
pub extern fn inet_ntop(__af: c_int, noalias __cp: ?*const anyopaque, noalias __buf: [*c]u8, __len: socklen_t) [*c]const u8;
pub extern fn inet_aton(__cp: [*c]const u8, __inp: [*c]struct_in_addr) c_int;
pub extern fn inet_neta(__net: in_addr_t, __buf: [*c]u8, __len: usize) [*c]u8;
pub extern fn inet_net_ntop(__af: c_int, __cp: ?*const anyopaque, __bits: c_int, __buf: [*c]u8, __len: usize) [*c]u8;
pub extern fn inet_net_pton(__af: c_int, __cp: [*c]const u8, __buf: ?*anyopaque, __len: usize) c_int;
pub extern fn inet_nsap_addr(__cp: [*c]const u8, __buf: [*c]u8, __len: c_int) c_uint;
pub extern fn inet_nsap_ntoa(__len: c_int, __cp: [*c]const u8, __buf: [*c]u8) [*c]u8;
pub const struct_rpcent = extern struct {
    r_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    r_aliases: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    r_number: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn setrpcent(__stayopen: c_int) void;
pub extern fn endrpcent() void;
pub extern fn getrpcbyname(__name: [*c]const u8) [*c]struct_rpcent;
pub extern fn getrpcbynumber(__number: c_int) [*c]struct_rpcent;
pub extern fn getrpcent() [*c]struct_rpcent;
pub extern fn getrpcbyname_r(__name: [*c]const u8, __result_buf: [*c]struct_rpcent, __buffer: [*c]u8, __buflen: usize, __result: [*c][*c]struct_rpcent) c_int;
pub extern fn getrpcbynumber_r(__number: c_int, __result_buf: [*c]struct_rpcent, __buffer: [*c]u8, __buflen: usize, __result: [*c][*c]struct_rpcent) c_int;
pub extern fn getrpcent_r(__result_buf: [*c]struct_rpcent, __buffer: [*c]u8, __buflen: usize, __result: [*c][*c]struct_rpcent) c_int;
pub const struct_netent = extern struct {
    n_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    n_aliases: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    n_addrtype: c_int = @import("std").mem.zeroes(c_int),
    n_net: u32 = @import("std").mem.zeroes(u32),
};
pub extern fn __h_errno_location() [*c]c_int;
pub extern fn herror(__str: [*c]const u8) void;
pub extern fn hstrerror(__err_num: c_int) [*c]const u8;
pub const struct_hostent = extern struct {
    h_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    h_aliases: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    h_addrtype: c_int = @import("std").mem.zeroes(c_int),
    h_length: c_int = @import("std").mem.zeroes(c_int),
    h_addr_list: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
};
pub extern fn sethostent(__stay_open: c_int) void;
pub extern fn endhostent() void;
pub extern fn gethostent() [*c]struct_hostent;
pub extern fn gethostbyaddr(__addr: ?*const anyopaque, __len: __socklen_t, __type: c_int) [*c]struct_hostent;
pub extern fn gethostbyname(__name: [*c]const u8) [*c]struct_hostent;
pub extern fn gethostbyname2(__name: [*c]const u8, __af: c_int) [*c]struct_hostent;
pub extern fn gethostent_r(noalias __result_buf: [*c]struct_hostent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_hostent, noalias __h_errnop: [*c]c_int) c_int;
pub extern fn gethostbyaddr_r(noalias __addr: ?*const anyopaque, __len: __socklen_t, __type: c_int, noalias __result_buf: [*c]struct_hostent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_hostent, noalias __h_errnop: [*c]c_int) c_int;
pub extern fn gethostbyname_r(noalias __name: [*c]const u8, noalias __result_buf: [*c]struct_hostent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_hostent, noalias __h_errnop: [*c]c_int) c_int;
pub extern fn gethostbyname2_r(noalias __name: [*c]const u8, __af: c_int, noalias __result_buf: [*c]struct_hostent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_hostent, noalias __h_errnop: [*c]c_int) c_int;
pub extern fn setnetent(__stay_open: c_int) void;
pub extern fn endnetent() void;
pub extern fn getnetent() [*c]struct_netent;
pub extern fn getnetbyaddr(__net: u32, __type: c_int) [*c]struct_netent;
pub extern fn getnetbyname(__name: [*c]const u8) [*c]struct_netent;
pub extern fn getnetent_r(noalias __result_buf: [*c]struct_netent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_netent, noalias __h_errnop: [*c]c_int) c_int;
pub extern fn getnetbyaddr_r(__net: u32, __type: c_int, noalias __result_buf: [*c]struct_netent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_netent, noalias __h_errnop: [*c]c_int) c_int;
pub extern fn getnetbyname_r(noalias __name: [*c]const u8, noalias __result_buf: [*c]struct_netent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_netent, noalias __h_errnop: [*c]c_int) c_int;
pub const struct_servent = extern struct {
    s_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    s_aliases: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    s_port: c_int = @import("std").mem.zeroes(c_int),
    s_proto: [*c]u8 = @import("std").mem.zeroes([*c]u8),
};
pub extern fn setservent(__stay_open: c_int) void;
pub extern fn endservent() void;
pub extern fn getservent() [*c]struct_servent;
pub extern fn getservbyname(__name: [*c]const u8, __proto: [*c]const u8) [*c]struct_servent;
pub extern fn getservbyport(__port: c_int, __proto: [*c]const u8) [*c]struct_servent;
pub extern fn getservent_r(noalias __result_buf: [*c]struct_servent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_servent) c_int;
pub extern fn getservbyname_r(noalias __name: [*c]const u8, noalias __proto: [*c]const u8, noalias __result_buf: [*c]struct_servent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_servent) c_int;
pub extern fn getservbyport_r(__port: c_int, noalias __proto: [*c]const u8, noalias __result_buf: [*c]struct_servent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_servent) c_int;
pub const struct_protoent = extern struct {
    p_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    p_aliases: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    p_proto: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn setprotoent(__stay_open: c_int) void;
pub extern fn endprotoent() void;
pub extern fn getprotoent() [*c]struct_protoent;
pub extern fn getprotobyname(__name: [*c]const u8) [*c]struct_protoent;
pub extern fn getprotobynumber(__proto: c_int) [*c]struct_protoent;
pub extern fn getprotoent_r(noalias __result_buf: [*c]struct_protoent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_protoent) c_int;
pub extern fn getprotobyname_r(noalias __name: [*c]const u8, noalias __result_buf: [*c]struct_protoent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_protoent) c_int;
pub extern fn getprotobynumber_r(__proto: c_int, noalias __result_buf: [*c]struct_protoent, noalias __buf: [*c]u8, __buflen: usize, noalias __result: [*c][*c]struct_protoent) c_int;
pub extern fn setnetgrent(__netgroup: [*c]const u8) c_int;
pub extern fn endnetgrent() void;
pub extern fn getnetgrent(noalias __hostp: [*c][*c]u8, noalias __userp: [*c][*c]u8, noalias __domainp: [*c][*c]u8) c_int;
pub extern fn innetgr(__netgroup: [*c]const u8, __host: [*c]const u8, __user: [*c]const u8, __domain: [*c]const u8) c_int;
pub extern fn getnetgrent_r(noalias __hostp: [*c][*c]u8, noalias __userp: [*c][*c]u8, noalias __domainp: [*c][*c]u8, noalias __buffer: [*c]u8, __buflen: usize) c_int;
pub extern fn rcmd(noalias __ahost: [*c][*c]u8, __rport: c_ushort, noalias __locuser: [*c]const u8, noalias __remuser: [*c]const u8, noalias __cmd: [*c]const u8, noalias __fd2p: [*c]c_int) c_int;
pub extern fn rcmd_af(noalias __ahost: [*c][*c]u8, __rport: c_ushort, noalias __locuser: [*c]const u8, noalias __remuser: [*c]const u8, noalias __cmd: [*c]const u8, noalias __fd2p: [*c]c_int, __af: sa_family_t) c_int;
pub extern fn rexec(noalias __ahost: [*c][*c]u8, __rport: c_int, noalias __name: [*c]const u8, noalias __pass: [*c]const u8, noalias __cmd: [*c]const u8, noalias __fd2p: [*c]c_int) c_int;
pub extern fn rexec_af(noalias __ahost: [*c][*c]u8, __rport: c_int, noalias __name: [*c]const u8, noalias __pass: [*c]const u8, noalias __cmd: [*c]const u8, noalias __fd2p: [*c]c_int, __af: sa_family_t) c_int;
pub extern fn ruserok(__rhost: [*c]const u8, __suser: c_int, __remuser: [*c]const u8, __locuser: [*c]const u8) c_int;
pub extern fn ruserok_af(__rhost: [*c]const u8, __suser: c_int, __remuser: [*c]const u8, __locuser: [*c]const u8, __af: sa_family_t) c_int;
pub extern fn iruserok(__raddr: u32, __suser: c_int, __remuser: [*c]const u8, __locuser: [*c]const u8) c_int;
pub extern fn iruserok_af(__raddr: ?*const anyopaque, __suser: c_int, __remuser: [*c]const u8, __locuser: [*c]const u8, __af: sa_family_t) c_int;
pub extern fn rresvport(__alport: [*c]c_int) c_int;
pub extern fn rresvport_af(__alport: [*c]c_int, __af: sa_family_t) c_int;
pub const struct_addrinfo = extern struct {
    ai_flags: c_int = @import("std").mem.zeroes(c_int),
    ai_family: c_int = @import("std").mem.zeroes(c_int),
    ai_socktype: c_int = @import("std").mem.zeroes(c_int),
    ai_protocol: c_int = @import("std").mem.zeroes(c_int),
    ai_addrlen: socklen_t = @import("std").mem.zeroes(socklen_t),
    ai_addr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    ai_canonname: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    ai_next: [*c]struct_addrinfo = @import("std").mem.zeroes([*c]struct_addrinfo),
};
pub const struct_gaicb = extern struct {
    ar_name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    ar_service: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    ar_request: [*c]const struct_addrinfo = @import("std").mem.zeroes([*c]const struct_addrinfo),
    ar_result: [*c]struct_addrinfo = @import("std").mem.zeroes([*c]struct_addrinfo),
    __return: c_int = @import("std").mem.zeroes(c_int),
    __glibc_reserved: [5]c_int = @import("std").mem.zeroes([5]c_int),
};
pub extern fn getaddrinfo(noalias __name: [*c]const u8, noalias __service: [*c]const u8, noalias __req: [*c]const struct_addrinfo, noalias __pai: [*c][*c]struct_addrinfo) c_int;
pub extern fn freeaddrinfo(__ai: [*c]struct_addrinfo) void;
pub extern fn gai_strerror(__ecode: c_int) [*c]const u8;
pub extern fn getnameinfo(noalias __sa: [*c]const struct_sockaddr, __salen: socklen_t, noalias __host: [*c]u8, __hostlen: socklen_t, noalias __serv: [*c]u8, __servlen: socklen_t, __flags: c_int) c_int;
pub extern fn getaddrinfo_a(__mode: c_int, noalias __list: [*c][*c]struct_gaicb, __ent: c_int, noalias __sig: [*c]struct_sigevent) c_int;
pub extern fn gai_suspend(__list: [*c]const [*c]const struct_gaicb, __ent: c_int, __timeout: [*c]const struct_timespec) c_int;
pub extern fn gai_error(__req: [*c]struct_gaicb) c_int;
pub extern fn gai_cancel(__gaicbp: [*c]struct_gaicb) c_int;
// /usr/include/bits/timex.h:81:3: warning: struct demoted to opaque type - has bitfield
pub const struct_timex = opaque {};
pub extern fn clock_adjtime(__clock_id: __clockid_t, __utx: ?*struct_timex) c_int;
pub const struct_tm = extern struct {
    tm_sec: c_int = @import("std").mem.zeroes(c_int),
    tm_min: c_int = @import("std").mem.zeroes(c_int),
    tm_hour: c_int = @import("std").mem.zeroes(c_int),
    tm_mday: c_int = @import("std").mem.zeroes(c_int),
    tm_mon: c_int = @import("std").mem.zeroes(c_int),
    tm_year: c_int = @import("std").mem.zeroes(c_int),
    tm_wday: c_int = @import("std").mem.zeroes(c_int),
    tm_yday: c_int = @import("std").mem.zeroes(c_int),
    tm_isdst: c_int = @import("std").mem.zeroes(c_int),
    tm_gmtoff: c_long = @import("std").mem.zeroes(c_long),
    tm_zone: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const struct_itimerspec = extern struct {
    it_interval: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    it_value: struct_timespec = @import("std").mem.zeroes(struct_timespec),
};
pub extern fn clock() clock_t;
pub extern fn time(__timer: [*c]time_t) time_t;
pub extern fn difftime(__time1: time_t, __time0: time_t) f64;
pub extern fn mktime(__tp: [*c]struct_tm) time_t;
pub extern fn strftime(noalias __s: [*c]u8, __maxsize: usize, noalias __format: [*c]const u8, noalias __tp: [*c]const struct_tm) usize;
pub extern fn strptime(noalias __s: [*c]const u8, noalias __fmt: [*c]const u8, __tp: [*c]struct_tm) [*c]u8;
pub extern fn strftime_l(noalias __s: [*c]u8, __maxsize: usize, noalias __format: [*c]const u8, noalias __tp: [*c]const struct_tm, __loc: locale_t) usize;
pub extern fn strptime_l(noalias __s: [*c]const u8, noalias __fmt: [*c]const u8, __tp: [*c]struct_tm, __loc: locale_t) [*c]u8;
pub extern fn gmtime(__timer: [*c]const time_t) [*c]struct_tm;
pub extern fn localtime(__timer: [*c]const time_t) [*c]struct_tm;
pub extern fn gmtime_r(noalias __timer: [*c]const time_t, noalias __tp: [*c]struct_tm) [*c]struct_tm;
pub extern fn localtime_r(noalias __timer: [*c]const time_t, noalias __tp: [*c]struct_tm) [*c]struct_tm;
pub extern fn asctime(__tp: [*c]const struct_tm) [*c]u8;
pub extern fn ctime(__timer: [*c]const time_t) [*c]u8;
pub extern fn asctime_r(noalias __tp: [*c]const struct_tm, noalias __buf: [*c]u8) [*c]u8;
pub extern fn ctime_r(noalias __timer: [*c]const time_t, noalias __buf: [*c]u8) [*c]u8;
pub extern var __tzname: [2][*c]u8;
pub extern var __daylight: c_int;
pub extern var __timezone: c_long;
pub extern var tzname: [2][*c]u8;
pub extern fn tzset() void;
pub extern var daylight: c_int;
pub extern var timezone: c_long;
pub extern fn timegm(__tp: [*c]struct_tm) time_t;
pub extern fn timelocal(__tp: [*c]struct_tm) time_t;
pub extern fn dysize(__year: c_int) c_int;
pub extern fn nanosleep(__requested_time: [*c]const struct_timespec, __remaining: [*c]struct_timespec) c_int;
pub extern fn clock_getres(__clock_id: clockid_t, __res: [*c]struct_timespec) c_int;
pub extern fn clock_gettime(__clock_id: clockid_t, __tp: [*c]struct_timespec) c_int;
pub extern fn clock_settime(__clock_id: clockid_t, __tp: [*c]const struct_timespec) c_int;
pub extern fn clock_nanosleep(__clock_id: clockid_t, __flags: c_int, __req: [*c]const struct_timespec, __rem: [*c]struct_timespec) c_int;
pub extern fn clock_getcpuclockid(__pid: pid_t, __clock_id: [*c]clockid_t) c_int;
pub extern fn timer_create(__clock_id: clockid_t, noalias __evp: [*c]struct_sigevent, noalias __timerid: [*c]timer_t) c_int;
pub extern fn timer_delete(__timerid: timer_t) c_int;
pub extern fn timer_settime(__timerid: timer_t, __flags: c_int, noalias __value: [*c]const struct_itimerspec, noalias __ovalue: [*c]struct_itimerspec) c_int;
pub extern fn timer_gettime(__timerid: timer_t, __value: [*c]struct_itimerspec) c_int;
pub extern fn timer_getoverrun(__timerid: timer_t) c_int;
pub extern fn timespec_get(__ts: [*c]struct_timespec, __base: c_int) c_int;
pub extern fn timespec_getres(__ts: [*c]struct_timespec, __base: c_int) c_int;
pub extern var getdate_err: c_int;
pub extern fn getdate(__string: [*c]const u8) [*c]struct_tm;
pub extern fn getdate_r(noalias __string: [*c]const u8, noalias __resbufp: [*c]struct_tm) c_int;
pub extern fn memalign(__alignment: c_ulong, __size: c_ulong) ?*anyopaque;
pub extern fn pvalloc(__size: usize) ?*anyopaque;
pub const struct_mallinfo = extern struct {
    arena: c_int = @import("std").mem.zeroes(c_int),
    ordblks: c_int = @import("std").mem.zeroes(c_int),
    smblks: c_int = @import("std").mem.zeroes(c_int),
    hblks: c_int = @import("std").mem.zeroes(c_int),
    hblkhd: c_int = @import("std").mem.zeroes(c_int),
    usmblks: c_int = @import("std").mem.zeroes(c_int),
    fsmblks: c_int = @import("std").mem.zeroes(c_int),
    uordblks: c_int = @import("std").mem.zeroes(c_int),
    fordblks: c_int = @import("std").mem.zeroes(c_int),
    keepcost: c_int = @import("std").mem.zeroes(c_int),
};
pub const struct_mallinfo2 = extern struct {
    arena: usize = @import("std").mem.zeroes(usize),
    ordblks: usize = @import("std").mem.zeroes(usize),
    smblks: usize = @import("std").mem.zeroes(usize),
    hblks: usize = @import("std").mem.zeroes(usize),
    hblkhd: usize = @import("std").mem.zeroes(usize),
    usmblks: usize = @import("std").mem.zeroes(usize),
    fsmblks: usize = @import("std").mem.zeroes(usize),
    uordblks: usize = @import("std").mem.zeroes(usize),
    fordblks: usize = @import("std").mem.zeroes(usize),
    keepcost: usize = @import("std").mem.zeroes(usize),
};
pub extern fn mallinfo() struct_mallinfo;
pub extern fn mallinfo2() struct_mallinfo2;
pub extern fn mallopt(__param: c_int, __val: c_int) c_int;
pub extern fn malloc_trim(__pad: usize) c_int;
pub extern fn malloc_usable_size(__ptr: ?*anyopaque) usize;
pub extern fn malloc_stats() void;
pub extern fn malloc_info(__options: c_int, __fp: [*c]FILE) c_int;
pub const struct_winsize = extern struct {
    ws_row: c_ushort = @import("std").mem.zeroes(c_ushort),
    ws_col: c_ushort = @import("std").mem.zeroes(c_ushort),
    ws_xpixel: c_ushort = @import("std").mem.zeroes(c_ushort),
    ws_ypixel: c_ushort = @import("std").mem.zeroes(c_ushort),
};
pub const struct_termio = extern struct {
    c_iflag: c_ushort = @import("std").mem.zeroes(c_ushort),
    c_oflag: c_ushort = @import("std").mem.zeroes(c_ushort),
    c_cflag: c_ushort = @import("std").mem.zeroes(c_ushort),
    c_lflag: c_ushort = @import("std").mem.zeroes(c_ushort),
    c_line: u8 = @import("std").mem.zeroes(u8),
    c_cc: [8]u8 = @import("std").mem.zeroes([8]u8),
};
pub extern fn ioctl(__fd: c_int, __request: c_ulong, ...) c_int;
pub const struct_crypt_data = extern struct {
    output: [384]u8 = @import("std").mem.zeroes([384]u8),
    setting: [384]u8 = @import("std").mem.zeroes([384]u8),
    input: [512]u8 = @import("std").mem.zeroes([512]u8),
    reserved: [767]u8 = @import("std").mem.zeroes([767]u8),
    initialized: u8 = @import("std").mem.zeroes(u8),
    internal: [30720]u8 = @import("std").mem.zeroes([30720]u8),
};
pub extern fn crypt_r(__phrase: [*c]const u8, __setting: [*c]const u8, noalias __data: [*c]struct_crypt_data) [*c]u8;
pub extern fn crypt_rn(__phrase: [*c]const u8, __setting: [*c]const u8, __data: ?*anyopaque, __size: c_int) [*c]u8;
pub extern fn crypt_ra(__phrase: [*c]const u8, __setting: [*c]const u8, __data: [*c]?*anyopaque, __size: [*c]c_int) [*c]u8;
pub extern fn crypt_gensalt(__prefix: [*c]const u8, __count: c_ulong, __rbytes: [*c]const u8, __nrbytes: c_int) [*c]u8;
pub extern fn crypt_gensalt_rn(__prefix: [*c]const u8, __count: c_ulong, __rbytes: [*c]const u8, __nrbytes: c_int, __output: [*c]u8, __output_size: c_int) [*c]u8;
pub extern fn crypt_gensalt_r(__prefix: [*c]const u8, __count: c_ulong, __rbytes: [*c]const u8, __nrbytes: c_int, __output: [*c]u8, __output_size: c_int) [*c]u8;
pub extern fn crypt_gensalt_ra(__prefix: [*c]const u8, __count: c_ulong, __rbytes: [*c]const u8, __nrbytes: c_int) [*c]u8;
pub extern fn crypt_checksalt(__setting: [*c]const u8) c_int;
pub extern fn crypt_preferred_method() [*c]const u8;
pub const struct_utsname = extern struct {
    sysname: [65]u8 = @import("std").mem.zeroes([65]u8),
    nodename: [65]u8 = @import("std").mem.zeroes([65]u8),
    release: [65]u8 = @import("std").mem.zeroes([65]u8),
    version: [65]u8 = @import("std").mem.zeroes([65]u8),
    machine: [65]u8 = @import("std").mem.zeroes([65]u8),
    domainname: [65]u8 = @import("std").mem.zeroes([65]u8),
};
pub extern fn uname(__name: [*c]struct_utsname) c_int;
pub extern fn _dl_mcount_wrapper_check(__selfpc: ?*anyopaque) void;
pub const Lmid_t = c_long;
pub extern fn dlopen(__file: [*c]const u8, __mode: c_int) ?*anyopaque;
pub extern fn dlclose(__handle: ?*anyopaque) c_int;
pub extern fn dlsym(noalias __handle: ?*anyopaque, noalias __name: [*c]const u8) ?*anyopaque;
pub extern fn dlmopen(__nsid: Lmid_t, __file: [*c]const u8, __mode: c_int) ?*anyopaque;
pub extern fn dlvsym(noalias __handle: ?*anyopaque, noalias __name: [*c]const u8, noalias __version: [*c]const u8) ?*anyopaque;
pub extern fn dlerror() [*c]u8;
pub const Dl_info = extern struct {
    dli_fname: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    dli_fbase: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    dli_sname: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    dli_saddr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub extern fn dladdr(__address: ?*const anyopaque, __info: [*c]Dl_info) c_int;
pub extern fn dladdr1(__address: ?*const anyopaque, __info: [*c]Dl_info, __extra_info: [*c]?*anyopaque, __flags: c_int) c_int;
pub const RTLD_DL_SYMENT: c_int = 1;
pub const RTLD_DL_LINKMAP: c_int = 2;
const enum_unnamed_70 = c_uint;
pub extern fn dlinfo(noalias __handle: ?*anyopaque, __request: c_int, noalias __arg: ?*anyopaque) c_int;
pub const RTLD_DI_LMID: c_int = 1;
pub const RTLD_DI_LINKMAP: c_int = 2;
pub const RTLD_DI_CONFIGADDR: c_int = 3;
pub const RTLD_DI_SERINFO: c_int = 4;
pub const RTLD_DI_SERINFOSIZE: c_int = 5;
pub const RTLD_DI_ORIGIN: c_int = 6;
pub const RTLD_DI_PROFILENAME: c_int = 7;
pub const RTLD_DI_PROFILEOUT: c_int = 8;
pub const RTLD_DI_TLS_MODID: c_int = 9;
pub const RTLD_DI_TLS_DATA: c_int = 10;
pub const RTLD_DI_PHDR: c_int = 11;
pub const RTLD_DI_MAX: c_int = 11;
const enum_unnamed_71 = c_uint;
pub const Dl_serpath = extern struct {
    dls_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    dls_flags: c_uint = @import("std").mem.zeroes(c_uint),
};
const union_unnamed_72 = extern union {
    dls_serpath: [0]Dl_serpath,
    __dls_serpath_pad: [1]Dl_serpath,
};
pub const Dl_serinfo = extern struct {
    dls_size: usize = @import("std").mem.zeroes(usize),
    dls_cnt: c_uint = @import("std").mem.zeroes(c_uint),
    unnamed_0: union_unnamed_72 = @import("std").mem.zeroes(union_unnamed_72),
};
pub const struct_link_map_73 = opaque {};
pub const struct_dl_find_object = extern struct {
    dlfo_flags: c_ulonglong = @import("std").mem.zeroes(c_ulonglong),
    dlfo_map_start: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    dlfo_map_end: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    dlfo_link_map: ?*struct_link_map_73 = @import("std").mem.zeroes(?*struct_link_map_73),
    dlfo_eh_frame: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __dflo_reserved: [7]c_ulonglong = @import("std").mem.zeroes([7]c_ulonglong),
};
pub extern fn _dl_find_object(__address: ?*anyopaque, __result: [*c]struct_dl_find_object) c_int;
pub const sem_t = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub extern fn sem_init(__sem: [*c]sem_t, __pshared: c_int, __value: c_uint) c_int;
pub extern fn sem_destroy(__sem: [*c]sem_t) c_int;
pub extern fn sem_open(__name: [*c]const u8, __oflag: c_int, ...) [*c]sem_t;
pub extern fn sem_close(__sem: [*c]sem_t) c_int;
pub extern fn sem_unlink(__name: [*c]const u8) c_int;
pub extern fn sem_wait(__sem: [*c]sem_t) c_int;
pub extern fn sem_timedwait(noalias __sem: [*c]sem_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn sem_clockwait(noalias __sem: [*c]sem_t, clock: clockid_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn sem_trywait(__sem: [*c]sem_t) c_int;
pub extern fn sem_post(__sem: [*c]sem_t) c_int;
pub extern fn sem_getvalue(noalias __sem: [*c]sem_t, noalias __sval: [*c]c_int) c_int;
pub const struct_prctl_mm_map = extern struct {
    start_code: __u64 = @import("std").mem.zeroes(__u64),
    end_code: __u64 = @import("std").mem.zeroes(__u64),
    start_data: __u64 = @import("std").mem.zeroes(__u64),
    end_data: __u64 = @import("std").mem.zeroes(__u64),
    start_brk: __u64 = @import("std").mem.zeroes(__u64),
    brk: __u64 = @import("std").mem.zeroes(__u64),
    start_stack: __u64 = @import("std").mem.zeroes(__u64),
    arg_start: __u64 = @import("std").mem.zeroes(__u64),
    arg_end: __u64 = @import("std").mem.zeroes(__u64),
    env_start: __u64 = @import("std").mem.zeroes(__u64),
    env_end: __u64 = @import("std").mem.zeroes(__u64),
    auxv: [*c]__u64 = @import("std").mem.zeroes([*c]__u64),
    auxv_size: __u32 = @import("std").mem.zeroes(__u32),
    exe_fd: __u32 = @import("std").mem.zeroes(__u32),
};
pub extern fn prctl(__option: c_int, ...) c_int;
pub extern fn sendfile(__out_fd: c_int, __in_fd: c_int, __offset: [*c]__off64_t, __count: usize) isize;
pub extern fn sendfile64(__out_fd: c_int, __in_fd: c_int, __offset: [*c]__off64_t, __count: usize) isize;
pub const EPOLL_CLOEXEC: c_int = 524288;
const enum_unnamed_74 = c_uint;
pub const EPOLLIN: c_int = 1;
pub const EPOLLPRI: c_int = 2;
pub const EPOLLOUT: c_int = 4;
pub const EPOLLRDNORM: c_int = 64;
pub const EPOLLRDBAND: c_int = 128;
pub const EPOLLWRNORM: c_int = 256;
pub const EPOLLWRBAND: c_int = 512;
pub const EPOLLMSG: c_int = 1024;
pub const EPOLLERR: c_int = 8;
pub const EPOLLHUP: c_int = 16;
pub const EPOLLRDHUP: c_int = 8192;
pub const EPOLLEXCLUSIVE: c_int = 268435456;
pub const EPOLLWAKEUP: c_int = 536870912;
pub const EPOLLONESHOT: c_int = 1073741824;
pub const EPOLLET: c_uint = 2147483648;
pub const enum_EPOLL_EVENTS = c_uint;
pub const union_epoll_data = extern union {
    ptr: ?*anyopaque,
    fd: c_int,
    u32: u32,
    u64: u64,
};
pub const epoll_data_t = union_epoll_data;
pub const struct_epoll_event = extern struct {
    events: u32 align(1) = @import("std").mem.zeroes(u32),
    data: epoll_data_t align(1) = @import("std").mem.zeroes(epoll_data_t),
};
pub const struct_epoll_params = extern struct {
    busy_poll_usecs: u32 = @import("std").mem.zeroes(u32),
    busy_poll_budget: u16 = @import("std").mem.zeroes(u16),
    prefer_busy_poll: u8 = @import("std").mem.zeroes(u8),
    __pad: u8 = @import("std").mem.zeroes(u8),
};
pub extern fn epoll_create(__size: c_int) c_int;
pub extern fn epoll_create1(__flags: c_int) c_int;
pub extern fn epoll_ctl(__epfd: c_int, __op: c_int, __fd: c_int, __event: [*c]struct_epoll_event) c_int;
pub extern fn epoll_wait(__epfd: c_int, __events: [*c]struct_epoll_event, __maxevents: c_int, __timeout: c_int) c_int;
pub extern fn epoll_pwait(__epfd: c_int, __events: [*c]struct_epoll_event, __maxevents: c_int, __timeout: c_int, __ss: [*c]const __sigset_t) c_int;
pub extern fn epoll_pwait2(__epfd: c_int, __events: [*c]struct_epoll_event, __maxevents: c_int, __timeout: [*c]const struct_timespec, __ss: [*c]const __sigset_t) c_int;
pub const EFD_SEMAPHORE: c_int = 1;
pub const EFD_CLOEXEC: c_int = 524288;
pub const EFD_NONBLOCK: c_int = 2048;
const enum_unnamed_75 = c_uint;
pub const eventfd_t = u64;
pub extern fn eventfd(__count: c_uint, __flags: c_int) c_int;
pub extern fn eventfd_read(__fd: c_int, __value: [*c]eventfd_t) c_int;
pub extern fn eventfd_write(__fd: c_int, __value: eventfd_t) c_int;
pub const struct___user_cap_header_struct = extern struct {
    version: __u32 = @import("std").mem.zeroes(__u32),
    pid: c_int = @import("std").mem.zeroes(c_int),
};
pub const cap_user_header_t = [*c]struct___user_cap_header_struct;
pub const struct___user_cap_data_struct = extern struct {
    effective: __u32 = @import("std").mem.zeroes(__u32),
    permitted: __u32 = @import("std").mem.zeroes(__u32),
    inheritable: __u32 = @import("std").mem.zeroes(__u32),
};
pub const cap_user_data_t = [*c]struct___user_cap_data_struct;
const struct_unnamed_76 = extern struct {
    permitted: __le32 = @import("std").mem.zeroes(__le32),
    inheritable: __le32 = @import("std").mem.zeroes(__le32),
};
pub const struct_vfs_cap_data = extern struct {
    magic_etc: __le32 = @import("std").mem.zeroes(__le32),
    data: [2]struct_unnamed_76 = @import("std").mem.zeroes([2]struct_unnamed_76),
};
const struct_unnamed_77 = extern struct {
    permitted: __le32 = @import("std").mem.zeroes(__le32),
    inheritable: __le32 = @import("std").mem.zeroes(__le32),
};
pub const struct_vfs_ns_cap_data = extern struct {
    magic_etc: __le32 = @import("std").mem.zeroes(__le32),
    data: [2]struct_unnamed_77 = @import("std").mem.zeroes([2]struct_unnamed_77),
    rootid: __le32 = @import("std").mem.zeroes(__le32),
};
const struct_unnamed_79 = extern struct {
    uh_sport: u16 = @import("std").mem.zeroes(u16),
    uh_dport: u16 = @import("std").mem.zeroes(u16),
    uh_ulen: u16 = @import("std").mem.zeroes(u16),
    uh_sum: u16 = @import("std").mem.zeroes(u16),
};
const struct_unnamed_80 = extern struct {
    source: u16 = @import("std").mem.zeroes(u16),
    dest: u16 = @import("std").mem.zeroes(u16),
    len: u16 = @import("std").mem.zeroes(u16),
    check: u16 = @import("std").mem.zeroes(u16),
};
const union_unnamed_78 = extern union {
    unnamed_0: struct_unnamed_79,
    unnamed_1: struct_unnamed_80,
};
pub const struct_udphdr = extern struct {
    unnamed_0: union_unnamed_78 = @import("std").mem.zeroes(union_unnamed_78),
};
pub const ngx_int_t = isize;
pub const ngx_uint_t = usize;
pub const ngx_flag_t = isize;
pub const ngx_buf_tag_t = ?*anyopaque;
pub const ngx_fd_t = c_int;
pub const ngx_file_info_t = struct_stat;
pub const struct_ngx_open_file_s = extern struct {
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    flush: ?*const fn ([*c]ngx_open_file_t, [*c]ngx_log_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_open_file_t, [*c]ngx_log_t) callconv(.C) void),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_open_file_t = struct_ngx_open_file_s;
pub const ngx_atomic_uint_t = c_ulong;
pub const ngx_log_handler_pt = ?*const fn ([*c]ngx_log_t, [*c]u_char, usize) callconv(.C) [*c]u_char;
pub const ngx_log_writer_pt = ?*const fn ([*c]ngx_log_t, ngx_uint_t, [*c]u_char, usize) callconv(.C) void;
pub const struct_ngx_log_s = extern struct {
    log_level: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    file: [*c]ngx_open_file_t = @import("std").mem.zeroes([*c]ngx_open_file_t),
    connection: ngx_atomic_uint_t = @import("std").mem.zeroes(ngx_atomic_uint_t),
    disk_full_time: time_t = @import("std").mem.zeroes(time_t),
    handler: ngx_log_handler_pt = @import("std").mem.zeroes(ngx_log_handler_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    writer: ngx_log_writer_pt = @import("std").mem.zeroes(ngx_log_writer_pt),
    wdata: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    action: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    next: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub const ngx_log_t = struct_ngx_log_s;
pub const struct_ngx_file_s = extern struct {
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    info: ngx_file_info_t = @import("std").mem.zeroes(ngx_file_info_t),
    offset: off_t = @import("std").mem.zeroes(off_t),
    sys_offset: off_t = @import("std").mem.zeroes(off_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    flags: packed struct {
        valid_info: bool,
        directio: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_file_t = struct_ngx_file_s;
pub const struct_ngx_buf_s = extern struct {
    pos: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    last: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    file_pos: off_t = @import("std").mem.zeroes(off_t),
    file_last: off_t = @import("std").mem.zeroes(off_t),
    start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    tag: ngx_buf_tag_t = @import("std").mem.zeroes(ngx_buf_tag_t),
    file: [*c]ngx_file_t = @import("std").mem.zeroes([*c]ngx_file_t),
    shadow: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    flags: packed struct {
        temporary: bool,
        memory: bool,
        mmap: bool,
        recycled: bool,
        in_file: bool,
        flush: bool,
        sync: bool,
        last_buf: bool,
        last_in_chain: bool,
        last_shadow: bool,
        temp_file: bool,
        padding: u21,
    } = @import("std").mem.zeroes(c_uint),
    num: c_int = @import("std").mem.zeroes(c_int),
};
pub const ngx_buf_t = struct_ngx_buf_s;
pub const struct_ngx_chain_s = extern struct {
    buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    next: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
};
pub const ngx_chain_t = struct_ngx_chain_s;
pub const struct_ngx_pool_large_s = extern struct {
    next: [*c]ngx_pool_large_t = @import("std").mem.zeroes([*c]ngx_pool_large_t),
    alloc: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_pool_large_t = struct_ngx_pool_large_s;
pub const ngx_pool_cleanup_pt = ?*const fn (?*anyopaque) callconv(.C) void;
pub const struct_ngx_pool_cleanup_s = extern struct {
    handler: ngx_pool_cleanup_pt = @import("std").mem.zeroes(ngx_pool_cleanup_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    next: [*c]ngx_pool_cleanup_t = @import("std").mem.zeroes([*c]ngx_pool_cleanup_t),
};
pub const ngx_pool_cleanup_t = struct_ngx_pool_cleanup_s;
pub const struct_ngx_pool_s = extern struct {
    d: ngx_pool_data_t = @import("std").mem.zeroes(ngx_pool_data_t),
    max: usize = @import("std").mem.zeroes(usize),
    current: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    chain: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    large: [*c]ngx_pool_large_t = @import("std").mem.zeroes([*c]ngx_pool_large_t),
    cleanup: [*c]ngx_pool_cleanup_t = @import("std").mem.zeroes([*c]ngx_pool_cleanup_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub const ngx_pool_t = struct_ngx_pool_s;
pub const ngx_event_handler_pt = ?*const fn ([*c]ngx_event_t) callconv(.C) void;
pub const ngx_rbtree_key_t = ngx_uint_t;
pub const struct_ngx_rbtree_node_s = extern struct {
    key: ngx_rbtree_key_t = @import("std").mem.zeroes(ngx_rbtree_key_t),
    left: [*c]ngx_rbtree_node_t = @import("std").mem.zeroes([*c]ngx_rbtree_node_t),
    right: [*c]ngx_rbtree_node_t = @import("std").mem.zeroes([*c]ngx_rbtree_node_t),
    parent: [*c]ngx_rbtree_node_t = @import("std").mem.zeroes([*c]ngx_rbtree_node_t),
    color: u_char = @import("std").mem.zeroes(u_char),
    data: u_char = @import("std").mem.zeroes(u_char),
};
pub const ngx_rbtree_node_t = struct_ngx_rbtree_node_s;
pub const struct_ngx_queue_s = extern struct {
    prev: [*c]ngx_queue_t = @import("std").mem.zeroes([*c]ngx_queue_t),
    next: [*c]ngx_queue_t = @import("std").mem.zeroes([*c]ngx_queue_t),
};
pub const ngx_queue_t = struct_ngx_queue_s;
pub const struct_ngx_event_s = extern struct {
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    flags: packed struct {
        write: bool,
        accept: bool,
        instance: bool,
        active: bool,
        disabled: bool,
        ready: bool,
        oneshot: bool,
        complete: bool,
        eof: bool,
        @"error": bool,
        timeout: bool,
        timer_set: bool,
        delayed: bool,
        deferred_accept: bool,
        pending_eof: bool,
        posted: bool,
        closed: bool,
        channel: bool,
        resovler: bool,
        cancelable: bool,
        padding: u12,
    } = @import("std").mem.zeroes(c_uint),
    available: c_int = @import("std").mem.zeroes(c_int),
    handler: ngx_event_handler_pt = @import("std").mem.zeroes(ngx_event_handler_pt),
    index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    timer: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
};
pub const ngx_event_t = struct_ngx_event_s;
pub const ngx_socket_t = c_int;
pub const ngx_recv_pt = ?*const fn ([*c]ngx_connection_t, [*c]u_char, usize) callconv(.C) isize;
pub const ngx_send_pt = ?*const fn ([*c]ngx_connection_t, [*c]u_char, usize) callconv(.C) isize;
pub const ngx_recv_chain_pt = ?*const fn ([*c]ngx_connection_t, [*c]ngx_chain_t, off_t) callconv(.C) isize;
pub const ngx_send_chain_pt = ?*const fn ([*c]ngx_connection_t, [*c]ngx_chain_t, off_t) callconv(.C) [*c]ngx_chain_t;
pub const ngx_connection_handler_pt = ?*const fn ([*c]ngx_connection_t) callconv(.C) void;
pub const ngx_rbtree_insert_pt = ?*const fn ([*c]ngx_rbtree_node_t, [*c]ngx_rbtree_node_t, [*c]ngx_rbtree_node_t) callconv(.C) void;
pub const struct_ngx_rbtree_s = extern struct {
    root: [*c]ngx_rbtree_node_t = @import("std").mem.zeroes([*c]ngx_rbtree_node_t),
    sentinel: [*c]ngx_rbtree_node_t = @import("std").mem.zeroes([*c]ngx_rbtree_node_t),
    insert: ngx_rbtree_insert_pt = @import("std").mem.zeroes(ngx_rbtree_insert_pt),
};
pub const ngx_rbtree_t = struct_ngx_rbtree_s;
pub const struct_ngx_listening_s = extern struct {
    fd: ngx_socket_t = @import("std").mem.zeroes(ngx_socket_t),
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    addr_text_max_len: usize = @import("std").mem.zeroes(usize),
    addr_text: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    type: c_int = @import("std").mem.zeroes(c_int),
    backlog: c_int = @import("std").mem.zeroes(c_int),
    rcvbuf: c_int = @import("std").mem.zeroes(c_int),
    sndbuf: c_int = @import("std").mem.zeroes(c_int),
    keepidle: c_int = @import("std").mem.zeroes(c_int),
    keepintvl: c_int = @import("std").mem.zeroes(c_int),
    keepcnt: c_int = @import("std").mem.zeroes(c_int),
    handler: ngx_connection_handler_pt = @import("std").mem.zeroes(ngx_connection_handler_pt),
    servers: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    log: ngx_log_t = @import("std").mem.zeroes(ngx_log_t),
    logp: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    pool_size: usize = @import("std").mem.zeroes(usize),
    post_accept_buffer_size: usize = @import("std").mem.zeroes(usize),
    previous: [*c]ngx_listening_t = @import("std").mem.zeroes([*c]ngx_listening_t),
    connection: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    worker: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    flags: packed struct {
        open: bool,
        remain: bool,
        ignore: bool,
        bound: bool,
        inherited: bool,
        nonblocking_accept: bool,
        listen: bool,
        nonblocking: bool,
        shared: bool,
        addr_ntop: bool,
        wildcard: bool,
        ipv6only: bool,
        reuseport: bool,
        add_reuseport: bool,
        keepalive: u2,
        quic: bool,
        deferred_accept: bool,
        delete_deferred: bool,
        add_deferred: bool,
        padding: u12,
    } = @import("std").mem.zeroes(c_uint),
    fastopen: c_int = @import("std").mem.zeroes(c_int),
};
pub const ngx_listening_t = struct_ngx_listening_s;
pub const struct_ngx_proxy_protocol_s = extern struct {
    src_addr: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    dst_addr: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    src_port: in_port_t = @import("std").mem.zeroes(in_port_t),
    dst_port: in_port_t = @import("std").mem.zeroes(in_port_t),
    tlvs: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_proxy_protocol_t = struct_ngx_proxy_protocol_s;
pub const struct_ngx_udp_connection_s = extern struct {
    node: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    connection: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    buffer: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    key: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_udp_connection_t = struct_ngx_udp_connection_s;
pub const ngx_msec_t = ngx_rbtree_key_t;
pub const struct_ngx_connection_s = extern struct {
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    read: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    write: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    fd: ngx_socket_t = @import("std").mem.zeroes(ngx_socket_t),
    recv: ngx_recv_pt = @import("std").mem.zeroes(ngx_recv_pt),
    send: ngx_send_pt = @import("std").mem.zeroes(ngx_send_pt),
    recv_chain: ngx_recv_chain_pt = @import("std").mem.zeroes(ngx_recv_chain_pt),
    send_chain: ngx_send_chain_pt = @import("std").mem.zeroes(ngx_send_chain_pt),
    listening: [*c]ngx_listening_t = @import("std").mem.zeroes([*c]ngx_listening_t),
    sent: off_t = @import("std").mem.zeroes(off_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    type: c_int = @import("std").mem.zeroes(c_int),
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    addr_text: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    proxy_protocol: [*c]ngx_proxy_protocol_t = @import("std").mem.zeroes([*c]ngx_proxy_protocol_t),
    udp: [*c]ngx_udp_connection_t = @import("std").mem.zeroes([*c]ngx_udp_connection_t),
    local_sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    local_socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    buffer: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    number: ngx_atomic_uint_t = @import("std").mem.zeroes(ngx_atomic_uint_t),
    start_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    requests: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    flags: packed struct {
        buffered: u8,
        log_error: u3,
        timedout: bool,
        @"error": bool,
        destroyed: bool,
        pipeline: bool,
        idle: bool,
        resuable: bool,
        close: bool,
        shared: bool,
        snedfile: bool,
        sndlowat: bool,
        tcp_nodelay: u2,
        tcp_nopush: u2,
        need_last_buf: bool,
        need_flush_buf: bool,
        padding: u5,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_connection_t = struct_ngx_connection_s;
pub const ngx_module_t = struct_ngx_module_s;
pub const struct_ngx_cycle_s = extern struct {
    conf_ctx: [*c][*c][*c]?*anyopaque = @import("std").mem.zeroes([*c][*c][*c]?*anyopaque),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    new_log: ngx_log_t = @import("std").mem.zeroes(ngx_log_t),
    log_use_stderr: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    files: [*c][*c]ngx_connection_t = @import("std").mem.zeroes([*c][*c]ngx_connection_t),
    free_connections: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    free_connection_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    modules: [*c][*c]ngx_module_t = @import("std").mem.zeroes([*c][*c]ngx_module_t),
    modules_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    modules_used: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    reusable_connections_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    reusable_connections_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    connections_reuse_time: time_t = @import("std").mem.zeroes(time_t),
    listening: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    paths: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    config_dump: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    config_dump_rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    config_dump_sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    open_files: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    shared_memory: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    connection_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    files_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    connections: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    read_events: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    write_events: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    old_cycle: [*c]ngx_cycle_t = @import("std").mem.zeroes([*c]ngx_cycle_t),
    conf_file: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    conf_param: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    conf_prefix: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    prefix: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    error_log: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    lock_file: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    hostname: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_cycle_t = struct_ngx_cycle_s;
pub const ngx_conf_handler_pt = ?*const fn ([*c]ngx_conf_t, [*c]ngx_command_t, ?*anyopaque) callconv(.C) [*c]u8;
pub const struct_ngx_conf_s = extern struct {
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    args: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    cycle: [*c]ngx_cycle_t = @import("std").mem.zeroes([*c]ngx_cycle_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    temp_pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    conf_file: [*c]ngx_conf_file_t = @import("std").mem.zeroes([*c]ngx_conf_file_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    module_type: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    cmd_type: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    handler: ngx_conf_handler_pt = @import("std").mem.zeroes(ngx_conf_handler_pt),
    handler_conf: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_conf_t = struct_ngx_conf_s;
pub const struct_ngx_command_s = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    type: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    set: ?*const fn ([*c]ngx_conf_t, [*c]ngx_command_t, ?*anyopaque) callconv(.C) [*c]u8 = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t, [*c]ngx_command_t, ?*anyopaque) callconv(.C) [*c]u8),
    conf: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    offset: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    post: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_command_t = struct_ngx_command_s;
pub const struct_ngx_module_s = extern struct {
    ctx_index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    spare0: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    spare1: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    version: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    signature: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    commands: [*c]ngx_command_t = @import("std").mem.zeroes([*c]ngx_command_t),
    type: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    init_master: ?*const fn ([*c]ngx_log_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_log_t) callconv(.C) ngx_int_t),
    init_module: ?*const fn ([*c]ngx_cycle_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) ngx_int_t),
    init_process: ?*const fn ([*c]ngx_cycle_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) ngx_int_t),
    init_thread: ?*const fn ([*c]ngx_cycle_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) ngx_int_t),
    exit_thread: ?*const fn ([*c]ngx_cycle_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) void),
    exit_process: ?*const fn ([*c]ngx_cycle_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) void),
    exit_master: ?*const fn ([*c]ngx_cycle_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) void),
    spare_hook0: usize = @import("std").mem.zeroes(usize),
    spare_hook1: usize = @import("std").mem.zeroes(usize),
    spare_hook2: usize = @import("std").mem.zeroes(usize),
    spare_hook3: usize = @import("std").mem.zeroes(usize),
    spare_hook4: usize = @import("std").mem.zeroes(usize),
    spare_hook5: usize = @import("std").mem.zeroes(usize),
    spare_hook6: usize = @import("std").mem.zeroes(usize),
    spare_hook7: usize = @import("std").mem.zeroes(usize),
};
pub const struct_ngx_event_aio_s = opaque {};
pub const ngx_event_aio_t = struct_ngx_event_aio_s;
pub const struct_ngx_thread_task_s = opaque {};
pub const ngx_thread_task_t = struct_ngx_thread_task_s;
pub const struct_ngx_ssl_s = opaque {};
pub const ngx_ssl_t = struct_ngx_ssl_s;
pub const struct_ngx_quic_stream_s = opaque {};
pub const ngx_quic_stream_t = struct_ngx_quic_stream_s;
pub const struct_ngx_ssl_connection_s = opaque {};
pub const ngx_ssl_connection_t = struct_ngx_ssl_connection_s;
pub const ngx_err_t = c_int;
pub extern fn ngx_strerror(err: ngx_err_t, errstr: [*c]u_char, size: usize) [*c]u_char;
pub extern fn ngx_strerror_init() ngx_int_t;
pub const ngx_atomic_int_t = c_long;
pub const ngx_atomic_t = ngx_atomic_uint_t;
pub extern fn ngx_spinlock(lock: [*c]volatile ngx_atomic_t, value: ngx_atomic_int_t, spin: ngx_uint_t) void;
pub const ngx_rbtree_key_int_t = ngx_int_t;
pub extern fn ngx_rbtree_insert(tree: [*c]ngx_rbtree_t, node: [*c]ngx_rbtree_node_t) void;
pub extern fn ngx_rbtree_delete(tree: [*c]ngx_rbtree_t, node: [*c]ngx_rbtree_node_t) void;
pub extern fn ngx_rbtree_insert_value(root: [*c]ngx_rbtree_node_t, node: [*c]ngx_rbtree_node_t, sentinel: [*c]ngx_rbtree_node_t) void;
pub extern fn ngx_rbtree_insert_timer_value(root: [*c]ngx_rbtree_node_t, node: [*c]ngx_rbtree_node_t, sentinel: [*c]ngx_rbtree_node_t) void;
pub extern fn ngx_rbtree_next(tree: [*c]ngx_rbtree_t, node: [*c]ngx_rbtree_node_t) [*c]ngx_rbtree_node_t;
pub fn ngx_rbtree_min(arg_node: [*c]ngx_rbtree_node_t, arg_sentinel: [*c]ngx_rbtree_node_t) callconv(.C) [*c]ngx_rbtree_node_t {
    var node = arg_node;
    _ = &node;
    var sentinel = arg_sentinel;
    _ = &sentinel;
    while (node.*.left != sentinel) {
        node = node.*.left;
    }
    return node;
}
pub const ngx_msec_int_t = ngx_rbtree_key_int_t;
pub const ngx_tm_t = struct_tm;
pub extern fn ngx_timezone_update() void;
pub extern fn ngx_localtime(s: time_t, tm: [*c]ngx_tm_t) void;
pub extern fn ngx_libc_localtime(s: time_t, tm: [*c]struct_tm) void;
pub extern fn ngx_libc_gmtime(s: time_t, tm: [*c]struct_tm) void;
pub extern fn ngx_nonblocking(s: ngx_socket_t) c_int;
pub extern fn ngx_blocking(s: ngx_socket_t) c_int;
pub extern fn ngx_tcp_nopush(s: ngx_socket_t) c_int;
pub extern fn ngx_tcp_push(s: ngx_socket_t) c_int;
pub const ngx_str_t = extern struct {
    len: usize = @import("std").mem.zeroes(usize),
    data: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
};
pub const ngx_keyval_t = extern struct {
    key: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    value: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_variable_value_t = extern struct {
    flags: packed struct {
        len: u28,
        valid: bool,
        no_cacheable: bool,
        not_found: bool,
        escape: bool,
    } = @import("std").mem.zeroes(c_uint),
    data: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
};
pub extern fn ngx_strlow(dst: [*c]u_char, src: [*c]u_char, n: usize) void;
pub extern fn ngx_strnlen(p: [*c]u_char, n: usize) usize;
pub fn ngx_strlchr(arg_p: [*c]u_char, arg_last: [*c]u_char, arg_c: u_char) callconv(.C) [*c]u_char {
    var p = arg_p;
    _ = &p;
    var last = arg_last;
    _ = &last;
    var c = arg_c;
    _ = &c;
    while (p < last) {
        if (@as(c_int, @bitCast(@as(c_uint, p.*))) == @as(c_int, @bitCast(@as(c_uint, c)))) {
            return p;
        }
        p += 1;
    }
    return null;
}
pub extern fn ngx_explicit_memzero(buf: ?*anyopaque, n: usize) void;
pub extern fn ngx_cpystrn(dst: [*c]u_char, src: [*c]u_char, n: usize) [*c]u_char;
pub extern fn ngx_pstrdup(pool: [*c]ngx_pool_t, src: [*c]ngx_str_t) [*c]u_char;
pub extern fn ngx_sprintf(buf: [*c]u_char, fmt: [*c]const u8, ...) [*c]u_char;
pub extern fn ngx_snprintf(buf: [*c]u_char, max: usize, fmt: [*c]const u8, ...) [*c]u_char;
pub extern fn ngx_slprintf(buf: [*c]u_char, last: [*c]u_char, fmt: [*c]const u8, ...) [*c]u_char;
pub extern fn ngx_vslprintf(buf: [*c]u_char, last: [*c]u_char, fmt: [*c]const u8, args: [*c]struct___va_list_tag_5) [*c]u_char;
pub extern fn ngx_strcasecmp(s1: [*c]u_char, s2: [*c]u_char) ngx_int_t;
pub extern fn ngx_strncasecmp(s1: [*c]u_char, s2: [*c]u_char, n: usize) ngx_int_t;
pub extern fn ngx_strnstr(s1: [*c]u_char, s2: [*c]u8, n: usize) [*c]u_char;
pub extern fn ngx_strstrn(s1: [*c]u_char, s2: [*c]u8, n: usize) [*c]u_char;
pub extern fn ngx_strcasestrn(s1: [*c]u_char, s2: [*c]u8, n: usize) [*c]u_char;
pub extern fn ngx_strlcasestrn(s1: [*c]u_char, last: [*c]u_char, s2: [*c]u_char, n: usize) [*c]u_char;
pub extern fn ngx_rstrncmp(s1: [*c]u_char, s2: [*c]u_char, n: usize) ngx_int_t;
pub extern fn ngx_rstrncasecmp(s1: [*c]u_char, s2: [*c]u_char, n: usize) ngx_int_t;
pub extern fn ngx_memn2cmp(s1: [*c]u_char, s2: [*c]u_char, n1: usize, n2: usize) ngx_int_t;
pub extern fn ngx_dns_strcmp(s1: [*c]u_char, s2: [*c]u_char) ngx_int_t;
pub extern fn ngx_filename_cmp(s1: [*c]u_char, s2: [*c]u_char, n: usize) ngx_int_t;
pub extern fn ngx_atoi(line: [*c]u_char, n: usize) ngx_int_t;
pub extern fn ngx_atofp(line: [*c]u_char, n: usize, point: usize) ngx_int_t;
pub extern fn ngx_atosz(line: [*c]u_char, n: usize) isize;
pub extern fn ngx_atoof(line: [*c]u_char, n: usize) off_t;
pub extern fn ngx_atotm(line: [*c]u_char, n: usize) time_t;
pub extern fn ngx_hextoi(line: [*c]u_char, n: usize) ngx_int_t;
pub extern fn ngx_hex_dump(dst: [*c]u_char, src: [*c]u_char, len: usize) [*c]u_char;
pub extern fn ngx_encode_base64(dst: [*c]ngx_str_t, src: [*c]ngx_str_t) void;
pub extern fn ngx_encode_base64url(dst: [*c]ngx_str_t, src: [*c]ngx_str_t) void;
pub extern fn ngx_decode_base64(dst: [*c]ngx_str_t, src: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_decode_base64url(dst: [*c]ngx_str_t, src: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_utf8_decode(p: [*c][*c]u_char, n: usize) u32;
pub extern fn ngx_utf8_length(p: [*c]u_char, n: usize) usize;
pub extern fn ngx_utf8_cpystrn(dst: [*c]u_char, src: [*c]u_char, n: usize, len: usize) [*c]u_char;
pub extern fn ngx_escape_uri(dst: [*c]u_char, src: [*c]u_char, size: usize, @"type": ngx_uint_t) usize;
pub extern fn ngx_unescape_uri(dst: [*c][*c]u_char, src: [*c][*c]u_char, size: usize, @"type": ngx_uint_t) void;
pub extern fn ngx_escape_html(dst: [*c]u_char, src: [*c]u_char, size: usize) usize;
pub extern fn ngx_escape_json(dst: [*c]u_char, src: [*c]u_char, size: usize) usize;
pub const ngx_str_node_t = extern struct {
    node: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    str: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub extern fn ngx_str_rbtree_insert_value(temp: [*c]ngx_rbtree_node_t, node: [*c]ngx_rbtree_node_t, sentinel: [*c]ngx_rbtree_node_t) void;
pub extern fn ngx_str_rbtree_lookup(rbtree: [*c]ngx_rbtree_t, name: [*c]ngx_str_t, hash: u32) [*c]ngx_str_node_t;
pub extern fn ngx_sort(base: ?*anyopaque, n: usize, size: usize, cmp: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.C) ngx_int_t) void;
pub const ngx_file_uniq_t = ino_t;
pub const ngx_file_mapping_t = extern struct {
    name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    size: usize = @import("std").mem.zeroes(usize),
    addr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub const ngx_dir_t = extern struct {
    dir: ?*DIR = @import("std").mem.zeroes(?*DIR),
    de: [*c]struct_dirent = @import("std").mem.zeroes([*c]struct_dirent),
    info: struct_stat = @import("std").mem.zeroes(struct_stat),
};
pub const ngx_glob_t = extern struct {
    n: usize = @import("std").mem.zeroes(usize),
    pglob: glob_t = @import("std").mem.zeroes(glob_t),
    pattern: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    @"test": ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_open_tempfile(name: [*c]u_char, persistent: ngx_uint_t, access: ngx_uint_t) ngx_fd_t;
pub extern fn ngx_read_file(file: [*c]ngx_file_t, buf: [*c]u_char, size: usize, offset: off_t) isize;
pub extern fn ngx_write_file(file: [*c]ngx_file_t, buf: [*c]u_char, size: usize, offset: off_t) isize;
pub extern fn ngx_write_chain_to_file(file: [*c]ngx_file_t, ce: [*c]ngx_chain_t, offset: off_t, pool: [*c]ngx_pool_t) isize;
pub fn ngx_write_fd(arg_fd: ngx_fd_t, arg_buf: ?*anyopaque, arg_n: usize) callconv(.C) isize {
    var fd = arg_fd;
    _ = &fd;
    var buf = arg_buf;
    _ = &buf;
    var n = arg_n;
    _ = &n;
    return write(fd, buf, n);
}
pub extern fn ngx_set_file_time(name: [*c]u_char, fd: ngx_fd_t, s: time_t) ngx_int_t;
pub extern fn ngx_create_file_mapping(fm: [*c]ngx_file_mapping_t) ngx_int_t;
pub extern fn ngx_close_file_mapping(fm: [*c]ngx_file_mapping_t) void;
pub extern fn ngx_open_dir(name: [*c]ngx_str_t, dir: [*c]ngx_dir_t) ngx_int_t;
pub extern fn ngx_read_dir(dir: [*c]ngx_dir_t) ngx_int_t;
pub fn ngx_de_info(arg_name: [*c]u_char, arg_dir: [*c]ngx_dir_t) callconv(.C) ngx_int_t {
    var name = arg_name;
    _ = &name;
    var dir = arg_dir;
    _ = &dir;
    return @as(ngx_int_t, @bitCast(@as(c_long, stat(@as([*c]const u8, @ptrCast(@alignCast(name))), &dir.*.info))));
}
pub extern fn ngx_open_glob(gl: [*c]ngx_glob_t) ngx_int_t;
pub extern fn ngx_read_glob(gl: [*c]ngx_glob_t, name: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_close_glob(gl: [*c]ngx_glob_t) void;
pub extern fn ngx_trylock_fd(fd: ngx_fd_t) ngx_err_t;
pub extern fn ngx_lock_fd(fd: ngx_fd_t) ngx_err_t;
pub extern fn ngx_unlock_fd(fd: ngx_fd_t) ngx_err_t;
pub extern fn ngx_read_ahead(fd: ngx_fd_t, n: usize) ngx_int_t;
pub extern fn ngx_directio_on(fd: ngx_fd_t) ngx_int_t;
pub extern fn ngx_directio_off(fd: ngx_fd_t) ngx_int_t;
pub extern fn ngx_fs_bsize(name: [*c]u_char) usize;
pub extern fn ngx_fs_available(name: [*c]u_char) off_t;
pub const ngx_shm_t = extern struct {
    addr: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    size: usize = @import("std").mem.zeroes(usize),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    exists: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_shm_alloc(shm: [*c]ngx_shm_t) ngx_int_t;
pub extern fn ngx_shm_free(shm: [*c]ngx_shm_t) void;
pub const ngx_cpuset_t = cpu_set_t;
pub extern fn ngx_setaffinity(cpu_affinity: [*c]ngx_cpuset_t, log: [*c]ngx_log_t) void;
pub extern fn ngx_init_setproctitle(log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_setproctitle(title: [*c]u8) void;
pub const ngx_pid_t = pid_t;
pub const ngx_spawn_proc_pt = ?*const fn ([*c]ngx_cycle_t, ?*anyopaque) callconv(.C) void;
pub const ngx_process_t = extern struct {
    pid: ngx_pid_t = @import("std").mem.zeroes(ngx_pid_t),
    status: c_int = @import("std").mem.zeroes(c_int),
    channel: [2]ngx_socket_t = @import("std").mem.zeroes([2]ngx_socket_t),
    proc: ngx_spawn_proc_pt = @import("std").mem.zeroes(ngx_spawn_proc_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
};
pub const ngx_exec_ctx_t = extern struct {
    path: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    argv: [*c]const [*c]u8 = @import("std").mem.zeroes([*c]const [*c]u8),
    envp: [*c]const [*c]u8 = @import("std").mem.zeroes([*c]const [*c]u8),
};
pub extern fn ngx_spawn_process(cycle: [*c]ngx_cycle_t, proc: ngx_spawn_proc_pt, data: ?*anyopaque, name: [*c]u8, respawn: ngx_int_t) ngx_pid_t;
pub extern fn ngx_execute(cycle: [*c]ngx_cycle_t, ctx: [*c]ngx_exec_ctx_t) ngx_pid_t;
pub extern fn ngx_init_signals(log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_debug_point() void;
pub extern var ngx_argc: c_int;
pub extern var ngx_argv: [*c][*c]u8;
pub extern var ngx_os_argv: [*c][*c]u8;
pub extern var ngx_pid: ngx_pid_t;
pub extern var ngx_parent: ngx_pid_t;
pub extern var ngx_channel: ngx_socket_t;
pub extern var ngx_process_slot: ngx_int_t;
pub extern var ngx_last_process: ngx_int_t;
pub extern var ngx_processes: [1024]ngx_process_t;
pub const ngx_uid_t = uid_t;
pub const ngx_gid_t = gid_t;
pub extern fn ngx_libc_crypt(pool: [*c]ngx_pool_t, key: [*c]u_char, salt: [*c]u_char, encrypted: [*c][*c]u_char) ngx_int_t;
pub extern fn ngx_dlerror() [*c]u8;
pub extern fn ngx_parse_size(line: [*c]ngx_str_t) isize;
pub extern fn ngx_parse_offset(line: [*c]ngx_str_t) off_t;
pub extern fn ngx_parse_time(line: [*c]ngx_str_t, is_sec: ngx_uint_t) ngx_int_t;
pub extern fn ngx_parse_http_time(value: [*c]u_char, len: usize) time_t;
pub extern fn ngx_log_error_core(level: ngx_uint_t, log: [*c]ngx_log_t, err: ngx_err_t, fmt: [*c]const u8, ...) void;
pub extern fn ngx_log_init(prefix: [*c]u_char, error_log: [*c]u_char) [*c]ngx_log_t;
pub extern fn ngx_log_abort(err: ngx_err_t, fmt: [*c]const u8, ...) void;
pub extern fn ngx_log_stderr(err: ngx_err_t, fmt: [*c]const u8, ...) void;
pub extern fn ngx_log_errno(buf: [*c]u_char, last: [*c]u_char, err: ngx_err_t) [*c]u_char;
pub extern fn ngx_log_open_default(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_log_redirect_stderr(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_log_get_file_log(head: [*c]ngx_log_t) [*c]ngx_log_t;
pub extern fn ngx_log_set_log(cf: [*c]ngx_conf_t, head: [*c][*c]ngx_log_t) [*c]u8;
pub fn ngx_write_stderr(arg_text: [*c]u8) callconv(.C) void {
    var text = arg_text;
    _ = &text;
    _ = ngx_write_fd(@as(c_int, 2), @as(?*anyopaque, @ptrCast(text)), strlen(@as([*c]const u8, @ptrCast(@alignCast(text)))));
}
pub fn ngx_write_stdout(arg_text: [*c]u8) callconv(.C) void {
    var text = arg_text;
    _ = &text;
    _ = ngx_write_fd(@as(c_int, 1), @as(?*anyopaque, @ptrCast(text)), strlen(@as([*c]const u8, @ptrCast(@alignCast(text)))));
}
pub extern var ngx_errlog_module: ngx_module_t;
pub extern var ngx_use_stderr: ngx_uint_t;
pub extern fn ngx_alloc(size: usize, log: [*c]ngx_log_t) ?*anyopaque;
pub extern fn ngx_calloc(size: usize, log: [*c]ngx_log_t) ?*anyopaque;
pub extern fn ngx_memalign(alignment: usize, size: usize, log: [*c]ngx_log_t) ?*anyopaque;
pub extern var ngx_pagesize: ngx_uint_t;
pub extern var ngx_pagesize_shift: ngx_uint_t;
pub extern var ngx_cacheline_size: ngx_uint_t;
pub const ngx_pool_data_t = extern struct {
    last: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    next: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    failed: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_pool_cleanup_file_t = extern struct {
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub extern fn ngx_create_pool(size: usize, log: [*c]ngx_log_t) [*c]ngx_pool_t;
pub extern fn ngx_destroy_pool(pool: [*c]ngx_pool_t) void;
pub extern fn ngx_reset_pool(pool: [*c]ngx_pool_t) void;
pub extern fn ngx_palloc(pool: [*c]ngx_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_pnalloc(pool: [*c]ngx_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_pcalloc(pool: [*c]ngx_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_pmemalign(pool: [*c]ngx_pool_t, size: usize, alignment: usize) ?*anyopaque;
pub extern fn ngx_pfree(pool: [*c]ngx_pool_t, p: ?*anyopaque) ngx_int_t;
pub extern fn ngx_pool_cleanup_add(p: [*c]ngx_pool_t, size: usize) [*c]ngx_pool_cleanup_t;
pub extern fn ngx_pool_run_cleanup_file(p: [*c]ngx_pool_t, fd: ngx_fd_t) void;
pub extern fn ngx_pool_cleanup_file(data: ?*anyopaque) void;
pub extern fn ngx_pool_delete_file(data: ?*anyopaque) void;
pub const ngx_bufs_t = extern struct {
    num: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    size: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_output_chain_filter_pt = ?*const fn (?*anyopaque, [*c]ngx_chain_t) callconv(.C) ngx_int_t;
pub const struct_ngx_output_chain_ctx_s = extern struct {
    buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    in: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    free: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    busy: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    flags: packed struct {
        sendfile: bool,
        directio: bool,
        unaligned: bool,
        need_in_memory: bool,
        need_in_temp: bool,
        aio: bool,
        padding: u26,
    } = @import("std").mem.zeroes(c_uint),
    alignment: off_t = @import("std").mem.zeroes(off_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    allocated: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    bufs: ngx_bufs_t = @import("std").mem.zeroes(ngx_bufs_t),
    tag: ngx_buf_tag_t = @import("std").mem.zeroes(ngx_buf_tag_t),
    output_filter: ngx_output_chain_filter_pt = @import("std").mem.zeroes(ngx_output_chain_filter_pt),
    filter_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_output_chain_ctx_t = struct_ngx_output_chain_ctx_s;
pub const ngx_output_chain_aio_pt = ?*const fn ([*c]ngx_output_chain_ctx_t, [*c]ngx_file_t) callconv(.C) void;
pub const ngx_chain_writer_ctx_t = extern struct {
    out: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    last: [*c][*c]ngx_chain_t = @import("std").mem.zeroes([*c][*c]ngx_chain_t),
    connection: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    limit: off_t = @import("std").mem.zeroes(off_t),
};
pub extern fn ngx_create_temp_buf(pool: [*c]ngx_pool_t, size: usize) [*c]ngx_buf_t;
pub extern fn ngx_create_chain_of_bufs(pool: [*c]ngx_pool_t, bufs: [*c]ngx_bufs_t) [*c]ngx_chain_t;
pub extern fn ngx_alloc_chain_link(pool: [*c]ngx_pool_t) [*c]ngx_chain_t;
pub extern fn ngx_output_chain(ctx: [*c]ngx_output_chain_ctx_t, in: [*c]ngx_chain_t) ngx_int_t;
pub extern fn ngx_chain_writer(ctx: ?*anyopaque, in: [*c]ngx_chain_t) ngx_int_t;
pub extern fn ngx_chain_add_copy(pool: [*c]ngx_pool_t, chain: [*c][*c]ngx_chain_t, in: [*c]ngx_chain_t) ngx_int_t;
pub extern fn ngx_chain_get_free_buf(p: [*c]ngx_pool_t, free: [*c][*c]ngx_chain_t) [*c]ngx_chain_t;
pub extern fn ngx_chain_update_chains(p: [*c]ngx_pool_t, free: [*c][*c]ngx_chain_t, busy: [*c][*c]ngx_chain_t, out: [*c][*c]ngx_chain_t, tag: ngx_buf_tag_t) void;
pub extern fn ngx_chain_coalesce_file(in: [*c][*c]ngx_chain_t, limit: off_t) off_t;
pub extern fn ngx_chain_update_sent(in: [*c]ngx_chain_t, sent: off_t) [*c]ngx_chain_t;
pub extern fn ngx_queue_middle(queue: [*c]ngx_queue_t) [*c]ngx_queue_t;
pub extern fn ngx_queue_sort(queue: [*c]ngx_queue_t, cmp: ?*const fn ([*c]const ngx_queue_t, [*c]const ngx_queue_t) callconv(.C) ngx_int_t) void;
pub const ngx_array_t = extern struct {
    elts: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    nelts: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    size: usize = @import("std").mem.zeroes(usize),
    nalloc: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
};
pub extern fn ngx_array_create(p: [*c]ngx_pool_t, n: ngx_uint_t, size: usize) [*c]ngx_array_t;
pub extern fn ngx_array_destroy(a: [*c]ngx_array_t) void;
pub extern fn ngx_array_push(a: [*c]ngx_array_t) ?*anyopaque;
pub extern fn ngx_array_push_n(a: [*c]ngx_array_t, n: ngx_uint_t) ?*anyopaque;
pub fn ngx_array_init(arg_array: [*c]ngx_array_t, arg_pool: [*c]ngx_pool_t, arg_n: ngx_uint_t, arg_size: usize) callconv(.C) ngx_int_t {
    var array = arg_array;
    _ = &array;
    var pool = arg_pool;
    _ = &pool;
    var n = arg_n;
    _ = &n;
    var size = arg_size;
    _ = &size;
    array.*.nelts = 0;
    array.*.size = size;
    array.*.nalloc = n;
    array.*.pool = pool;
    array.*.elts = ngx_palloc(pool, n *% size);
    if (array.*.elts == @as(?*anyopaque, @ptrFromInt(@as(c_int, 0)))) {
        return @as(ngx_int_t, @bitCast(@as(c_long, -@as(c_int, 1))));
    }
    return 0;
}
pub const ngx_list_part_t = struct_ngx_list_part_s;
pub const struct_ngx_list_part_s = extern struct {
    elts: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    nelts: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    next: [*c]ngx_list_part_t = @import("std").mem.zeroes([*c]ngx_list_part_t),
};
pub const ngx_list_t = extern struct {
    last: [*c]ngx_list_part_t = @import("std").mem.zeroes([*c]ngx_list_part_t),
    part: ngx_list_part_t = @import("std").mem.zeroes(ngx_list_part_t),
    size: usize = @import("std").mem.zeroes(usize),
    nalloc: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
};
pub extern fn ngx_list_create(pool: [*c]ngx_pool_t, n: ngx_uint_t, size: usize) [*c]ngx_list_t;
pub fn ngx_list_init(arg_list: [*c]ngx_list_t, arg_pool: [*c]ngx_pool_t, arg_n: ngx_uint_t, arg_size: usize) callconv(.C) ngx_int_t {
    var list = arg_list;
    _ = &list;
    var pool = arg_pool;
    _ = &pool;
    var n = arg_n;
    _ = &n;
    var size = arg_size;
    _ = &size;
    list.*.part.elts = ngx_palloc(pool, n *% size);
    if (list.*.part.elts == @as(?*anyopaque, @ptrFromInt(@as(c_int, 0)))) {
        return @as(ngx_int_t, @bitCast(@as(c_long, -@as(c_int, 1))));
    }
    list.*.part.nelts = 0;
    list.*.part.next = null;
    list.*.last = &list.*.part;
    list.*.size = size;
    list.*.nalloc = n;
    list.*.pool = pool;
    return 0;
}
pub extern fn ngx_list_push(list: [*c]ngx_list_t) ?*anyopaque;
pub const ngx_hash_elt_t = extern struct {
    value: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    len: u_short = @import("std").mem.zeroes(u_short),
    name: [1]u_char = @import("std").mem.zeroes([1]u_char),
};
pub const ngx_hash_t = extern struct {
    buckets: [*c][*c]ngx_hash_elt_t = @import("std").mem.zeroes([*c][*c]ngx_hash_elt_t),
    size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_hash_wildcard_t = extern struct {
    hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    value: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_hash_key_t = extern struct {
    key: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    key_hash: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    value: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_hash_key_pt = ?*const fn ([*c]u_char, usize) callconv(.C) ngx_uint_t;
pub const ngx_hash_combined_t = extern struct {
    hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    wc_head: [*c]ngx_hash_wildcard_t = @import("std").mem.zeroes([*c]ngx_hash_wildcard_t),
    wc_tail: [*c]ngx_hash_wildcard_t = @import("std").mem.zeroes([*c]ngx_hash_wildcard_t),
};
pub const ngx_hash_init_t = extern struct {
    hash: [*c]ngx_hash_t = @import("std").mem.zeroes([*c]ngx_hash_t),
    key: ngx_hash_key_pt = @import("std").mem.zeroes(ngx_hash_key_pt),
    max_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    bucket_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    temp_pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
};
pub const ngx_hash_keys_arrays_t = extern struct {
    hsize: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    temp_pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    keys: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    keys_hash: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    dns_wc_head: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    dns_wc_head_hash: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    dns_wc_tail: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    dns_wc_tail_hash: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
};
pub const ngx_table_elt_t = struct_ngx_table_elt_s;
pub const struct_ngx_table_elt_s = extern struct {
    hash: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    key: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    value: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    lowcase_key: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    next: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
};
pub extern fn ngx_hash_find(hash: [*c]ngx_hash_t, key: ngx_uint_t, name: [*c]u_char, len: usize) ?*anyopaque;
pub extern fn ngx_hash_find_wc_head(hwc: [*c]ngx_hash_wildcard_t, name: [*c]u_char, len: usize) ?*anyopaque;
pub extern fn ngx_hash_find_wc_tail(hwc: [*c]ngx_hash_wildcard_t, name: [*c]u_char, len: usize) ?*anyopaque;
pub extern fn ngx_hash_find_combined(hash: [*c]ngx_hash_combined_t, key: ngx_uint_t, name: [*c]u_char, len: usize) ?*anyopaque;
pub extern fn ngx_hash_init(hinit: [*c]ngx_hash_init_t, names: [*c]ngx_hash_key_t, nelts: ngx_uint_t) ngx_int_t;
pub extern fn ngx_hash_wildcard_init(hinit: [*c]ngx_hash_init_t, names: [*c]ngx_hash_key_t, nelts: ngx_uint_t) ngx_int_t;
pub extern fn ngx_hash_key(data: [*c]u_char, len: usize) ngx_uint_t;
pub extern fn ngx_hash_key_lc(data: [*c]u_char, len: usize) ngx_uint_t;
pub extern fn ngx_hash_strlow(dst: [*c]u_char, src: [*c]u_char, n: usize) ngx_uint_t;
pub extern fn ngx_hash_keys_array_init(ha: [*c]ngx_hash_keys_arrays_t, @"type": ngx_uint_t) ngx_int_t;
pub extern fn ngx_hash_add_key(ha: [*c]ngx_hash_keys_arrays_t, key: [*c]ngx_str_t, value: ?*anyopaque, flags: ngx_uint_t) ngx_int_t;
pub const ngx_path_manager_pt = ?*const fn (?*anyopaque) callconv(.C) ngx_msec_t;
pub const ngx_path_purger_pt = ?*const fn (?*anyopaque) callconv(.C) ngx_msec_t;
pub const ngx_path_loader_pt = ?*const fn (?*anyopaque) callconv(.C) void;
pub const ngx_path_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    len: usize = @import("std").mem.zeroes(usize),
    level: [3]usize = @import("std").mem.zeroes([3]usize),
    manager: ngx_path_manager_pt = @import("std").mem.zeroes(ngx_path_manager_pt),
    purger: ngx_path_purger_pt = @import("std").mem.zeroes(ngx_path_purger_pt),
    loader: ngx_path_loader_pt = @import("std").mem.zeroes(ngx_path_loader_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    conf_file: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    line: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_path_init_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    level: [3]usize = @import("std").mem.zeroes([3]usize),
};
pub const ngx_temp_file_t = extern struct {
    file: ngx_file_t = @import("std").mem.zeroes(ngx_file_t),
    offset: off_t = @import("std").mem.zeroes(off_t),
    path: [*c]ngx_path_t = @import("std").mem.zeroes([*c]ngx_path_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    warn: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    access: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    flags: packed struct {
        log_level: u8,
        persistent: bool,
        clean: bool,
        thread_write: bool,
        padding: u21,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_ext_rename_file_t = extern struct {
    access: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    path_access: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    time: time_t = @import("std").mem.zeroes(time_t),
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    flags: packed struct {
        create_path: bool,
        delete_file: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub const ngx_copy_file_t = extern struct {
    size: off_t = @import("std").mem.zeroes(off_t),
    buf_size: usize = @import("std").mem.zeroes(usize),
    access: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    time: time_t = @import("std").mem.zeroes(time_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub const ngx_tree_init_handler_pt = ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) ngx_int_t;
pub const ngx_tree_ctx_t = struct_ngx_tree_ctx_s;
pub const ngx_tree_handler_pt = ?*const fn ([*c]ngx_tree_ctx_t, [*c]ngx_str_t) callconv(.C) ngx_int_t;
pub const struct_ngx_tree_ctx_s = extern struct {
    size: off_t = @import("std").mem.zeroes(off_t),
    fs_size: off_t = @import("std").mem.zeroes(off_t),
    access: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    mtime: time_t = @import("std").mem.zeroes(time_t),
    init_handler: ngx_tree_init_handler_pt = @import("std").mem.zeroes(ngx_tree_init_handler_pt),
    file_handler: ngx_tree_handler_pt = @import("std").mem.zeroes(ngx_tree_handler_pt),
    pre_tree_handler: ngx_tree_handler_pt = @import("std").mem.zeroes(ngx_tree_handler_pt),
    post_tree_handler: ngx_tree_handler_pt = @import("std").mem.zeroes(ngx_tree_handler_pt),
    spec_handler: ngx_tree_handler_pt = @import("std").mem.zeroes(ngx_tree_handler_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    alloc: usize = @import("std").mem.zeroes(usize),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub extern fn ngx_get_full_name(pool: [*c]ngx_pool_t, prefix: [*c]ngx_str_t, name: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_write_chain_to_temp_file(tf: [*c]ngx_temp_file_t, chain: [*c]ngx_chain_t) isize;
pub extern fn ngx_create_temp_file(file: [*c]ngx_file_t, path: [*c]ngx_path_t, pool: [*c]ngx_pool_t, persistent: ngx_uint_t, clean: ngx_uint_t, access: ngx_uint_t) ngx_int_t;
pub extern fn ngx_create_hashed_filename(path: [*c]ngx_path_t, file: [*c]u_char, len: usize) void;
pub extern fn ngx_create_path(file: [*c]ngx_file_t, path: [*c]ngx_path_t) ngx_int_t;
pub extern fn ngx_create_full_path(dir: [*c]u_char, access: ngx_uint_t) ngx_err_t;
pub extern fn ngx_add_path(cf: [*c]ngx_conf_t, slot: [*c][*c]ngx_path_t) ngx_int_t;
pub extern fn ngx_create_paths(cycle: [*c]ngx_cycle_t, user: ngx_uid_t) ngx_int_t;
pub extern fn ngx_ext_rename_file(src: [*c]ngx_str_t, to: [*c]ngx_str_t, ext: [*c]ngx_ext_rename_file_t) ngx_int_t;
pub extern fn ngx_copy_file(from: [*c]u_char, to: [*c]u_char, cf: [*c]ngx_copy_file_t) ngx_int_t;
pub extern fn ngx_walk_tree(ctx: [*c]ngx_tree_ctx_t, tree: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_next_temp_number(collision: ngx_uint_t) ngx_atomic_uint_t;
pub extern fn ngx_conf_set_path_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_merge_path_value(cf: [*c]ngx_conf_t, path: [*c][*c]ngx_path_t, prev: [*c]ngx_path_t, init: [*c]ngx_path_init_t) [*c]u8;
pub extern fn ngx_conf_set_access_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern var ngx_temp_number: [*c]volatile ngx_atomic_t;
pub extern var ngx_random_number: ngx_atomic_int_t;
pub fn ngx_crc(arg_data: [*c]u_char, arg_len: usize) callconv(.C) u32 {
    var data = arg_data;
    _ = &data;
    var len = arg_len;
    _ = &len;
    var sum: u32 = undefined;
    _ = &sum;
    {
        sum = 0;
        while (len != 0) : (len -%= 1) {
            sum = (sum >> @intCast(1)) | (sum << @intCast(31));
            sum +%= @as(u32, @bitCast(@as(c_uint, (blk: {
                const ref = &data;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*)));
        }
    }
    return sum;
}
pub extern var ngx_crc32_table_short: [*c]u32;
pub const ngx_crc32_table256: [*c]u32 = @extern([*c]u32, .{
    .name = "ngx_crc32_table256",
});
pub fn ngx_crc32_short(arg_p: [*c]u_char, arg_len: usize) callconv(.C) u32 {
    var p = arg_p;
    _ = &p;
    var len = arg_len;
    _ = &len;
    var c: u_char = undefined;
    _ = &c;
    var crc: u32 = undefined;
    _ = &crc;
    crc = 4294967295;
    while ((blk: {
        const ref = &len;
        const tmp = ref.*;
        ref.* -%= 1;
        break :blk tmp;
    }) != 0) {
        c = (blk: {
            const ref = &p;
            const tmp = ref.*;
            ref.* += 1;
            break :blk tmp;
        }).*;
        crc = ngx_crc32_table_short[(crc ^ @as(u32, @bitCast(@as(c_int, @bitCast(@as(c_uint, c))) & @as(c_int, 15)))) & @as(u32, @bitCast(@as(c_int, 15)))] ^ (crc >> @intCast(4));
        crc = ngx_crc32_table_short[(crc ^ @as(u32, @bitCast(@as(c_int, @bitCast(@as(c_uint, c))) >> @intCast(4)))) & @as(u32, @bitCast(@as(c_int, 15)))] ^ (crc >> @intCast(4));
    }
    return crc ^ @as(c_uint, 4294967295);
}
pub fn ngx_crc32_long(arg_p: [*c]u_char, arg_len: usize) callconv(.C) u32 {
    var p = arg_p;
    _ = &p;
    var len = arg_len;
    _ = &len;
    var crc: u32 = undefined;
    _ = &crc;
    crc = 4294967295;
    while ((blk: {
        const ref = &len;
        const tmp = ref.*;
        ref.* -%= 1;
        break :blk tmp;
    }) != 0) {
        crc = ngx_crc32_table256[
            (crc ^ @as(u32, @bitCast(@as(c_uint, (blk: {
                const ref = &p;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*)))) & @as(u32, @bitCast(@as(c_int, 255)))
        ] ^ (crc >> @intCast(8));
    }
    return crc ^ @as(c_uint, 4294967295);
}
pub fn ngx_crc32_update(arg_crc: [*c]u32, arg_p: [*c]u_char, arg_len: usize) callconv(.C) void {
    var crc = arg_crc;
    _ = &crc;
    var p = arg_p;
    _ = &p;
    var len = arg_len;
    _ = &len;
    var c: u32 = undefined;
    _ = &c;
    c = crc.*;
    while ((blk: {
        const ref = &len;
        const tmp = ref.*;
        ref.* -%= 1;
        break :blk tmp;
    }) != 0) {
        c = ngx_crc32_table256[
            (c ^ @as(u32, @bitCast(@as(c_uint, (blk: {
                const ref = &p;
                const tmp = ref.*;
                ref.* += 1;
                break :blk tmp;
            }).*)))) & @as(u32, @bitCast(@as(c_int, 255)))
        ] ^ (c >> @intCast(8));
    }
    crc.* = c;
}
pub extern fn ngx_crc32_table_init() ngx_int_t;
pub extern fn ngx_murmur_hash2(data: [*c]u_char, len: usize) u32;
pub const __gwchar_t = c_int;
pub const imaxdiv_t = extern struct {
    quot: c_long = @import("std").mem.zeroes(c_long),
    rem: c_long = @import("std").mem.zeroes(c_long),
};
pub extern fn imaxabs(__n: intmax_t) intmax_t;
pub extern fn imaxdiv(__numer: intmax_t, __denom: intmax_t) imaxdiv_t;
pub extern fn strtoimax(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) intmax_t;
pub extern fn strtoumax(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) uintmax_t;
pub extern fn wcstoimax(noalias __nptr: [*c]const __gwchar_t, noalias __endptr: [*c][*c]__gwchar_t, __base: c_int) intmax_t;
pub extern fn wcstoumax(noalias __nptr: [*c]const __gwchar_t, noalias __endptr: [*c][*c]__gwchar_t, __base: c_int) uintmax_t;
pub const PCRE2_UCHAR8 = u8;
pub const PCRE2_UCHAR16 = u16;
pub const PCRE2_UCHAR32 = u32;
pub const PCRE2_SPTR8 = [*c]const PCRE2_UCHAR8;
pub const PCRE2_SPTR16 = [*c]const PCRE2_UCHAR16;
pub const PCRE2_SPTR32 = [*c]const PCRE2_UCHAR32;
pub const struct_pcre2_real_general_context_8 = opaque {};
pub const pcre2_general_context_8 = struct_pcre2_real_general_context_8;
pub const struct_pcre2_real_compile_context_8 = opaque {};
pub const pcre2_compile_context_8 = struct_pcre2_real_compile_context_8;
pub const struct_pcre2_real_match_context_8 = opaque {};
pub const pcre2_match_context_8 = struct_pcre2_real_match_context_8;
pub const struct_pcre2_real_convert_context_8 = opaque {};
pub const pcre2_convert_context_8 = struct_pcre2_real_convert_context_8;
pub const struct_pcre2_real_code_8 = opaque {};
pub const pcre2_code_8 = struct_pcre2_real_code_8;
pub const struct_pcre2_real_match_data_8 = opaque {};
pub const pcre2_match_data_8 = struct_pcre2_real_match_data_8;
pub const struct_pcre2_real_jit_stack_8 = opaque {};
pub const pcre2_jit_stack_8 = struct_pcre2_real_jit_stack_8;
pub const pcre2_jit_callback_8 = ?*const fn (?*anyopaque) callconv(.C) ?*pcre2_jit_stack_8;
pub const struct_pcre2_callout_block_8 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    callout_number: u32 = @import("std").mem.zeroes(u32),
    capture_top: u32 = @import("std").mem.zeroes(u32),
    capture_last: u32 = @import("std").mem.zeroes(u32),
    offset_vector: [*c]usize = @import("std").mem.zeroes([*c]usize),
    mark: PCRE2_SPTR8 = @import("std").mem.zeroes(PCRE2_SPTR8),
    subject: PCRE2_SPTR8 = @import("std").mem.zeroes(PCRE2_SPTR8),
    subject_length: usize = @import("std").mem.zeroes(usize),
    start_match: usize = @import("std").mem.zeroes(usize),
    current_position: usize = @import("std").mem.zeroes(usize),
    pattern_position: usize = @import("std").mem.zeroes(usize),
    next_item_length: usize = @import("std").mem.zeroes(usize),
    callout_string_offset: usize = @import("std").mem.zeroes(usize),
    callout_string_length: usize = @import("std").mem.zeroes(usize),
    callout_string: PCRE2_SPTR8 = @import("std").mem.zeroes(PCRE2_SPTR8),
    callout_flags: u32 = @import("std").mem.zeroes(u32),
};
pub const pcre2_callout_block_8 = struct_pcre2_callout_block_8;
pub const struct_pcre2_callout_enumerate_block_8 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    pattern_position: usize = @import("std").mem.zeroes(usize),
    next_item_length: usize = @import("std").mem.zeroes(usize),
    callout_number: u32 = @import("std").mem.zeroes(u32),
    callout_string_offset: usize = @import("std").mem.zeroes(usize),
    callout_string_length: usize = @import("std").mem.zeroes(usize),
    callout_string: PCRE2_SPTR8 = @import("std").mem.zeroes(PCRE2_SPTR8),
};
pub const pcre2_callout_enumerate_block_8 = struct_pcre2_callout_enumerate_block_8;
pub const struct_pcre2_substitute_callout_block_8 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    input: PCRE2_SPTR8 = @import("std").mem.zeroes(PCRE2_SPTR8),
    output: PCRE2_SPTR8 = @import("std").mem.zeroes(PCRE2_SPTR8),
    output_offsets: [2]usize = @import("std").mem.zeroes([2]usize),
    ovector: [*c]usize = @import("std").mem.zeroes([*c]usize),
    oveccount: u32 = @import("std").mem.zeroes(u32),
    subscount: u32 = @import("std").mem.zeroes(u32),
};
pub const pcre2_substitute_callout_block_8 = struct_pcre2_substitute_callout_block_8;
pub extern fn pcre2_config_8(u32, ?*anyopaque) c_int;
pub extern fn pcre2_general_context_copy_8(?*pcre2_general_context_8) ?*pcre2_general_context_8;
pub extern fn pcre2_general_context_create_8(?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque, ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void, ?*anyopaque) ?*pcre2_general_context_8;
pub extern fn pcre2_general_context_free_8(?*pcre2_general_context_8) void;
pub extern fn pcre2_compile_context_copy_8(?*pcre2_compile_context_8) ?*pcre2_compile_context_8;
pub extern fn pcre2_compile_context_create_8(?*pcre2_general_context_8) ?*pcre2_compile_context_8;
pub extern fn pcre2_compile_context_free_8(?*pcre2_compile_context_8) void;
pub extern fn pcre2_set_bsr_8(?*pcre2_compile_context_8, u32) c_int;
pub extern fn pcre2_set_character_tables_8(?*pcre2_compile_context_8, [*c]const u8) c_int;
pub extern fn pcre2_set_compile_extra_options_8(?*pcre2_compile_context_8, u32) c_int;
pub extern fn pcre2_set_max_pattern_length_8(?*pcre2_compile_context_8, usize) c_int;
pub extern fn pcre2_set_max_pattern_compiled_length_8(?*pcre2_compile_context_8, usize) c_int;
pub extern fn pcre2_set_max_varlookbehind_8(?*pcre2_compile_context_8, u32) c_int;
pub extern fn pcre2_set_newline_8(?*pcre2_compile_context_8, u32) c_int;
pub extern fn pcre2_set_parens_nest_limit_8(?*pcre2_compile_context_8, u32) c_int;
pub extern fn pcre2_set_compile_recursion_guard_8(?*pcre2_compile_context_8, ?*const fn (u32, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_convert_context_copy_8(?*pcre2_convert_context_8) ?*pcre2_convert_context_8;
pub extern fn pcre2_convert_context_create_8(?*pcre2_general_context_8) ?*pcre2_convert_context_8;
pub extern fn pcre2_convert_context_free_8(?*pcre2_convert_context_8) void;
pub extern fn pcre2_set_glob_escape_8(?*pcre2_convert_context_8, u32) c_int;
pub extern fn pcre2_set_glob_separator_8(?*pcre2_convert_context_8, u32) c_int;
pub extern fn pcre2_pattern_convert_8(PCRE2_SPTR8, usize, u32, [*c][*c]PCRE2_UCHAR8, [*c]usize, ?*pcre2_convert_context_8) c_int;
pub extern fn pcre2_converted_pattern_free_8([*c]PCRE2_UCHAR8) void;
pub extern fn pcre2_match_context_copy_8(?*pcre2_match_context_8) ?*pcre2_match_context_8;
pub extern fn pcre2_match_context_create_8(?*pcre2_general_context_8) ?*pcre2_match_context_8;
pub extern fn pcre2_match_context_free_8(?*pcre2_match_context_8) void;
pub extern fn pcre2_set_callout_8(?*pcre2_match_context_8, ?*const fn ([*c]pcre2_callout_block_8, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_set_substitute_callout_8(?*pcre2_match_context_8, ?*const fn ([*c]pcre2_substitute_callout_block_8, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_set_depth_limit_8(?*pcre2_match_context_8, u32) c_int;
pub extern fn pcre2_set_heap_limit_8(?*pcre2_match_context_8, u32) c_int;
pub extern fn pcre2_set_match_limit_8(?*pcre2_match_context_8, u32) c_int;
pub extern fn pcre2_set_offset_limit_8(?*pcre2_match_context_8, usize) c_int;
pub extern fn pcre2_set_recursion_limit_8(?*pcre2_match_context_8, u32) c_int;
pub extern fn pcre2_set_recursion_memory_management_8(?*pcre2_match_context_8, ?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque, ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void, ?*anyopaque) c_int;
pub extern fn pcre2_compile_8(PCRE2_SPTR8, usize, u32, [*c]c_int, [*c]usize, ?*pcre2_compile_context_8) ?*pcre2_code_8;
pub extern fn pcre2_code_free_8(?*pcre2_code_8) void;
pub extern fn pcre2_code_copy_8(?*const pcre2_code_8) ?*pcre2_code_8;
pub extern fn pcre2_code_copy_with_tables_8(?*const pcre2_code_8) ?*pcre2_code_8;
pub extern fn pcre2_pattern_info_8(?*const pcre2_code_8, u32, ?*anyopaque) c_int;
pub extern fn pcre2_callout_enumerate_8(?*const pcre2_code_8, ?*const fn ([*c]pcre2_callout_enumerate_block_8, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_match_data_create_8(u32, ?*pcre2_general_context_8) ?*pcre2_match_data_8;
pub extern fn pcre2_match_data_create_from_pattern_8(?*const pcre2_code_8, ?*pcre2_general_context_8) ?*pcre2_match_data_8;
pub extern fn pcre2_dfa_match_8(?*const pcre2_code_8, PCRE2_SPTR8, usize, usize, u32, ?*pcre2_match_data_8, ?*pcre2_match_context_8, [*c]c_int, usize) c_int;
pub extern fn pcre2_match_8(?*const pcre2_code_8, PCRE2_SPTR8, usize, usize, u32, ?*pcre2_match_data_8, ?*pcre2_match_context_8) c_int;
pub extern fn pcre2_match_data_free_8(?*pcre2_match_data_8) void;
pub extern fn pcre2_get_mark_8(?*pcre2_match_data_8) PCRE2_SPTR8;
pub extern fn pcre2_get_match_data_size_8(?*pcre2_match_data_8) usize;
pub extern fn pcre2_get_match_data_heapframes_size_8(?*pcre2_match_data_8) usize;
pub extern fn pcre2_get_ovector_count_8(?*pcre2_match_data_8) u32;
pub extern fn pcre2_get_ovector_pointer_8(?*pcre2_match_data_8) [*c]usize;
pub extern fn pcre2_get_startchar_8(?*pcre2_match_data_8) usize;
pub extern fn pcre2_substring_copy_byname_8(?*pcre2_match_data_8, PCRE2_SPTR8, [*c]PCRE2_UCHAR8, [*c]usize) c_int;
pub extern fn pcre2_substring_copy_bynumber_8(?*pcre2_match_data_8, u32, [*c]PCRE2_UCHAR8, [*c]usize) c_int;
pub extern fn pcre2_substring_free_8([*c]PCRE2_UCHAR8) void;
pub extern fn pcre2_substring_get_byname_8(?*pcre2_match_data_8, PCRE2_SPTR8, [*c][*c]PCRE2_UCHAR8, [*c]usize) c_int;
pub extern fn pcre2_substring_get_bynumber_8(?*pcre2_match_data_8, u32, [*c][*c]PCRE2_UCHAR8, [*c]usize) c_int;
pub extern fn pcre2_substring_length_byname_8(?*pcre2_match_data_8, PCRE2_SPTR8, [*c]usize) c_int;
pub extern fn pcre2_substring_length_bynumber_8(?*pcre2_match_data_8, u32, [*c]usize) c_int;
pub extern fn pcre2_substring_nametable_scan_8(?*const pcre2_code_8, PCRE2_SPTR8, [*c]PCRE2_SPTR8, [*c]PCRE2_SPTR8) c_int;
pub extern fn pcre2_substring_number_from_name_8(?*const pcre2_code_8, PCRE2_SPTR8) c_int;
pub extern fn pcre2_substring_list_free_8([*c][*c]PCRE2_UCHAR8) void;
pub extern fn pcre2_substring_list_get_8(?*pcre2_match_data_8, [*c][*c][*c]PCRE2_UCHAR8, [*c][*c]usize) c_int;
pub extern fn pcre2_serialize_encode_8([*c]?*const pcre2_code_8, i32, [*c][*c]u8, [*c]usize, ?*pcre2_general_context_8) i32;
pub extern fn pcre2_serialize_decode_8([*c]?*pcre2_code_8, i32, [*c]const u8, ?*pcre2_general_context_8) i32;
pub extern fn pcre2_serialize_get_number_of_codes_8([*c]const u8) i32;
pub extern fn pcre2_serialize_free_8([*c]u8) void;
pub extern fn pcre2_substitute_8(?*const pcre2_code_8, PCRE2_SPTR8, usize, usize, u32, ?*pcre2_match_data_8, ?*pcre2_match_context_8, PCRE2_SPTR8, usize, [*c]PCRE2_UCHAR8, [*c]usize) c_int;
pub extern fn pcre2_jit_compile_8(?*pcre2_code_8, u32) c_int;
pub extern fn pcre2_jit_match_8(?*const pcre2_code_8, PCRE2_SPTR8, usize, usize, u32, ?*pcre2_match_data_8, ?*pcre2_match_context_8) c_int;
pub extern fn pcre2_jit_free_unused_memory_8(?*pcre2_general_context_8) void;
pub extern fn pcre2_jit_stack_create_8(usize, usize, ?*pcre2_general_context_8) ?*pcre2_jit_stack_8;
pub extern fn pcre2_jit_stack_assign_8(?*pcre2_match_context_8, pcre2_jit_callback_8, ?*anyopaque) void;
pub extern fn pcre2_jit_stack_free_8(?*pcre2_jit_stack_8) void;
pub extern fn pcre2_get_error_message_8(c_int, [*c]PCRE2_UCHAR8, usize) c_int;
pub extern fn pcre2_maketables_8(?*pcre2_general_context_8) [*c]const u8;
pub extern fn pcre2_maketables_free_8(?*pcre2_general_context_8, [*c]const u8) void;
pub const struct_pcre2_real_general_context_16 = opaque {};
pub const pcre2_general_context_16 = struct_pcre2_real_general_context_16;
pub const struct_pcre2_real_compile_context_16 = opaque {};
pub const pcre2_compile_context_16 = struct_pcre2_real_compile_context_16;
pub const struct_pcre2_real_match_context_16 = opaque {};
pub const pcre2_match_context_16 = struct_pcre2_real_match_context_16;
pub const struct_pcre2_real_convert_context_16 = opaque {};
pub const pcre2_convert_context_16 = struct_pcre2_real_convert_context_16;
pub const struct_pcre2_real_code_16 = opaque {};
pub const pcre2_code_16 = struct_pcre2_real_code_16;
pub const struct_pcre2_real_match_data_16 = opaque {};
pub const pcre2_match_data_16 = struct_pcre2_real_match_data_16;
pub const struct_pcre2_real_jit_stack_16 = opaque {};
pub const pcre2_jit_stack_16 = struct_pcre2_real_jit_stack_16;
pub const pcre2_jit_callback_16 = ?*const fn (?*anyopaque) callconv(.C) ?*pcre2_jit_stack_16;
pub const struct_pcre2_callout_block_16 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    callout_number: u32 = @import("std").mem.zeroes(u32),
    capture_top: u32 = @import("std").mem.zeroes(u32),
    capture_last: u32 = @import("std").mem.zeroes(u32),
    offset_vector: [*c]usize = @import("std").mem.zeroes([*c]usize),
    mark: PCRE2_SPTR16 = @import("std").mem.zeroes(PCRE2_SPTR16),
    subject: PCRE2_SPTR16 = @import("std").mem.zeroes(PCRE2_SPTR16),
    subject_length: usize = @import("std").mem.zeroes(usize),
    start_match: usize = @import("std").mem.zeroes(usize),
    current_position: usize = @import("std").mem.zeroes(usize),
    pattern_position: usize = @import("std").mem.zeroes(usize),
    next_item_length: usize = @import("std").mem.zeroes(usize),
    callout_string_offset: usize = @import("std").mem.zeroes(usize),
    callout_string_length: usize = @import("std").mem.zeroes(usize),
    callout_string: PCRE2_SPTR16 = @import("std").mem.zeroes(PCRE2_SPTR16),
    callout_flags: u32 = @import("std").mem.zeroes(u32),
};
pub const pcre2_callout_block_16 = struct_pcre2_callout_block_16;
pub const struct_pcre2_callout_enumerate_block_16 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    pattern_position: usize = @import("std").mem.zeroes(usize),
    next_item_length: usize = @import("std").mem.zeroes(usize),
    callout_number: u32 = @import("std").mem.zeroes(u32),
    callout_string_offset: usize = @import("std").mem.zeroes(usize),
    callout_string_length: usize = @import("std").mem.zeroes(usize),
    callout_string: PCRE2_SPTR16 = @import("std").mem.zeroes(PCRE2_SPTR16),
};
pub const pcre2_callout_enumerate_block_16 = struct_pcre2_callout_enumerate_block_16;
pub const struct_pcre2_substitute_callout_block_16 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    input: PCRE2_SPTR16 = @import("std").mem.zeroes(PCRE2_SPTR16),
    output: PCRE2_SPTR16 = @import("std").mem.zeroes(PCRE2_SPTR16),
    output_offsets: [2]usize = @import("std").mem.zeroes([2]usize),
    ovector: [*c]usize = @import("std").mem.zeroes([*c]usize),
    oveccount: u32 = @import("std").mem.zeroes(u32),
    subscount: u32 = @import("std").mem.zeroes(u32),
};
pub const pcre2_substitute_callout_block_16 = struct_pcre2_substitute_callout_block_16;
pub extern fn pcre2_config_16(u32, ?*anyopaque) c_int;
pub extern fn pcre2_general_context_copy_16(?*pcre2_general_context_16) ?*pcre2_general_context_16;
pub extern fn pcre2_general_context_create_16(?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque, ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void, ?*anyopaque) ?*pcre2_general_context_16;
pub extern fn pcre2_general_context_free_16(?*pcre2_general_context_16) void;
pub extern fn pcre2_compile_context_copy_16(?*pcre2_compile_context_16) ?*pcre2_compile_context_16;
pub extern fn pcre2_compile_context_create_16(?*pcre2_general_context_16) ?*pcre2_compile_context_16;
pub extern fn pcre2_compile_context_free_16(?*pcre2_compile_context_16) void;
pub extern fn pcre2_set_bsr_16(?*pcre2_compile_context_16, u32) c_int;
pub extern fn pcre2_set_character_tables_16(?*pcre2_compile_context_16, [*c]const u8) c_int;
pub extern fn pcre2_set_compile_extra_options_16(?*pcre2_compile_context_16, u32) c_int;
pub extern fn pcre2_set_max_pattern_length_16(?*pcre2_compile_context_16, usize) c_int;
pub extern fn pcre2_set_max_pattern_compiled_length_16(?*pcre2_compile_context_16, usize) c_int;
pub extern fn pcre2_set_max_varlookbehind_16(?*pcre2_compile_context_16, u32) c_int;
pub extern fn pcre2_set_newline_16(?*pcre2_compile_context_16, u32) c_int;
pub extern fn pcre2_set_parens_nest_limit_16(?*pcre2_compile_context_16, u32) c_int;
pub extern fn pcre2_set_compile_recursion_guard_16(?*pcre2_compile_context_16, ?*const fn (u32, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_convert_context_copy_16(?*pcre2_convert_context_16) ?*pcre2_convert_context_16;
pub extern fn pcre2_convert_context_create_16(?*pcre2_general_context_16) ?*pcre2_convert_context_16;
pub extern fn pcre2_convert_context_free_16(?*pcre2_convert_context_16) void;
pub extern fn pcre2_set_glob_escape_16(?*pcre2_convert_context_16, u32) c_int;
pub extern fn pcre2_set_glob_separator_16(?*pcre2_convert_context_16, u32) c_int;
pub extern fn pcre2_pattern_convert_16(PCRE2_SPTR16, usize, u32, [*c][*c]PCRE2_UCHAR16, [*c]usize, ?*pcre2_convert_context_16) c_int;
pub extern fn pcre2_converted_pattern_free_16([*c]PCRE2_UCHAR16) void;
pub extern fn pcre2_match_context_copy_16(?*pcre2_match_context_16) ?*pcre2_match_context_16;
pub extern fn pcre2_match_context_create_16(?*pcre2_general_context_16) ?*pcre2_match_context_16;
pub extern fn pcre2_match_context_free_16(?*pcre2_match_context_16) void;
pub extern fn pcre2_set_callout_16(?*pcre2_match_context_16, ?*const fn ([*c]pcre2_callout_block_16, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_set_substitute_callout_16(?*pcre2_match_context_16, ?*const fn ([*c]pcre2_substitute_callout_block_16, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_set_depth_limit_16(?*pcre2_match_context_16, u32) c_int;
pub extern fn pcre2_set_heap_limit_16(?*pcre2_match_context_16, u32) c_int;
pub extern fn pcre2_set_match_limit_16(?*pcre2_match_context_16, u32) c_int;
pub extern fn pcre2_set_offset_limit_16(?*pcre2_match_context_16, usize) c_int;
pub extern fn pcre2_set_recursion_limit_16(?*pcre2_match_context_16, u32) c_int;
pub extern fn pcre2_set_recursion_memory_management_16(?*pcre2_match_context_16, ?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque, ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void, ?*anyopaque) c_int;
pub extern fn pcre2_compile_16(PCRE2_SPTR16, usize, u32, [*c]c_int, [*c]usize, ?*pcre2_compile_context_16) ?*pcre2_code_16;
pub extern fn pcre2_code_free_16(?*pcre2_code_16) void;
pub extern fn pcre2_code_copy_16(?*const pcre2_code_16) ?*pcre2_code_16;
pub extern fn pcre2_code_copy_with_tables_16(?*const pcre2_code_16) ?*pcre2_code_16;
pub extern fn pcre2_pattern_info_16(?*const pcre2_code_16, u32, ?*anyopaque) c_int;
pub extern fn pcre2_callout_enumerate_16(?*const pcre2_code_16, ?*const fn ([*c]pcre2_callout_enumerate_block_16, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_match_data_create_16(u32, ?*pcre2_general_context_16) ?*pcre2_match_data_16;
pub extern fn pcre2_match_data_create_from_pattern_16(?*const pcre2_code_16, ?*pcre2_general_context_16) ?*pcre2_match_data_16;
pub extern fn pcre2_dfa_match_16(?*const pcre2_code_16, PCRE2_SPTR16, usize, usize, u32, ?*pcre2_match_data_16, ?*pcre2_match_context_16, [*c]c_int, usize) c_int;
pub extern fn pcre2_match_16(?*const pcre2_code_16, PCRE2_SPTR16, usize, usize, u32, ?*pcre2_match_data_16, ?*pcre2_match_context_16) c_int;
pub extern fn pcre2_match_data_free_16(?*pcre2_match_data_16) void;
pub extern fn pcre2_get_mark_16(?*pcre2_match_data_16) PCRE2_SPTR16;
pub extern fn pcre2_get_match_data_size_16(?*pcre2_match_data_16) usize;
pub extern fn pcre2_get_match_data_heapframes_size_16(?*pcre2_match_data_16) usize;
pub extern fn pcre2_get_ovector_count_16(?*pcre2_match_data_16) u32;
pub extern fn pcre2_get_ovector_pointer_16(?*pcre2_match_data_16) [*c]usize;
pub extern fn pcre2_get_startchar_16(?*pcre2_match_data_16) usize;
pub extern fn pcre2_substring_copy_byname_16(?*pcre2_match_data_16, PCRE2_SPTR16, [*c]PCRE2_UCHAR16, [*c]usize) c_int;
pub extern fn pcre2_substring_copy_bynumber_16(?*pcre2_match_data_16, u32, [*c]PCRE2_UCHAR16, [*c]usize) c_int;
pub extern fn pcre2_substring_free_16([*c]PCRE2_UCHAR16) void;
pub extern fn pcre2_substring_get_byname_16(?*pcre2_match_data_16, PCRE2_SPTR16, [*c][*c]PCRE2_UCHAR16, [*c]usize) c_int;
pub extern fn pcre2_substring_get_bynumber_16(?*pcre2_match_data_16, u32, [*c][*c]PCRE2_UCHAR16, [*c]usize) c_int;
pub extern fn pcre2_substring_length_byname_16(?*pcre2_match_data_16, PCRE2_SPTR16, [*c]usize) c_int;
pub extern fn pcre2_substring_length_bynumber_16(?*pcre2_match_data_16, u32, [*c]usize) c_int;
pub extern fn pcre2_substring_nametable_scan_16(?*const pcre2_code_16, PCRE2_SPTR16, [*c]PCRE2_SPTR16, [*c]PCRE2_SPTR16) c_int;
pub extern fn pcre2_substring_number_from_name_16(?*const pcre2_code_16, PCRE2_SPTR16) c_int;
pub extern fn pcre2_substring_list_free_16([*c][*c]PCRE2_UCHAR16) void;
pub extern fn pcre2_substring_list_get_16(?*pcre2_match_data_16, [*c][*c][*c]PCRE2_UCHAR16, [*c][*c]usize) c_int;
pub extern fn pcre2_serialize_encode_16([*c]?*const pcre2_code_16, i32, [*c][*c]u8, [*c]usize, ?*pcre2_general_context_16) i32;
pub extern fn pcre2_serialize_decode_16([*c]?*pcre2_code_16, i32, [*c]const u8, ?*pcre2_general_context_16) i32;
pub extern fn pcre2_serialize_get_number_of_codes_16([*c]const u8) i32;
pub extern fn pcre2_serialize_free_16([*c]u8) void;
pub extern fn pcre2_substitute_16(?*const pcre2_code_16, PCRE2_SPTR16, usize, usize, u32, ?*pcre2_match_data_16, ?*pcre2_match_context_16, PCRE2_SPTR16, usize, [*c]PCRE2_UCHAR16, [*c]usize) c_int;
pub extern fn pcre2_jit_compile_16(?*pcre2_code_16, u32) c_int;
pub extern fn pcre2_jit_match_16(?*const pcre2_code_16, PCRE2_SPTR16, usize, usize, u32, ?*pcre2_match_data_16, ?*pcre2_match_context_16) c_int;
pub extern fn pcre2_jit_free_unused_memory_16(?*pcre2_general_context_16) void;
pub extern fn pcre2_jit_stack_create_16(usize, usize, ?*pcre2_general_context_16) ?*pcre2_jit_stack_16;
pub extern fn pcre2_jit_stack_assign_16(?*pcre2_match_context_16, pcre2_jit_callback_16, ?*anyopaque) void;
pub extern fn pcre2_jit_stack_free_16(?*pcre2_jit_stack_16) void;
pub extern fn pcre2_get_error_message_16(c_int, [*c]PCRE2_UCHAR16, usize) c_int;
pub extern fn pcre2_maketables_16(?*pcre2_general_context_16) [*c]const u8;
pub extern fn pcre2_maketables_free_16(?*pcre2_general_context_16, [*c]const u8) void;
pub const struct_pcre2_real_general_context_32 = opaque {};
pub const pcre2_general_context_32 = struct_pcre2_real_general_context_32;
pub const struct_pcre2_real_compile_context_32 = opaque {};
pub const pcre2_compile_context_32 = struct_pcre2_real_compile_context_32;
pub const struct_pcre2_real_match_context_32 = opaque {};
pub const pcre2_match_context_32 = struct_pcre2_real_match_context_32;
pub const struct_pcre2_real_convert_context_32 = opaque {};
pub const pcre2_convert_context_32 = struct_pcre2_real_convert_context_32;
pub const struct_pcre2_real_code_32 = opaque {};
pub const pcre2_code_32 = struct_pcre2_real_code_32;
pub const struct_pcre2_real_match_data_32 = opaque {};
pub const pcre2_match_data_32 = struct_pcre2_real_match_data_32;
pub const struct_pcre2_real_jit_stack_32 = opaque {};
pub const pcre2_jit_stack_32 = struct_pcre2_real_jit_stack_32;
pub const pcre2_jit_callback_32 = ?*const fn (?*anyopaque) callconv(.C) ?*pcre2_jit_stack_32;
pub const struct_pcre2_callout_block_32 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    callout_number: u32 = @import("std").mem.zeroes(u32),
    capture_top: u32 = @import("std").mem.zeroes(u32),
    capture_last: u32 = @import("std").mem.zeroes(u32),
    offset_vector: [*c]usize = @import("std").mem.zeroes([*c]usize),
    mark: PCRE2_SPTR32 = @import("std").mem.zeroes(PCRE2_SPTR32),
    subject: PCRE2_SPTR32 = @import("std").mem.zeroes(PCRE2_SPTR32),
    subject_length: usize = @import("std").mem.zeroes(usize),
    start_match: usize = @import("std").mem.zeroes(usize),
    current_position: usize = @import("std").mem.zeroes(usize),
    pattern_position: usize = @import("std").mem.zeroes(usize),
    next_item_length: usize = @import("std").mem.zeroes(usize),
    callout_string_offset: usize = @import("std").mem.zeroes(usize),
    callout_string_length: usize = @import("std").mem.zeroes(usize),
    callout_string: PCRE2_SPTR32 = @import("std").mem.zeroes(PCRE2_SPTR32),
    callout_flags: u32 = @import("std").mem.zeroes(u32),
};
pub const pcre2_callout_block_32 = struct_pcre2_callout_block_32;
pub const struct_pcre2_callout_enumerate_block_32 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    pattern_position: usize = @import("std").mem.zeroes(usize),
    next_item_length: usize = @import("std").mem.zeroes(usize),
    callout_number: u32 = @import("std").mem.zeroes(u32),
    callout_string_offset: usize = @import("std").mem.zeroes(usize),
    callout_string_length: usize = @import("std").mem.zeroes(usize),
    callout_string: PCRE2_SPTR32 = @import("std").mem.zeroes(PCRE2_SPTR32),
};
pub const pcre2_callout_enumerate_block_32 = struct_pcre2_callout_enumerate_block_32;
pub const struct_pcre2_substitute_callout_block_32 = extern struct {
    version: u32 = @import("std").mem.zeroes(u32),
    input: PCRE2_SPTR32 = @import("std").mem.zeroes(PCRE2_SPTR32),
    output: PCRE2_SPTR32 = @import("std").mem.zeroes(PCRE2_SPTR32),
    output_offsets: [2]usize = @import("std").mem.zeroes([2]usize),
    ovector: [*c]usize = @import("std").mem.zeroes([*c]usize),
    oveccount: u32 = @import("std").mem.zeroes(u32),
    subscount: u32 = @import("std").mem.zeroes(u32),
};
pub const pcre2_substitute_callout_block_32 = struct_pcre2_substitute_callout_block_32;
pub extern fn pcre2_config_32(u32, ?*anyopaque) c_int;
pub extern fn pcre2_general_context_copy_32(?*pcre2_general_context_32) ?*pcre2_general_context_32;
pub extern fn pcre2_general_context_create_32(?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque, ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void, ?*anyopaque) ?*pcre2_general_context_32;
pub extern fn pcre2_general_context_free_32(?*pcre2_general_context_32) void;
pub extern fn pcre2_compile_context_copy_32(?*pcre2_compile_context_32) ?*pcre2_compile_context_32;
pub extern fn pcre2_compile_context_create_32(?*pcre2_general_context_32) ?*pcre2_compile_context_32;
pub extern fn pcre2_compile_context_free_32(?*pcre2_compile_context_32) void;
pub extern fn pcre2_set_bsr_32(?*pcre2_compile_context_32, u32) c_int;
pub extern fn pcre2_set_character_tables_32(?*pcre2_compile_context_32, [*c]const u8) c_int;
pub extern fn pcre2_set_compile_extra_options_32(?*pcre2_compile_context_32, u32) c_int;
pub extern fn pcre2_set_max_pattern_length_32(?*pcre2_compile_context_32, usize) c_int;
pub extern fn pcre2_set_max_pattern_compiled_length_32(?*pcre2_compile_context_32, usize) c_int;
pub extern fn pcre2_set_max_varlookbehind_32(?*pcre2_compile_context_32, u32) c_int;
pub extern fn pcre2_set_newline_32(?*pcre2_compile_context_32, u32) c_int;
pub extern fn pcre2_set_parens_nest_limit_32(?*pcre2_compile_context_32, u32) c_int;
pub extern fn pcre2_set_compile_recursion_guard_32(?*pcre2_compile_context_32, ?*const fn (u32, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_convert_context_copy_32(?*pcre2_convert_context_32) ?*pcre2_convert_context_32;
pub extern fn pcre2_convert_context_create_32(?*pcre2_general_context_32) ?*pcre2_convert_context_32;
pub extern fn pcre2_convert_context_free_32(?*pcre2_convert_context_32) void;
pub extern fn pcre2_set_glob_escape_32(?*pcre2_convert_context_32, u32) c_int;
pub extern fn pcre2_set_glob_separator_32(?*pcre2_convert_context_32, u32) c_int;
pub extern fn pcre2_pattern_convert_32(PCRE2_SPTR32, usize, u32, [*c][*c]PCRE2_UCHAR32, [*c]usize, ?*pcre2_convert_context_32) c_int;
pub extern fn pcre2_converted_pattern_free_32([*c]PCRE2_UCHAR32) void;
pub extern fn pcre2_match_context_copy_32(?*pcre2_match_context_32) ?*pcre2_match_context_32;
pub extern fn pcre2_match_context_create_32(?*pcre2_general_context_32) ?*pcre2_match_context_32;
pub extern fn pcre2_match_context_free_32(?*pcre2_match_context_32) void;
pub extern fn pcre2_set_callout_32(?*pcre2_match_context_32, ?*const fn ([*c]pcre2_callout_block_32, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_set_substitute_callout_32(?*pcre2_match_context_32, ?*const fn ([*c]pcre2_substitute_callout_block_32, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_set_depth_limit_32(?*pcre2_match_context_32, u32) c_int;
pub extern fn pcre2_set_heap_limit_32(?*pcre2_match_context_32, u32) c_int;
pub extern fn pcre2_set_match_limit_32(?*pcre2_match_context_32, u32) c_int;
pub extern fn pcre2_set_offset_limit_32(?*pcre2_match_context_32, usize) c_int;
pub extern fn pcre2_set_recursion_limit_32(?*pcre2_match_context_32, u32) c_int;
pub extern fn pcre2_set_recursion_memory_management_32(?*pcre2_match_context_32, ?*const fn (usize, ?*anyopaque) callconv(.C) ?*anyopaque, ?*const fn (?*anyopaque, ?*anyopaque) callconv(.C) void, ?*anyopaque) c_int;
pub extern fn pcre2_compile_32(PCRE2_SPTR32, usize, u32, [*c]c_int, [*c]usize, ?*pcre2_compile_context_32) ?*pcre2_code_32;
pub extern fn pcre2_code_free_32(?*pcre2_code_32) void;
pub extern fn pcre2_code_copy_32(?*const pcre2_code_32) ?*pcre2_code_32;
pub extern fn pcre2_code_copy_with_tables_32(?*const pcre2_code_32) ?*pcre2_code_32;
pub extern fn pcre2_pattern_info_32(?*const pcre2_code_32, u32, ?*anyopaque) c_int;
pub extern fn pcre2_callout_enumerate_32(?*const pcre2_code_32, ?*const fn ([*c]pcre2_callout_enumerate_block_32, ?*anyopaque) callconv(.C) c_int, ?*anyopaque) c_int;
pub extern fn pcre2_match_data_create_32(u32, ?*pcre2_general_context_32) ?*pcre2_match_data_32;
pub extern fn pcre2_match_data_create_from_pattern_32(?*const pcre2_code_32, ?*pcre2_general_context_32) ?*pcre2_match_data_32;
pub extern fn pcre2_dfa_match_32(?*const pcre2_code_32, PCRE2_SPTR32, usize, usize, u32, ?*pcre2_match_data_32, ?*pcre2_match_context_32, [*c]c_int, usize) c_int;
pub extern fn pcre2_match_32(?*const pcre2_code_32, PCRE2_SPTR32, usize, usize, u32, ?*pcre2_match_data_32, ?*pcre2_match_context_32) c_int;
pub extern fn pcre2_match_data_free_32(?*pcre2_match_data_32) void;
pub extern fn pcre2_get_mark_32(?*pcre2_match_data_32) PCRE2_SPTR32;
pub extern fn pcre2_get_match_data_size_32(?*pcre2_match_data_32) usize;
pub extern fn pcre2_get_match_data_heapframes_size_32(?*pcre2_match_data_32) usize;
pub extern fn pcre2_get_ovector_count_32(?*pcre2_match_data_32) u32;
pub extern fn pcre2_get_ovector_pointer_32(?*pcre2_match_data_32) [*c]usize;
pub extern fn pcre2_get_startchar_32(?*pcre2_match_data_32) usize;
pub extern fn pcre2_substring_copy_byname_32(?*pcre2_match_data_32, PCRE2_SPTR32, [*c]PCRE2_UCHAR32, [*c]usize) c_int;
pub extern fn pcre2_substring_copy_bynumber_32(?*pcre2_match_data_32, u32, [*c]PCRE2_UCHAR32, [*c]usize) c_int;
pub extern fn pcre2_substring_free_32([*c]PCRE2_UCHAR32) void;
pub extern fn pcre2_substring_get_byname_32(?*pcre2_match_data_32, PCRE2_SPTR32, [*c][*c]PCRE2_UCHAR32, [*c]usize) c_int;
pub extern fn pcre2_substring_get_bynumber_32(?*pcre2_match_data_32, u32, [*c][*c]PCRE2_UCHAR32, [*c]usize) c_int;
pub extern fn pcre2_substring_length_byname_32(?*pcre2_match_data_32, PCRE2_SPTR32, [*c]usize) c_int;
pub extern fn pcre2_substring_length_bynumber_32(?*pcre2_match_data_32, u32, [*c]usize) c_int;
pub extern fn pcre2_substring_nametable_scan_32(?*const pcre2_code_32, PCRE2_SPTR32, [*c]PCRE2_SPTR32, [*c]PCRE2_SPTR32) c_int;
pub extern fn pcre2_substring_number_from_name_32(?*const pcre2_code_32, PCRE2_SPTR32) c_int;
pub extern fn pcre2_substring_list_free_32([*c][*c]PCRE2_UCHAR32) void;
pub extern fn pcre2_substring_list_get_32(?*pcre2_match_data_32, [*c][*c][*c]PCRE2_UCHAR32, [*c][*c]usize) c_int;
pub extern fn pcre2_serialize_encode_32([*c]?*const pcre2_code_32, i32, [*c][*c]u8, [*c]usize, ?*pcre2_general_context_32) i32;
pub extern fn pcre2_serialize_decode_32([*c]?*pcre2_code_32, i32, [*c]const u8, ?*pcre2_general_context_32) i32;
pub extern fn pcre2_serialize_get_number_of_codes_32([*c]const u8) i32;
pub extern fn pcre2_serialize_free_32([*c]u8) void;
pub extern fn pcre2_substitute_32(?*const pcre2_code_32, PCRE2_SPTR32, usize, usize, u32, ?*pcre2_match_data_32, ?*pcre2_match_context_32, PCRE2_SPTR32, usize, [*c]PCRE2_UCHAR32, [*c]usize) c_int;
pub extern fn pcre2_jit_compile_32(?*pcre2_code_32, u32) c_int;
pub extern fn pcre2_jit_match_32(?*const pcre2_code_32, PCRE2_SPTR32, usize, usize, u32, ?*pcre2_match_data_32, ?*pcre2_match_context_32) c_int;
pub extern fn pcre2_jit_free_unused_memory_32(?*pcre2_general_context_32) void;
pub extern fn pcre2_jit_stack_create_32(usize, usize, ?*pcre2_general_context_32) ?*pcre2_jit_stack_32;
pub extern fn pcre2_jit_stack_assign_32(?*pcre2_match_context_32, pcre2_jit_callback_32, ?*anyopaque) void;
pub extern fn pcre2_jit_stack_free_32(?*pcre2_jit_stack_32) void;
pub extern fn pcre2_get_error_message_32(c_int, [*c]PCRE2_UCHAR32, usize) c_int;
pub extern fn pcre2_maketables_32(?*pcre2_general_context_32) [*c]const u8;
pub extern fn pcre2_maketables_free_32(?*pcre2_general_context_32, [*c]const u8) void;
pub const ngx_regex_t = pcre2_code_8;
pub const ngx_regex_compile_t = extern struct {
    pattern: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    options: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    regex: ?*ngx_regex_t = @import("std").mem.zeroes(?*ngx_regex_t),
    captures: c_int = @import("std").mem.zeroes(c_int),
    named_captures: c_int = @import("std").mem.zeroes(c_int),
    name_size: c_int = @import("std").mem.zeroes(c_int),
    names: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    err: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_regex_elt_t = extern struct {
    regex: ?*ngx_regex_t = @import("std").mem.zeroes(?*ngx_regex_t),
    name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
};
pub extern fn ngx_regex_init() void;
pub extern fn ngx_regex_compile(rc: [*c]ngx_regex_compile_t) ngx_int_t;
pub extern fn ngx_regex_exec(re: ?*ngx_regex_t, s: [*c]ngx_str_t, captures: [*c]c_int, size: ngx_uint_t) ngx_int_t;
pub extern fn ngx_regex_exec_array(a: [*c]ngx_array_t, s: [*c]ngx_str_t, log: [*c]ngx_log_t) ngx_int_t;
pub const ngx_radix_node_t = struct_ngx_radix_node_s;
pub const struct_ngx_radix_node_s = extern struct {
    right: [*c]ngx_radix_node_t = @import("std").mem.zeroes([*c]ngx_radix_node_t),
    left: [*c]ngx_radix_node_t = @import("std").mem.zeroes([*c]ngx_radix_node_t),
    parent: [*c]ngx_radix_node_t = @import("std").mem.zeroes([*c]ngx_radix_node_t),
    value: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_radix_tree_t = extern struct {
    root: [*c]ngx_radix_node_t = @import("std").mem.zeroes([*c]ngx_radix_node_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    free: [*c]ngx_radix_node_t = @import("std").mem.zeroes([*c]ngx_radix_node_t),
    start: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    size: usize = @import("std").mem.zeroes(usize),
};
pub extern fn ngx_radix_tree_create(pool: [*c]ngx_pool_t, preallocate: ngx_int_t) [*c]ngx_radix_tree_t;
pub extern fn ngx_radix32tree_insert(tree: [*c]ngx_radix_tree_t, key: u32, mask: u32, value: usize) ngx_int_t;
pub extern fn ngx_radix32tree_delete(tree: [*c]ngx_radix_tree_t, key: u32, mask: u32) ngx_int_t;
pub extern fn ngx_radix32tree_find(tree: [*c]ngx_radix_tree_t, key: u32) usize;
pub extern fn ngx_radix128tree_insert(tree: [*c]ngx_radix_tree_t, key: [*c]u_char, mask: [*c]u_char, value: usize) ngx_int_t;
pub extern fn ngx_radix128tree_delete(tree: [*c]ngx_radix_tree_t, key: [*c]u_char, mask: [*c]u_char) ngx_int_t;
pub extern fn ngx_radix128tree_find(tree: [*c]ngx_radix_tree_t, key: [*c]u_char) usize;
pub const ngx_time_t = extern struct {
    sec: time_t = @import("std").mem.zeroes(time_t),
    msec: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    gmtoff: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
};
pub extern fn ngx_time_init() void;
pub extern fn ngx_time_update() void;
pub extern fn ngx_time_sigsafe_update() void;
pub extern fn ngx_http_time(buf: [*c]u_char, t: time_t) [*c]u_char;
pub extern fn ngx_http_cookie_time(buf: [*c]u_char, t: time_t) [*c]u_char;
pub extern fn ngx_gmtime(t: time_t, tp: [*c]ngx_tm_t) void;
pub extern fn ngx_next_time(when: time_t) time_t;
pub extern var ngx_cached_time: [*c]volatile ngx_time_t;
pub extern var ngx_cached_err_log_time: ngx_str_t;
pub extern var ngx_cached_http_time: ngx_str_t;
pub extern var ngx_cached_http_log_time: ngx_str_t;
pub extern var ngx_cached_http_log_iso8601: ngx_str_t;
pub extern var ngx_cached_syslog_time: ngx_str_t;
pub extern var ngx_current_msec: ngx_msec_t;
pub extern fn ngx_rwlock_wlock(lock: [*c]volatile ngx_atomic_t) void;
pub extern fn ngx_rwlock_rlock(lock: [*c]volatile ngx_atomic_t) void;
pub extern fn ngx_rwlock_unlock(lock: [*c]volatile ngx_atomic_t) void;
pub extern fn ngx_rwlock_downgrade(lock: [*c]volatile ngx_atomic_t) void;
pub const ngx_shmtx_sh_t = extern struct {
    lock: ngx_atomic_t = @import("std").mem.zeroes(ngx_atomic_t),
    wait: ngx_atomic_t = @import("std").mem.zeroes(ngx_atomic_t),
};
pub const ngx_shmtx_t = extern struct {
    lock: [*c]volatile ngx_atomic_t = @import("std").mem.zeroes([*c]volatile ngx_atomic_t),
    wait: [*c]volatile ngx_atomic_t = @import("std").mem.zeroes([*c]volatile ngx_atomic_t),
    semaphore: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    sem: sem_t = @import("std").mem.zeroes(sem_t),
    spin: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_shmtx_create(mtx: [*c]ngx_shmtx_t, addr: [*c]ngx_shmtx_sh_t, name: [*c]u_char) ngx_int_t;
pub extern fn ngx_shmtx_destroy(mtx: [*c]ngx_shmtx_t) void;
pub extern fn ngx_shmtx_trylock(mtx: [*c]ngx_shmtx_t) ngx_uint_t;
pub extern fn ngx_shmtx_lock(mtx: [*c]ngx_shmtx_t) void;
pub extern fn ngx_shmtx_unlock(mtx: [*c]ngx_shmtx_t) void;
pub extern fn ngx_shmtx_force_unlock(mtx: [*c]ngx_shmtx_t, pid: ngx_pid_t) ngx_uint_t;
pub const ngx_slab_page_t = struct_ngx_slab_page_s;
pub const struct_ngx_slab_page_s = extern struct {
    slab: usize = @import("std").mem.zeroes(usize),
    next: [*c]ngx_slab_page_t = @import("std").mem.zeroes([*c]ngx_slab_page_t),
    prev: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_slab_stat_t = extern struct {
    total: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    used: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    reqs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    fails: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_slab_pool_t = extern struct {
    lock: ngx_shmtx_sh_t = @import("std").mem.zeroes(ngx_shmtx_sh_t),
    min_size: usize = @import("std").mem.zeroes(usize),
    min_shift: usize = @import("std").mem.zeroes(usize),
    pages: [*c]ngx_slab_page_t = @import("std").mem.zeroes([*c]ngx_slab_page_t),
    last: [*c]ngx_slab_page_t = @import("std").mem.zeroes([*c]ngx_slab_page_t),
    free: ngx_slab_page_t = @import("std").mem.zeroes(ngx_slab_page_t),
    stats: [*c]ngx_slab_stat_t = @import("std").mem.zeroes([*c]ngx_slab_stat_t),
    pfree: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    mutex: ngx_shmtx_t = @import("std").mem.zeroes(ngx_shmtx_t),
    log_ctx: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    zero: u_char = @import("std").mem.zeroes(u_char),
    flags: packed struct {
        log_nomem: bool,
        padding: u31,
    } = @import("std").mem.zeroes(c_uint),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    addr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub extern fn ngx_slab_sizes_init() void;
pub extern fn ngx_slab_init(pool: [*c]ngx_slab_pool_t) void;
pub extern fn ngx_slab_alloc(pool: [*c]ngx_slab_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_slab_alloc_locked(pool: [*c]ngx_slab_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_slab_calloc(pool: [*c]ngx_slab_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_slab_calloc_locked(pool: [*c]ngx_slab_pool_t, size: usize) ?*anyopaque;
pub extern fn ngx_slab_free(pool: [*c]ngx_slab_pool_t, p: ?*anyopaque) void;
pub extern fn ngx_slab_free_locked(pool: [*c]ngx_slab_pool_t, p: ?*anyopaque) void;
pub const ngx_sockaddr_t = extern union {
    sockaddr: struct_sockaddr,
    sockaddr_in: struct_sockaddr_in,
    sockaddr_in6: struct_sockaddr_in6,
    sockaddr_un: struct_sockaddr_un,
};
pub const ngx_in_cidr_t = extern struct {
    addr: in_addr_t = @import("std").mem.zeroes(in_addr_t),
    mask: in_addr_t = @import("std").mem.zeroes(in_addr_t),
};
pub const ngx_in6_cidr_t = extern struct {
    addr: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
    mask: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
};
const union_unnamed_81 = extern union {
    in: ngx_in_cidr_t,
    in6: ngx_in6_cidr_t,
};
pub const ngx_cidr_t = extern struct {
    family: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    u: union_unnamed_81 = @import("std").mem.zeroes(union_unnamed_81),
};
pub const ngx_addr_t = extern struct {
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_url_t = extern struct {
    url: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    host: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    port_text: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    uri: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    port: in_port_t = @import("std").mem.zeroes(in_port_t),
    default_port: in_port_t = @import("std").mem.zeroes(in_port_t),
    last_port: in_port_t = @import("std").mem.zeroes(in_port_t),
    family: c_int = @import("std").mem.zeroes(c_int),
    flags: packed struct {
        listen: bool,
        uri_part: bool,
        no_resolve: bool,
        no_port: bool,
        wildcard: bool,
        padding: u27,
    } = @import("std").mem.zeroes(c_uint),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    sockaddr: ngx_sockaddr_t = @import("std").mem.zeroes(ngx_sockaddr_t),
    addrs: [*c]ngx_addr_t = @import("std").mem.zeroes([*c]ngx_addr_t),
    naddrs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    err: [*c]u8 = @import("std").mem.zeroes([*c]u8),
};
pub extern fn ngx_inet_addr(text: [*c]u_char, len: usize) in_addr_t;
pub extern fn ngx_inet6_addr(p: [*c]u_char, len: usize, addr: [*c]u_char) ngx_int_t;
pub extern fn ngx_inet6_ntop(p: [*c]u_char, text: [*c]u_char, len: usize) usize;
pub extern fn ngx_sock_ntop(sa: [*c]struct_sockaddr, socklen: socklen_t, text: [*c]u_char, len: usize, port: ngx_uint_t) usize;
pub extern fn ngx_inet_ntop(family: c_int, addr: ?*anyopaque, text: [*c]u_char, len: usize) usize;
pub extern fn ngx_ptocidr(text: [*c]ngx_str_t, cidr: [*c]ngx_cidr_t) ngx_int_t;
pub extern fn ngx_cidr_match(sa: [*c]struct_sockaddr, cidrs: [*c]ngx_array_t) ngx_int_t;
pub extern fn ngx_parse_addr(pool: [*c]ngx_pool_t, addr: [*c]ngx_addr_t, text: [*c]u_char, len: usize) ngx_int_t;
pub extern fn ngx_parse_addr_port(pool: [*c]ngx_pool_t, addr: [*c]ngx_addr_t, text: [*c]u_char, len: usize) ngx_int_t;
pub extern fn ngx_parse_url(pool: [*c]ngx_pool_t, u: [*c]ngx_url_t) ngx_int_t;
pub extern fn ngx_inet_resolve_host(pool: [*c]ngx_pool_t, u: [*c]ngx_url_t) ngx_int_t;
pub extern fn ngx_cmp_sockaddr(sa1: [*c]struct_sockaddr, slen1: socklen_t, sa2: [*c]struct_sockaddr, slen2: socklen_t, cmp_port: ngx_uint_t) ngx_int_t;
pub extern fn ngx_inet_get_port(sa: [*c]struct_sockaddr) in_port_t;
pub extern fn ngx_inet_set_port(sa: [*c]struct_sockaddr, port: in_port_t) void;
pub extern fn ngx_inet_wildcard(sa: [*c]struct_sockaddr) ngx_uint_t;
pub const ngx_shm_zone_t = struct_ngx_shm_zone_s;
pub const ngx_shm_zone_init_pt = ?*const fn ([*c]ngx_shm_zone_t, ?*anyopaque) callconv(.C) ngx_int_t;
pub const struct_ngx_shm_zone_s = extern struct {
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    shm: ngx_shm_t = @import("std").mem.zeroes(ngx_shm_t),
    init: ngx_shm_zone_init_pt = @import("std").mem.zeroes(ngx_shm_zone_init_pt),
    tag: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    sync: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    noreuse: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_core_conf_t = extern struct {
    daemon: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    master: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    timer_resolution: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    shutdown_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    worker_processes: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    debug_points: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    rlimit_nofile: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    rlimit_core: off_t = @import("std").mem.zeroes(off_t),
    priority: c_int = @import("std").mem.zeroes(c_int),
    cpu_affinity_auto: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    cpu_affinity_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    cpu_affinity: [*c]ngx_cpuset_t = @import("std").mem.zeroes([*c]ngx_cpuset_t),
    username: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    user: ngx_uid_t = @import("std").mem.zeroes(ngx_uid_t),
    group: ngx_gid_t = @import("std").mem.zeroes(ngx_gid_t),
    working_directory: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    lock_file: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    pid: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    oldpid: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    env: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    environment: [*c][*c]u8 = @import("std").mem.zeroes([*c][*c]u8),
    transparent: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_init_cycle(old_cycle: [*c]ngx_cycle_t) [*c]ngx_cycle_t;
pub extern fn ngx_create_pidfile(name: [*c]ngx_str_t, log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_delete_pidfile(cycle: [*c]ngx_cycle_t) void;
pub extern fn ngx_signal_process(cycle: [*c]ngx_cycle_t, sig: [*c]u8) ngx_int_t;
pub extern fn ngx_reopen_files(cycle: [*c]ngx_cycle_t, user: ngx_uid_t) void;
pub extern fn ngx_set_environment(cycle: [*c]ngx_cycle_t, last: [*c]ngx_uint_t) [*c][*c]u8;
pub extern fn ngx_exec_new_binary(cycle: [*c]ngx_cycle_t, argv: [*c]const [*c]u8) ngx_pid_t;
pub extern fn ngx_get_cpu_affinity(n: ngx_uint_t) [*c]ngx_cpuset_t;
pub extern fn ngx_shared_memory_add(cf: [*c]ngx_conf_t, name: [*c]ngx_str_t, size: usize, tag: ?*anyopaque) [*c]ngx_shm_zone_t;
pub extern fn ngx_set_shutdown_timer(cycle: [*c]ngx_cycle_t) void;
pub extern var ngx_cycle: [*c]volatile ngx_cycle_t;
pub extern var ngx_old_cycles: ngx_array_t;
pub extern var ngx_core_module: ngx_module_t;
pub extern var ngx_test_config: ngx_uint_t;
pub extern var ngx_dump_config: ngx_uint_t;
pub extern var ngx_quiet_mode: ngx_uint_t;
pub const struct_ngx_resolver_s = extern struct {
    event: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    dummy: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    ident: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    connections: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    last_connection: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    name_rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    name_sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    srv_rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    srv_sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    addr_rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    addr_sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    name_resend_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    srv_resend_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    addr_resend_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    name_expire_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    srv_expire_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    addr_expire_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    flags: packed struct {
        ipv4: bool,
        ipv6: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
    addr6_rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    addr6_sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    addr6_resend_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    addr6_expire_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    resend_timeout: time_t = @import("std").mem.zeroes(time_t),
    tcp_timeout: time_t = @import("std").mem.zeroes(time_t),
    expire: time_t = @import("std").mem.zeroes(time_t),
    valid: time_t = @import("std").mem.zeroes(time_t),
    log_level: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_resolver_t = struct_ngx_resolver_s;
pub const ngx_resolver_connection_t = extern struct {
    udp: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    tcp: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    server: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    log: ngx_log_t = @import("std").mem.zeroes(ngx_log_t),
    read_buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    write_buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    resolver: [*c]ngx_resolver_t = @import("std").mem.zeroes([*c]ngx_resolver_t),
};
pub const ngx_resolver_ctx_t = struct_ngx_resolver_ctx_s;
pub const ngx_resolver_handler_pt = ?*const fn ([*c]ngx_resolver_ctx_t) callconv(.C) void;
pub const struct_ngx_resolver_ctx_s = extern struct {
    next: [*c]ngx_resolver_ctx_t = @import("std").mem.zeroes([*c]ngx_resolver_ctx_t),
    resolver: [*c]ngx_resolver_t = @import("std").mem.zeroes([*c]ngx_resolver_t),
    node: [*c]ngx_resolver_node_t = @import("std").mem.zeroes([*c]ngx_resolver_node_t),
    ident: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    state: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    service: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    valid: time_t = @import("std").mem.zeroes(time_t),
    naddrs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    addrs: [*c]ngx_resolver_addr_t = @import("std").mem.zeroes([*c]ngx_resolver_addr_t),
    addr: ngx_resolver_addr_t = @import("std").mem.zeroes(ngx_resolver_addr_t),
    sin: struct_sockaddr_in = @import("std").mem.zeroes(struct_sockaddr_in),
    count: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    nsrvs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    srvs: [*c]ngx_resolver_srv_name_t = @import("std").mem.zeroes([*c]ngx_resolver_srv_name_t),
    handler: ngx_resolver_handler_pt = @import("std").mem.zeroes(ngx_resolver_handler_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    flags: packed struct {
        quick: bool,
        @"async": bool,
        cancelable: bool,
        padding: u29,
    } = @import("std").mem.zeroes(c_uint),
    recursion: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    event: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
};
pub const ngx_resolver_addr_t = extern struct {
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    priority: u_short = @import("std").mem.zeroes(u_short),
    weight: u_short = @import("std").mem.zeroes(u_short),
};
pub const ngx_resolver_srv_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    priority: u_short = @import("std").mem.zeroes(u_short),
    weight: u_short = @import("std").mem.zeroes(u_short),
    port: u_short = @import("std").mem.zeroes(u_short),
};
pub const ngx_resolver_srv_name_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    priority: u_short = @import("std").mem.zeroes(u_short),
    weight: u_short = @import("std").mem.zeroes(u_short),
    port: u_short = @import("std").mem.zeroes(u_short),
    ctx: [*c]ngx_resolver_ctx_t = @import("std").mem.zeroes([*c]ngx_resolver_ctx_t),
    state: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    naddrs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    addrs: [*c]ngx_addr_t = @import("std").mem.zeroes([*c]ngx_addr_t),
};
const union_unnamed_82 = extern union {
    addr: in_addr_t,
    addrs: [*c]in_addr_t,
    cname: [*c]u_char,
    srvs: [*c]ngx_resolver_srv_t,
};
const union_unnamed_83 = extern union {
    addr6: struct_in6_addr,
    addrs6: [*c]struct_in6_addr,
};
pub const ngx_resolver_node_t = extern struct {
    node: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    addr6: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
    nlen: u_short = @import("std").mem.zeroes(u_short),
    qlen: u_short = @import("std").mem.zeroes(u_short),
    query: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    query6: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    u: union_unnamed_82 = @import("std").mem.zeroes(union_unnamed_82),
    code: u_char = @import("std").mem.zeroes(u_char),
    naddrs: u_short = @import("std").mem.zeroes(u_short),
    nsrvs: u_short = @import("std").mem.zeroes(u_short),
    cnlen: u_short = @import("std").mem.zeroes(u_short),
    u6: union_unnamed_83 = @import("std").mem.zeroes(union_unnamed_83),
    naddrs6: u_short = @import("std").mem.zeroes(u_short),
    expire: time_t = @import("std").mem.zeroes(time_t),
    valid: time_t = @import("std").mem.zeroes(time_t),
    ttl: u32 = @import("std").mem.zeroes(u32),
    flags: packed struct {
        tcp: bool,
        tcp6: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
    last_connection: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    waiting: [*c]ngx_resolver_ctx_t = @import("std").mem.zeroes([*c]ngx_resolver_ctx_t),
};
pub extern fn ngx_resolver_create(cf: [*c]ngx_conf_t, names: [*c]ngx_str_t, n: ngx_uint_t) [*c]ngx_resolver_t;
pub extern fn ngx_resolve_start(r: [*c]ngx_resolver_t, temp: [*c]ngx_resolver_ctx_t) [*c]ngx_resolver_ctx_t;
pub extern fn ngx_resolve_name(ctx: [*c]ngx_resolver_ctx_t) ngx_int_t;
pub extern fn ngx_resolve_name_done(ctx: [*c]ngx_resolver_ctx_t) void;
pub extern fn ngx_resolve_addr(ctx: [*c]ngx_resolver_ctx_t) ngx_int_t;
pub extern fn ngx_resolve_addr_done(ctx: [*c]ngx_resolver_ctx_t) void;
pub extern fn ngx_resolver_strerror(err: ngx_int_t) [*c]u8;
pub const ngx_cache_manager_ctx_t = extern struct {
    handler: ngx_event_handler_pt = @import("std").mem.zeroes(ngx_event_handler_pt),
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    delay: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
};
pub extern fn ngx_master_process_cycle(cycle: [*c]ngx_cycle_t) void;
pub extern fn ngx_single_process_cycle(cycle: [*c]ngx_cycle_t) void;
pub extern var ngx_process: ngx_uint_t;
pub extern var ngx_worker: ngx_uint_t;
pub extern var ngx_new_binary: ngx_pid_t;
pub extern var ngx_inherited: ngx_uint_t;
pub extern var ngx_daemonized: ngx_uint_t;
pub extern var ngx_exiting: ngx_uint_t;
pub extern var ngx_reap: sig_atomic_t;
pub extern var ngx_sigio: sig_atomic_t;
pub extern var ngx_sigalrm: sig_atomic_t;
pub extern var ngx_quit: sig_atomic_t;
pub extern var ngx_debug_quit: sig_atomic_t;
pub extern var ngx_terminate: sig_atomic_t;
pub extern var ngx_noaccept: sig_atomic_t;
pub extern var ngx_reconfigure: sig_atomic_t;
pub extern var ngx_reopen: sig_atomic_t;
pub extern var ngx_change_binary: sig_atomic_t;
pub const ngx_conf_file_t = extern struct {
    file: ngx_file_t = @import("std").mem.zeroes(ngx_file_t),
    buffer: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    dump: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    line: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_conf_dump_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    buffer: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
};
pub const ngx_conf_post_handler_pt = ?*const fn ([*c]ngx_conf_t, ?*anyopaque, ?*anyopaque) callconv(.C) [*c]u8;
pub const ngx_conf_post_t = extern struct {
    post_handler: ngx_conf_post_handler_pt = @import("std").mem.zeroes(ngx_conf_post_handler_pt),
};
pub const ngx_conf_deprecated_t = extern struct {
    post_handler: ngx_conf_post_handler_pt = @import("std").mem.zeroes(ngx_conf_post_handler_pt),
    old_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    new_name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
};
pub const ngx_conf_num_bounds_t = extern struct {
    post_handler: ngx_conf_post_handler_pt = @import("std").mem.zeroes(ngx_conf_post_handler_pt),
    low: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    high: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
};
pub const ngx_conf_enum_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    value: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_conf_bitmask_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    mask: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_conf_deprecated(cf: [*c]ngx_conf_t, post: ?*anyopaque, data: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_check_num_bounds(cf: [*c]ngx_conf_t, post: ?*anyopaque, data: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_param(cf: [*c]ngx_conf_t) [*c]u8;
pub extern fn ngx_conf_parse(cf: [*c]ngx_conf_t, filename: [*c]ngx_str_t) [*c]u8;
pub extern fn ngx_conf_include(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_full_name(cycle: [*c]ngx_cycle_t, name: [*c]ngx_str_t, conf_prefix: ngx_uint_t) ngx_int_t;
pub extern fn ngx_conf_open_file(cycle: [*c]ngx_cycle_t, name: [*c]ngx_str_t) [*c]ngx_open_file_t;
pub extern fn ngx_conf_log_error(level: ngx_uint_t, cf: [*c]ngx_conf_t, err: ngx_err_t, fmt: [*c]const u8, ...) void;
pub extern fn ngx_conf_set_flag_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_str_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_str_array_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_keyval_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_num_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_size_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_off_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_msec_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_sec_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_bufs_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_enum_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_conf_set_bitmask_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub const ngx_core_module_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    create_conf: ?*const fn ([*c]ngx_cycle_t) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) ?*anyopaque),
    init_conf: ?*const fn ([*c]ngx_cycle_t, ?*anyopaque) callconv(.C) [*c]u8 = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t, ?*anyopaque) callconv(.C) [*c]u8),
};
pub extern fn ngx_preinit_modules() ngx_int_t;
pub extern fn ngx_cycle_modules(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_init_modules(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_count_modules(cycle: [*c]ngx_cycle_t, @"type": ngx_uint_t) ngx_int_t;
pub extern fn ngx_add_module(cf: [*c]ngx_conf_t, file: [*c]ngx_str_t, module: [*c]ngx_module_t, order: [*c][*c]u8) ngx_int_t;
pub const ngx_modules: [*c][*c]ngx_module_t = @extern([*c][*c]ngx_module_t, .{
    .name = "ngx_modules",
});
pub extern var ngx_max_module: ngx_uint_t;
pub const ngx_module_names: [*c][*c]u8 = @extern([*c][*c]u8, .{
    .name = "ngx_module_names",
});
pub const ngx_open_file_info_t = extern struct {
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    uniq: ngx_file_uniq_t = @import("std").mem.zeroes(ngx_file_uniq_t),
    mtime: time_t = @import("std").mem.zeroes(time_t),
    size: off_t = @import("std").mem.zeroes(off_t),
    fs_size: off_t = @import("std").mem.zeroes(off_t),
    directio: off_t = @import("std").mem.zeroes(off_t),
    read_ahead: usize = @import("std").mem.zeroes(usize),
    err: ngx_err_t = @import("std").mem.zeroes(ngx_err_t),
    failed: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    valid: time_t = @import("std").mem.zeroes(time_t),
    min_uses: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    disable_symlinks_from: usize = @import("std").mem.zeroes(usize),
    flags: packed struct {
        disable_symlinks: u2,
        test_dir: bool,
        test_only: bool,
        log: bool,
        errors: bool,
        events: bool,
        is_dir: bool,
        is_file: bool,
        is_link: bool,
        is_exec: bool,
        is_directio: bool,
        padding: u20,
    } = @import("std").mem.zeroes(c_uint),
};
pub const struct_ngx_cached_open_file_s = extern struct {
    node: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    created: time_t = @import("std").mem.zeroes(time_t),
    accessed: time_t = @import("std").mem.zeroes(time_t),
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    uniq: ngx_file_uniq_t = @import("std").mem.zeroes(ngx_file_uniq_t),
    mtime: time_t = @import("std").mem.zeroes(time_t),
    size: off_t = @import("std").mem.zeroes(off_t),
    err: ngx_err_t = @import("std").mem.zeroes(ngx_err_t),
    uses: u32 = @import("std").mem.zeroes(u32),
    disable_symlinks_from: usize = @import("std").mem.zeroes(usize),
    flags: packed struct {
        disable_symlinks: u2,
        count: u24,
        close: bool,
        use_event: bool,
        is_dir: bool,
        is_file: bool,
        is_link: bool,
        is_exec: bool,
        is_directio: bool,
        padding: u31,
    } = @import("std").mem.zeroes(c_ulong),

    event: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
};
pub const ngx_cached_open_file_t = struct_ngx_cached_open_file_s;
pub const ngx_open_file_cache_t = extern struct {
    rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    expire_queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    current: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    max: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    inactive: time_t = @import("std").mem.zeroes(time_t),
};
pub const ngx_open_file_cache_cleanup_t = extern struct {
    cache: [*c]ngx_open_file_cache_t = @import("std").mem.zeroes([*c]ngx_open_file_cache_t),
    file: [*c]ngx_cached_open_file_t = @import("std").mem.zeroes([*c]ngx_cached_open_file_t),
    min_uses: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
};
pub const ngx_open_file_cache_event_t = extern struct {
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    read: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    write: [*c]ngx_event_t = @import("std").mem.zeroes([*c]ngx_event_t),
    fd: ngx_fd_t = @import("std").mem.zeroes(ngx_fd_t),
    file: [*c]ngx_cached_open_file_t = @import("std").mem.zeroes([*c]ngx_cached_open_file_t),
    cache: [*c]ngx_open_file_cache_t = @import("std").mem.zeroes([*c]ngx_open_file_cache_t),
};
pub extern fn ngx_open_file_cache_init(pool: [*c]ngx_pool_t, max: ngx_uint_t, inactive: time_t) [*c]ngx_open_file_cache_t;
pub extern fn ngx_open_cached_file(cache: [*c]ngx_open_file_cache_t, name: [*c]ngx_str_t, of: [*c]ngx_open_file_info_t, pool: [*c]ngx_pool_t) ngx_int_t;
pub const ngx_os_io_t = extern struct {
    recv: ngx_recv_pt = @import("std").mem.zeroes(ngx_recv_pt),
    recv_chain: ngx_recv_chain_pt = @import("std").mem.zeroes(ngx_recv_chain_pt),
    udp_recv: ngx_recv_pt = @import("std").mem.zeroes(ngx_recv_pt),
    send: ngx_send_pt = @import("std").mem.zeroes(ngx_send_pt),
    udp_send: ngx_send_pt = @import("std").mem.zeroes(ngx_send_pt),
    udp_send_chain: ngx_send_chain_pt = @import("std").mem.zeroes(ngx_send_chain_pt),
    send_chain: ngx_send_chain_pt = @import("std").mem.zeroes(ngx_send_chain_pt),
    flags: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_os_init(log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_os_status(log: [*c]ngx_log_t) void;
pub extern fn ngx_os_specific_init(log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_os_specific_status(log: [*c]ngx_log_t) void;
pub extern fn ngx_daemon(log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_os_signal_process(cycle: [*c]ngx_cycle_t, sig: [*c]u8, pid: ngx_pid_t) ngx_int_t;
pub extern fn ngx_unix_recv(c: [*c]ngx_connection_t, buf: [*c]u_char, size: usize) isize;
pub extern fn ngx_readv_chain(c: [*c]ngx_connection_t, entry: [*c]ngx_chain_t, limit: off_t) isize;
pub extern fn ngx_udp_unix_recv(c: [*c]ngx_connection_t, buf: [*c]u_char, size: usize) isize;
pub extern fn ngx_unix_send(c: [*c]ngx_connection_t, buf: [*c]u_char, size: usize) isize;
pub extern fn ngx_writev_chain(c: [*c]ngx_connection_t, in: [*c]ngx_chain_t, limit: off_t) [*c]ngx_chain_t;
pub extern fn ngx_udp_unix_send(c: [*c]ngx_connection_t, buf: [*c]u_char, size: usize) isize;
pub extern fn ngx_udp_unix_sendmsg_chain(c: [*c]ngx_connection_t, in: [*c]ngx_chain_t, limit: off_t) [*c]ngx_chain_t;
pub const ngx_iovec_t = extern struct {
    iovs: [*c]struct_iovec = @import("std").mem.zeroes([*c]struct_iovec),
    count: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    size: usize = @import("std").mem.zeroes(usize),
    nalloc: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_output_chain_to_iovec(vec: [*c]ngx_iovec_t, in: [*c]ngx_chain_t, limit: usize, log: [*c]ngx_log_t) [*c]ngx_chain_t;
pub extern fn ngx_writev(c: [*c]ngx_connection_t, vec: [*c]ngx_iovec_t) isize;
pub extern var ngx_os_io: ngx_os_io_t;
pub extern var ngx_ncpu: ngx_int_t;
pub extern var ngx_max_sockets: ngx_int_t;
pub extern var ngx_inherited_nonblocking: ngx_uint_t;
pub extern var ngx_tcp_nodelay_and_tcp_nopush: ngx_uint_t;
pub extern fn ngx_linux_sendfile_chain(c: [*c]ngx_connection_t, in: [*c]ngx_chain_t, limit: off_t) [*c]ngx_chain_t;
pub const NGX_ERROR_ALERT: c_int = 0;
pub const NGX_ERROR_ERR: c_int = 1;
pub const NGX_ERROR_INFO: c_int = 2;
pub const NGX_ERROR_IGNORE_ECONNRESET: c_int = 3;
pub const NGX_ERROR_IGNORE_EINVAL: c_int = 4;
pub const NGX_ERROR_IGNORE_EMSGSIZE: c_int = 5;
pub const ngx_connection_log_error_e = c_uint;
pub const NGX_TCP_NODELAY_UNSET: c_int = 0;
pub const NGX_TCP_NODELAY_SET: c_int = 1;
pub const NGX_TCP_NODELAY_DISABLED: c_int = 2;
pub const ngx_connection_tcp_nodelay_e = c_uint;
pub const NGX_TCP_NOPUSH_UNSET: c_int = 0;
pub const NGX_TCP_NOPUSH_SET: c_int = 1;
pub const NGX_TCP_NOPUSH_DISABLED: c_int = 2;
pub const ngx_connection_tcp_nopush_e = c_uint;
pub extern fn ngx_create_listening(cf: [*c]ngx_conf_t, sockaddr: [*c]struct_sockaddr, socklen: socklen_t) [*c]ngx_listening_t;
pub extern fn ngx_clone_listening(cycle: [*c]ngx_cycle_t, ls: [*c]ngx_listening_t) ngx_int_t;
pub extern fn ngx_set_inherited_sockets(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_open_listening_sockets(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_configure_listening_sockets(cycle: [*c]ngx_cycle_t) void;
pub extern fn ngx_close_listening_sockets(cycle: [*c]ngx_cycle_t) void;
pub extern fn ngx_close_connection(c: [*c]ngx_connection_t) void;
pub extern fn ngx_close_idle_connections(cycle: [*c]ngx_cycle_t) void;
pub extern fn ngx_connection_local_sockaddr(c: [*c]ngx_connection_t, s: [*c]ngx_str_t, port: ngx_uint_t) ngx_int_t;
pub extern fn ngx_tcp_nodelay(c: [*c]ngx_connection_t) ngx_int_t;
pub extern fn ngx_connection_error(c: [*c]ngx_connection_t, err: ngx_err_t, text: [*c]u8) ngx_int_t;
pub extern fn ngx_get_connection(s: ngx_socket_t, log: [*c]ngx_log_t) [*c]ngx_connection_t;
pub extern fn ngx_free_connection(c: [*c]ngx_connection_t) void;
pub extern fn ngx_reusable_connection(c: [*c]ngx_connection_t, reusable: ngx_uint_t) void;
pub const ngx_syslog_peer_t = extern struct {
    facility: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    severity: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    tag: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    hostname: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    server: ngx_addr_t = @import("std").mem.zeroes(ngx_addr_t),
    conn: ngx_connection_t = @import("std").mem.zeroes(ngx_connection_t),
    log: ngx_log_t = @import("std").mem.zeroes(ngx_log_t),
    logp: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    flags: packed struct {
        busy: bool,
        nohostname: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
};
pub extern fn ngx_syslog_process_conf(cf: [*c]ngx_conf_t, peer: [*c]ngx_syslog_peer_t) [*c]u8;
pub extern fn ngx_syslog_add_header(peer: [*c]ngx_syslog_peer_t, buf: [*c]u_char) [*c]u_char;
pub extern fn ngx_syslog_writer(log: [*c]ngx_log_t, level: ngx_uint_t, buf: [*c]u_char, len: usize) void;
pub extern fn ngx_syslog_send(peer: [*c]ngx_syslog_peer_t, buf: [*c]u_char, len: usize) isize;
pub extern fn ngx_proxy_protocol_read(c: [*c]ngx_connection_t, buf: [*c]u_char, last: [*c]u_char) [*c]u_char;
pub extern fn ngx_proxy_protocol_write(c: [*c]ngx_connection_t, buf: [*c]u_char, last: [*c]u_char) [*c]u_char;
pub extern fn ngx_proxy_protocol_get_tlv(c: [*c]ngx_connection_t, name: [*c]ngx_str_t, value: [*c]ngx_str_t) ngx_int_t;
pub const BPF_MAY_GOTO: c_int = 0;
pub const enum_bpf_cond_pseudo_jmp = c_uint;
pub const BPF_REG_0: c_int = 0;
pub const BPF_REG_1: c_int = 1;
pub const BPF_REG_2: c_int = 2;
pub const BPF_REG_3: c_int = 3;
pub const BPF_REG_4: c_int = 4;
pub const BPF_REG_5: c_int = 5;
pub const BPF_REG_6: c_int = 6;
pub const BPF_REG_7: c_int = 7;
pub const BPF_REG_8: c_int = 8;
pub const BPF_REG_9: c_int = 9;
pub const BPF_REG_10: c_int = 10;
pub const __MAX_BPF_REG: c_int = 11;
const enum_unnamed_84 = c_uint;
// /usr/include/linux/bpf.h:79:7: warning: struct demoted to opaque type - has bitfield
pub const struct_bpf_insn = opaque {};
pub const struct_bpf_lpm_trie_key = extern struct {
    prefixlen: __u32 align(4) = @import("std").mem.zeroes(__u32),
    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 4)));
    }
};
pub const struct_bpf_lpm_trie_key_hdr = extern struct {
    prefixlen: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_85 = extern union {
    hdr: struct_bpf_lpm_trie_key_hdr,
    prefixlen: __u32,
};
pub const struct_bpf_lpm_trie_key_u8 = extern struct {
    unnamed_0: union_unnamed_85 align(4) = @import("std").mem.zeroes(union_unnamed_85),
    pub fn data(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 4)));
    }
};
pub const struct_bpf_cgroup_storage_key = extern struct {
    cgroup_inode_id: __u64 = @import("std").mem.zeroes(__u64),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
};
pub const BPF_CGROUP_ITER_ORDER_UNSPEC: c_int = 0;
pub const BPF_CGROUP_ITER_SELF_ONLY: c_int = 1;
pub const BPF_CGROUP_ITER_DESCENDANTS_PRE: c_int = 2;
pub const BPF_CGROUP_ITER_DESCENDANTS_POST: c_int = 3;
pub const BPF_CGROUP_ITER_ANCESTORS_UP: c_int = 4;
pub const enum_bpf_cgroup_iter_order = c_uint;
const struct_unnamed_86 = extern struct {
    map_fd: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_87 = extern struct {
    order: enum_bpf_cgroup_iter_order = @import("std").mem.zeroes(enum_bpf_cgroup_iter_order),
    cgroup_fd: __u32 = @import("std").mem.zeroes(__u32),
    cgroup_id: __u64 = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_88 = extern struct {
    tid: __u32 = @import("std").mem.zeroes(__u32),
    pid: __u32 = @import("std").mem.zeroes(__u32),
    pid_fd: __u32 = @import("std").mem.zeroes(__u32),
};
pub const union_bpf_iter_link_info = extern union {
    map: struct_unnamed_86,
    cgroup: struct_unnamed_87,
    task: struct_unnamed_88,
};
pub const BPF_MAP_CREATE: c_int = 0;
pub const BPF_MAP_LOOKUP_ELEM: c_int = 1;
pub const BPF_MAP_UPDATE_ELEM: c_int = 2;
pub const BPF_MAP_DELETE_ELEM: c_int = 3;
pub const BPF_MAP_GET_NEXT_KEY: c_int = 4;
pub const BPF_PROG_LOAD: c_int = 5;
pub const BPF_OBJ_PIN: c_int = 6;
pub const BPF_OBJ_GET: c_int = 7;
pub const BPF_PROG_ATTACH: c_int = 8;
pub const BPF_PROG_DETACH: c_int = 9;
pub const BPF_PROG_TEST_RUN: c_int = 10;
pub const BPF_PROG_RUN: c_int = 10;
pub const BPF_PROG_GET_NEXT_ID: c_int = 11;
pub const BPF_MAP_GET_NEXT_ID: c_int = 12;
pub const BPF_PROG_GET_FD_BY_ID: c_int = 13;
pub const BPF_MAP_GET_FD_BY_ID: c_int = 14;
pub const BPF_OBJ_GET_INFO_BY_FD: c_int = 15;
pub const BPF_PROG_QUERY: c_int = 16;
pub const BPF_RAW_TRACEPOINT_OPEN: c_int = 17;
pub const BPF_BTF_LOAD: c_int = 18;
pub const BPF_BTF_GET_FD_BY_ID: c_int = 19;
pub const BPF_TASK_FD_QUERY: c_int = 20;
pub const BPF_MAP_LOOKUP_AND_DELETE_ELEM: c_int = 21;
pub const BPF_MAP_FREEZE: c_int = 22;
pub const BPF_BTF_GET_NEXT_ID: c_int = 23;
pub const BPF_MAP_LOOKUP_BATCH: c_int = 24;
pub const BPF_MAP_LOOKUP_AND_DELETE_BATCH: c_int = 25;
pub const BPF_MAP_UPDATE_BATCH: c_int = 26;
pub const BPF_MAP_DELETE_BATCH: c_int = 27;
pub const BPF_LINK_CREATE: c_int = 28;
pub const BPF_LINK_UPDATE: c_int = 29;
pub const BPF_LINK_GET_FD_BY_ID: c_int = 30;
pub const BPF_LINK_GET_NEXT_ID: c_int = 31;
pub const BPF_ENABLE_STATS: c_int = 32;
pub const BPF_ITER_CREATE: c_int = 33;
pub const BPF_LINK_DETACH: c_int = 34;
pub const BPF_PROG_BIND_MAP: c_int = 35;
pub const BPF_TOKEN_CREATE: c_int = 36;
pub const __MAX_BPF_CMD: c_int = 37;
pub const enum_bpf_cmd = c_uint;
pub const BPF_MAP_TYPE_UNSPEC: c_int = 0;
pub const BPF_MAP_TYPE_HASH: c_int = 1;
pub const BPF_MAP_TYPE_ARRAY: c_int = 2;
pub const BPF_MAP_TYPE_PROG_ARRAY: c_int = 3;
pub const BPF_MAP_TYPE_PERF_EVENT_ARRAY: c_int = 4;
pub const BPF_MAP_TYPE_PERCPU_HASH: c_int = 5;
pub const BPF_MAP_TYPE_PERCPU_ARRAY: c_int = 6;
pub const BPF_MAP_TYPE_STACK_TRACE: c_int = 7;
pub const BPF_MAP_TYPE_CGROUP_ARRAY: c_int = 8;
pub const BPF_MAP_TYPE_LRU_HASH: c_int = 9;
pub const BPF_MAP_TYPE_LRU_PERCPU_HASH: c_int = 10;
pub const BPF_MAP_TYPE_LPM_TRIE: c_int = 11;
pub const BPF_MAP_TYPE_ARRAY_OF_MAPS: c_int = 12;
pub const BPF_MAP_TYPE_HASH_OF_MAPS: c_int = 13;
pub const BPF_MAP_TYPE_DEVMAP: c_int = 14;
pub const BPF_MAP_TYPE_SOCKMAP: c_int = 15;
pub const BPF_MAP_TYPE_CPUMAP: c_int = 16;
pub const BPF_MAP_TYPE_XSKMAP: c_int = 17;
pub const BPF_MAP_TYPE_SOCKHASH: c_int = 18;
pub const BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED: c_int = 19;
pub const BPF_MAP_TYPE_CGROUP_STORAGE: c_int = 19;
pub const BPF_MAP_TYPE_REUSEPORT_SOCKARRAY: c_int = 20;
pub const BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE_DEPRECATED: c_int = 21;
pub const BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE: c_int = 21;
pub const BPF_MAP_TYPE_QUEUE: c_int = 22;
pub const BPF_MAP_TYPE_STACK: c_int = 23;
pub const BPF_MAP_TYPE_SK_STORAGE: c_int = 24;
pub const BPF_MAP_TYPE_DEVMAP_HASH: c_int = 25;
pub const BPF_MAP_TYPE_STRUCT_OPS: c_int = 26;
pub const BPF_MAP_TYPE_RINGBUF: c_int = 27;
pub const BPF_MAP_TYPE_INODE_STORAGE: c_int = 28;
pub const BPF_MAP_TYPE_TASK_STORAGE: c_int = 29;
pub const BPF_MAP_TYPE_BLOOM_FILTER: c_int = 30;
pub const BPF_MAP_TYPE_USER_RINGBUF: c_int = 31;
pub const BPF_MAP_TYPE_CGRP_STORAGE: c_int = 32;
pub const BPF_MAP_TYPE_ARENA: c_int = 33;
pub const __MAX_BPF_MAP_TYPE: c_int = 34;
pub const enum_bpf_map_type = c_uint;
pub const BPF_PROG_TYPE_UNSPEC: c_int = 0;
pub const BPF_PROG_TYPE_SOCKET_FILTER: c_int = 1;
pub const BPF_PROG_TYPE_KPROBE: c_int = 2;
pub const BPF_PROG_TYPE_SCHED_CLS: c_int = 3;
pub const BPF_PROG_TYPE_SCHED_ACT: c_int = 4;
pub const BPF_PROG_TYPE_TRACEPOINT: c_int = 5;
pub const BPF_PROG_TYPE_XDP: c_int = 6;
pub const BPF_PROG_TYPE_PERF_EVENT: c_int = 7;
pub const BPF_PROG_TYPE_CGROUP_SKB: c_int = 8;
pub const BPF_PROG_TYPE_CGROUP_SOCK: c_int = 9;
pub const BPF_PROG_TYPE_LWT_IN: c_int = 10;
pub const BPF_PROG_TYPE_LWT_OUT: c_int = 11;
pub const BPF_PROG_TYPE_LWT_XMIT: c_int = 12;
pub const BPF_PROG_TYPE_SOCK_OPS: c_int = 13;
pub const BPF_PROG_TYPE_SK_SKB: c_int = 14;
pub const BPF_PROG_TYPE_CGROUP_DEVICE: c_int = 15;
pub const BPF_PROG_TYPE_SK_MSG: c_int = 16;
pub const BPF_PROG_TYPE_RAW_TRACEPOINT: c_int = 17;
pub const BPF_PROG_TYPE_CGROUP_SOCK_ADDR: c_int = 18;
pub const BPF_PROG_TYPE_LWT_SEG6LOCAL: c_int = 19;
pub const BPF_PROG_TYPE_LIRC_MODE2: c_int = 20;
pub const BPF_PROG_TYPE_SK_REUSEPORT: c_int = 21;
pub const BPF_PROG_TYPE_FLOW_DISSECTOR: c_int = 22;
pub const BPF_PROG_TYPE_CGROUP_SYSCTL: c_int = 23;
pub const BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE: c_int = 24;
pub const BPF_PROG_TYPE_CGROUP_SOCKOPT: c_int = 25;
pub const BPF_PROG_TYPE_TRACING: c_int = 26;
pub const BPF_PROG_TYPE_STRUCT_OPS: c_int = 27;
pub const BPF_PROG_TYPE_EXT: c_int = 28;
pub const BPF_PROG_TYPE_LSM: c_int = 29;
pub const BPF_PROG_TYPE_SK_LOOKUP: c_int = 30;
pub const BPF_PROG_TYPE_SYSCALL: c_int = 31;
pub const BPF_PROG_TYPE_NETFILTER: c_int = 32;
pub const __MAX_BPF_PROG_TYPE: c_int = 33;
pub const enum_bpf_prog_type = c_uint;
pub const BPF_CGROUP_INET_INGRESS: c_int = 0;
pub const BPF_CGROUP_INET_EGRESS: c_int = 1;
pub const BPF_CGROUP_INET_SOCK_CREATE: c_int = 2;
pub const BPF_CGROUP_SOCK_OPS: c_int = 3;
pub const BPF_SK_SKB_STREAM_PARSER: c_int = 4;
pub const BPF_SK_SKB_STREAM_VERDICT: c_int = 5;
pub const BPF_CGROUP_DEVICE: c_int = 6;
pub const BPF_SK_MSG_VERDICT: c_int = 7;
pub const BPF_CGROUP_INET4_BIND: c_int = 8;
pub const BPF_CGROUP_INET6_BIND: c_int = 9;
pub const BPF_CGROUP_INET4_CONNECT: c_int = 10;
pub const BPF_CGROUP_INET6_CONNECT: c_int = 11;
pub const BPF_CGROUP_INET4_POST_BIND: c_int = 12;
pub const BPF_CGROUP_INET6_POST_BIND: c_int = 13;
pub const BPF_CGROUP_UDP4_SENDMSG: c_int = 14;
pub const BPF_CGROUP_UDP6_SENDMSG: c_int = 15;
pub const BPF_LIRC_MODE2: c_int = 16;
pub const BPF_FLOW_DISSECTOR: c_int = 17;
pub const BPF_CGROUP_SYSCTL: c_int = 18;
pub const BPF_CGROUP_UDP4_RECVMSG: c_int = 19;
pub const BPF_CGROUP_UDP6_RECVMSG: c_int = 20;
pub const BPF_CGROUP_GETSOCKOPT: c_int = 21;
pub const BPF_CGROUP_SETSOCKOPT: c_int = 22;
pub const BPF_TRACE_RAW_TP: c_int = 23;
pub const BPF_TRACE_FENTRY: c_int = 24;
pub const BPF_TRACE_FEXIT: c_int = 25;
pub const BPF_MODIFY_RETURN: c_int = 26;
pub const BPF_LSM_MAC: c_int = 27;
pub const BPF_TRACE_ITER: c_int = 28;
pub const BPF_CGROUP_INET4_GETPEERNAME: c_int = 29;
pub const BPF_CGROUP_INET6_GETPEERNAME: c_int = 30;
pub const BPF_CGROUP_INET4_GETSOCKNAME: c_int = 31;
pub const BPF_CGROUP_INET6_GETSOCKNAME: c_int = 32;
pub const BPF_XDP_DEVMAP: c_int = 33;
pub const BPF_CGROUP_INET_SOCK_RELEASE: c_int = 34;
pub const BPF_XDP_CPUMAP: c_int = 35;
pub const BPF_SK_LOOKUP: c_int = 36;
pub const BPF_XDP: c_int = 37;
pub const BPF_SK_SKB_VERDICT: c_int = 38;
pub const BPF_SK_REUSEPORT_SELECT: c_int = 39;
pub const BPF_SK_REUSEPORT_SELECT_OR_MIGRATE: c_int = 40;
pub const BPF_PERF_EVENT: c_int = 41;
pub const BPF_TRACE_KPROBE_MULTI: c_int = 42;
pub const BPF_LSM_CGROUP: c_int = 43;
pub const BPF_STRUCT_OPS: c_int = 44;
pub const BPF_NETFILTER: c_int = 45;
pub const BPF_TCX_INGRESS: c_int = 46;
pub const BPF_TCX_EGRESS: c_int = 47;
pub const BPF_TRACE_UPROBE_MULTI: c_int = 48;
pub const BPF_CGROUP_UNIX_CONNECT: c_int = 49;
pub const BPF_CGROUP_UNIX_SENDMSG: c_int = 50;
pub const BPF_CGROUP_UNIX_RECVMSG: c_int = 51;
pub const BPF_CGROUP_UNIX_GETPEERNAME: c_int = 52;
pub const BPF_CGROUP_UNIX_GETSOCKNAME: c_int = 53;
pub const BPF_NETKIT_PRIMARY: c_int = 54;
pub const BPF_NETKIT_PEER: c_int = 55;
pub const BPF_TRACE_KPROBE_SESSION: c_int = 56;
pub const __MAX_BPF_ATTACH_TYPE: c_int = 57;
pub const enum_bpf_attach_type = c_uint;
pub const BPF_LINK_TYPE_UNSPEC: c_int = 0;
pub const BPF_LINK_TYPE_RAW_TRACEPOINT: c_int = 1;
pub const BPF_LINK_TYPE_TRACING: c_int = 2;
pub const BPF_LINK_TYPE_CGROUP: c_int = 3;
pub const BPF_LINK_TYPE_ITER: c_int = 4;
pub const BPF_LINK_TYPE_NETNS: c_int = 5;
pub const BPF_LINK_TYPE_XDP: c_int = 6;
pub const BPF_LINK_TYPE_PERF_EVENT: c_int = 7;
pub const BPF_LINK_TYPE_KPROBE_MULTI: c_int = 8;
pub const BPF_LINK_TYPE_STRUCT_OPS: c_int = 9;
pub const BPF_LINK_TYPE_NETFILTER: c_int = 10;
pub const BPF_LINK_TYPE_TCX: c_int = 11;
pub const BPF_LINK_TYPE_UPROBE_MULTI: c_int = 12;
pub const BPF_LINK_TYPE_NETKIT: c_int = 13;
pub const BPF_LINK_TYPE_SOCKMAP: c_int = 14;
pub const __MAX_BPF_LINK_TYPE: c_int = 15;
pub const enum_bpf_link_type = c_uint;
pub const BPF_PERF_EVENT_UNSPEC: c_int = 0;
pub const BPF_PERF_EVENT_UPROBE: c_int = 1;
pub const BPF_PERF_EVENT_URETPROBE: c_int = 2;
pub const BPF_PERF_EVENT_KPROBE: c_int = 3;
pub const BPF_PERF_EVENT_KRETPROBE: c_int = 4;
pub const BPF_PERF_EVENT_TRACEPOINT: c_int = 5;
pub const BPF_PERF_EVENT_EVENT: c_int = 6;
pub const enum_bpf_perf_event_type = c_uint;
pub const BPF_F_KPROBE_MULTI_RETURN: c_int = 1;
const enum_unnamed_89 = c_uint;
pub const BPF_F_UPROBE_MULTI_RETURN: c_int = 1;
const enum_unnamed_90 = c_uint;
pub const BPF_ADDR_SPACE_CAST: c_int = 1;
pub const enum_bpf_addr_space_cast = c_uint;
pub const BPF_ANY: c_int = 0;
pub const BPF_NOEXIST: c_int = 1;
pub const BPF_EXIST: c_int = 2;
pub const BPF_F_LOCK: c_int = 4;
const enum_unnamed_91 = c_uint;
pub const BPF_F_NO_PREALLOC: c_int = 1;
pub const BPF_F_NO_COMMON_LRU: c_int = 2;
pub const BPF_F_NUMA_NODE: c_int = 4;
pub const BPF_F_RDONLY: c_int = 8;
pub const BPF_F_WRONLY: c_int = 16;
pub const BPF_F_STACK_BUILD_ID: c_int = 32;
pub const BPF_F_ZERO_SEED: c_int = 64;
pub const BPF_F_RDONLY_PROG: c_int = 128;
pub const BPF_F_WRONLY_PROG: c_int = 256;
pub const BPF_F_CLONE: c_int = 512;
pub const BPF_F_MMAPABLE: c_int = 1024;
pub const BPF_F_PRESERVE_ELEMS: c_int = 2048;
pub const BPF_F_INNER_MAP: c_int = 4096;
pub const BPF_F_LINK: c_int = 8192;
pub const BPF_F_PATH_FD: c_int = 16384;
pub const BPF_F_VTYPE_BTF_OBJ_FD: c_int = 32768;
pub const BPF_F_TOKEN_FD: c_int = 65536;
pub const BPF_F_SEGV_ON_FAULT: c_int = 131072;
pub const BPF_F_NO_USER_CONV: c_int = 262144;
const enum_unnamed_92 = c_uint;
pub const BPF_STATS_RUN_TIME: c_int = 0;
pub const enum_bpf_stats_type = c_uint;
pub const BPF_STACK_BUILD_ID_EMPTY: c_int = 0;
pub const BPF_STACK_BUILD_ID_VALID: c_int = 1;
pub const BPF_STACK_BUILD_ID_IP: c_int = 2;
pub const enum_bpf_stack_build_id_status = c_uint;
const union_unnamed_93 = extern union {
    offset: __u64,
    ip: __u64,
};
pub const struct_bpf_stack_build_id = extern struct {
    status: __s32 = @import("std").mem.zeroes(__s32),
    build_id: [20]u8 = @import("std").mem.zeroes([20]u8),
    unnamed_0: union_unnamed_93 = @import("std").mem.zeroes(union_unnamed_93),
};
const struct_unnamed_94 = extern struct {
    map_type: __u32 = @import("std").mem.zeroes(__u32),
    key_size: __u32 = @import("std").mem.zeroes(__u32),
    value_size: __u32 = @import("std").mem.zeroes(__u32),
    max_entries: __u32 = @import("std").mem.zeroes(__u32),
    map_flags: __u32 = @import("std").mem.zeroes(__u32),
    inner_map_fd: __u32 = @import("std").mem.zeroes(__u32),
    numa_node: __u32 = @import("std").mem.zeroes(__u32),
    map_name: [16]u8 = @import("std").mem.zeroes([16]u8),
    map_ifindex: __u32 = @import("std").mem.zeroes(__u32),
    btf_fd: __u32 = @import("std").mem.zeroes(__u32),
    btf_key_type_id: __u32 = @import("std").mem.zeroes(__u32),
    btf_value_type_id: __u32 = @import("std").mem.zeroes(__u32),
    btf_vmlinux_value_type_id: __u32 = @import("std").mem.zeroes(__u32),
    map_extra: __u64 = @import("std").mem.zeroes(__u64),
    value_type_btf_obj_fd: __s32 = @import("std").mem.zeroes(__s32),
    map_token_fd: __s32 = @import("std").mem.zeroes(__s32),
};
const union_unnamed_96 = extern union {
    value: __u64 align(8),
    next_key: __u64 align(8),
};
const struct_unnamed_95 = extern struct {
    map_fd: __u32 = @import("std").mem.zeroes(__u32),
    key: __u64 align(8) = @import("std").mem.zeroes(__u64),
    unnamed_0: union_unnamed_96 = @import("std").mem.zeroes(union_unnamed_96),
    flags: __u64 = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_97 = extern struct {
    in_batch: __u64 align(8) = @import("std").mem.zeroes(__u64),
    out_batch: __u64 align(8) = @import("std").mem.zeroes(__u64),
    keys: __u64 align(8) = @import("std").mem.zeroes(__u64),
    values: __u64 align(8) = @import("std").mem.zeroes(__u64),
    count: __u32 = @import("std").mem.zeroes(__u32),
    map_fd: __u32 = @import("std").mem.zeroes(__u32),
    elem_flags: __u64 = @import("std").mem.zeroes(__u64),
    flags: __u64 = @import("std").mem.zeroes(__u64),
};
const union_unnamed_99 = extern union {
    attach_prog_fd: __u32,
    attach_btf_obj_fd: __u32,
};
const struct_unnamed_98 = extern struct {
    prog_type: __u32 = @import("std").mem.zeroes(__u32),
    insn_cnt: __u32 = @import("std").mem.zeroes(__u32),
    insns: __u64 align(8) = @import("std").mem.zeroes(__u64),
    license: __u64 align(8) = @import("std").mem.zeroes(__u64),
    log_level: __u32 = @import("std").mem.zeroes(__u32),
    log_size: __u32 = @import("std").mem.zeroes(__u32),
    log_buf: __u64 align(8) = @import("std").mem.zeroes(__u64),
    kern_version: __u32 = @import("std").mem.zeroes(__u32),
    prog_flags: __u32 = @import("std").mem.zeroes(__u32),
    prog_name: [16]u8 = @import("std").mem.zeroes([16]u8),
    prog_ifindex: __u32 = @import("std").mem.zeroes(__u32),
    expected_attach_type: __u32 = @import("std").mem.zeroes(__u32),
    prog_btf_fd: __u32 = @import("std").mem.zeroes(__u32),
    func_info_rec_size: __u32 = @import("std").mem.zeroes(__u32),
    func_info: __u64 align(8) = @import("std").mem.zeroes(__u64),
    func_info_cnt: __u32 = @import("std").mem.zeroes(__u32),
    line_info_rec_size: __u32 = @import("std").mem.zeroes(__u32),
    line_info: __u64 align(8) = @import("std").mem.zeroes(__u64),
    line_info_cnt: __u32 = @import("std").mem.zeroes(__u32),
    attach_btf_id: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_99 = @import("std").mem.zeroes(union_unnamed_99),
    core_relo_cnt: __u32 = @import("std").mem.zeroes(__u32),
    fd_array: __u64 align(8) = @import("std").mem.zeroes(__u64),
    core_relos: __u64 align(8) = @import("std").mem.zeroes(__u64),
    core_relo_rec_size: __u32 = @import("std").mem.zeroes(__u32),
    log_true_size: __u32 = @import("std").mem.zeroes(__u32),
    prog_token_fd: __s32 = @import("std").mem.zeroes(__s32),
};
const struct_unnamed_100 = extern struct {
    pathname: __u64 align(8) = @import("std").mem.zeroes(__u64),
    bpf_fd: __u32 = @import("std").mem.zeroes(__u32),
    file_flags: __u32 = @import("std").mem.zeroes(__u32),
    path_fd: __s32 = @import("std").mem.zeroes(__s32),
};
const union_unnamed_102 = extern union {
    target_fd: __u32,
    target_ifindex: __u32,
};
const union_unnamed_103 = extern union {
    relative_fd: __u32,
    relative_id: __u32,
};
const struct_unnamed_101 = extern struct {
    unnamed_0: union_unnamed_102 = @import("std").mem.zeroes(union_unnamed_102),
    attach_bpf_fd: __u32 = @import("std").mem.zeroes(__u32),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
    attach_flags: __u32 = @import("std").mem.zeroes(__u32),
    replace_bpf_fd: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_1: union_unnamed_103 = @import("std").mem.zeroes(union_unnamed_103),
    expected_revision: __u64 = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_104 = extern struct {
    prog_fd: __u32 = @import("std").mem.zeroes(__u32),
    retval: __u32 = @import("std").mem.zeroes(__u32),
    data_size_in: __u32 = @import("std").mem.zeroes(__u32),
    data_size_out: __u32 = @import("std").mem.zeroes(__u32),
    data_in: __u64 align(8) = @import("std").mem.zeroes(__u64),
    data_out: __u64 align(8) = @import("std").mem.zeroes(__u64),
    repeat: __u32 = @import("std").mem.zeroes(__u32),
    duration: __u32 = @import("std").mem.zeroes(__u32),
    ctx_size_in: __u32 = @import("std").mem.zeroes(__u32),
    ctx_size_out: __u32 = @import("std").mem.zeroes(__u32),
    ctx_in: __u64 align(8) = @import("std").mem.zeroes(__u64),
    ctx_out: __u64 align(8) = @import("std").mem.zeroes(__u64),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    cpu: __u32 = @import("std").mem.zeroes(__u32),
    batch_size: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_106 = extern union {
    start_id: __u32,
    prog_id: __u32,
    map_id: __u32,
    btf_id: __u32,
    link_id: __u32,
};
const struct_unnamed_105 = extern struct {
    unnamed_0: union_unnamed_106 = @import("std").mem.zeroes(union_unnamed_106),
    next_id: __u32 = @import("std").mem.zeroes(__u32),
    open_flags: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_107 = extern struct {
    bpf_fd: __u32 = @import("std").mem.zeroes(__u32),
    info_len: __u32 = @import("std").mem.zeroes(__u32),
    info: __u64 align(8) = @import("std").mem.zeroes(__u64),
};
const union_unnamed_109 = extern union {
    target_fd: __u32,
    target_ifindex: __u32,
};
const union_unnamed_110 = extern union {
    prog_cnt: __u32,
    count: __u32,
};
// /usr/include/linux/bpf.h:1656:3: warning: struct demoted to opaque type - has bitfield
const struct_unnamed_108 = opaque {};
// /usr/include/linux/bpf.h:1669:3: warning: struct demoted to opaque type - has bitfield
const struct_unnamed_111 = opaque {};
const struct_unnamed_112 = extern struct {
    btf: __u64 align(8) = @import("std").mem.zeroes(__u64),
    btf_log_buf: __u64 align(8) = @import("std").mem.zeroes(__u64),
    btf_size: __u32 = @import("std").mem.zeroes(__u32),
    btf_log_size: __u32 = @import("std").mem.zeroes(__u32),
    btf_log_level: __u32 = @import("std").mem.zeroes(__u32),
    btf_log_true_size: __u32 = @import("std").mem.zeroes(__u32),
    btf_flags: __u32 = @import("std").mem.zeroes(__u32),
    btf_token_fd: __s32 = @import("std").mem.zeroes(__s32),
};
const struct_unnamed_113 = extern struct {
    pid: __u32 = @import("std").mem.zeroes(__u32),
    fd: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    buf_len: __u32 = @import("std").mem.zeroes(__u32),
    buf: __u64 align(8) = @import("std").mem.zeroes(__u64),
    prog_id: __u32 = @import("std").mem.zeroes(__u32),
    fd_type: __u32 = @import("std").mem.zeroes(__u32),
    probe_offset: __u64 = @import("std").mem.zeroes(__u64),
    probe_addr: __u64 = @import("std").mem.zeroes(__u64),
};
const union_unnamed_115 = extern union {
    prog_fd: __u32,
    map_fd: __u32,
};
const union_unnamed_116 = extern union {
    target_fd: __u32,
    target_ifindex: __u32,
};
const struct_unnamed_118 = extern struct {
    iter_info: __u64 align(8) = @import("std").mem.zeroes(__u64),
    iter_info_len: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_119 = extern struct {
    bpf_cookie: __u64 = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_120 = extern struct {
    flags: __u32 = @import("std").mem.zeroes(__u32),
    cnt: __u32 = @import("std").mem.zeroes(__u32),
    syms: __u64 align(8) = @import("std").mem.zeroes(__u64),
    addrs: __u64 align(8) = @import("std").mem.zeroes(__u64),
    cookies: __u64 align(8) = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_121 = extern struct {
    target_btf_id: __u32 = @import("std").mem.zeroes(__u32),
    cookie: __u64 = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_122 = extern struct {
    pf: __u32 = @import("std").mem.zeroes(__u32),
    hooknum: __u32 = @import("std").mem.zeroes(__u32),
    priority: __s32 = @import("std").mem.zeroes(__s32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_124 = extern union {
    relative_fd: __u32,
    relative_id: __u32,
};
const struct_unnamed_123 = extern struct {
    unnamed_0: union_unnamed_124 = @import("std").mem.zeroes(union_unnamed_124),
    expected_revision: __u64 = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_125 = extern struct {
    path: __u64 align(8) = @import("std").mem.zeroes(__u64),
    offsets: __u64 align(8) = @import("std").mem.zeroes(__u64),
    ref_ctr_offsets: __u64 align(8) = @import("std").mem.zeroes(__u64),
    cookies: __u64 align(8) = @import("std").mem.zeroes(__u64),
    cnt: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    pid: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_127 = extern union {
    relative_fd: __u32,
    relative_id: __u32,
};
const struct_unnamed_126 = extern struct {
    unnamed_0: union_unnamed_127 = @import("std").mem.zeroes(union_unnamed_127),
    expected_revision: __u64 = @import("std").mem.zeroes(__u64),
};
const union_unnamed_117 = extern union {
    target_btf_id: __u32,
    unnamed_0: struct_unnamed_118,
    perf_event: struct_unnamed_119,
    kprobe_multi: struct_unnamed_120,
    tracing: struct_unnamed_121,
    netfilter: struct_unnamed_122,
    tcx: struct_unnamed_123,
    uprobe_multi: struct_unnamed_125,
    netkit: struct_unnamed_126,
};
const struct_unnamed_114 = extern struct {
    unnamed_0: union_unnamed_115 = @import("std").mem.zeroes(union_unnamed_115),
    unnamed_1: union_unnamed_116 = @import("std").mem.zeroes(union_unnamed_116),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_2: union_unnamed_117 = @import("std").mem.zeroes(union_unnamed_117),
};
const union_unnamed_129 = extern union {
    new_prog_fd: __u32,
    new_map_fd: __u32,
};
const union_unnamed_130 = extern union {
    old_prog_fd: __u32,
    old_map_fd: __u32,
};
const struct_unnamed_128 = extern struct {
    link_fd: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_129 = @import("std").mem.zeroes(union_unnamed_129),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_1: union_unnamed_130 = @import("std").mem.zeroes(union_unnamed_130),
};
const struct_unnamed_131 = extern struct {
    link_fd: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_132 = extern struct {
    type: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_133 = extern struct {
    link_fd: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_134 = extern struct {
    prog_fd: __u32 = @import("std").mem.zeroes(__u32),
    map_fd: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_135 = extern struct {
    flags: __u32 = @import("std").mem.zeroes(__u32),
    bpffs_fd: __u32 = @import("std").mem.zeroes(__u32),
};
pub const union_bpf_attr = extern union {
    unnamed_0: struct_unnamed_94,
    unnamed_1: struct_unnamed_95,
    batch: struct_unnamed_97,
    unnamed_2: struct_unnamed_98,
    unnamed_3: struct_unnamed_100,
    unnamed_4: struct_unnamed_101,
    @"test": struct_unnamed_104,
    unnamed_5: struct_unnamed_105,
    info: struct_unnamed_107,
    query: struct_unnamed_108,
    raw_tracepoint: struct_unnamed_111,
    unnamed_6: struct_unnamed_112,
    task_fd_query: struct_unnamed_113,
    link_create: struct_unnamed_114,
    link_update: struct_unnamed_128,
    link_detach: struct_unnamed_131,
    enable_stats: struct_unnamed_132,
    iter_create: struct_unnamed_133,
    prog_bind_map: struct_unnamed_134,
    token_create: struct_unnamed_135,
};
pub const BPF_FUNC_unspec: c_int = 0;
pub const BPF_FUNC_map_lookup_elem: c_int = 1;
pub const BPF_FUNC_map_update_elem: c_int = 2;
pub const BPF_FUNC_map_delete_elem: c_int = 3;
pub const BPF_FUNC_probe_read: c_int = 4;
pub const BPF_FUNC_ktime_get_ns: c_int = 5;
pub const BPF_FUNC_trace_printk: c_int = 6;
pub const BPF_FUNC_get_prandom_u32: c_int = 7;
pub const BPF_FUNC_get_smp_processor_id: c_int = 8;
pub const BPF_FUNC_skb_store_bytes: c_int = 9;
pub const BPF_FUNC_l3_csum_replace: c_int = 10;
pub const BPF_FUNC_l4_csum_replace: c_int = 11;
pub const BPF_FUNC_tail_call: c_int = 12;
pub const BPF_FUNC_clone_redirect: c_int = 13;
pub const BPF_FUNC_get_current_pid_tgid: c_int = 14;
pub const BPF_FUNC_get_current_uid_gid: c_int = 15;
pub const BPF_FUNC_get_current_comm: c_int = 16;
pub const BPF_FUNC_get_cgroup_classid: c_int = 17;
pub const BPF_FUNC_skb_vlan_push: c_int = 18;
pub const BPF_FUNC_skb_vlan_pop: c_int = 19;
pub const BPF_FUNC_skb_get_tunnel_key: c_int = 20;
pub const BPF_FUNC_skb_set_tunnel_key: c_int = 21;
pub const BPF_FUNC_perf_event_read: c_int = 22;
pub const BPF_FUNC_redirect: c_int = 23;
pub const BPF_FUNC_get_route_realm: c_int = 24;
pub const BPF_FUNC_perf_event_output: c_int = 25;
pub const BPF_FUNC_skb_load_bytes: c_int = 26;
pub const BPF_FUNC_get_stackid: c_int = 27;
pub const BPF_FUNC_csum_diff: c_int = 28;
pub const BPF_FUNC_skb_get_tunnel_opt: c_int = 29;
pub const BPF_FUNC_skb_set_tunnel_opt: c_int = 30;
pub const BPF_FUNC_skb_change_proto: c_int = 31;
pub const BPF_FUNC_skb_change_type: c_int = 32;
pub const BPF_FUNC_skb_under_cgroup: c_int = 33;
pub const BPF_FUNC_get_hash_recalc: c_int = 34;
pub const BPF_FUNC_get_current_task: c_int = 35;
pub const BPF_FUNC_probe_write_user: c_int = 36;
pub const BPF_FUNC_current_task_under_cgroup: c_int = 37;
pub const BPF_FUNC_skb_change_tail: c_int = 38;
pub const BPF_FUNC_skb_pull_data: c_int = 39;
pub const BPF_FUNC_csum_update: c_int = 40;
pub const BPF_FUNC_set_hash_invalid: c_int = 41;
pub const BPF_FUNC_get_numa_node_id: c_int = 42;
pub const BPF_FUNC_skb_change_head: c_int = 43;
pub const BPF_FUNC_xdp_adjust_head: c_int = 44;
pub const BPF_FUNC_probe_read_str: c_int = 45;
pub const BPF_FUNC_get_socket_cookie: c_int = 46;
pub const BPF_FUNC_get_socket_uid: c_int = 47;
pub const BPF_FUNC_set_hash: c_int = 48;
pub const BPF_FUNC_setsockopt: c_int = 49;
pub const BPF_FUNC_skb_adjust_room: c_int = 50;
pub const BPF_FUNC_redirect_map: c_int = 51;
pub const BPF_FUNC_sk_redirect_map: c_int = 52;
pub const BPF_FUNC_sock_map_update: c_int = 53;
pub const BPF_FUNC_xdp_adjust_meta: c_int = 54;
pub const BPF_FUNC_perf_event_read_value: c_int = 55;
pub const BPF_FUNC_perf_prog_read_value: c_int = 56;
pub const BPF_FUNC_getsockopt: c_int = 57;
pub const BPF_FUNC_override_return: c_int = 58;
pub const BPF_FUNC_sock_ops_cb_flags_set: c_int = 59;
pub const BPF_FUNC_msg_redirect_map: c_int = 60;
pub const BPF_FUNC_msg_apply_bytes: c_int = 61;
pub const BPF_FUNC_msg_cork_bytes: c_int = 62;
pub const BPF_FUNC_msg_pull_data: c_int = 63;
pub const BPF_FUNC_bind: c_int = 64;
pub const BPF_FUNC_xdp_adjust_tail: c_int = 65;
pub const BPF_FUNC_skb_get_xfrm_state: c_int = 66;
pub const BPF_FUNC_get_stack: c_int = 67;
pub const BPF_FUNC_skb_load_bytes_relative: c_int = 68;
pub const BPF_FUNC_fib_lookup: c_int = 69;
pub const BPF_FUNC_sock_hash_update: c_int = 70;
pub const BPF_FUNC_msg_redirect_hash: c_int = 71;
pub const BPF_FUNC_sk_redirect_hash: c_int = 72;
pub const BPF_FUNC_lwt_push_encap: c_int = 73;
pub const BPF_FUNC_lwt_seg6_store_bytes: c_int = 74;
pub const BPF_FUNC_lwt_seg6_adjust_srh: c_int = 75;
pub const BPF_FUNC_lwt_seg6_action: c_int = 76;
pub const BPF_FUNC_rc_repeat: c_int = 77;
pub const BPF_FUNC_rc_keydown: c_int = 78;
pub const BPF_FUNC_skb_cgroup_id: c_int = 79;
pub const BPF_FUNC_get_current_cgroup_id: c_int = 80;
pub const BPF_FUNC_get_local_storage: c_int = 81;
pub const BPF_FUNC_sk_select_reuseport: c_int = 82;
pub const BPF_FUNC_skb_ancestor_cgroup_id: c_int = 83;
pub const BPF_FUNC_sk_lookup_tcp: c_int = 84;
pub const BPF_FUNC_sk_lookup_udp: c_int = 85;
pub const BPF_FUNC_sk_release: c_int = 86;
pub const BPF_FUNC_map_push_elem: c_int = 87;
pub const BPF_FUNC_map_pop_elem: c_int = 88;
pub const BPF_FUNC_map_peek_elem: c_int = 89;
pub const BPF_FUNC_msg_push_data: c_int = 90;
pub const BPF_FUNC_msg_pop_data: c_int = 91;
pub const BPF_FUNC_rc_pointer_rel: c_int = 92;
pub const BPF_FUNC_spin_lock: c_int = 93;
pub const BPF_FUNC_spin_unlock: c_int = 94;
pub const BPF_FUNC_sk_fullsock: c_int = 95;
pub const BPF_FUNC_tcp_sock: c_int = 96;
pub const BPF_FUNC_skb_ecn_set_ce: c_int = 97;
pub const BPF_FUNC_get_listener_sock: c_int = 98;
pub const BPF_FUNC_skc_lookup_tcp: c_int = 99;
pub const BPF_FUNC_tcp_check_syncookie: c_int = 100;
pub const BPF_FUNC_sysctl_get_name: c_int = 101;
pub const BPF_FUNC_sysctl_get_current_value: c_int = 102;
pub const BPF_FUNC_sysctl_get_new_value: c_int = 103;
pub const BPF_FUNC_sysctl_set_new_value: c_int = 104;
pub const BPF_FUNC_strtol: c_int = 105;
pub const BPF_FUNC_strtoul: c_int = 106;
pub const BPF_FUNC_sk_storage_get: c_int = 107;
pub const BPF_FUNC_sk_storage_delete: c_int = 108;
pub const BPF_FUNC_send_signal: c_int = 109;
pub const BPF_FUNC_tcp_gen_syncookie: c_int = 110;
pub const BPF_FUNC_skb_output: c_int = 111;
pub const BPF_FUNC_probe_read_user: c_int = 112;
pub const BPF_FUNC_probe_read_kernel: c_int = 113;
pub const BPF_FUNC_probe_read_user_str: c_int = 114;
pub const BPF_FUNC_probe_read_kernel_str: c_int = 115;
pub const BPF_FUNC_tcp_send_ack: c_int = 116;
pub const BPF_FUNC_send_signal_thread: c_int = 117;
pub const BPF_FUNC_jiffies64: c_int = 118;
pub const BPF_FUNC_read_branch_records: c_int = 119;
pub const BPF_FUNC_get_ns_current_pid_tgid: c_int = 120;
pub const BPF_FUNC_xdp_output: c_int = 121;
pub const BPF_FUNC_get_netns_cookie: c_int = 122;
pub const BPF_FUNC_get_current_ancestor_cgroup_id: c_int = 123;
pub const BPF_FUNC_sk_assign: c_int = 124;
pub const BPF_FUNC_ktime_get_boot_ns: c_int = 125;
pub const BPF_FUNC_seq_printf: c_int = 126;
pub const BPF_FUNC_seq_write: c_int = 127;
pub const BPF_FUNC_sk_cgroup_id: c_int = 128;
pub const BPF_FUNC_sk_ancestor_cgroup_id: c_int = 129;
pub const BPF_FUNC_ringbuf_output: c_int = 130;
pub const BPF_FUNC_ringbuf_reserve: c_int = 131;
pub const BPF_FUNC_ringbuf_submit: c_int = 132;
pub const BPF_FUNC_ringbuf_discard: c_int = 133;
pub const BPF_FUNC_ringbuf_query: c_int = 134;
pub const BPF_FUNC_csum_level: c_int = 135;
pub const BPF_FUNC_skc_to_tcp6_sock: c_int = 136;
pub const BPF_FUNC_skc_to_tcp_sock: c_int = 137;
pub const BPF_FUNC_skc_to_tcp_timewait_sock: c_int = 138;
pub const BPF_FUNC_skc_to_tcp_request_sock: c_int = 139;
pub const BPF_FUNC_skc_to_udp6_sock: c_int = 140;
pub const BPF_FUNC_get_task_stack: c_int = 141;
pub const BPF_FUNC_load_hdr_opt: c_int = 142;
pub const BPF_FUNC_store_hdr_opt: c_int = 143;
pub const BPF_FUNC_reserve_hdr_opt: c_int = 144;
pub const BPF_FUNC_inode_storage_get: c_int = 145;
pub const BPF_FUNC_inode_storage_delete: c_int = 146;
pub const BPF_FUNC_d_path: c_int = 147;
pub const BPF_FUNC_copy_from_user: c_int = 148;
pub const BPF_FUNC_snprintf_btf: c_int = 149;
pub const BPF_FUNC_seq_printf_btf: c_int = 150;
pub const BPF_FUNC_skb_cgroup_classid: c_int = 151;
pub const BPF_FUNC_redirect_neigh: c_int = 152;
pub const BPF_FUNC_per_cpu_ptr: c_int = 153;
pub const BPF_FUNC_this_cpu_ptr: c_int = 154;
pub const BPF_FUNC_redirect_peer: c_int = 155;
pub const BPF_FUNC_task_storage_get: c_int = 156;
pub const BPF_FUNC_task_storage_delete: c_int = 157;
pub const BPF_FUNC_get_current_task_btf: c_int = 158;
pub const BPF_FUNC_bprm_opts_set: c_int = 159;
pub const BPF_FUNC_ktime_get_coarse_ns: c_int = 160;
pub const BPF_FUNC_ima_inode_hash: c_int = 161;
pub const BPF_FUNC_sock_from_file: c_int = 162;
pub const BPF_FUNC_check_mtu: c_int = 163;
pub const BPF_FUNC_for_each_map_elem: c_int = 164;
pub const BPF_FUNC_snprintf: c_int = 165;
pub const BPF_FUNC_sys_bpf: c_int = 166;
pub const BPF_FUNC_btf_find_by_name_kind: c_int = 167;
pub const BPF_FUNC_sys_close: c_int = 168;
pub const BPF_FUNC_timer_init: c_int = 169;
pub const BPF_FUNC_timer_set_callback: c_int = 170;
pub const BPF_FUNC_timer_start: c_int = 171;
pub const BPF_FUNC_timer_cancel: c_int = 172;
pub const BPF_FUNC_get_func_ip: c_int = 173;
pub const BPF_FUNC_get_attach_cookie: c_int = 174;
pub const BPF_FUNC_task_pt_regs: c_int = 175;
pub const BPF_FUNC_get_branch_snapshot: c_int = 176;
pub const BPF_FUNC_trace_vprintk: c_int = 177;
pub const BPF_FUNC_skc_to_unix_sock: c_int = 178;
pub const BPF_FUNC_kallsyms_lookup_name: c_int = 179;
pub const BPF_FUNC_find_vma: c_int = 180;
pub const BPF_FUNC_loop: c_int = 181;
pub const BPF_FUNC_strncmp: c_int = 182;
pub const BPF_FUNC_get_func_arg: c_int = 183;
pub const BPF_FUNC_get_func_ret: c_int = 184;
pub const BPF_FUNC_get_func_arg_cnt: c_int = 185;
pub const BPF_FUNC_get_retval: c_int = 186;
pub const BPF_FUNC_set_retval: c_int = 187;
pub const BPF_FUNC_xdp_get_buff_len: c_int = 188;
pub const BPF_FUNC_xdp_load_bytes: c_int = 189;
pub const BPF_FUNC_xdp_store_bytes: c_int = 190;
pub const BPF_FUNC_copy_from_user_task: c_int = 191;
pub const BPF_FUNC_skb_set_tstamp: c_int = 192;
pub const BPF_FUNC_ima_file_hash: c_int = 193;
pub const BPF_FUNC_kptr_xchg: c_int = 194;
pub const BPF_FUNC_map_lookup_percpu_elem: c_int = 195;
pub const BPF_FUNC_skc_to_mptcp_sock: c_int = 196;
pub const BPF_FUNC_dynptr_from_mem: c_int = 197;
pub const BPF_FUNC_ringbuf_reserve_dynptr: c_int = 198;
pub const BPF_FUNC_ringbuf_submit_dynptr: c_int = 199;
pub const BPF_FUNC_ringbuf_discard_dynptr: c_int = 200;
pub const BPF_FUNC_dynptr_read: c_int = 201;
pub const BPF_FUNC_dynptr_write: c_int = 202;
pub const BPF_FUNC_dynptr_data: c_int = 203;
pub const BPF_FUNC_tcp_raw_gen_syncookie_ipv4: c_int = 204;
pub const BPF_FUNC_tcp_raw_gen_syncookie_ipv6: c_int = 205;
pub const BPF_FUNC_tcp_raw_check_syncookie_ipv4: c_int = 206;
pub const BPF_FUNC_tcp_raw_check_syncookie_ipv6: c_int = 207;
pub const BPF_FUNC_ktime_get_tai_ns: c_int = 208;
pub const BPF_FUNC_user_ringbuf_drain: c_int = 209;
pub const BPF_FUNC_cgrp_storage_get: c_int = 210;
pub const BPF_FUNC_cgrp_storage_delete: c_int = 211;
pub const __BPF_FUNC_MAX_ID: c_int = 212;
pub const enum_bpf_func_id = c_uint;
pub const BPF_F_RECOMPUTE_CSUM: c_int = 1;
pub const BPF_F_INVALIDATE_HASH: c_int = 2;
const enum_unnamed_136 = c_uint;
pub const BPF_F_HDR_FIELD_MASK: c_int = 15;
const enum_unnamed_137 = c_uint;
pub const BPF_F_PSEUDO_HDR: c_int = 16;
pub const BPF_F_MARK_MANGLED_0: c_int = 32;
pub const BPF_F_MARK_ENFORCE: c_int = 64;
const enum_unnamed_138 = c_uint;
pub const BPF_F_INGRESS: c_int = 1;
const enum_unnamed_139 = c_uint;
pub const BPF_F_TUNINFO_IPV6: c_int = 1;
const enum_unnamed_140 = c_uint;
pub const BPF_F_SKIP_FIELD_MASK: c_int = 255;
pub const BPF_F_USER_STACK: c_int = 256;
pub const BPF_F_FAST_STACK_CMP: c_int = 512;
pub const BPF_F_REUSE_STACKID: c_int = 1024;
pub const BPF_F_USER_BUILD_ID: c_int = 2048;
const enum_unnamed_141 = c_uint;
pub const BPF_F_ZERO_CSUM_TX: c_int = 2;
pub const BPF_F_DONT_FRAGMENT: c_int = 4;
pub const BPF_F_SEQ_NUMBER: c_int = 8;
pub const BPF_F_NO_TUNNEL_KEY: c_int = 16;
const enum_unnamed_142 = c_uint;
pub const BPF_F_TUNINFO_FLAGS: c_int = 16;
const enum_unnamed_143 = c_uint;
pub const BPF_F_INDEX_MASK: c_ulong = 4294967295;
pub const BPF_F_CURRENT_CPU: c_ulong = 4294967295;
pub const BPF_F_CTXLEN_MASK: c_ulong = 4503595332403200;
const enum_unnamed_144 = c_ulong;
pub const BPF_F_CURRENT_NETNS: c_int = -1;
const enum_unnamed_145 = c_int;
pub const BPF_CSUM_LEVEL_QUERY: c_int = 0;
pub const BPF_CSUM_LEVEL_INC: c_int = 1;
pub const BPF_CSUM_LEVEL_DEC: c_int = 2;
pub const BPF_CSUM_LEVEL_RESET: c_int = 3;
const enum_unnamed_146 = c_uint;
pub const BPF_F_ADJ_ROOM_FIXED_GSO: c_int = 1;
pub const BPF_F_ADJ_ROOM_ENCAP_L3_IPV4: c_int = 2;
pub const BPF_F_ADJ_ROOM_ENCAP_L3_IPV6: c_int = 4;
pub const BPF_F_ADJ_ROOM_ENCAP_L4_GRE: c_int = 8;
pub const BPF_F_ADJ_ROOM_ENCAP_L4_UDP: c_int = 16;
pub const BPF_F_ADJ_ROOM_NO_CSUM_RESET: c_int = 32;
pub const BPF_F_ADJ_ROOM_ENCAP_L2_ETH: c_int = 64;
pub const BPF_F_ADJ_ROOM_DECAP_L3_IPV4: c_int = 128;
pub const BPF_F_ADJ_ROOM_DECAP_L3_IPV6: c_int = 256;
const enum_unnamed_147 = c_uint;
pub const BPF_ADJ_ROOM_ENCAP_L2_MASK: c_int = 255;
pub const BPF_ADJ_ROOM_ENCAP_L2_SHIFT: c_int = 56;
const enum_unnamed_148 = c_uint;
pub const BPF_F_SYSCTL_BASE_NAME: c_int = 1;
const enum_unnamed_149 = c_uint;
pub const BPF_LOCAL_STORAGE_GET_F_CREATE: c_int = 1;
pub const BPF_SK_STORAGE_GET_F_CREATE: c_int = 1;
const enum_unnamed_150 = c_uint;
pub const BPF_F_GET_BRANCH_RECORDS_SIZE: c_int = 1;
const enum_unnamed_151 = c_uint;
pub const BPF_RB_NO_WAKEUP: c_int = 1;
pub const BPF_RB_FORCE_WAKEUP: c_int = 2;
const enum_unnamed_152 = c_uint;
pub const BPF_RB_AVAIL_DATA: c_int = 0;
pub const BPF_RB_RING_SIZE: c_int = 1;
pub const BPF_RB_CONS_POS: c_int = 2;
pub const BPF_RB_PROD_POS: c_int = 3;
const enum_unnamed_153 = c_uint;
pub const BPF_RINGBUF_BUSY_BIT: c_uint = 2147483648;
pub const BPF_RINGBUF_DISCARD_BIT: c_int = 1073741824;
pub const BPF_RINGBUF_HDR_SZ: c_int = 8;
const enum_unnamed_154 = c_uint;
pub const BPF_SK_LOOKUP_F_REPLACE: c_int = 1;
pub const BPF_SK_LOOKUP_F_NO_REUSEPORT: c_int = 2;
const enum_unnamed_155 = c_uint;
pub const BPF_ADJ_ROOM_NET: c_int = 0;
pub const BPF_ADJ_ROOM_MAC: c_int = 1;
pub const enum_bpf_adj_room_mode = c_uint;
pub const BPF_HDR_START_MAC: c_int = 0;
pub const BPF_HDR_START_NET: c_int = 1;
pub const enum_bpf_hdr_start_off = c_uint;
pub const BPF_LWT_ENCAP_SEG6: c_int = 0;
pub const BPF_LWT_ENCAP_SEG6_INLINE: c_int = 1;
pub const BPF_LWT_ENCAP_IP: c_int = 2;
pub const enum_bpf_lwt_encap_mode = c_uint;
pub const BPF_F_BPRM_SECUREEXEC: c_int = 1;
const enum_unnamed_156 = c_uint;
pub const BPF_F_BROADCAST: c_int = 8;
pub const BPF_F_EXCLUDE_INGRESS: c_int = 16;
const enum_unnamed_157 = c_uint;
pub const BPF_SKB_TSTAMP_UNSPEC: c_int = 0;
pub const BPF_SKB_TSTAMP_DELIVERY_MONO: c_int = 1;
const enum_unnamed_158 = c_uint;
const struct_unnamed_161 = extern struct {
    ipv4_src: __be32 = @import("std").mem.zeroes(__be32),
    ipv4_dst: __be32 = @import("std").mem.zeroes(__be32),
};
const struct_unnamed_162 = extern struct {
    ipv6_src: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    ipv6_dst: [4]__u32 = @import("std").mem.zeroes([4]__u32),
};
const union_unnamed_160 = extern union {
    unnamed_0: struct_unnamed_161,
    unnamed_1: struct_unnamed_162,
};
pub const struct_bpf_flow_keys = extern struct {
    nhoff: __u16 = @import("std").mem.zeroes(__u16),
    thoff: __u16 = @import("std").mem.zeroes(__u16),
    addr_proto: __u16 = @import("std").mem.zeroes(__u16),
    is_frag: __u8 = @import("std").mem.zeroes(__u8),
    is_first_frag: __u8 = @import("std").mem.zeroes(__u8),
    is_encap: __u8 = @import("std").mem.zeroes(__u8),
    ip_proto: __u8 = @import("std").mem.zeroes(__u8),
    n_proto: __be16 = @import("std").mem.zeroes(__be16),
    sport: __be16 = @import("std").mem.zeroes(__be16),
    dport: __be16 = @import("std").mem.zeroes(__be16),
    unnamed_0: union_unnamed_160 = @import("std").mem.zeroes(union_unnamed_160),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    flow_label: __be32 = @import("std").mem.zeroes(__be32),
};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_159 = opaque {};
// /usr/include/linux/bpf.h:6338:2: warning: struct demoted to opaque type - has bitfield
pub const struct_bpf_sock = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_163 = opaque {};
// /usr/include/linux/bpf.h:6260:2: warning: struct demoted to opaque type - has bitfield
pub const struct___sk_buff = opaque {};
const union_unnamed_164 = extern union {
    remote_ipv4: __u32,
    remote_ipv6: [4]__u32,
};
const union_unnamed_165 = extern union {
    tunnel_ext: __u16,
    tunnel_flags: __be16,
};
const union_unnamed_166 = extern union {
    local_ipv4: __u32,
    local_ipv6: [4]__u32,
};
pub const struct_bpf_tunnel_key = extern struct {
    tunnel_id: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_164 = @import("std").mem.zeroes(union_unnamed_164),
    tunnel_tos: __u8 = @import("std").mem.zeroes(__u8),
    tunnel_ttl: __u8 = @import("std").mem.zeroes(__u8),
    unnamed_1: union_unnamed_165 = @import("std").mem.zeroes(union_unnamed_165),
    tunnel_label: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_2: union_unnamed_166 = @import("std").mem.zeroes(union_unnamed_166),
};
const union_unnamed_167 = extern union {
    remote_ipv4: __u32,
    remote_ipv6: [4]__u32,
};
pub const struct_bpf_xfrm_state = extern struct {
    reqid: __u32 = @import("std").mem.zeroes(__u32),
    spi: __u32 = @import("std").mem.zeroes(__u32),
    family: __u16 = @import("std").mem.zeroes(__u16),
    ext: __u16 = @import("std").mem.zeroes(__u16),
    unnamed_0: union_unnamed_167 = @import("std").mem.zeroes(union_unnamed_167),
};
pub const BPF_OK: c_int = 0;
pub const BPF_DROP: c_int = 2;
pub const BPF_REDIRECT: c_int = 7;
pub const BPF_LWT_REROUTE: c_int = 128;
pub const BPF_FLOW_DISSECTOR_CONTINUE: c_int = 129;
pub const enum_bpf_ret_code = c_uint;
pub const struct_bpf_tcp_sock = extern struct {
    snd_cwnd: __u32 = @import("std").mem.zeroes(__u32),
    srtt_us: __u32 = @import("std").mem.zeroes(__u32),
    rtt_min: __u32 = @import("std").mem.zeroes(__u32),
    snd_ssthresh: __u32 = @import("std").mem.zeroes(__u32),
    rcv_nxt: __u32 = @import("std").mem.zeroes(__u32),
    snd_nxt: __u32 = @import("std").mem.zeroes(__u32),
    snd_una: __u32 = @import("std").mem.zeroes(__u32),
    mss_cache: __u32 = @import("std").mem.zeroes(__u32),
    ecn_flags: __u32 = @import("std").mem.zeroes(__u32),
    rate_delivered: __u32 = @import("std").mem.zeroes(__u32),
    rate_interval_us: __u32 = @import("std").mem.zeroes(__u32),
    packets_out: __u32 = @import("std").mem.zeroes(__u32),
    retrans_out: __u32 = @import("std").mem.zeroes(__u32),
    total_retrans: __u32 = @import("std").mem.zeroes(__u32),
    segs_in: __u32 = @import("std").mem.zeroes(__u32),
    data_segs_in: __u32 = @import("std").mem.zeroes(__u32),
    segs_out: __u32 = @import("std").mem.zeroes(__u32),
    data_segs_out: __u32 = @import("std").mem.zeroes(__u32),
    lost_out: __u32 = @import("std").mem.zeroes(__u32),
    sacked_out: __u32 = @import("std").mem.zeroes(__u32),
    bytes_received: __u64 = @import("std").mem.zeroes(__u64),
    bytes_acked: __u64 = @import("std").mem.zeroes(__u64),
    dsack_dups: __u32 = @import("std").mem.zeroes(__u32),
    delivered: __u32 = @import("std").mem.zeroes(__u32),
    delivered_ce: __u32 = @import("std").mem.zeroes(__u32),
    icsk_retransmits: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_169 = extern struct {
    saddr: __be32 = @import("std").mem.zeroes(__be32),
    daddr: __be32 = @import("std").mem.zeroes(__be32),
    sport: __be16 = @import("std").mem.zeroes(__be16),
    dport: __be16 = @import("std").mem.zeroes(__be16),
};
const struct_unnamed_170 = extern struct {
    saddr: [4]__be32 = @import("std").mem.zeroes([4]__be32),
    daddr: [4]__be32 = @import("std").mem.zeroes([4]__be32),
    sport: __be16 = @import("std").mem.zeroes(__be16),
    dport: __be16 = @import("std").mem.zeroes(__be16),
};
const union_unnamed_168 = extern union {
    ipv4: struct_unnamed_169,
    ipv6: struct_unnamed_170,
};
pub const struct_bpf_sock_tuple = extern struct {
    unnamed_0: union_unnamed_168 = @import("std").mem.zeroes(union_unnamed_168),
};
pub const TCX_NEXT: c_int = -1;
pub const TCX_PASS: c_int = 0;
pub const TCX_DROP: c_int = 2;
pub const TCX_REDIRECT: c_int = 7;
pub const enum_tcx_action_base = c_int;
pub const struct_bpf_xdp_sock = extern struct {
    queue_id: __u32 = @import("std").mem.zeroes(__u32),
};
pub const XDP_ABORTED: c_int = 0;
pub const XDP_DROP: c_int = 1;
pub const XDP_PASS: c_int = 2;
pub const XDP_TX: c_int = 3;
pub const XDP_REDIRECT: c_int = 4;
pub const enum_xdp_action = c_uint;
pub const struct_xdp_md = extern struct {
    data: __u32 = @import("std").mem.zeroes(__u32),
    data_end: __u32 = @import("std").mem.zeroes(__u32),
    data_meta: __u32 = @import("std").mem.zeroes(__u32),
    ingress_ifindex: __u32 = @import("std").mem.zeroes(__u32),
    rx_queue_index: __u32 = @import("std").mem.zeroes(__u32),
    egress_ifindex: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_171 = extern union {
    fd: c_int,
    id: __u32,
};
pub const struct_bpf_devmap_val = extern struct {
    ifindex: __u32 = @import("std").mem.zeroes(__u32),
    bpf_prog: union_unnamed_171 = @import("std").mem.zeroes(union_unnamed_171),
};
const union_unnamed_172 = extern union {
    fd: c_int,
    id: __u32,
};
pub const struct_bpf_cpumap_val = extern struct {
    qsize: __u32 = @import("std").mem.zeroes(__u32),
    bpf_prog: union_unnamed_172 = @import("std").mem.zeroes(union_unnamed_172),
};
pub const SK_DROP: c_int = 0;
pub const SK_PASS: c_int = 1;
pub const enum_sk_action = c_uint;
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_173 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_174 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_175 = opaque {};
pub const struct_sk_msg_md = extern struct {
    unnamed_0: union_unnamed_173 = @import("std").mem.zeroes(union_unnamed_173),
    unnamed_1: union_unnamed_174 = @import("std").mem.zeroes(union_unnamed_174),
    family: __u32 = @import("std").mem.zeroes(__u32),
    remote_ip4: __u32 = @import("std").mem.zeroes(__u32),
    local_ip4: __u32 = @import("std").mem.zeroes(__u32),
    remote_ip6: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    local_ip6: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    remote_port: __u32 = @import("std").mem.zeroes(__u32),
    local_port: __u32 = @import("std").mem.zeroes(__u32),
    size: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_2: union_unnamed_175 = @import("std").mem.zeroes(union_unnamed_175),
};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_176 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_177 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_178 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_179 = opaque {};
pub const struct_sk_reuseport_md = extern struct {
    unnamed_0: union_unnamed_176 = @import("std").mem.zeroes(union_unnamed_176),
    unnamed_1: union_unnamed_177 = @import("std").mem.zeroes(union_unnamed_177),
    len: __u32 = @import("std").mem.zeroes(__u32),
    eth_protocol: __u32 = @import("std").mem.zeroes(__u32),
    ip_protocol: __u32 = @import("std").mem.zeroes(__u32),
    bind_inany: __u32 = @import("std").mem.zeroes(__u32),
    hash: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_2: union_unnamed_178 = @import("std").mem.zeroes(union_unnamed_178),
    unnamed_3: union_unnamed_179 = @import("std").mem.zeroes(union_unnamed_179),
};
// /usr/include/linux/bpf.h:6558:8: warning: struct demoted to opaque type - has bitfield
pub const struct_bpf_prog_info = opaque {};
pub const struct_bpf_map_info = extern struct {
    type: __u32 = @import("std").mem.zeroes(__u32),
    id: __u32 = @import("std").mem.zeroes(__u32),
    key_size: __u32 = @import("std").mem.zeroes(__u32),
    value_size: __u32 = @import("std").mem.zeroes(__u32),
    max_entries: __u32 = @import("std").mem.zeroes(__u32),
    map_flags: __u32 = @import("std").mem.zeroes(__u32),
    name: [16]u8 = @import("std").mem.zeroes([16]u8),
    ifindex: __u32 = @import("std").mem.zeroes(__u32),
    btf_vmlinux_value_type_id: __u32 = @import("std").mem.zeroes(__u32),
    netns_dev: __u64 = @import("std").mem.zeroes(__u64),
    netns_ino: __u64 = @import("std").mem.zeroes(__u64),
    btf_id: __u32 = @import("std").mem.zeroes(__u32),
    btf_key_type_id: __u32 = @import("std").mem.zeroes(__u32),
    btf_value_type_id: __u32 = @import("std").mem.zeroes(__u32),
    btf_vmlinux_id: __u32 = @import("std").mem.zeroes(__u32),
    map_extra: __u64 = @import("std").mem.zeroes(__u64),
};
pub const struct_bpf_btf_info = extern struct {
    btf: __u64 align(8) = @import("std").mem.zeroes(__u64),
    btf_size: __u32 = @import("std").mem.zeroes(__u32),
    id: __u32 = @import("std").mem.zeroes(__u32),
    name: __u64 align(8) = @import("std").mem.zeroes(__u64),
    name_len: __u32 = @import("std").mem.zeroes(__u32),
    kernel_btf: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_181 = extern struct {
    tp_name: __u64 align(8) = @import("std").mem.zeroes(__u64),
    tp_name_len: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_182 = extern struct {
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
    target_obj_id: __u32 = @import("std").mem.zeroes(__u32),
    target_btf_id: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_183 = extern struct {
    cgroup_id: __u64 = @import("std").mem.zeroes(__u64),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_186 = extern struct {
    map_id: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_185 = extern union {
    map: struct_unnamed_186,
};
const struct_unnamed_188 = extern struct {
    cgroup_id: __u64 = @import("std").mem.zeroes(__u64),
    order: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_189 = extern struct {
    tid: __u32 = @import("std").mem.zeroes(__u32),
    pid: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_187 = extern union {
    cgroup: struct_unnamed_188,
    task: struct_unnamed_189,
};
const struct_unnamed_184 = extern struct {
    target_name: __u64 align(8) = @import("std").mem.zeroes(__u64),
    target_name_len: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_185 = @import("std").mem.zeroes(union_unnamed_185),
    unnamed_1: union_unnamed_187 = @import("std").mem.zeroes(union_unnamed_187),
};
const struct_unnamed_190 = extern struct {
    netns_ino: __u32 = @import("std").mem.zeroes(__u32),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_191 = extern struct {
    ifindex: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_192 = extern struct {
    map_id: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_193 = extern struct {
    pf: __u32 = @import("std").mem.zeroes(__u32),
    hooknum: __u32 = @import("std").mem.zeroes(__u32),
    priority: __s32 = @import("std").mem.zeroes(__s32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_194 = extern struct {
    addrs: __u64 align(8) = @import("std").mem.zeroes(__u64),
    count: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    missed: __u64 = @import("std").mem.zeroes(__u64),
    cookies: __u64 align(8) = @import("std").mem.zeroes(__u64),
};
const struct_unnamed_195 = extern struct {
    path: __u64 align(8) = @import("std").mem.zeroes(__u64),
    offsets: __u64 align(8) = @import("std").mem.zeroes(__u64),
    ref_ctr_offsets: __u64 align(8) = @import("std").mem.zeroes(__u64),
    cookies: __u64 align(8) = @import("std").mem.zeroes(__u64),
    path_size: __u32 = @import("std").mem.zeroes(__u32),
    count: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
    pid: __u32 = @import("std").mem.zeroes(__u32),
};
// /usr/include/linux/bpf.h:6691:4: warning: struct demoted to opaque type - has bitfield
const struct_unnamed_196 = opaque {};
const struct_unnamed_197 = extern struct {
    ifindex: __u32 = @import("std").mem.zeroes(__u32),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_198 = extern struct {
    ifindex: __u32 = @import("std").mem.zeroes(__u32),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_199 = extern struct {
    map_id: __u32 = @import("std").mem.zeroes(__u32),
    attach_type: __u32 = @import("std").mem.zeroes(__u32),
};
const union_unnamed_180 = extern union {
    raw_tracepoint: struct_unnamed_181,
    tracing: struct_unnamed_182,
    cgroup: struct_unnamed_183,
    iter: struct_unnamed_184,
    netns: struct_unnamed_190,
    xdp: struct_unnamed_191,
    struct_ops: struct_unnamed_192,
    netfilter: struct_unnamed_193,
    kprobe_multi: struct_unnamed_194,
    uprobe_multi: struct_unnamed_195,
    perf_event: struct_unnamed_196,
    tcx: struct_unnamed_197,
    netkit: struct_unnamed_198,
    sockmap: struct_unnamed_199,
};
pub const struct_bpf_link_info = extern struct {
    type: __u32 = @import("std").mem.zeroes(__u32),
    id: __u32 = @import("std").mem.zeroes(__u32),
    prog_id: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_180 = @import("std").mem.zeroes(union_unnamed_180),
};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_200 = opaque {};
pub const struct_bpf_sock_addr = extern struct {
    user_family: __u32 = @import("std").mem.zeroes(__u32),
    user_ip4: __u32 = @import("std").mem.zeroes(__u32),
    user_ip6: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    user_port: __u32 = @import("std").mem.zeroes(__u32),
    family: __u32 = @import("std").mem.zeroes(__u32),
    type: __u32 = @import("std").mem.zeroes(__u32),
    protocol: __u32 = @import("std").mem.zeroes(__u32),
    msg_src_ip4: __u32 = @import("std").mem.zeroes(__u32),
    msg_src_ip6: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    unnamed_0: union_unnamed_200 = @import("std").mem.zeroes(union_unnamed_200),
};
const union_unnamed_201 = extern union {
    args: [4]__u32,
    reply: __u32,
    replylong: [4]__u32,
};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_202 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_203 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_204 = opaque {};
pub const struct_bpf_sock_ops = extern struct {
    op: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_201 = @import("std").mem.zeroes(union_unnamed_201),
    family: __u32 = @import("std").mem.zeroes(__u32),
    remote_ip4: __u32 = @import("std").mem.zeroes(__u32),
    local_ip4: __u32 = @import("std").mem.zeroes(__u32),
    remote_ip6: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    local_ip6: [4]__u32 = @import("std").mem.zeroes([4]__u32),
    remote_port: __u32 = @import("std").mem.zeroes(__u32),
    local_port: __u32 = @import("std").mem.zeroes(__u32),
    is_fullsock: __u32 = @import("std").mem.zeroes(__u32),
    snd_cwnd: __u32 = @import("std").mem.zeroes(__u32),
    srtt_us: __u32 = @import("std").mem.zeroes(__u32),
    bpf_sock_ops_cb_flags: __u32 = @import("std").mem.zeroes(__u32),
    state: __u32 = @import("std").mem.zeroes(__u32),
    rtt_min: __u32 = @import("std").mem.zeroes(__u32),
    snd_ssthresh: __u32 = @import("std").mem.zeroes(__u32),
    rcv_nxt: __u32 = @import("std").mem.zeroes(__u32),
    snd_nxt: __u32 = @import("std").mem.zeroes(__u32),
    snd_una: __u32 = @import("std").mem.zeroes(__u32),
    mss_cache: __u32 = @import("std").mem.zeroes(__u32),
    ecn_flags: __u32 = @import("std").mem.zeroes(__u32),
    rate_delivered: __u32 = @import("std").mem.zeroes(__u32),
    rate_interval_us: __u32 = @import("std").mem.zeroes(__u32),
    packets_out: __u32 = @import("std").mem.zeroes(__u32),
    retrans_out: __u32 = @import("std").mem.zeroes(__u32),
    total_retrans: __u32 = @import("std").mem.zeroes(__u32),
    segs_in: __u32 = @import("std").mem.zeroes(__u32),
    data_segs_in: __u32 = @import("std").mem.zeroes(__u32),
    segs_out: __u32 = @import("std").mem.zeroes(__u32),
    data_segs_out: __u32 = @import("std").mem.zeroes(__u32),
    lost_out: __u32 = @import("std").mem.zeroes(__u32),
    sacked_out: __u32 = @import("std").mem.zeroes(__u32),
    sk_txhash: __u32 = @import("std").mem.zeroes(__u32),
    bytes_received: __u64 = @import("std").mem.zeroes(__u64),
    bytes_acked: __u64 = @import("std").mem.zeroes(__u64),
    unnamed_1: union_unnamed_202 = @import("std").mem.zeroes(union_unnamed_202),
    unnamed_2: union_unnamed_203 = @import("std").mem.zeroes(union_unnamed_203),
    unnamed_3: union_unnamed_204 = @import("std").mem.zeroes(union_unnamed_204),
    skb_len: __u32 = @import("std").mem.zeroes(__u32),
    skb_tcp_flags: __u32 = @import("std").mem.zeroes(__u32),
    skb_hwtstamp: __u64 = @import("std").mem.zeroes(__u64),
};
pub const BPF_SOCK_OPS_RTO_CB_FLAG: c_int = 1;
pub const BPF_SOCK_OPS_RETRANS_CB_FLAG: c_int = 2;
pub const BPF_SOCK_OPS_STATE_CB_FLAG: c_int = 4;
pub const BPF_SOCK_OPS_RTT_CB_FLAG: c_int = 8;
pub const BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG: c_int = 16;
pub const BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG: c_int = 32;
pub const BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG: c_int = 64;
pub const BPF_SOCK_OPS_ALL_CB_FLAGS: c_int = 127;
const enum_unnamed_205 = c_uint;
pub const BPF_SOCK_OPS_VOID: c_int = 0;
pub const BPF_SOCK_OPS_TIMEOUT_INIT: c_int = 1;
pub const BPF_SOCK_OPS_RWND_INIT: c_int = 2;
pub const BPF_SOCK_OPS_TCP_CONNECT_CB: c_int = 3;
pub const BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB: c_int = 4;
pub const BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB: c_int = 5;
pub const BPF_SOCK_OPS_NEEDS_ECN: c_int = 6;
pub const BPF_SOCK_OPS_BASE_RTT: c_int = 7;
pub const BPF_SOCK_OPS_RTO_CB: c_int = 8;
pub const BPF_SOCK_OPS_RETRANS_CB: c_int = 9;
pub const BPF_SOCK_OPS_STATE_CB: c_int = 10;
pub const BPF_SOCK_OPS_TCP_LISTEN_CB: c_int = 11;
pub const BPF_SOCK_OPS_RTT_CB: c_int = 12;
pub const BPF_SOCK_OPS_PARSE_HDR_OPT_CB: c_int = 13;
pub const BPF_SOCK_OPS_HDR_OPT_LEN_CB: c_int = 14;
pub const BPF_SOCK_OPS_WRITE_HDR_OPT_CB: c_int = 15;
const enum_unnamed_206 = c_uint;
pub const BPF_TCP_ESTABLISHED: c_int = 1;
pub const BPF_TCP_SYN_SENT: c_int = 2;
pub const BPF_TCP_SYN_RECV: c_int = 3;
pub const BPF_TCP_FIN_WAIT1: c_int = 4;
pub const BPF_TCP_FIN_WAIT2: c_int = 5;
pub const BPF_TCP_TIME_WAIT: c_int = 6;
pub const BPF_TCP_CLOSE: c_int = 7;
pub const BPF_TCP_CLOSE_WAIT: c_int = 8;
pub const BPF_TCP_LAST_ACK: c_int = 9;
pub const BPF_TCP_LISTEN: c_int = 10;
pub const BPF_TCP_CLOSING: c_int = 11;
pub const BPF_TCP_NEW_SYN_RECV: c_int = 12;
pub const BPF_TCP_BOUND_INACTIVE: c_int = 13;
pub const BPF_TCP_MAX_STATES: c_int = 14;
const enum_unnamed_207 = c_uint;
pub const TCP_BPF_IW: c_int = 1001;
pub const TCP_BPF_SNDCWND_CLAMP: c_int = 1002;
pub const TCP_BPF_DELACK_MAX: c_int = 1003;
pub const TCP_BPF_RTO_MIN: c_int = 1004;
pub const TCP_BPF_SYN: c_int = 1005;
pub const TCP_BPF_SYN_IP: c_int = 1006;
pub const TCP_BPF_SYN_MAC: c_int = 1007;
const enum_unnamed_208 = c_uint;
pub const BPF_LOAD_HDR_OPT_TCP_SYN: c_int = 1;
const enum_unnamed_209 = c_uint;
pub const BPF_WRITE_HDR_TCP_CURRENT_MSS: c_int = 1;
pub const BPF_WRITE_HDR_TCP_SYNACK_COOKIE: c_int = 2;
const enum_unnamed_210 = c_uint;
pub const struct_bpf_perf_event_value = extern struct {
    counter: __u64 = @import("std").mem.zeroes(__u64),
    enabled: __u64 = @import("std").mem.zeroes(__u64),
    running: __u64 = @import("std").mem.zeroes(__u64),
};
pub const BPF_DEVCG_ACC_MKNOD: c_int = 1;
pub const BPF_DEVCG_ACC_READ: c_int = 2;
pub const BPF_DEVCG_ACC_WRITE: c_int = 4;
const enum_unnamed_211 = c_uint;
pub const BPF_DEVCG_DEV_BLOCK: c_int = 1;
pub const BPF_DEVCG_DEV_CHAR: c_int = 2;
const enum_unnamed_212 = c_uint;
pub const struct_bpf_cgroup_dev_ctx = extern struct {
    access_type: __u32 = @import("std").mem.zeroes(__u32),
    major: __u32 = @import("std").mem.zeroes(__u32),
    minor: __u32 = @import("std").mem.zeroes(__u32),
};
pub const struct_bpf_raw_tracepoint_args = extern struct {
    pub fn args(self: anytype) @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), c_ulonglong) {
        const Intermediate = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), u8);
        const ReturnType = @import("std").zig.c_translation.FlexibleArrayType(@TypeOf(self), c_ulonglong);
        return @as(ReturnType, @ptrCast(@alignCast(@as(Intermediate, @ptrCast(self)) + 0)));
    }
};
pub const BPF_FIB_LOOKUP_DIRECT: c_int = 1;
pub const BPF_FIB_LOOKUP_OUTPUT: c_int = 2;
pub const BPF_FIB_LOOKUP_SKIP_NEIGH: c_int = 4;
pub const BPF_FIB_LOOKUP_TBID: c_int = 8;
pub const BPF_FIB_LOOKUP_SRC: c_int = 16;
pub const BPF_FIB_LOOKUP_MARK: c_int = 32;
const enum_unnamed_213 = c_uint;
pub const BPF_FIB_LKUP_RET_SUCCESS: c_int = 0;
pub const BPF_FIB_LKUP_RET_BLACKHOLE: c_int = 1;
pub const BPF_FIB_LKUP_RET_UNREACHABLE: c_int = 2;
pub const BPF_FIB_LKUP_RET_PROHIBIT: c_int = 3;
pub const BPF_FIB_LKUP_RET_NOT_FWDED: c_int = 4;
pub const BPF_FIB_LKUP_RET_FWD_DISABLED: c_int = 5;
pub const BPF_FIB_LKUP_RET_UNSUPP_LWT: c_int = 6;
pub const BPF_FIB_LKUP_RET_NO_NEIGH: c_int = 7;
pub const BPF_FIB_LKUP_RET_FRAG_NEEDED: c_int = 8;
pub const BPF_FIB_LKUP_RET_NO_SRC_ADDR: c_int = 9;
const enum_unnamed_214 = c_uint;
const union_unnamed_215 = extern union {
    tot_len: __u16 align(1),
    mtu_result: __u16 align(1),
};
const union_unnamed_216 = extern union {
    tos: __u8,
    flowinfo: __be32,
    rt_metric: __u32,
};
const union_unnamed_217 = extern union {
    ipv4_src: __be32,
    ipv6_src: [4]__u32,
};
const union_unnamed_218 = extern union {
    ipv4_dst: __be32,
    ipv6_dst: [4]__u32,
};
const struct_unnamed_220 = extern struct {
    h_vlan_proto: __be16 = @import("std").mem.zeroes(__be16),
    h_vlan_TCI: __be16 = @import("std").mem.zeroes(__be16),
};
const union_unnamed_219 = extern union {
    unnamed_0: struct_unnamed_220,
    tbid: __u32,
};
const struct_unnamed_222 = extern struct {
    mark: __u32 = @import("std").mem.zeroes(__u32),
};
const struct_unnamed_223 = extern struct {
    smac: [6]__u8 = @import("std").mem.zeroes([6]__u8),
    dmac: [6]__u8 = @import("std").mem.zeroes([6]__u8),
};
const union_unnamed_221 = extern union {
    unnamed_0: struct_unnamed_222,
    unnamed_1: struct_unnamed_223,
};
pub const struct_bpf_fib_lookup = extern struct {
    family: __u8 = @import("std").mem.zeroes(__u8),
    l4_protocol: __u8 = @import("std").mem.zeroes(__u8),
    sport: __be16 = @import("std").mem.zeroes(__be16),
    dport: __be16 = @import("std").mem.zeroes(__be16),
    unnamed_0: union_unnamed_215 = @import("std").mem.zeroes(union_unnamed_215),
    ifindex: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_1: union_unnamed_216 = @import("std").mem.zeroes(union_unnamed_216),
    unnamed_2: union_unnamed_217 = @import("std").mem.zeroes(union_unnamed_217),
    unnamed_3: union_unnamed_218 = @import("std").mem.zeroes(union_unnamed_218),
    unnamed_4: union_unnamed_219 = @import("std").mem.zeroes(union_unnamed_219),
    unnamed_5: union_unnamed_221 = @import("std").mem.zeroes(union_unnamed_221),
};
const union_unnamed_224 = extern union {
    ipv4_nh: __be32,
    ipv6_nh: [4]__u32,
};
pub const struct_bpf_redir_neigh = extern struct {
    nh_family: __u32 = @import("std").mem.zeroes(__u32),
    unnamed_0: union_unnamed_224 = @import("std").mem.zeroes(union_unnamed_224),
};
pub const BPF_MTU_CHK_SEGS: c_int = 1;
pub const enum_bpf_check_mtu_flags = c_uint;
pub const BPF_MTU_CHK_RET_SUCCESS: c_int = 0;
pub const BPF_MTU_CHK_RET_FRAG_NEEDED: c_int = 1;
pub const BPF_MTU_CHK_RET_SEGS_TOOBIG: c_int = 2;
pub const enum_bpf_check_mtu_ret = c_uint;
pub const BPF_FD_TYPE_RAW_TRACEPOINT: c_int = 0;
pub const BPF_FD_TYPE_TRACEPOINT: c_int = 1;
pub const BPF_FD_TYPE_KPROBE: c_int = 2;
pub const BPF_FD_TYPE_KRETPROBE: c_int = 3;
pub const BPF_FD_TYPE_UPROBE: c_int = 4;
pub const BPF_FD_TYPE_URETPROBE: c_int = 5;
pub const enum_bpf_task_fd_type = c_uint;
pub const BPF_FLOW_DISSECTOR_F_PARSE_1ST_FRAG: c_int = 1;
pub const BPF_FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL: c_int = 2;
pub const BPF_FLOW_DISSECTOR_F_STOP_AT_ENCAP: c_int = 4;
const enum_unnamed_225 = c_uint;
pub const struct_bpf_func_info = extern struct {
    insn_off: __u32 = @import("std").mem.zeroes(__u32),
    type_id: __u32 = @import("std").mem.zeroes(__u32),
};
pub const struct_bpf_line_info = extern struct {
    insn_off: __u32 = @import("std").mem.zeroes(__u32),
    file_name_off: __u32 = @import("std").mem.zeroes(__u32),
    line_off: __u32 = @import("std").mem.zeroes(__u32),
    line_col: __u32 = @import("std").mem.zeroes(__u32),
};
pub const struct_bpf_spin_lock = extern struct {
    val: __u32 = @import("std").mem.zeroes(__u32),
};
pub const struct_bpf_timer = extern struct {
    __opaque: [2]__u64 = @import("std").mem.zeroes([2]__u64),
};
pub const struct_bpf_wq = extern struct {
    __opaque: [2]__u64 = @import("std").mem.zeroes([2]__u64),
};
pub const struct_bpf_dynptr = extern struct {
    __opaque: [2]__u64 = @import("std").mem.zeroes([2]__u64),
};
pub const struct_bpf_list_head = extern struct {
    __opaque: [2]__u64 = @import("std").mem.zeroes([2]__u64),
};
pub const struct_bpf_list_node = extern struct {
    __opaque: [3]__u64 = @import("std").mem.zeroes([3]__u64),
};
pub const struct_bpf_rb_root = extern struct {
    __opaque: [2]__u64 = @import("std").mem.zeroes([2]__u64),
};
pub const struct_bpf_rb_node = extern struct {
    __opaque: [4]__u64 = @import("std").mem.zeroes([4]__u64),
};
pub const struct_bpf_refcount = extern struct {
    __opaque: [1]__u32 = @import("std").mem.zeroes([1]__u32),
};
pub const struct_bpf_sysctl = extern struct {
    write: __u32 = @import("std").mem.zeroes(__u32),
    file_pos: __u32 = @import("std").mem.zeroes(__u32),
};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_226 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_227 = opaque {};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_228 = opaque {};
pub const struct_bpf_sockopt = extern struct {
    unnamed_0: union_unnamed_226 = @import("std").mem.zeroes(union_unnamed_226),
    unnamed_1: union_unnamed_227 = @import("std").mem.zeroes(union_unnamed_227),
    unnamed_2: union_unnamed_228 = @import("std").mem.zeroes(union_unnamed_228),
    level: __s32 = @import("std").mem.zeroes(__s32),
    optname: __s32 = @import("std").mem.zeroes(__s32),
    optlen: __s32 = @import("std").mem.zeroes(__s32),
    retval: __s32 = @import("std").mem.zeroes(__s32),
};
pub const struct_bpf_pidns_info = extern struct {
    pid: __u32 = @import("std").mem.zeroes(__u32),
    tgid: __u32 = @import("std").mem.zeroes(__u32),
};
// /usr/include/linux/bpf.h:6207:2: warning: union demoted to opaque type - has bitfield
const union_unnamed_230 = opaque {};
const union_unnamed_229 = extern union {
    unnamed_0: union_unnamed_230,
    cookie: __u64,
};
// /usr/include/linux/bpf.h:7377:2: warning: struct demoted to opaque type - has bitfield
pub const struct_bpf_sk_lookup = opaque {};
pub const struct_btf_ptr = extern struct {
    ptr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    type_id: __u32 = @import("std").mem.zeroes(__u32),
    flags: __u32 = @import("std").mem.zeroes(__u32),
};
pub const BTF_F_COMPACT: c_int = 1;
pub const BTF_F_NONAME: c_int = 2;
pub const BTF_F_PTR_RAW: c_int = 4;
pub const BTF_F_ZERO: c_int = 8;
const enum_unnamed_231 = c_uint;
pub const BPF_CORE_FIELD_BYTE_OFFSET: c_int = 0;
pub const BPF_CORE_FIELD_BYTE_SIZE: c_int = 1;
pub const BPF_CORE_FIELD_EXISTS: c_int = 2;
pub const BPF_CORE_FIELD_SIGNED: c_int = 3;
pub const BPF_CORE_FIELD_LSHIFT_U64: c_int = 4;
pub const BPF_CORE_FIELD_RSHIFT_U64: c_int = 5;
pub const BPF_CORE_TYPE_ID_LOCAL: c_int = 6;
pub const BPF_CORE_TYPE_ID_TARGET: c_int = 7;
pub const BPF_CORE_TYPE_EXISTS: c_int = 8;
pub const BPF_CORE_TYPE_SIZE: c_int = 9;
pub const BPF_CORE_ENUMVAL_EXISTS: c_int = 10;
pub const BPF_CORE_ENUMVAL_VALUE: c_int = 11;
pub const BPF_CORE_TYPE_MATCHES: c_int = 12;
pub const enum_bpf_core_relo_kind = c_uint;
pub const struct_bpf_core_relo = extern struct {
    insn_off: __u32 = @import("std").mem.zeroes(__u32),
    type_id: __u32 = @import("std").mem.zeroes(__u32),
    access_str_off: __u32 = @import("std").mem.zeroes(__u32),
    kind: enum_bpf_core_relo_kind = @import("std").mem.zeroes(enum_bpf_core_relo_kind),
};
pub const BPF_F_TIMER_ABS: c_int = 1;
pub const BPF_F_TIMER_CPU_PIN: c_int = 2;
const enum_unnamed_232 = c_uint;
pub const struct_bpf_iter_num = extern struct {
    __opaque: [1]__u64 = @import("std").mem.zeroes([1]__u64),
};
pub const ngx_bpf_reloc_t = extern struct {
    name: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    offset: c_int = @import("std").mem.zeroes(c_int),
};
pub const ngx_bpf_program_t = extern struct {
    license: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    type: enum_bpf_prog_type = @import("std").mem.zeroes(enum_bpf_prog_type),
    ins: ?*struct_bpf_insn = @import("std").mem.zeroes(?*struct_bpf_insn),
    nins: usize = @import("std").mem.zeroes(usize),
    relocs: [*c]ngx_bpf_reloc_t = @import("std").mem.zeroes([*c]ngx_bpf_reloc_t),
    nrelocs: usize = @import("std").mem.zeroes(usize),
};
pub extern fn ngx_bpf_program_link(program: [*c]ngx_bpf_program_t, symbol: [*c]const u8, fd: c_int) void;
pub extern fn ngx_bpf_load_program(log: [*c]ngx_log_t, program: [*c]ngx_bpf_program_t) c_int;
pub extern fn ngx_bpf_map_create(log: [*c]ngx_log_t, @"type": enum_bpf_map_type, key_size: c_int, value_size: c_int, max_entries: c_int, map_flags: u32) c_int;
pub extern fn ngx_bpf_map_update(fd: c_int, key: ?*const anyopaque, value: ?*const anyopaque, flags: u64) c_int;
pub extern fn ngx_bpf_map_delete(fd: c_int, key: ?*const anyopaque) c_int;
pub extern fn ngx_bpf_map_lookup(fd: c_int, key: ?*const anyopaque, value: ?*anyopaque) c_int;
pub extern fn ngx_cpuinfo() void;
pub const ngx_http_request_t = struct_ngx_http_request_s;
pub const ngx_http_event_handler_pt = ?*const fn ([*c]ngx_http_request_t) callconv(.C) void;
pub const struct_ngx_http_file_cache_s = extern struct {
    sh: [*c]ngx_http_file_cache_sh_t = @import("std").mem.zeroes([*c]ngx_http_file_cache_sh_t),
    shpool: [*c]ngx_slab_pool_t = @import("std").mem.zeroes([*c]ngx_slab_pool_t),
    path: [*c]ngx_path_t = @import("std").mem.zeroes([*c]ngx_path_t),
    min_free: off_t = @import("std").mem.zeroes(off_t),
    max_size: off_t = @import("std").mem.zeroes(off_t),
    bsize: usize = @import("std").mem.zeroes(usize),
    inactive: time_t = @import("std").mem.zeroes(time_t),
    fail_time: time_t = @import("std").mem.zeroes(time_t),
    files: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    loader_files: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    last: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    loader_sleep: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    loader_threshold: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    manager_files: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    manager_sleep: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    manager_threshold: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    shm_zone: [*c]ngx_shm_zone_t = @import("std").mem.zeroes([*c]ngx_shm_zone_t),
    use_temp_path: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_file_cache_t = struct_ngx_http_file_cache_s;
pub const struct_ngx_http_cache_s = extern struct {
    file: ngx_file_t = @import("std").mem.zeroes(ngx_file_t),
    keys: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    crc32: u32 = @import("std").mem.zeroes(u32),
    key: [16]u_char = @import("std").mem.zeroes([16]u_char),
    main: [16]u_char = @import("std").mem.zeroes([16]u_char),
    uniq: ngx_file_uniq_t = @import("std").mem.zeroes(ngx_file_uniq_t),
    valid_sec: time_t = @import("std").mem.zeroes(time_t),
    updating_sec: time_t = @import("std").mem.zeroes(time_t),
    error_sec: time_t = @import("std").mem.zeroes(time_t),
    last_modified: time_t = @import("std").mem.zeroes(time_t),
    date: time_t = @import("std").mem.zeroes(time_t),
    etag: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    vary: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    variant: [16]u_char = @import("std").mem.zeroes([16]u_char),
    buffer_size: usize = @import("std").mem.zeroes(usize),
    header_start: usize = @import("std").mem.zeroes(usize),
    body_start: usize = @import("std").mem.zeroes(usize),
    length: off_t = @import("std").mem.zeroes(off_t),
    fs_size: off_t = @import("std").mem.zeroes(off_t),
    min_uses: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    @"error": ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    valid_msec: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    vary_tag: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    file_cache: [*c]ngx_http_file_cache_t = @import("std").mem.zeroes([*c]ngx_http_file_cache_t),
    node: [*c]ngx_http_file_cache_node_t = @import("std").mem.zeroes([*c]ngx_http_file_cache_node_t),
    lock_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    lock_age: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    lock_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    wait_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    wait_event: ngx_event_t = @import("std").mem.zeroes(ngx_event_t),
    flags: packed struct {
        lock: bool,
        waiting: bool,
        updated: bool,
        updating: bool,
        exists: bool,
        temp_file: bool,
        purged: bool,
        reading: bool,
        secondary: bool,
        update_variant: bool,
        background: bool,
        stale_updating: bool,
        stale_error: bool,
        padding: u19,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_http_cache_t = struct_ngx_http_cache_s;
pub const ngx_http_upstream_handler_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_upstream_t) callconv(.C) void;
pub const ngx_event_get_peer_pt = ?*const fn ([*c]ngx_peer_connection_t, ?*anyopaque) callconv(.C) ngx_int_t;
pub const ngx_event_free_peer_pt = ?*const fn ([*c]ngx_peer_connection_t, ?*anyopaque, ngx_uint_t) callconv(.C) void;
pub const ngx_event_notify_peer_pt = ?*const fn ([*c]ngx_peer_connection_t, ?*anyopaque, ngx_uint_t) callconv(.C) void;
pub const struct_ngx_peer_connection_s = extern struct {
    connection: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    name: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    tries: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    start_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    get: ngx_event_get_peer_pt = @import("std").mem.zeroes(ngx_event_get_peer_pt),
    free: ngx_event_free_peer_pt = @import("std").mem.zeroes(ngx_event_free_peer_pt),
    notify: ngx_event_notify_peer_pt = @import("std").mem.zeroes(ngx_event_notify_peer_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    local: [*c]ngx_addr_t = @import("std").mem.zeroes([*c]ngx_addr_t),
    type: c_int = @import("std").mem.zeroes(c_int),
    rcvbuf: c_int = @import("std").mem.zeroes(c_int),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    flags: packed struct {
        cached: bool,
        transparent: bool,
        so_keepalive: bool,
        down: bool,
        log_error: u2,
        padding: u26,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_peer_connection_t = struct_ngx_peer_connection_s;
pub const ngx_event_pipe_input_filter_pt = ?*const fn ([*c]ngx_event_pipe_t, [*c]ngx_buf_t) callconv(.C) ngx_int_t;
pub const ngx_event_pipe_output_filter_pt = ?*const fn (?*anyopaque, [*c]ngx_chain_t) callconv(.C) ngx_int_t;
pub const struct_ngx_event_pipe_s = extern struct {
    upstream: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    downstream: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    free_raw_bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    in: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    last_in: [*c][*c]ngx_chain_t = @import("std").mem.zeroes([*c][*c]ngx_chain_t),
    writing: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    out: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    free: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    busy: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    input_filter: ngx_event_pipe_input_filter_pt = @import("std").mem.zeroes(ngx_event_pipe_input_filter_pt),
    input_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    output_filter: ngx_event_pipe_output_filter_pt = @import("std").mem.zeroes(ngx_event_pipe_output_filter_pt),
    output_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    flags: packed struct {
        read: bool,
        cacheable: bool,
        single_buf: bool,
        free_bufs: bool,
        upstream_done: bool,
        upstream_error: bool,
        upstream_eof: bool,
        upstream_blocked: bool,
        downstream_done: bool,
        downstream_error: bool,
        cyclic_temp_file: bool,
        aio: bool,
        padding: u20,
    } = @import("std").mem.zeroes(c_uint),
    allocated: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    bufs: ngx_bufs_t = @import("std").mem.zeroes(ngx_bufs_t),
    tag: ngx_buf_tag_t = @import("std").mem.zeroes(ngx_buf_tag_t),
    busy_size: isize = @import("std").mem.zeroes(isize),
    read_length: off_t = @import("std").mem.zeroes(off_t),
    length: off_t = @import("std").mem.zeroes(off_t),
    max_temp_file_size: off_t = @import("std").mem.zeroes(off_t),
    temp_file_write_size: isize = @import("std").mem.zeroes(isize),
    read_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    send_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    send_lowat: isize = @import("std").mem.zeroes(isize),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    preread_bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    preread_size: usize = @import("std").mem.zeroes(usize),
    buf_to_file: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    limit_rate: usize = @import("std").mem.zeroes(usize),
    start_sec: time_t = @import("std").mem.zeroes(time_t),
    temp_file: [*c]ngx_temp_file_t = @import("std").mem.zeroes([*c]ngx_temp_file_t),
    num: c_int = @import("std").mem.zeroes(c_int),
};
pub const ngx_event_pipe_t = struct_ngx_event_pipe_s;
pub const struct_ngx_http_upstream_srv_conf_s = extern struct {
    peer: ngx_http_upstream_peer_t = @import("std").mem.zeroes(ngx_http_upstream_peer_t),
    srv_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    servers: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    flags: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    host: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    file_name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    line: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    port: in_port_t = @import("std").mem.zeroes(in_port_t),
    no_port: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    shm_zone: [*c]ngx_shm_zone_t = @import("std").mem.zeroes([*c]ngx_shm_zone_t),
    resolver: [*c]ngx_resolver_t = @import("std").mem.zeroes([*c]ngx_resolver_t),
    resolver_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
};
pub const ngx_http_upstream_srv_conf_t = struct_ngx_http_upstream_srv_conf_s;
pub const ngx_http_cleanup_pt = ?*const fn (?*anyopaque) callconv(.C) void;
pub const struct_ngx_http_upstream_s = extern struct {
    read_event_handler: ngx_http_upstream_handler_pt = @import("std").mem.zeroes(ngx_http_upstream_handler_pt),
    write_event_handler: ngx_http_upstream_handler_pt = @import("std").mem.zeroes(ngx_http_upstream_handler_pt),
    peer: ngx_peer_connection_t = @import("std").mem.zeroes(ngx_peer_connection_t),
    pipe: [*c]ngx_event_pipe_t = @import("std").mem.zeroes([*c]ngx_event_pipe_t),
    request_bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    output: ngx_output_chain_ctx_t = @import("std").mem.zeroes(ngx_output_chain_ctx_t),
    writer: ngx_chain_writer_ctx_t = @import("std").mem.zeroes(ngx_chain_writer_ctx_t),
    conf: ?*ngx_http_upstream_conf_t = @import("std").mem.zeroes(?*ngx_http_upstream_conf_t),
    upstream: [*c]ngx_http_upstream_srv_conf_t = @import("std").mem.zeroes([*c]ngx_http_upstream_srv_conf_t),
    caches: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    headers_in: ngx_http_upstream_headers_in_t = @import("std").mem.zeroes(ngx_http_upstream_headers_in_t),
    resolved: [*c]ngx_http_upstream_resolved_t = @import("std").mem.zeroes([*c]ngx_http_upstream_resolved_t),
    from_client: ngx_buf_t = @import("std").mem.zeroes(ngx_buf_t),
    buffer: ngx_buf_t = @import("std").mem.zeroes(ngx_buf_t),
    length: off_t = @import("std").mem.zeroes(off_t),
    out_bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    busy_bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    free_bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    input_filter_init: ?*const fn (?*anyopaque) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.C) ngx_int_t),
    input_filter: ?*const fn (?*anyopaque, isize) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn (?*anyopaque, isize) callconv(.C) ngx_int_t),
    input_filter_ctx: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    create_key: ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t),
    create_request: ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t),
    reinit_request: ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t),
    process_header: ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t),
    abort_request: ?*const fn ([*c]ngx_http_request_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t) callconv(.C) void),
    finalize_request: ?*const fn ([*c]ngx_http_request_t, ngx_int_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t, ngx_int_t) callconv(.C) void),
    rewrite_redirect: ?*const fn ([*c]ngx_http_request_t, [*c]ngx_table_elt_t, usize) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t, [*c]ngx_table_elt_t, usize) callconv(.C) ngx_int_t),
    rewrite_cookie: ?*const fn ([*c]ngx_http_request_t, [*c]ngx_table_elt_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_http_request_t, [*c]ngx_table_elt_t) callconv(.C) ngx_int_t),
    start_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    state: [*c]ngx_http_upstream_state_t = @import("std").mem.zeroes([*c]ngx_http_upstream_state_t),
    method: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    schema: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    uri: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    cleanup: [*c]ngx_http_cleanup_pt = @import("std").mem.zeroes([*c]ngx_http_cleanup_pt),
};
pub const ngx_http_upstream_t = struct_ngx_http_upstream_s;
pub const struct_ngx_http_postponed_request_s = extern struct {
    request: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
    out: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    next: [*c]ngx_http_postponed_request_t = @import("std").mem.zeroes([*c]ngx_http_postponed_request_t),
};
pub const ngx_http_postponed_request_t = struct_ngx_http_postponed_request_s;
pub const struct_ngx_http_posted_request_s = extern struct {
    request: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
    next: [*c]ngx_http_posted_request_t = @import("std").mem.zeroes([*c]ngx_http_posted_request_t),
};
pub const ngx_http_posted_request_t = struct_ngx_http_posted_request_s;
pub const ngx_http_handler_pt = ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t;
pub const ngx_http_variable_value_t = ngx_variable_value_t;
pub const struct_ngx_http_v2_stream_s = opaque {};
pub const ngx_http_v2_stream_t = struct_ngx_http_v2_stream_s;
pub const struct_ngx_http_v3_parse_s = opaque {};
pub const ngx_http_v3_parse_t = struct_ngx_http_v3_parse_s;
pub const ngx_http_log_handler_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_request_t, [*c]u_char, usize) callconv(.C) [*c]u_char;
pub const struct_ngx_http_cleanup_s = extern struct {
    handler: ngx_http_cleanup_pt = @import("std").mem.zeroes(ngx_http_cleanup_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    next: [*c]ngx_http_cleanup_t = @import("std").mem.zeroes([*c]ngx_http_cleanup_t),
};
pub const ngx_http_cleanup_t = struct_ngx_http_cleanup_s;
pub const struct_ngx_http_request_s = extern struct {
    signature: u32 = @import("std").mem.zeroes(u32),
    connection: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    ctx: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    main_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    srv_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    loc_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    read_event_handler: ngx_http_event_handler_pt = @import("std").mem.zeroes(ngx_http_event_handler_pt),
    write_event_handler: ngx_http_event_handler_pt = @import("std").mem.zeroes(ngx_http_event_handler_pt),
    cache: [*c]ngx_http_cache_t = @import("std").mem.zeroes([*c]ngx_http_cache_t),
    upstream: [*c]ngx_http_upstream_t = @import("std").mem.zeroes([*c]ngx_http_upstream_t),
    upstream_states: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    pool: [*c]ngx_pool_t = @import("std").mem.zeroes([*c]ngx_pool_t),
    header_in: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    headers_in: ngx_http_headers_in_t = @import("std").mem.zeroes(ngx_http_headers_in_t),
    headers_out: ngx_http_headers_out_t = @import("std").mem.zeroes(ngx_http_headers_out_t),
    request_body: [*c]ngx_http_request_body_t = @import("std").mem.zeroes([*c]ngx_http_request_body_t),
    lingering_time: time_t = @import("std").mem.zeroes(time_t),
    start_sec: time_t = @import("std").mem.zeroes(time_t),
    start_msec: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    method: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    http_version: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    request_line: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    uri: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    args: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    exten: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    unparsed_uri: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    method_name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    http_protocol: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    schema: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    out: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    main: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
    parent: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
    postponed: [*c]ngx_http_postponed_request_t = @import("std").mem.zeroes([*c]ngx_http_postponed_request_t),
    post_subrequest: [*c]ngx_http_post_subrequest_t = @import("std").mem.zeroes([*c]ngx_http_post_subrequest_t),
    posted_requests: [*c]ngx_http_posted_request_t = @import("std").mem.zeroes([*c]ngx_http_posted_request_t),
    phase_handler: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    content_handler: ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(ngx_http_handler_pt),
    access_code: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    variables: [*c]ngx_http_variable_value_t = @import("std").mem.zeroes([*c]ngx_http_variable_value_t),
    ncaptures: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    captures: [*c]c_int = @import("std").mem.zeroes([*c]c_int),
    captures_data: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    limit_rate: usize = @import("std").mem.zeroes(usize),
    limit_rate_after: usize = @import("std").mem.zeroes(usize),
    header_size: usize = @import("std").mem.zeroes(usize),
    request_length: off_t = @import("std").mem.zeroes(off_t),
    err_status: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    http_connection: [*c]ngx_http_connection_t = @import("std").mem.zeroes([*c]ngx_http_connection_t),
    stream: ?*ngx_http_v2_stream_t = @import("std").mem.zeroes(?*ngx_http_v2_stream_t),
    v3_parse: ?*ngx_http_v3_parse_t = @import("std").mem.zeroes(?*ngx_http_v3_parse_t),
    log_handler: ngx_http_log_handler_pt = @import("std").mem.zeroes(ngx_http_log_handler_pt),
    cleanup: [*c]ngx_http_cleanup_t = @import("std").mem.zeroes([*c]ngx_http_cleanup_t),
    flags0: packed struct {
        count: u16,
        subrequests: u8,
        blocked: u8,
        aio: bool,
        http_state: u4,
        complex_uri: bool,
        quoted_uri: bool,
        plus_in_uri: bool,
        empty_path_in_uri: bool,
        invalid_header: bool,
        add_uri_to_alias: bool,
        valid_location: bool,
        valid_unparsed_uri: bool,
        uri_changed: bool,
        uri_changes: u4,
        request_body_in_single_buf: bool,
        request_body_in_file_only: bool,
        request_body_in_persistent_file: bool,
        request_body_in_clean_file: bool,
        request_body_file_group_access: bool,
        request_body_file_log_level: u3,
        request_body_no_buffering: bool,
        subrequest_in_memory: bool,
        waited: bool,
        cached: bool,
        gzip_tested: bool,
        gzip_ok: bool,
    } = @import("std").mem.zeroes(c_ulong),
    flags1: packed struct {
        gzip_vary: bool,
        realloc_captures: bool,
        proxy: bool,
        bypass_cache: bool,
        no_cache: bool,
        limit_conn_status: u2,
        limit_req_status: u3,
        limit_rate_set: bool,
        limit_rate_after_set: bool,
        pipeline: bool,
        chunked: bool,
        header_only: bool,
        expect_trailers: bool,
        keepalive: bool,
        lingering_close: bool,
        discard_body: bool,
        reading_body: bool,
        internal: bool,
        error_page: bool,
        filter_finalize: bool,
        post_action: bool,
        request_complete: bool,
        request_output: bool,
        header_sent: bool,
        response_sent: bool,
        expect_tested: bool,
        root_tested: bool,
        done: bool,
        logged: bool,
        terminated: bool,
        buffered: u4,
        main_filter_need_in_memory: bool,
        filter_need_in_memory: bool,
        filter_need_temporary: bool,
        preserve_body: bool,
        allow_ranges: bool,
        subrequest_ranges: bool,
        single_range: bool,
        disable_not_modified: bool,
        stat_reading: bool,
        stat_writing: bool,
        stat_processing: bool,
        background: bool,
        health_check: bool,
        padding: u14,
    } = @import("std").mem.zeroes(c_ulong),
    state: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    header_hash: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    lowcase_index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    lowcase_header: [32]u_char = @import("std").mem.zeroes([32]u_char),
    header_name_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    header_name_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    header_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    header_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    uri_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    uri_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    uri_ext: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    args_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    request_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    request_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    method_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    schema_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    schema_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    host_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    host_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    flags2: packed struct {
        http_minor: u16,
        http_major: u16,
    } = @import("std").mem.zeroes(c_uint),
};
pub const struct_ngx_http_log_ctx_s = extern struct {
    connection: [*c]ngx_connection_t = @import("std").mem.zeroes([*c]ngx_connection_t),
    request: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
    current_request: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
};
pub const ngx_http_log_ctx_t = struct_ngx_http_log_ctx_s;
pub const struct_ngx_http_chunked_s = extern struct {
    state: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    size: off_t = @import("std").mem.zeroes(off_t),
    length: off_t = @import("std").mem.zeroes(off_t),
};
pub const ngx_http_chunked_t = struct_ngx_http_chunked_s;
pub const struct_ngx_http_v3_session_s = opaque {};
pub const ngx_http_v3_session_t = struct_ngx_http_v3_session_s;
pub const ngx_http_header_handler_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_table_elt_t, ngx_uint_t) callconv(.C) ngx_int_t;
pub const ngx_http_set_variable_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_variable_value_t, usize) callconv(.C) void;
pub const ngx_http_get_variable_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_variable_value_t, usize) callconv(.C) ngx_int_t;
pub const struct_ngx_http_variable_s = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    set_handler: ngx_http_set_variable_pt = @import("std").mem.zeroes(ngx_http_set_variable_pt),
    get_handler: ngx_http_get_variable_pt = @import("std").mem.zeroes(ngx_http_get_variable_pt),
    data: usize = @import("std").mem.zeroes(usize),
    flags: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_variable_t = struct_ngx_http_variable_s;
pub extern fn ngx_http_add_variable(cf: [*c]ngx_conf_t, name: [*c]ngx_str_t, flags: ngx_uint_t) [*c]ngx_http_variable_t;
pub extern fn ngx_http_get_variable_index(cf: [*c]ngx_conf_t, name: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_http_get_indexed_variable(r: [*c]ngx_http_request_t, index: ngx_uint_t) [*c]ngx_http_variable_value_t;
pub extern fn ngx_http_get_flushed_variable(r: [*c]ngx_http_request_t, index: ngx_uint_t) [*c]ngx_http_variable_value_t;
pub extern fn ngx_http_get_variable(r: [*c]ngx_http_request_t, name: [*c]ngx_str_t, key: ngx_uint_t) [*c]ngx_http_variable_value_t;
pub extern fn ngx_http_variable_unknown_header(r: [*c]ngx_http_request_t, v: [*c]ngx_http_variable_value_t, @"var": [*c]ngx_str_t, part: [*c]ngx_list_part_t, prefix: usize) ngx_int_t;
pub const ngx_http_regex_variable_t = extern struct {
    capture: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    index: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
};
pub const ngx_http_regex_t = extern struct {
    regex: ?*ngx_regex_t = @import("std").mem.zeroes(?*ngx_regex_t),
    ncaptures: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    variables: [*c]ngx_http_regex_variable_t = @import("std").mem.zeroes([*c]ngx_http_regex_variable_t),
    nvariables: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_http_map_regex_t = extern struct {
    regex: [*c]ngx_http_regex_t = @import("std").mem.zeroes([*c]ngx_http_regex_t),
    value: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub extern fn ngx_http_regex_compile(cf: [*c]ngx_conf_t, rc: [*c]ngx_regex_compile_t) [*c]ngx_http_regex_t;
pub extern fn ngx_http_regex_exec(r: [*c]ngx_http_request_t, re: [*c]ngx_http_regex_t, s: [*c]ngx_str_t) ngx_int_t;
pub const ngx_http_map_t = extern struct {
    hash: ngx_hash_combined_t = @import("std").mem.zeroes(ngx_hash_combined_t),
    regex: [*c]ngx_http_map_regex_t = @import("std").mem.zeroes([*c]ngx_http_map_regex_t),
    nregex: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_http_map_find(r: [*c]ngx_http_request_t, map: [*c]ngx_http_map_t, match: [*c]ngx_str_t) ?*anyopaque;
pub extern fn ngx_http_variables_add_core_vars(cf: [*c]ngx_conf_t) ngx_int_t;
pub extern fn ngx_http_variables_init_vars(cf: [*c]ngx_conf_t) ngx_int_t;
pub extern var ngx_http_variable_null_value: ngx_http_variable_value_t;
pub extern var ngx_http_variable_true_value: ngx_http_variable_value_t;
pub const ngx_http_conf_ctx_t = extern struct {
    main_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    srv_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    loc_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
};
pub const ngx_http_module_t = extern struct {
    preconfiguration: ?*const fn ([*c]ngx_conf_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t) callconv(.C) ngx_int_t),
    postconfiguration: ?*const fn ([*c]ngx_conf_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t) callconv(.C) ngx_int_t),
    create_main_conf: ?*const fn ([*c]ngx_conf_t) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t) callconv(.C) ?*anyopaque),
    init_main_conf: ?*const fn ([*c]ngx_conf_t, ?*anyopaque) callconv(.C) [*c]u8 = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t, ?*anyopaque) callconv(.C) [*c]u8),
    create_srv_conf: ?*const fn ([*c]ngx_conf_t) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t) callconv(.C) ?*anyopaque),
    merge_srv_conf: ?*const fn ([*c]ngx_conf_t, ?*anyopaque, ?*anyopaque) callconv(.C) [*c]u8 = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t, ?*anyopaque, ?*anyopaque) callconv(.C) [*c]u8),
    create_loc_conf: ?*const fn ([*c]ngx_conf_t) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t) callconv(.C) ?*anyopaque),
    merge_loc_conf: ?*const fn ([*c]ngx_conf_t, ?*anyopaque, ?*anyopaque) callconv(.C) [*c]u8 = @import("std").mem.zeroes(?*const fn ([*c]ngx_conf_t, ?*anyopaque, ?*anyopaque) callconv(.C) [*c]u8),
};
pub const NGX_HTTP_INITING_REQUEST_STATE: c_int = 0;
pub const NGX_HTTP_READING_REQUEST_STATE: c_int = 1;
pub const NGX_HTTP_PROCESS_REQUEST_STATE: c_int = 2;
pub const NGX_HTTP_CONNECT_UPSTREAM_STATE: c_int = 3;
pub const NGX_HTTP_WRITING_UPSTREAM_STATE: c_int = 4;
pub const NGX_HTTP_READING_UPSTREAM_STATE: c_int = 5;
pub const NGX_HTTP_WRITING_REQUEST_STATE: c_int = 6;
pub const NGX_HTTP_LINGERING_CLOSE_STATE: c_int = 7;
pub const NGX_HTTP_KEEPALIVE_STATE: c_int = 8;
pub const ngx_http_state_e = c_uint;
pub const ngx_http_header_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    offset: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    handler: ngx_http_header_handler_pt = @import("std").mem.zeroes(ngx_http_header_handler_pt),
};
pub const ngx_http_header_out_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    offset: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_headers_in_t = extern struct {
    headers: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    host: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    connection: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    if_modified_since: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    if_unmodified_since: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    if_match: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    if_none_match: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    user_agent: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    referer: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_length: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_range: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_type: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    range: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    if_range: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    transfer_encoding: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    te: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    expect: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    upgrade: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    accept_encoding: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    via: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    authorization: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    keep_alive: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    x_forwarded_for: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    cookie: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    user: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    passwd: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    server: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    content_length_n: off_t = @import("std").mem.zeroes(off_t),
    keep_alive_n: time_t = @import("std").mem.zeroes(time_t),
    flags: packed struct {
        connection_type: u2,
        chunked: bool,
        multi: bool,
        multi_linked: bool,
        msie: bool,
        msie6: bool,
        opera: bool,
        gecko: bool,
        chrome: bool,
        safari: bool,
        konqueror: bool,
        padding: u20,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_http_headers_out_t = extern struct {
    headers: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    trailers: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    status: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    status_line: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    server: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    date: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_length: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_encoding: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    location: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    refresh: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    last_modified: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_range: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    accept_ranges: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    www_authenticate: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    expires: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    etag: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    cache_control: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    link: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    override_charset: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    content_type_len: usize = @import("std").mem.zeroes(usize),
    content_type: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    charset: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    content_type_lowcase: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    content_type_hash: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    content_length_n: off_t = @import("std").mem.zeroes(off_t),
    content_offset: off_t = @import("std").mem.zeroes(off_t),
    date_time: time_t = @import("std").mem.zeroes(time_t),
    last_modified_time: time_t = @import("std").mem.zeroes(time_t),
};
pub const ngx_http_client_body_handler_pt = ?*const fn ([*c]ngx_http_request_t) callconv(.C) void;
pub const ngx_http_request_body_t = extern struct {
    temp_file: [*c]ngx_temp_file_t = @import("std").mem.zeroes([*c]ngx_temp_file_t),
    bufs: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    rest: off_t = @import("std").mem.zeroes(off_t),
    received: off_t = @import("std").mem.zeroes(off_t),
    free: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    busy: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    chunked: [*c]ngx_http_chunked_t = @import("std").mem.zeroes([*c]ngx_http_chunked_t),
    post_handler: ngx_http_client_body_handler_pt = @import("std").mem.zeroes(ngx_http_client_body_handler_pt),
    flags: packed struct {
        filter_need_buffering: bool,
        last_sent: bool,
        last_saved: bool,
        padding: u29,
    } = @import("std").mem.zeroes(c_uint),
};
pub const struct_ngx_http_addr_conf_s = extern struct {
    default_server: [*c]ngx_http_core_srv_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_srv_conf_t),
    virtual_names: [*c]ngx_http_virtual_names_t = @import("std").mem.zeroes([*c]ngx_http_virtual_names_t),
    flags: packed struct {
        ssl: bool,
        http2: bool,
        quic: bool,
        proxy_protocol: bool,
        padding: u28,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_http_addr_conf_t = struct_ngx_http_addr_conf_s;
pub const ngx_http_connection_t = extern struct {
    addr_conf: [*c]ngx_http_addr_conf_t = @import("std").mem.zeroes([*c]ngx_http_addr_conf_t),
    conf_ctx: [*c]ngx_http_conf_ctx_t = @import("std").mem.zeroes([*c]ngx_http_conf_ctx_t),
    busy: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    nbusy: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    free: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    flags: packed struct {
        ssl: bool,
        proxy_protocol: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
};
pub const ngx_http_post_subrequest_pt = ?*const fn ([*c]ngx_http_request_t, ?*anyopaque, ngx_int_t) callconv(.C) ngx_int_t;
pub const ngx_http_post_subrequest_t = extern struct {
    handler: ngx_http_post_subrequest_pt = @import("std").mem.zeroes(ngx_http_post_subrequest_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_http_ephemeral_t = extern struct {
    terminal_posted_request: ngx_http_posted_request_t = @import("std").mem.zeroes(ngx_http_posted_request_t),
};
pub const ngx_http_headers_in: [*c]ngx_http_header_t = @extern([*c]ngx_http_header_t, .{
    .name = "ngx_http_headers_in",
});
pub const ngx_http_headers_out: [*c]ngx_http_header_out_t = @extern([*c]ngx_http_header_out_t, .{
    .name = "ngx_http_headers_out",
});
pub const ngx_http_script_engine_t = extern struct {
    ip: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    pos: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    sp: [*c]ngx_http_variable_value_t = @import("std").mem.zeroes([*c]ngx_http_variable_value_t),
    buf: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    line: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    args: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    flags: packed struct {
        flushed: bool,
        skip: bool,
        quote: bool,
        is_args: bool,
        log: bool,
        padding: u27,
    } = @import("std").mem.zeros(c_uint),
    status: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    request: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
};
pub const ngx_http_script_compile_t = extern struct {
    cf: [*c]ngx_conf_t = @import("std").mem.zeroes([*c]ngx_conf_t),
    source: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    flushes: [*c][*c]ngx_array_t = @import("std").mem.zeroes([*c][*c]ngx_array_t),
    lengths: [*c][*c]ngx_array_t = @import("std").mem.zeroes([*c][*c]ngx_array_t),
    values: [*c][*c]ngx_array_t = @import("std").mem.zeroes([*c][*c]ngx_array_t),
    variables: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    ncaptures: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    captures_mask: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    main: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    flags: packed struct {
        compile_args: bool,
        complete_lengths: bool,
        complete_values: bool,
        zero: bool,
        conf_prefix: bool,
        root_prefix: bool,
        dup_capture: bool,
        args: bool,
        padding: u24,
    } = @import("std").mem.zeros(c_uint),
};
const union_unnamed_233 = extern union {
    size: usize,
};
pub const ngx_http_complex_value_t = extern struct {
    value: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    flushes: [*c]ngx_uint_t = @import("std").mem.zeroes([*c]ngx_uint_t),
    lengths: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    values: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    u: union_unnamed_233 = @import("std").mem.zeroes(union_unnamed_233),
};
pub const ngx_http_compile_complex_value_t = extern struct {
    cf: [*c]ngx_conf_t = @import("std").mem.zeroes([*c]ngx_conf_t),
    value: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    complex_value: [*c]ngx_http_complex_value_t = @import("std").mem.zeroes([*c]ngx_http_complex_value_t),
    flags: packed struct {
        zero: bool,
        conf_prefix: bool,
        root_prefix: bool,
        padding: u29,
    } = @import("std").mem.zeros(c_uint),
};
pub const ngx_http_script_code_pt = ?*const fn ([*c]ngx_http_script_engine_t) callconv(.C) void;
pub const ngx_http_script_len_code_pt = ?*const fn ([*c]ngx_http_script_engine_t) callconv(.C) usize;
pub const ngx_http_script_copy_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    len: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_http_script_var_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    index: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_http_script_var_handler_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    handler: ngx_http_set_variable_pt = @import("std").mem.zeroes(ngx_http_set_variable_pt),
    data: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_http_script_copy_capture_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    n: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_http_script_regex_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    regex: [*c]ngx_http_regex_t = @import("std").mem.zeroes([*c]ngx_http_regex_t),
    lengths: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    size: usize = @import("std").mem.zeroes(usize),
    status: usize = @import("std").mem.zeroes(usize),
    next: usize = @import("std").mem.zeroes(usize),
    flags: packed struct {
        @"test": bool,
        negative_test: bool,
        uri: bool,
        args: bool,
        add_args: bool,
        redirect: bool,
        break_cycle: bool,
        padding: u25,
    } = @import("std").mem.zeros(c_uint),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_http_script_regex_end_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    flags: packed struct {
        uri: bool,
        args: bool,
        add_args: bool,
        redirect: bool,
        padding: u28,
    } = @import("std").mem.zeros(c_uint),
};
pub const ngx_http_script_full_name_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    conf_prefix: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_http_script_return_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    status: usize = @import("std").mem.zeroes(usize),
    text: ngx_http_complex_value_t = @import("std").mem.zeroes(ngx_http_complex_value_t),
};
pub const ngx_http_script_file_plain: c_int = 0;
pub const ngx_http_script_file_not_plain: c_int = 1;
pub const ngx_http_script_file_dir: c_int = 2;
pub const ngx_http_script_file_not_dir: c_int = 3;
pub const ngx_http_script_file_exists: c_int = 4;
pub const ngx_http_script_file_not_exists: c_int = 5;
pub const ngx_http_script_file_exec: c_int = 6;
pub const ngx_http_script_file_not_exec: c_int = 7;
pub const ngx_http_script_file_op_e = c_uint;
pub const ngx_http_script_file_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    op: usize = @import("std").mem.zeroes(usize),
};
pub const ngx_http_script_if_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    next: usize = @import("std").mem.zeroes(usize),
    loc_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
};
pub const ngx_http_script_complex_value_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    lengths: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
};
pub const ngx_http_script_value_code_t = extern struct {
    code: ngx_http_script_code_pt = @import("std").mem.zeroes(ngx_http_script_code_pt),
    value: usize = @import("std").mem.zeroes(usize),
    text_len: usize = @import("std").mem.zeroes(usize),
    text_data: usize = @import("std").mem.zeroes(usize),
};
pub extern fn ngx_http_script_flush_complex_value(r: [*c]ngx_http_request_t, val: [*c]ngx_http_complex_value_t) void;
pub extern fn ngx_http_complex_value(r: [*c]ngx_http_request_t, val: [*c]ngx_http_complex_value_t, value: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_http_complex_value_size(r: [*c]ngx_http_request_t, val: [*c]ngx_http_complex_value_t, default_value: usize) usize;
pub extern fn ngx_http_compile_complex_value(ccv: [*c]ngx_http_compile_complex_value_t) ngx_int_t;
pub extern fn ngx_http_set_complex_value_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_set_complex_value_zero_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_set_complex_value_size_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_test_predicates(r: [*c]ngx_http_request_t, predicates: [*c]ngx_array_t) ngx_int_t;
pub extern fn ngx_http_test_required_predicates(r: [*c]ngx_http_request_t, predicates: [*c]ngx_array_t) ngx_int_t;
pub extern fn ngx_http_set_predicate_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_script_variables_count(value: [*c]ngx_str_t) ngx_uint_t;
pub extern fn ngx_http_script_compile(sc: [*c]ngx_http_script_compile_t) ngx_int_t;
pub extern fn ngx_http_script_run(r: [*c]ngx_http_request_t, value: [*c]ngx_str_t, code_lengths: ?*anyopaque, reserved: usize, code_values: ?*anyopaque) [*c]u_char;
pub extern fn ngx_http_script_flush_no_cacheable_variables(r: [*c]ngx_http_request_t, indices: [*c]ngx_array_t) void;
pub extern fn ngx_http_script_start_code(pool: [*c]ngx_pool_t, codes: [*c][*c]ngx_array_t, size: usize) ?*anyopaque;
pub extern fn ngx_http_script_add_code(codes: [*c]ngx_array_t, size: usize, code: ?*anyopaque) ?*anyopaque;
pub extern fn ngx_http_script_copy_len_code(e: [*c]ngx_http_script_engine_t) usize;
pub extern fn ngx_http_script_copy_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_copy_var_len_code(e: [*c]ngx_http_script_engine_t) usize;
pub extern fn ngx_http_script_copy_var_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_copy_capture_len_code(e: [*c]ngx_http_script_engine_t) usize;
pub extern fn ngx_http_script_copy_capture_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_mark_args_code(e: [*c]ngx_http_script_engine_t) usize;
pub extern fn ngx_http_script_start_args_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_regex_start_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_regex_end_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_return_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_break_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_if_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_equal_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_not_equal_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_file_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_complex_value_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_value_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_set_var_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_var_set_handler_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_var_code(e: [*c]ngx_http_script_engine_t) void;
pub extern fn ngx_http_script_nop_code(e: [*c]ngx_http_script_engine_t) void;
pub const ngx_event_actions_t = extern struct {
    add: ?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t),
    del: ?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t),
    enable: ?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t),
    disable: ?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_event_t, ngx_int_t, ngx_uint_t) callconv(.C) ngx_int_t),
    add_conn: ?*const fn ([*c]ngx_connection_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_connection_t) callconv(.C) ngx_int_t),
    del_conn: ?*const fn ([*c]ngx_connection_t, ngx_uint_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_connection_t, ngx_uint_t) callconv(.C) ngx_int_t),
    notify: ?*const fn (ngx_event_handler_pt) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn (ngx_event_handler_pt) callconv(.C) ngx_int_t),
    process_events: ?*const fn ([*c]ngx_cycle_t, ngx_msec_t, ngx_uint_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t, ngx_msec_t, ngx_uint_t) callconv(.C) ngx_int_t),
    init: ?*const fn ([*c]ngx_cycle_t, ngx_msec_t) callconv(.C) ngx_int_t = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t, ngx_msec_t) callconv(.C) ngx_int_t),
    done: ?*const fn ([*c]ngx_cycle_t) callconv(.C) void = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) void),
};
pub extern var ngx_event_actions: ngx_event_actions_t;
pub extern var ngx_use_epoll_rdhup: ngx_uint_t;
pub extern var ngx_io: ngx_os_io_t;
pub const ngx_event_conf_t = extern struct {
    connections: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    use: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    multi_accept: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    accept_mutex: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    accept_mutex_delay: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
};
pub const ngx_event_module_t = extern struct {
    name: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    create_conf: ?*const fn ([*c]ngx_cycle_t) callconv(.C) ?*anyopaque = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t) callconv(.C) ?*anyopaque),
    init_conf: ?*const fn ([*c]ngx_cycle_t, ?*anyopaque) callconv(.C) [*c]u8 = @import("std").mem.zeroes(?*const fn ([*c]ngx_cycle_t, ?*anyopaque) callconv(.C) [*c]u8),
    actions: ngx_event_actions_t = @import("std").mem.zeroes(ngx_event_actions_t),
};
pub extern var ngx_connection_counter: [*c]volatile ngx_atomic_t;
pub extern var ngx_accept_mutex_ptr: [*c]volatile ngx_atomic_t;
pub extern var ngx_accept_mutex: ngx_shmtx_t;
pub extern var ngx_use_accept_mutex: ngx_uint_t;
pub extern var ngx_accept_events: ngx_uint_t;
pub extern var ngx_accept_mutex_held: ngx_uint_t;
pub extern var ngx_accept_mutex_delay: ngx_msec_t;
pub extern var ngx_accept_disabled: ngx_int_t;
pub extern var ngx_use_exclusive_accept: ngx_uint_t;
pub extern var ngx_event_timer_alarm: sig_atomic_t;
pub extern var ngx_event_flags: ngx_uint_t;
pub extern var ngx_events_module: ngx_module_t;
pub extern var ngx_event_core_module: ngx_module_t;
pub extern fn ngx_event_accept(ev: [*c]ngx_event_t) void;
pub extern fn ngx_trylock_accept_mutex(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_enable_accept_events(cycle: [*c]ngx_cycle_t) ngx_int_t;
pub extern fn ngx_accept_log_error(log: [*c]ngx_log_t, buf: [*c]u_char, len: usize) [*c]u_char;
pub extern fn ngx_process_events_and_timers(cycle: [*c]ngx_cycle_t) void;
pub extern fn ngx_handle_read_event(rev: [*c]ngx_event_t, flags: ngx_uint_t) ngx_int_t;
pub extern fn ngx_handle_write_event(wev: [*c]ngx_event_t, lowat: usize) ngx_int_t;
pub extern fn ngx_send_lowat(c: [*c]ngx_connection_t, lowat: usize) ngx_int_t;
pub extern fn ngx_event_timer_init(log: [*c]ngx_log_t) ngx_int_t;
pub extern fn ngx_event_find_timer() ngx_msec_t;
pub extern fn ngx_event_expire_timers() void;
pub extern fn ngx_event_no_timers_left() ngx_int_t;
pub extern var ngx_event_timer_rbtree: ngx_rbtree_t;
pub fn ngx_event_del_timer(arg_ev: [*c]ngx_event_t) callconv(.C) void {
    var ev = arg_ev;
    _ = &ev;
    ngx_rbtree_delete(&ngx_event_timer_rbtree, &ev.*.timer);
}
pub extern fn ngx_event_process_posted(cycle: [*c]ngx_cycle_t, posted: [*c]ngx_queue_t) void;
pub extern fn ngx_event_move_posted_next(cycle: [*c]ngx_cycle_t) void;
pub extern var ngx_posted_accept_events: ngx_queue_t;
pub extern var ngx_posted_next_events: ngx_queue_t;
pub extern var ngx_posted_events: ngx_queue_t;
pub const ngx_addrinfo_t = extern union {
    pkt: struct_in_pktinfo,
    pkt6: struct_in6_pktinfo,
};
pub extern fn ngx_set_srcaddr_cmsg(cmsg: [*c]struct_cmsghdr, local_sockaddr: [*c]struct_sockaddr) usize;
pub extern fn ngx_get_srcaddr_cmsg(cmsg: [*c]struct_cmsghdr, local_sockaddr: [*c]struct_sockaddr) ngx_int_t;
pub extern fn ngx_event_recvmsg(ev: [*c]ngx_event_t) void;
pub extern fn ngx_sendmsg(c: [*c]ngx_connection_t, msg: [*c]struct_msghdr, flags: c_int) isize;
pub extern fn ngx_udp_rbtree_insert_value(temp: [*c]ngx_rbtree_node_t, node: [*c]ngx_rbtree_node_t, sentinel: [*c]ngx_rbtree_node_t) void;
pub extern fn ngx_delete_udp_connection(data: ?*anyopaque) void;
pub const ngx_event_set_peer_session_pt = ?*const fn ([*c]ngx_peer_connection_t, ?*anyopaque) callconv(.C) ngx_int_t;
pub const ngx_event_save_peer_session_pt = ?*const fn ([*c]ngx_peer_connection_t, ?*anyopaque) callconv(.C) void;
pub extern fn ngx_event_connect_peer(pc: [*c]ngx_peer_connection_t) ngx_int_t;
pub extern fn ngx_event_get_peer(pc: [*c]ngx_peer_connection_t, data: ?*anyopaque) ngx_int_t;
pub extern fn ngx_event_pipe(p: [*c]ngx_event_pipe_t, do_write: ngx_int_t) ngx_int_t;
pub extern fn ngx_event_pipe_copy_input_filter(p: [*c]ngx_event_pipe_t, buf: [*c]ngx_buf_t) ngx_int_t;
pub extern fn ngx_event_pipe_add_free_buf(p: [*c]ngx_event_pipe_t, b: [*c]ngx_buf_t) ngx_int_t;
pub const ngx_http_upstream_state_t = extern struct {
    status: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    response_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    connect_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    header_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    queue_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    response_length: off_t = @import("std").mem.zeroes(off_t),
    bytes_received: off_t = @import("std").mem.zeroes(off_t),
    bytes_sent: off_t = @import("std").mem.zeroes(off_t),
    peer: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
};
pub const ngx_http_upstream_main_conf_t = extern struct {
    headers_in_hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    upstreams: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
};
pub const ngx_http_upstream_init_pt = ?*const fn ([*c]ngx_conf_t, [*c]ngx_http_upstream_srv_conf_t) callconv(.C) ngx_int_t;
pub const ngx_http_upstream_init_peer_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_upstream_srv_conf_t) callconv(.C) ngx_int_t;
pub const ngx_http_upstream_peer_t = extern struct {
    init_upstream: ngx_http_upstream_init_pt = @import("std").mem.zeroes(ngx_http_upstream_init_pt),
    init: ngx_http_upstream_init_peer_pt = @import("std").mem.zeroes(ngx_http_upstream_init_peer_pt),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const ngx_http_upstream_server_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    addrs: [*c]ngx_addr_t = @import("std").mem.zeroes([*c]ngx_addr_t),
    naddrs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    weight: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    max_conns: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    max_fails: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    fail_timeout: time_t = @import("std").mem.zeroes(time_t),
    slow_start: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    down: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    host: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    service: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_http_upstream_local_t = extern struct {
    addr: [*c]ngx_addr_t = @import("std").mem.zeroes([*c]ngx_addr_t),
    value: [*c]ngx_http_complex_value_t = @import("std").mem.zeroes([*c]ngx_http_complex_value_t),
    transparent: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
// src/http/ngx_http_upstream.h:231:38: warning: struct demoted to opaque type - has bitfield
pub const ngx_http_upstream_conf_t = opaque {};
pub const ngx_http_upstream_header_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    handler: ngx_http_header_handler_pt = @import("std").mem.zeroes(ngx_http_header_handler_pt),
    offset: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    copy_handler: ngx_http_header_handler_pt = @import("std").mem.zeroes(ngx_http_header_handler_pt),
    conf: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    redirect: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_upstream_headers_in_t = extern struct {
    headers: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    trailers: ngx_list_t = @import("std").mem.zeroes(ngx_list_t),
    status_n: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    status_line: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    status: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    date: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    server: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    connection: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    expires: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    etag: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    x_accel_expires: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    x_accel_redirect: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    x_accel_limit_rate: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_type: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_length: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    last_modified: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    location: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    refresh: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    www_authenticate: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    transfer_encoding: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    vary: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    cache_control: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    set_cookie: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    content_length_n: off_t = @import("std").mem.zeroes(off_t),
    last_modified_time: time_t = @import("std").mem.zeroes(time_t),
};
pub const ngx_http_upstream_resolved_t = extern struct {
    host: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    port: in_port_t = @import("std").mem.zeroes(in_port_t),
    no_port: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    naddrs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    addrs: [*c]ngx_resolver_addr_t = @import("std").mem.zeroes([*c]ngx_resolver_addr_t),
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    ctx: [*c]ngx_resolver_ctx_t = @import("std").mem.zeroes([*c]ngx_resolver_ctx_t),
};
pub const ngx_http_upstream_next_t = extern struct {
    status: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    mask: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_upstream_param_t = extern struct {
    key: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    value: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    skip_empty: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_http_upstream_create(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_upstream_init(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_upstream_non_buffered_filter_init(data: ?*anyopaque) ngx_int_t;
pub extern fn ngx_http_upstream_non_buffered_filter(data: ?*anyopaque, bytes: isize) ngx_int_t;
pub extern fn ngx_http_upstream_add(cf: [*c]ngx_conf_t, u: [*c]ngx_url_t, flags: ngx_uint_t) [*c]ngx_http_upstream_srv_conf_t;
pub extern fn ngx_http_upstream_bind_set_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_upstream_param_set_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_upstream_hide_headers_hash(cf: [*c]ngx_conf_t, conf: ?*ngx_http_upstream_conf_t, prev: ?*ngx_http_upstream_conf_t, default_hide_headers: [*c]ngx_str_t, hash: [*c]ngx_hash_init_t) ngx_int_t;
pub extern var ngx_http_upstream_module: ngx_module_t;
pub const ngx_http_upstream_cache_method_mask: [*c]ngx_conf_bitmask_t = @extern([*c]ngx_conf_bitmask_t, .{
    .name = "ngx_http_upstream_cache_method_mask",
});
pub const ngx_http_upstream_ignore_headers_masks: [*c]ngx_conf_bitmask_t = @extern([*c]ngx_conf_bitmask_t, .{
    .name = "ngx_http_upstream_ignore_headers_masks",
});
pub const struct_ngx_http_upstream_rr_peer_s = extern struct {
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    server: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    current_weight: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    effective_weight: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    weight: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    conns: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    max_conns: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    fails: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    accessed: time_t = @import("std").mem.zeroes(time_t),
    checked: time_t = @import("std").mem.zeroes(time_t),
    max_fails: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    fail_timeout: time_t = @import("std").mem.zeroes(time_t),
    slow_start: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    start_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    down: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    lock: ngx_atomic_t = @import("std").mem.zeroes(ngx_atomic_t),
    refs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    host: [*c]ngx_http_upstream_host_t = @import("std").mem.zeroes([*c]ngx_http_upstream_host_t),
    next: [*c]ngx_http_upstream_rr_peer_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peer_t),
};
pub const ngx_http_upstream_rr_peer_t = struct_ngx_http_upstream_rr_peer_s;
pub const ngx_http_upstream_rr_peers_t = struct_ngx_http_upstream_rr_peers_s;
pub const struct_ngx_http_upstream_rr_peers_s = extern struct {
    number: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    shpool: [*c]ngx_slab_pool_t = @import("std").mem.zeroes([*c]ngx_slab_pool_t),
    rwlock: ngx_atomic_t = @import("std").mem.zeroes(ngx_atomic_t),
    config: [*c]ngx_uint_t = @import("std").mem.zeroes([*c]ngx_uint_t),
    resolve: [*c]ngx_http_upstream_rr_peer_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peer_t),
    zone_next: [*c]ngx_http_upstream_rr_peers_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peers_t),
    total_weight: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    tries: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    name: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    next: [*c]ngx_http_upstream_rr_peers_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peers_t),
    peer: [*c]ngx_http_upstream_rr_peer_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peer_t),
};
pub const ngx_http_upstream_host_t = extern struct {
    event: ngx_event_t = @import("std").mem.zeroes(ngx_event_t),
    worker: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    service: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    valid: time_t = @import("std").mem.zeroes(time_t),
    peers: [*c]ngx_http_upstream_rr_peers_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peers_t),
    peer: [*c]ngx_http_upstream_rr_peer_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peer_t),
};
pub const ngx_http_upstream_rr_peer_data_t = extern struct {
    config: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    peers: [*c]ngx_http_upstream_rr_peers_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peers_t),
    current: [*c]ngx_http_upstream_rr_peer_t = @import("std").mem.zeroes([*c]ngx_http_upstream_rr_peer_t),
    tried: [*c]usize = @import("std").mem.zeroes([*c]usize),
    data: usize = @import("std").mem.zeroes(usize),
};
pub extern fn ngx_http_upstream_init_round_robin(cf: [*c]ngx_conf_t, us: [*c]ngx_http_upstream_srv_conf_t) ngx_int_t;
pub extern fn ngx_http_upstream_init_round_robin_peer(r: [*c]ngx_http_request_t, us: [*c]ngx_http_upstream_srv_conf_t) ngx_int_t;
pub extern fn ngx_http_upstream_create_round_robin_peer(r: [*c]ngx_http_request_t, ur: [*c]ngx_http_upstream_resolved_t) ngx_int_t;
pub extern fn ngx_http_upstream_get_round_robin_peer(pc: [*c]ngx_peer_connection_t, data: ?*anyopaque) ngx_int_t;
pub extern fn ngx_http_upstream_free_round_robin_peer(pc: [*c]ngx_peer_connection_t, data: ?*anyopaque, state: ngx_uint_t) void;
pub const ngx_http_location_tree_node_t = struct_ngx_http_location_tree_node_s;
pub const struct_ngx_http_core_loc_conf_s = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    escaped_name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    regex: [*c]ngx_http_regex_t = @import("std").mem.zeroes([*c]ngx_http_regex_t),
    flags: packed struct {
        noname: bool,
        lmt_excpt: bool,
        named: bool,
        exact_match: bool,
        noregex: bool,
        auto_redirect: bool,
        gzip_disable_msie6: u2,
        gzip_disalbe_degradation: u2,
        padding: u22,
    } = @import("std").mem.zeroes(c_uint),
    static_locations: [*c]ngx_http_location_tree_node_t = @import("std").mem.zeroes([*c]ngx_http_location_tree_node_t),
    regex_locations: [*c][*c]ngx_http_core_loc_conf_t = @import("std").mem.zeroes([*c][*c]ngx_http_core_loc_conf_t),
    loc_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    limit_except: u32 = @import("std").mem.zeroes(u32),
    limit_except_loc_conf: [*c]?*anyopaque = @import("std").mem.zeroes([*c]?*anyopaque),
    handler: ngx_http_handler_pt = @import("std").mem.zeroes(ngx_http_handler_pt),
    alias: usize = @import("std").mem.zeroes(usize),
    root: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    post_action: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    root_lengths: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    root_values: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    types: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    types_hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    default_type: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    client_max_body_size: off_t = @import("std").mem.zeroes(off_t),
    directio: off_t = @import("std").mem.zeroes(off_t),
    directio_alignment: off_t = @import("std").mem.zeroes(off_t),
    client_body_buffer_size: usize = @import("std").mem.zeroes(usize),
    send_lowat: usize = @import("std").mem.zeroes(usize),
    postpone_output: usize = @import("std").mem.zeroes(usize),
    sendfile_max_chunk: usize = @import("std").mem.zeroes(usize),
    read_ahead: usize = @import("std").mem.zeroes(usize),
    subrequest_output_buffer_size: usize = @import("std").mem.zeroes(usize),
    limit_rate: [*c]ngx_http_complex_value_t = @import("std").mem.zeroes([*c]ngx_http_complex_value_t),
    limit_rate_after: [*c]ngx_http_complex_value_t = @import("std").mem.zeroes([*c]ngx_http_complex_value_t),
    client_body_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    send_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    keepalive_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    keepalive_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    lingering_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    lingering_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    resolver_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    auth_delay: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    resolver: [*c]ngx_resolver_t = @import("std").mem.zeroes([*c]ngx_resolver_t),
    keepalive_header: time_t = @import("std").mem.zeroes(time_t),
    keepalive_requests: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    keepalive_disable: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    satisfy: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    lingering_close: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    if_modified_since: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    max_ranges: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    client_body_in_file_only: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    client_body_in_single_buffer: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    internal: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    sendfile: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    aio: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    aio_write: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    tcp_nopush: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    tcp_nodelay: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    reset_timedout_connection: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    absolute_redirect: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    server_name_in_redirect: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    port_in_redirect: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    msie_padding: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    msie_refresh: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    log_not_found: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    log_subrequest: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    recursive_error_pages: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    server_tokens: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    chunked_transfer_encoding: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    etag: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    gzip_vary: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    gzip_http_version: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    gzip_proxied: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    gzip_disable: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    disable_symlinks: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    disable_symlinks_from: [*c]ngx_http_complex_value_t = @import("std").mem.zeroes([*c]ngx_http_complex_value_t),
    error_pages: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    client_body_temp_path: [*c]ngx_path_t = @import("std").mem.zeroes([*c]ngx_path_t),
    open_file_cache: [*c]ngx_open_file_cache_t = @import("std").mem.zeroes([*c]ngx_open_file_cache_t),
    open_file_cache_valid: time_t = @import("std").mem.zeroes(time_t),
    open_file_cache_min_uses: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    open_file_cache_errors: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    open_file_cache_events: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    error_log: [*c]ngx_log_t = @import("std").mem.zeroes([*c]ngx_log_t),
    types_hash_max_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    types_hash_bucket_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    locations: [*c]ngx_queue_t = @import("std").mem.zeroes([*c]ngx_queue_t),
};
pub const ngx_http_core_loc_conf_t = struct_ngx_http_core_loc_conf_s;
pub const struct_ngx_http_location_tree_node_s = extern struct {
    left: [*c]ngx_http_location_tree_node_t = @import("std").mem.zeroes([*c]ngx_http_location_tree_node_t),
    right: [*c]ngx_http_location_tree_node_t = @import("std").mem.zeroes([*c]ngx_http_location_tree_node_t),
    tree: [*c]ngx_http_location_tree_node_t = @import("std").mem.zeroes([*c]ngx_http_location_tree_node_t),
    exact: [*c]ngx_http_core_loc_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_loc_conf_t),
    inclusive: [*c]ngx_http_core_loc_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_loc_conf_t),
    len: u_short = @import("std").mem.zeroes(u_short),
    auto_redirect: u_char = @import("std").mem.zeroes(u_char),
    name: [1]u_char = @import("std").mem.zeroes([1]u_char),
};
pub const ngx_http_listen_opt_t = extern struct {
    sockaddr: [*c]struct_sockaddr = @import("std").mem.zeroes([*c]struct_sockaddr),
    socklen: socklen_t = @import("std").mem.zeroes(socklen_t),
    addr_text: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    flags: packed struct {
        set: bool,
        default_server: bool,
        bind: bool,
        wildcard: bool,
        ssl: bool,
        http2: bool,
        quic: bool,
        ipv6only: bool,
        deferred_accept: bool,
        reuseport: bool,
        so_keepalive: u2,
        proxy_protocol: bool,
        padding: u19,
    } = @import("std").mem.zeroes(c_uint),
    backlog: c_int = @import("std").mem.zeroes(c_int),
    rcvbuf: c_int = @import("std").mem.zeroes(c_int),
    sndbuf: c_int = @import("std").mem.zeroes(c_int),
    type: c_int = @import("std").mem.zeroes(c_int),
    fastopen: c_int = @import("std").mem.zeroes(c_int),
    tcp_keepidle: c_int = @import("std").mem.zeroes(c_int),
    tcp_keepintvl: c_int = @import("std").mem.zeroes(c_int),
    tcp_keepcnt: c_int = @import("std").mem.zeroes(c_int),
};
pub const NGX_HTTP_POST_READ_PHASE: c_int = 0;
pub const NGX_HTTP_SERVER_REWRITE_PHASE: c_int = 1;
pub const NGX_HTTP_FIND_CONFIG_PHASE: c_int = 2;
pub const NGX_HTTP_REWRITE_PHASE: c_int = 3;
pub const NGX_HTTP_POST_REWRITE_PHASE: c_int = 4;
pub const NGX_HTTP_PREACCESS_PHASE: c_int = 5;
pub const NGX_HTTP_ACCESS_PHASE: c_int = 6;
pub const NGX_HTTP_POST_ACCESS_PHASE: c_int = 7;
pub const NGX_HTTP_PRECONTENT_PHASE: c_int = 8;
pub const NGX_HTTP_CONTENT_PHASE: c_int = 9;
pub const NGX_HTTP_LOG_PHASE: c_int = 10;
pub const ngx_http_phases = c_uint;
pub const ngx_http_phase_handler_t = struct_ngx_http_phase_handler_s;
pub const ngx_http_phase_handler_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_phase_handler_t) callconv(.C) ngx_int_t;
pub const struct_ngx_http_phase_handler_s = extern struct {
    checker: ngx_http_phase_handler_pt = @import("std").mem.zeroes(ngx_http_phase_handler_pt),
    handler: ngx_http_handler_pt = @import("std").mem.zeroes(ngx_http_handler_pt),
    next: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_phase_engine_t = extern struct {
    handlers: [*c]ngx_http_phase_handler_t = @import("std").mem.zeroes([*c]ngx_http_phase_handler_t),
    server_rewrite_index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    location_rewrite_index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_phase_t = extern struct {
    handlers: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
};
pub const ngx_http_core_main_conf_t = extern struct {
    servers: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    phase_engine: ngx_http_phase_engine_t = @import("std").mem.zeroes(ngx_http_phase_engine_t),
    headers_in_hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    variables_hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    variables: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    prefix_variables: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    ncaptures: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    server_names_hash_max_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    server_names_hash_bucket_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    variables_hash_max_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    variables_hash_bucket_size: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    variables_keys: [*c]ngx_hash_keys_arrays_t = @import("std").mem.zeroes([*c]ngx_hash_keys_arrays_t),
    ports: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    phases: [11]ngx_http_phase_t = @import("std").mem.zeroes([11]ngx_http_phase_t),
};
pub const ngx_http_core_srv_conf_t = extern struct {
    server_names: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    ctx: [*c]ngx_http_conf_ctx_t = @import("std").mem.zeroes([*c]ngx_http_conf_ctx_t),
    file_name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    line: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    server_name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    connection_pool_size: usize = @import("std").mem.zeroes(usize),
    request_pool_size: usize = @import("std").mem.zeroes(usize),
    client_header_buffer_size: usize = @import("std").mem.zeroes(usize),
    large_client_header_buffers: ngx_bufs_t = @import("std").mem.zeroes(ngx_bufs_t),
    client_header_timeout: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
    ignore_invalid_headers: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    merge_slashes: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    underscores_in_headers: ngx_flag_t = @import("std").mem.zeroes(ngx_flag_t),
    flags: packed struct {
        listen: bool,
        captures: bool,
        padding: u30,
    } = @import("std").mem.zeroes(c_uint),
    named_locations: [*c][*c]ngx_http_core_loc_conf_t = @import("std").mem.zeroes([*c][*c]ngx_http_core_loc_conf_t),
};
pub const ngx_http_server_name_t = extern struct {
    regex: [*c]ngx_http_regex_t = @import("std").mem.zeroes([*c]ngx_http_regex_t),
    server: [*c]ngx_http_core_srv_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_srv_conf_t),
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_http_virtual_names_t = extern struct {
    names: ngx_hash_combined_t = @import("std").mem.zeroes(ngx_hash_combined_t),
    nregex: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    regex: [*c]ngx_http_server_name_t = @import("std").mem.zeroes([*c]ngx_http_server_name_t),
};
pub const ngx_http_in_addr_t = extern struct {
    addr: in_addr_t = @import("std").mem.zeroes(in_addr_t),
    conf: ngx_http_addr_conf_t = @import("std").mem.zeroes(ngx_http_addr_conf_t),
};
pub const ngx_http_in6_addr_t = extern struct {
    addr6: struct_in6_addr = @import("std").mem.zeroes(struct_in6_addr),
    conf: ngx_http_addr_conf_t = @import("std").mem.zeroes(ngx_http_addr_conf_t),
};
pub const ngx_http_port_t = extern struct {
    addrs: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    naddrs: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_conf_port_t = extern struct {
    family: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    type: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    port: in_port_t = @import("std").mem.zeroes(in_port_t),
    addrs: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
};
pub const ngx_http_conf_addr_t = extern struct {
    opt: ngx_http_listen_opt_t = @import("std").mem.zeroes(ngx_http_listen_opt_t),
    flags: packed struct {
        protocols: u3,
        protocols_set: bool,
        protocols_changed: bool,
        padding: u27,
    } = @import("std").mem.zeroes(c_uint),
    hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    wc_head: [*c]ngx_hash_wildcard_t = @import("std").mem.zeroes([*c]ngx_hash_wildcard_t),
    wc_tail: [*c]ngx_hash_wildcard_t = @import("std").mem.zeroes([*c]ngx_hash_wildcard_t),
    nregex: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    regex: [*c]ngx_http_server_name_t = @import("std").mem.zeroes([*c]ngx_http_server_name_t),
    default_server: [*c]ngx_http_core_srv_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_srv_conf_t),
    servers: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
};
pub const ngx_http_err_page_t = extern struct {
    status: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    overwrite: ngx_int_t = @import("std").mem.zeroes(ngx_int_t),
    value: ngx_http_complex_value_t = @import("std").mem.zeroes(ngx_http_complex_value_t),
    args: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_http_location_queue_t = extern struct {
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    exact: [*c]ngx_http_core_loc_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_loc_conf_t),
    inclusive: [*c]ngx_http_core_loc_conf_t = @import("std").mem.zeroes([*c]ngx_http_core_loc_conf_t),
    name: [*c]ngx_str_t = @import("std").mem.zeroes([*c]ngx_str_t),
    file_name: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    line: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    list: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
};
pub extern fn ngx_http_core_run_phases(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_core_generic_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_core_rewrite_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_core_find_config_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_core_post_rewrite_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_core_access_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_core_post_access_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_core_content_phase(r: [*c]ngx_http_request_t, ph: [*c]ngx_http_phase_handler_t) ngx_int_t;
pub extern fn ngx_http_test_content_type(r: [*c]ngx_http_request_t, types_hash: [*c]ngx_hash_t) ?*anyopaque;
pub extern fn ngx_http_set_content_type(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_set_exten(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_set_etag(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_weak_etag(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_send_response(r: [*c]ngx_http_request_t, status: ngx_uint_t, ct: [*c]ngx_str_t, cv: [*c]ngx_http_complex_value_t) ngx_int_t;
pub extern fn ngx_http_map_uri_to_path(r: [*c]ngx_http_request_t, name: [*c]ngx_str_t, root_length: [*c]usize, reserved: usize) [*c]u_char;
pub extern fn ngx_http_auth_basic_user(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_gzip_ok(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_subrequest(r: [*c]ngx_http_request_t, uri: [*c]ngx_str_t, args: [*c]ngx_str_t, psr: [*c][*c]ngx_http_request_t, ps: [*c]ngx_http_post_subrequest_t, flags: ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_internal_redirect(r: [*c]ngx_http_request_t, uri: [*c]ngx_str_t, args: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_http_named_location(r: [*c]ngx_http_request_t, name: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_http_cleanup_add(r: [*c]ngx_http_request_t, size: usize) [*c]ngx_http_cleanup_t;
pub const ngx_http_output_header_filter_pt = ?*const fn ([*c]ngx_http_request_t) callconv(.C) ngx_int_t;
pub const ngx_http_output_body_filter_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_chain_t) callconv(.C) ngx_int_t;
pub const ngx_http_request_body_filter_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_chain_t) callconv(.C) ngx_int_t;
pub extern fn ngx_http_output_filter(r: [*c]ngx_http_request_t, chain: [*c]ngx_chain_t) ngx_int_t;
pub extern fn ngx_http_write_filter(r: [*c]ngx_http_request_t, chain: [*c]ngx_chain_t) ngx_int_t;
pub extern fn ngx_http_request_body_save_filter(r: [*c]ngx_http_request_t, chain: [*c]ngx_chain_t) ngx_int_t;
pub extern fn ngx_http_set_disable_symlinks(r: [*c]ngx_http_request_t, clcf: [*c]ngx_http_core_loc_conf_t, path: [*c]ngx_str_t, of: [*c]ngx_open_file_info_t) ngx_int_t;
pub extern fn ngx_http_get_forwarded_addr(r: [*c]ngx_http_request_t, addr: [*c]ngx_addr_t, headers: [*c]ngx_table_elt_t, value: [*c]ngx_str_t, proxies: [*c]ngx_array_t, recursive: c_int) ngx_int_t;
pub extern fn ngx_http_link_multi_headers(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern var ngx_http_core_module: ngx_module_t;
pub extern var ngx_http_max_module: ngx_uint_t;
pub extern var ngx_http_core_get_method: ngx_str_t;
pub const ngx_http_cache_valid_t = extern struct {
    status: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    valid: time_t = @import("std").mem.zeroes(time_t),
};
pub const ngx_http_file_cache_node_t = extern struct {
    node: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    key: [8]u_char = @import("std").mem.zeroes([8]u_char),
    flags: packed struct {
        count: u20,
        uses: u10,
        valid_msec: u10,
        @"error": u10,
        exists: bool,
        updating: bool,
        deleting: bool,
        purged: bool,
        padding: u10,
    } = @import("std").mem.zeroes(c_ulong),
    uniq: ngx_file_uniq_t = @import("std").mem.zeroes(ngx_file_uniq_t),
    expire: time_t = @import("std").mem.zeroes(time_t),
    valid_sec: time_t = @import("std").mem.zeroes(time_t),
    body_start: usize = @import("std").mem.zeroes(usize),
    fs_size: off_t = @import("std").mem.zeroes(off_t),
    lock_time: ngx_msec_t = @import("std").mem.zeroes(ngx_msec_t),
};
pub const ngx_http_file_cache_header_t = extern struct {
    version: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    valid_sec: time_t = @import("std").mem.zeroes(time_t),
    updating_sec: time_t = @import("std").mem.zeroes(time_t),
    error_sec: time_t = @import("std").mem.zeroes(time_t),
    last_modified: time_t = @import("std").mem.zeroes(time_t),
    date: time_t = @import("std").mem.zeroes(time_t),
    crc32: u32 = @import("std").mem.zeroes(u32),
    valid_msec: u_short = @import("std").mem.zeroes(u_short),
    header_start: u_short = @import("std").mem.zeroes(u_short),
    body_start: u_short = @import("std").mem.zeroes(u_short),
    etag_len: u_char = @import("std").mem.zeroes(u_char),
    etag: [128]u_char = @import("std").mem.zeroes([128]u_char),
    vary_len: u_char = @import("std").mem.zeroes(u_char),
    vary: [128]u_char = @import("std").mem.zeroes([128]u_char),
    variant: [16]u_char = @import("std").mem.zeroes([16]u_char),
};
pub const ngx_http_file_cache_sh_t = extern struct {
    rbtree: ngx_rbtree_t = @import("std").mem.zeroes(ngx_rbtree_t),
    sentinel: ngx_rbtree_node_t = @import("std").mem.zeroes(ngx_rbtree_node_t),
    queue: ngx_queue_t = @import("std").mem.zeroes(ngx_queue_t),
    cold: ngx_atomic_t = @import("std").mem.zeroes(ngx_atomic_t),
    loading: ngx_atomic_t = @import("std").mem.zeroes(ngx_atomic_t),
    size: off_t = @import("std").mem.zeroes(off_t),
    count: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    watermark: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub extern fn ngx_http_file_cache_new(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_file_cache_create(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_file_cache_create_key(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_file_cache_open(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_file_cache_set_header(r: [*c]ngx_http_request_t, buf: [*c]u_char) ngx_int_t;
pub extern fn ngx_http_file_cache_update(r: [*c]ngx_http_request_t, tf: [*c]ngx_temp_file_t) void;
pub extern fn ngx_http_file_cache_update_header(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_cache_send([*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_file_cache_free(c: [*c]ngx_http_cache_t, tf: [*c]ngx_temp_file_t) void;
pub extern fn ngx_http_file_cache_valid(cache_valid: [*c]ngx_array_t, status: ngx_uint_t) time_t;
pub extern fn ngx_http_file_cache_set_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_file_cache_valid_set_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub const ngx_http_cache_status: [*c]ngx_str_t = @extern([*c]ngx_str_t, .{
    .name = "ngx_http_cache_status",
});
pub const ngx_http_ssi_main_conf_t = extern struct {
    hash: ngx_hash_t = @import("std").mem.zeroes(ngx_hash_t),
    commands: ngx_hash_keys_arrays_t = @import("std").mem.zeroes(ngx_hash_keys_arrays_t),
};
pub const ngx_http_ssi_ctx_t = extern struct {
    buf: [*c]ngx_buf_t = @import("std").mem.zeroes([*c]ngx_buf_t),
    pos: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    copy_start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    copy_end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    key: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    command: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    params: ngx_array_t = @import("std").mem.zeroes(ngx_array_t),
    param: [*c]ngx_table_elt_t = @import("std").mem.zeroes([*c]ngx_table_elt_t),
    params_array: [4]ngx_table_elt_t = @import("std").mem.zeroes([4]ngx_table_elt_t),
    in: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    out: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    last_out: [*c][*c]ngx_chain_t = @import("std").mem.zeroes([*c][*c]ngx_chain_t),
    busy: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    free: [*c]ngx_chain_t = @import("std").mem.zeroes([*c]ngx_chain_t),
    state: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    saved_state: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    saved: usize = @import("std").mem.zeroes(usize),
    looked: usize = @import("std").mem.zeroes(usize),
    value_len: usize = @import("std").mem.zeroes(usize),
    variables: [*c]ngx_list_t = @import("std").mem.zeroes([*c]ngx_list_t),
    blocks: [*c]ngx_array_t = @import("std").mem.zeroes([*c]ngx_array_t),
    ncaptures: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    captures: [*c]c_int = @import("std").mem.zeroes([*c]c_int),
    captures_data: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    wait: [*c]ngx_http_request_t = @import("std").mem.zeroes([*c]ngx_http_request_t),
    value_buf: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    timefmt: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    errmsg: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
};
pub const ngx_http_ssi_command_pt = ?*const fn ([*c]ngx_http_request_t, [*c]ngx_http_ssi_ctx_t, [*c][*c]ngx_str_t) callconv(.C) ngx_int_t;
pub const ngx_http_ssi_param_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    index: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
};
pub const ngx_http_ssi_command_t = extern struct {
    name: ngx_str_t = @import("std").mem.zeroes(ngx_str_t),
    handler: ngx_http_ssi_command_pt = @import("std").mem.zeroes(ngx_http_ssi_command_pt),
    params: [*c]ngx_http_ssi_param_t = @import("std").mem.zeroes([*c]ngx_http_ssi_param_t),
};
pub extern var ngx_http_ssi_filter_module: ngx_module_t;
pub const ngx_http_status_t = extern struct {
    http_version: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    code: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    count: ngx_uint_t = @import("std").mem.zeroes(ngx_uint_t),
    start: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
    end: [*c]u_char = @import("std").mem.zeroes([*c]u_char),
};
pub extern fn ngx_http_add_location(cf: [*c]ngx_conf_t, locations: [*c][*c]ngx_queue_t, clcf: [*c]ngx_http_core_loc_conf_t) ngx_int_t;
pub extern fn ngx_http_add_listen(cf: [*c]ngx_conf_t, cscf: [*c]ngx_http_core_srv_conf_t, lsopt: [*c]ngx_http_listen_opt_t) ngx_int_t;
pub extern fn ngx_http_init_connection(c: [*c]ngx_connection_t) void;
pub extern fn ngx_http_close_connection(c: [*c]ngx_connection_t) void;
pub extern fn ngx_http_parse_request_line(r: [*c]ngx_http_request_t, b: [*c]ngx_buf_t) ngx_int_t;
pub extern fn ngx_http_parse_uri(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_parse_complex_uri(r: [*c]ngx_http_request_t, merge_slashes: ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_parse_status_line(r: [*c]ngx_http_request_t, b: [*c]ngx_buf_t, status: [*c]ngx_http_status_t) ngx_int_t;
pub extern fn ngx_http_parse_unsafe_uri(r: [*c]ngx_http_request_t, uri: [*c]ngx_str_t, args: [*c]ngx_str_t, flags: [*c]ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_parse_header_line(r: [*c]ngx_http_request_t, b: [*c]ngx_buf_t, allow_underscores: ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_parse_multi_header_lines(r: [*c]ngx_http_request_t, headers: [*c]ngx_table_elt_t, name: [*c]ngx_str_t, value: [*c]ngx_str_t) [*c]ngx_table_elt_t;
pub extern fn ngx_http_parse_set_cookie_lines(r: [*c]ngx_http_request_t, headers: [*c]ngx_table_elt_t, name: [*c]ngx_str_t, value: [*c]ngx_str_t) [*c]ngx_table_elt_t;
pub extern fn ngx_http_arg(r: [*c]ngx_http_request_t, name: [*c]u_char, len: usize, value: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_http_split_args(r: [*c]ngx_http_request_t, uri: [*c]ngx_str_t, args: [*c]ngx_str_t) void;
pub extern fn ngx_http_parse_chunked(r: [*c]ngx_http_request_t, b: [*c]ngx_buf_t, ctx: [*c]ngx_http_chunked_t, keep_trailers: ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_create_request(c: [*c]ngx_connection_t) [*c]ngx_http_request_t;
pub extern fn ngx_http_process_request_uri(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_process_request_header(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_process_request(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_update_location_config(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_handler(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_run_posted_requests(c: [*c]ngx_connection_t) void;
pub extern fn ngx_http_post_request(r: [*c]ngx_http_request_t, pr: [*c]ngx_http_posted_request_t) ngx_int_t;
pub extern fn ngx_http_set_virtual_server(r: [*c]ngx_http_request_t, host: [*c]ngx_str_t) ngx_int_t;
pub extern fn ngx_http_validate_host(host: [*c]ngx_str_t, pool: [*c]ngx_pool_t, alloc: ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_close_request(r: [*c]ngx_http_request_t, rc: ngx_int_t) void;
pub extern fn ngx_http_finalize_request(r: [*c]ngx_http_request_t, rc: ngx_int_t) void;
pub extern fn ngx_http_free_request(r: [*c]ngx_http_request_t, rc: ngx_int_t) void;
pub extern fn ngx_http_empty_handler(wev: [*c]ngx_event_t) void;
pub extern fn ngx_http_request_empty_handler(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_send_special(r: [*c]ngx_http_request_t, flags: ngx_uint_t) ngx_int_t;
pub extern fn ngx_http_read_client_request_body(r: [*c]ngx_http_request_t, post_handler: ngx_http_client_body_handler_pt) ngx_int_t;
pub extern fn ngx_http_read_unbuffered_request_body(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_send_header(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_special_response_handler(r: [*c]ngx_http_request_t, @"error": ngx_int_t) ngx_int_t;
pub extern fn ngx_http_filter_finalize_request(r: [*c]ngx_http_request_t, m: [*c]ngx_module_t, @"error": ngx_int_t) ngx_int_t;
pub extern fn ngx_http_clean_header(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_discard_request_body(r: [*c]ngx_http_request_t) ngx_int_t;
pub extern fn ngx_http_discarded_request_body_handler(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_block_reading(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_test_reading(r: [*c]ngx_http_request_t) void;
pub extern fn ngx_http_types_slot(cf: [*c]ngx_conf_t, cmd: [*c]ngx_command_t, conf: ?*anyopaque) [*c]u8;
pub extern fn ngx_http_merge_types(cf: [*c]ngx_conf_t, keys: [*c][*c]ngx_array_t, types_hash: [*c]ngx_hash_t, prev_keys: [*c][*c]ngx_array_t, prev_types_hash: [*c]ngx_hash_t, default_types: [*c]ngx_str_t) [*c]u8;
pub extern fn ngx_http_set_default_types(cf: [*c]ngx_conf_t, types: [*c][*c]ngx_array_t, default_type: [*c]ngx_str_t) ngx_int_t;
pub extern var ngx_http_module: ngx_module_t;
pub const ngx_http_html_default_types: [*c]ngx_str_t = @extern([*c]ngx_str_t, .{
    .name = "ngx_http_html_default_types",
});
pub extern var ngx_http_top_header_filter: ngx_http_output_header_filter_pt;
pub extern var ngx_http_top_body_filter: ngx_http_output_body_filter_pt;
pub extern var ngx_http_top_request_body_filter: ngx_http_request_body_filter_pt;
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 18);
pub const __clang_minor__ = @as(c_int, 1);
pub const __clang_patchlevel__ = @as(c_int, 6);
pub const __clang_version__ = "18.1.6 (https://github.com/ziglang/zig-bootstrap 98bc6bf4fc4009888d33941daf6b600d20a42a56)";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __MEMORY_SCOPE_SYSTEM = @as(c_int, 0);
pub const __MEMORY_SCOPE_DEVICE = @as(c_int, 1);
pub const __MEMORY_SCOPE_WRKGRP = @as(c_int, 2);
pub const __MEMORY_SCOPE_WVFRNT = @as(c_int, 3);
pub const __MEMORY_SCOPE_SINGLE = @as(c_int, 4);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __FPCLASS_SNAN = @as(c_int, 0x0001);
pub const __FPCLASS_QNAN = @as(c_int, 0x0002);
pub const __FPCLASS_NEGINF = @as(c_int, 0x0004);
pub const __FPCLASS_NEGNORMAL = @as(c_int, 0x0008);
pub const __FPCLASS_NEGSUBNORMAL = @as(c_int, 0x0010);
pub const __FPCLASS_NEGZERO = @as(c_int, 0x0020);
pub const __FPCLASS_POSZERO = @as(c_int, 0x0040);
pub const __FPCLASS_POSSUBNORMAL = @as(c_int, 0x0080);
pub const __FPCLASS_POSNORMAL = @as(c_int, 0x0100);
pub const __FPCLASS_POSINF = @as(c_int, 0x0200);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 18.1.6 (https://github.com/ziglang/zig-bootstrap 98bc6bf4fc4009888d33941daf6b600d20a42a56)";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 8);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 8388608, .decimal);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_FMTd__ = "ld";
pub const __INTMAX_FMTi__ = "li";
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):95:9
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_FMTo__ = "lo";
pub const __UINTMAX_FMTu__ = "lu";
pub const __UINTMAX_FMTx__ = "lx";
pub const __UINTMAX_FMTX__ = "lX";
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):101:9
pub const __PTRDIFF_TYPE__ = c_long;
pub const __PTRDIFF_FMTd__ = "ld";
pub const __PTRDIFF_FMTi__ = "li";
pub const __INTPTR_TYPE__ = c_long;
pub const __INTPTR_FMTd__ = "ld";
pub const __INTPTR_FMTi__ = "li";
pub const __SIZE_TYPE__ = c_ulong;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZE_FMTx__ = "lx";
pub const __SIZE_FMTX__ = "lX";
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __UINTPTR_FMTo__ = "lo";
pub const __UINTPTR_FMTu__ = "lu";
pub const __UINTPTR_FMTx__ = "lx";
pub const __UINTPTR_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):198:9
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// (no file):220:9
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):228:9
pub const __UINT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "ld";
pub const __INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_LEAST64_FMTo__ = "lo";
pub const __UINT_LEAST64_FMTu__ = "lu";
pub const __UINT_LEAST64_FMTx__ = "lx";
pub const __UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "ld";
pub const __INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_FAST64_FMTo__ = "lo";
pub const __UINT_FAST64_FMTu__ = "lu";
pub const __UINT_FAST64_FMTx__ = "lx";
pub const __UINT_FAST64_FMTX__ = "lX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __PIE__ = @as(c_int, 2);
pub const __pie__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __ELF__ = @as(c_int, 1);
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):359:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):360:9
pub const __corei7 = @as(c_int, 1);
pub const __corei7__ = @as(c_int, 1);
pub const __tune_corei7__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const __gnu_linux__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const _DEBUG = @as(c_int, 1);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const _NGX_HTTP_H_INCLUDED_ = "";
pub const _NGX_CONFIG_H_INCLUDED_ = "";
pub const NGX_HAVE_UNISTD_H = @as(c_int, 1);
pub const NGX_HAVE_INTTYPES_H = @as(c_int, 1);
pub const NGX_HAVE_LIMITS_H = @as(c_int, 1);
pub const NGX_HAVE_SYS_PARAM_H = @as(c_int, 1);
pub const NGX_HAVE_SYS_MOUNT_H = @as(c_int, 1);
pub const NGX_HAVE_SYS_STATVFS_H = @as(c_int, 1);
pub const NGX_HAVE_CRYPT_H = @as(c_int, 1);
pub const NGX_LINUX = @as(c_int, 1);
pub const NGX_HAVE_SYS_PRCTL_H = @as(c_int, 1);
pub const NGX_HAVE_SYS_VFS_H = @as(c_int, 1);
pub const _NGX_LINUX_CONFIG_H_INCLUDED_ = "";
pub const _GNU_SOURCE = "";
pub const _FILE_OFFSET_BITS = @as(c_int, 64);
pub const _SYS_TYPES_H = @as(c_int, 1);
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(((__clang_major__ << @as(c_int, 16)) + __clang_minor__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__clang_major__ << @as(c_int, 16)) + __clang_minor__) >= ((maj << @as(c_int, 16)) + min);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`");
// /usr/include/features.h:189:9
pub const _ISOC95_SOURCE = @as(c_int, 1);
pub const _ISOC99_SOURCE = @as(c_int, 1);
pub const _ISOC11_SOURCE = @as(c_int, 1);
pub const _ISOC23_SOURCE = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const _XOPEN_SOURCE = @as(c_int, 700);
pub const _XOPEN_SOURCE_EXTENDED = @as(c_int, 1);
pub const _LARGEFILE64_SOURCE = @as(c_int, 1);
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const _DYNAMIC_STACK_SIZE_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC23 = @as(c_int, 1);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const __USE_XOPEN = @as(c_int, 1);
pub const __USE_XOPEN_EXTENDED = @as(c_int, 1);
pub const __USE_UNIX98 = @as(c_int, 1);
pub const _LARGEFILE_SOURCE = @as(c_int, 1);
pub const __USE_XOPEN2K8XSI = @as(c_int, 1);
pub const __USE_XOPEN2KXSI = @as(c_int, 1);
pub const __USE_LARGEFILE = @as(c_int, 1);
pub const __USE_LARGEFILE64 = @as(c_int, 1);
pub const __USE_FILE_OFFSET64 = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_TIME_BITS64 = @as(c_int, 1);
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_DYNAMIC_STACK_SIZE = @as(c_int, 1);
pub const __USE_GNU = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const __GLIBC_USE_C23_STRTOL = @as(c_int, 1);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 40);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`");
// /usr/include/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__has_builtin(name)) {
    _ = &name;
    return __has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`");
// /usr/include/sys/cdefs.h:55:10
pub const __LEAF = "";
pub const __LEAF_ATTR = "";
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/sys/cdefs.h:82:11
pub const __COLD = @compileError("unable to translate macro: undefined identifier `__cold__`");
// /usr/include/sys/cdefs.h:102:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'");
// /usr/include/sys/cdefs.h:131:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token '#'");
// /usr/include/sys/cdefs.h:132:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub const __attribute_overloadable__ = @compileError("unable to translate macro: undefined identifier `__overloadable__`");
// /usr/include/sys/cdefs.h:151:10
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin_object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin_object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin_object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin_object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:370:10
pub const __errordecl = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/sys/cdefs.h:371:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['");
// /usr/include/sys/cdefs.h:379:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/sys/cdefs.h:410:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/sys/cdefs.h:417:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/sys/cdefs.h:419:11
pub const __ASMNAME = @compileError("unable to translate C expr: unexpected token ','");
// /usr/include/sys/cdefs.h:422:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __REDIRECT_FORTIFY = __REDIRECT;
pub const __REDIRECT_FORTIFY_NTH = __REDIRECT_NTH;
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`");
// /usr/include/sys/cdefs.h:452:10
pub const __attribute_alloc_size__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:463:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`");
// /usr/include/sys/cdefs.h:469:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`");
// /usr/include/sys/cdefs.h:479:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /usr/include/sys/cdefs.h:486:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`");
// /usr/include/sys/cdefs.h:492:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`");
// /usr/include/sys/cdefs.h:501:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`");
// /usr/include/sys/cdefs.h:502:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/sys/cdefs.h:510:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/sys/cdefs.h:520:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`");
// /usr/include/sys/cdefs.h:533:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`");
// /usr/include/sys/cdefs.h:543:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`");
// /usr/include/sys/cdefs.h:555:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`");
// /usr/include/sys/cdefs.h:568:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`");
// /usr/include/sys/cdefs.h:577:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`");
// /usr/include/sys/cdefs.h:595:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`");
// /usr/include/sys/cdefs.h:604:10
pub const __extern_inline = @compileError("unable to translate macro: undefined identifier `__gnu_inline__`");
// /usr/include/sys/cdefs.h:622:11
pub const __extern_always_inline = @compileError("unable to translate macro: undefined identifier `__gnu_inline__`");
// /usr/include/sys/cdefs.h:623:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'");
// /usr/include/sys/cdefs.h:666:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin_expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin_expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin_expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin_expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub const __attribute_copy__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:715:10
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub inline fn __LDBL_REDIR1(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR(name: anytype, proto: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR1_NTH(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR_NTH(name: anytype, proto: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    return name ++ proto ++ __THROW;
}
pub const __LDBL_REDIR2_DECL = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:792:10
pub const __LDBL_REDIR_DECL = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:793:10
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /usr/include/sys/cdefs.h:807:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`");
// /usr/include/sys/cdefs.h:808:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub const __fortified_attr_access = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:853:11
pub const __attr_access = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:854:11
pub const __attr_access_none = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:855:11
pub const __attr_dealloc = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/sys/cdefs.h:865:10
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`");
// /usr/include/sys/cdefs.h:872:10
pub const __attribute_struct_may_alias__ = @compileError("unable to translate macro: undefined identifier `__may_alias__`");
// /usr/include/sys/cdefs.h:881:10
pub const __stub___compat_bdflush = "";
pub const __stub_chflags = "";
pub const __stub_fchflags = "";
pub const __stub_gtty = "";
pub const __stub_revoke = "";
pub const __stub_setlogin = "";
pub const __stub_sigreturn = "";
pub const __stub_stty = "";
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const __STD_TYPE = @compileError("unable to translate C expr: unexpected token 'typedef'");
// /usr/include/bits/types.h:137:10
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`");
// /usr/include/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const __u_char_defined = "";
pub const __ino_t_defined = "";
pub const __ino64_t_defined = "";
pub const __dev_t_defined = "";
pub const __gid_t_defined = "";
pub const __mode_t_defined = "";
pub const __nlink_t_defined = "";
pub const __uid_t_defined = "";
pub const __off_t_defined = "";
pub const __off64_t_defined = "";
pub const __pid_t_defined = "";
pub const __id_t_defined = "";
pub const __ssize_t_defined = "";
pub const __daddr_t_defined = "";
pub const __key_t_defined = "";
pub const __clock_t_defined = @as(c_int, 1);
pub const __clockid_t_defined = @as(c_int, 1);
pub const __time_t_defined = @as(c_int, 1);
pub const __timer_t_defined = @as(c_int, 1);
pub const __useconds_t_defined = "";
pub const __suseconds_t_defined = "";
pub const __need_size_t = "";
pub const _SIZE_T = "";
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const __BIT_TYPES_DEFINED__ = @as(c_int, 1);
pub const _ENDIAN_H = @as(c_int, 1);
pub const _BITS_ENDIAN_H = @as(c_int, 1);
pub const __LITTLE_ENDIAN = @as(c_int, 1234);
pub const __BIG_ENDIAN = @as(c_int, 4321);
pub const __PDP_ENDIAN = @as(c_int, 3412);
pub const _BITS_ENDIANNESS_H = @as(c_int, 1);
pub const __BYTE_ORDER = __LITTLE_ENDIAN;
pub const __FLOAT_WORD_ORDER = __BYTE_ORDER;
pub inline fn __LONG_LONG_PAIR(HI: anytype, LO: anytype) @TypeOf(HI) {
    _ = &HI;
    _ = &LO;
    return blk: {
        _ = &LO;
        break :blk HI;
    };
}
pub const LITTLE_ENDIAN = __LITTLE_ENDIAN;
pub const BIG_ENDIAN = __BIG_ENDIAN;
pub const PDP_ENDIAN = __PDP_ENDIAN;
pub const BYTE_ORDER = __BYTE_ORDER;
pub const _BITS_BYTESWAP_H = @as(c_int, 1);
pub inline fn __bswap_constant_16(x: anytype) __uint16_t {
    _ = &x;
    return @import("std").zig.c_translation.cast(__uint16_t, ((x >> @as(c_int, 8)) & @as(c_int, 0xff)) | ((x & @as(c_int, 0xff)) << @as(c_int, 8)));
}
pub inline fn __bswap_constant_32(x: anytype) @TypeOf(((((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24))) {
    _ = &x;
    return ((((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24));
}
pub inline fn __bswap_constant_64(x: anytype) @TypeOf(((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56))) {
    _ = &x;
    return ((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56));
}
pub const _BITS_UINTN_IDENTITY_H = @as(c_int, 1);
pub inline fn htobe16(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn htole16(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn be16toh(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn le16toh(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn htobe32(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn htole32(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn be32toh(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn le32toh(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn htobe64(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn htole64(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub inline fn be64toh(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn le64toh(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub const _SYS_SELECT_H = @as(c_int, 1);
pub const __FD_ZERO = @compileError("unable to translate macro: undefined identifier `__i`");
// /usr/include/bits/select.h:25:9
pub const __FD_SET = @compileError("unable to translate C expr: expected ')' instead got '|='");
// /usr/include/bits/select.h:32:9
pub const __FD_CLR = @compileError("unable to translate C expr: expected ')' instead got '&='");
// /usr/include/bits/select.h:34:9
pub inline fn __FD_ISSET(d: anytype, s: anytype) @TypeOf((__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0)) {
    _ = &d;
    _ = &s;
    return (__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0);
}
pub const __sigset_t_defined = @as(c_int, 1);
pub const ____sigset_t_defined = "";
pub const _SIGSET_NWORDS = @import("std").zig.c_translation.MacroArithmetic.div(@as(c_int, 1024), @as(c_int, 8) * @import("std").zig.c_translation.sizeof(c_ulong));
pub const __timeval_defined = @as(c_int, 1);
pub const _STRUCT_TIMESPEC = @as(c_int, 1);
pub const __NFDBITS = @as(c_int, 8) * @import("std").zig.c_translation.cast(c_int, @import("std").zig.c_translation.sizeof(__fd_mask));
pub inline fn __FD_ELT(d: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(d, __NFDBITS)) {
    _ = &d;
    return @import("std").zig.c_translation.MacroArithmetic.div(d, __NFDBITS);
}
pub inline fn __FD_MASK(d: anytype) __fd_mask {
    _ = &d;
    return @import("std").zig.c_translation.cast(__fd_mask, @as(c_ulong, 1) << @import("std").zig.c_translation.MacroArithmetic.rem(d, __NFDBITS));
}
pub inline fn __FDS_BITS(set: anytype) @TypeOf(set.*.fds_bits) {
    _ = &set;
    return set.*.fds_bits;
}
pub const FD_SETSIZE = __FD_SETSIZE;
pub const NFDBITS = __NFDBITS;
pub inline fn FD_SET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_SET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_SET(fd, fdsetp);
}
pub inline fn FD_CLR(fd: anytype, fdsetp: anytype) @TypeOf(__FD_CLR(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_CLR(fd, fdsetp);
}
pub inline fn FD_ISSET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_ISSET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_ISSET(fd, fdsetp);
}
pub inline fn FD_ZERO(fdsetp: anytype) @TypeOf(__FD_ZERO(fdsetp)) {
    _ = &fdsetp;
    return __FD_ZERO(fdsetp);
}
pub const __blksize_t_defined = "";
pub const __blkcnt_t_defined = "";
pub const __fsblkcnt_t_defined = "";
pub const __fsfilcnt_t_defined = "";
pub const _BITS_PTHREADTYPES_COMMON_H = @as(c_int, 1);
pub const _THREAD_SHARED_TYPES_H = @as(c_int, 1);
pub const _BITS_PTHREADTYPES_ARCH_H = @as(c_int, 1);
pub const __SIZEOF_PTHREAD_MUTEX_T = @as(c_int, 40);
pub const __SIZEOF_PTHREAD_ATTR_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_RWLOCK_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_BARRIER_T = @as(c_int, 32);
pub const __SIZEOF_PTHREAD_MUTEXATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_COND_T = @as(c_int, 48);
pub const __SIZEOF_PTHREAD_CONDATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_RWLOCKATTR_T = @as(c_int, 8);
pub const __SIZEOF_PTHREAD_BARRIERATTR_T = @as(c_int, 4);
pub const __LOCK_ALIGNMENT = "";
pub const __ONCE_ALIGNMENT = "";
pub const _BITS_ATOMIC_WIDE_COUNTER_H = "";
pub const _THREAD_MUTEX_INTERNAL_H = @as(c_int, 1);
pub const __PTHREAD_MUTEX_HAVE_PREV = @as(c_int, 1);
pub const __PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/bits/struct_mutex.h:56:10
pub const _RWLOCK_INTERNAL_H = "";
pub const __PTHREAD_RWLOCK_ELISION_EXTRA = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/bits/struct_rwlock.h:40:11
pub inline fn __PTHREAD_RWLOCK_INITIALIZER(__flags: anytype) @TypeOf(__flags) {
    _ = &__flags;
    return blk: {
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = &__PTHREAD_RWLOCK_ELISION_EXTRA;
        _ = @as(c_int, 0);
        break :blk __flags;
    };
}
pub const __ONCE_FLAG_INIT = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/bits/thread-shared-types.h:113:9
pub const __have_pthread_attr_t = @as(c_int, 1);
pub const _SYS_TIME_H = @as(c_int, 1);
pub const TIMEVAL_TO_TIMESPEC = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/sys/time.h:38:10
pub const TIMESPEC_TO_TIMEVAL = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/sys/time.h:42:10
pub inline fn timerisset(tvp: anytype) @TypeOf((tvp.*.tv_sec != 0) or (tvp.*.tv_usec != 0)) {
    _ = &tvp;
    return (tvp.*.tv_sec != 0) or (tvp.*.tv_usec != 0);
}
pub const timerclear = @compileError("unable to translate C expr: expected ')' instead got '='");
// /usr/include/sys/time.h:232:10
pub inline fn timercmp(a: anytype, b: anytype, CMP: anytype) @TypeOf(if (a.*.tv_sec == b.*.tv_sec) a.*.tv_usec ++ CMP(b).*.tv_usec else a.*.tv_sec ++ CMP(b).*.tv_sec) {
    _ = &a;
    _ = &b;
    _ = &CMP;
    return if (a.*.tv_sec == b.*.tv_sec) a.*.tv_usec ++ CMP(b).*.tv_usec else a.*.tv_sec ++ CMP(b).*.tv_sec;
}
pub const timeradd = @compileError("unable to translate C expr: unexpected token 'do'");
// /usr/include/sys/time.h:237:10
pub const timersub = @compileError("unable to translate C expr: unexpected token 'do'");
// /usr/include/sys/time.h:247:10
pub const _UNISTD_H = @as(c_int, 1);
pub const _POSIX_VERSION = @as(c_long, 200809);
pub const __POSIX2_THIS_VERSION = @as(c_long, 200809);
pub const _POSIX2_VERSION = __POSIX2_THIS_VERSION;
pub const _POSIX2_C_VERSION = __POSIX2_THIS_VERSION;
pub const _POSIX2_C_BIND = __POSIX2_THIS_VERSION;
pub const _POSIX2_C_DEV = __POSIX2_THIS_VERSION;
pub const _POSIX2_SW_DEV = __POSIX2_THIS_VERSION;
pub const _POSIX2_LOCALEDEF = __POSIX2_THIS_VERSION;
pub const _XOPEN_VERSION = @as(c_int, 700);
pub const _XOPEN_XCU_VERSION = @as(c_int, 4);
pub const _XOPEN_XPG2 = @as(c_int, 1);
pub const _XOPEN_XPG3 = @as(c_int, 1);
pub const _XOPEN_XPG4 = @as(c_int, 1);
pub const _XOPEN_UNIX = @as(c_int, 1);
pub const _XOPEN_ENH_I18N = @as(c_int, 1);
pub const _XOPEN_LEGACY = @as(c_int, 1);
pub const _BITS_POSIX_OPT_H = @as(c_int, 1);
pub const _POSIX_JOB_CONTROL = @as(c_int, 1);
pub const _POSIX_SAVED_IDS = @as(c_int, 1);
pub const _POSIX_PRIORITY_SCHEDULING = @as(c_long, 200809);
pub const _POSIX_SYNCHRONIZED_IO = @as(c_long, 200809);
pub const _POSIX_FSYNC = @as(c_long, 200809);
pub const _POSIX_MAPPED_FILES = @as(c_long, 200809);
pub const _POSIX_MEMLOCK = @as(c_long, 200809);
pub const _POSIX_MEMLOCK_RANGE = @as(c_long, 200809);
pub const _POSIX_MEMORY_PROTECTION = @as(c_long, 200809);
pub const _POSIX_CHOWN_RESTRICTED = @as(c_int, 0);
pub const _POSIX_VDISABLE = '\x00';
pub const _POSIX_NO_TRUNC = @as(c_int, 1);
pub const _XOPEN_REALTIME = @as(c_int, 1);
pub const _XOPEN_REALTIME_THREADS = @as(c_int, 1);
pub const _XOPEN_SHM = @as(c_int, 1);
pub const _POSIX_THREADS = @as(c_long, 200809);
pub const _POSIX_REENTRANT_FUNCTIONS = @as(c_int, 1);
pub const _POSIX_THREAD_SAFE_FUNCTIONS = @as(c_long, 200809);
pub const _POSIX_THREAD_PRIORITY_SCHEDULING = @as(c_long, 200809);
pub const _POSIX_THREAD_ATTR_STACKSIZE = @as(c_long, 200809);
pub const _POSIX_THREAD_ATTR_STACKADDR = @as(c_long, 200809);
pub const _POSIX_THREAD_PRIO_INHERIT = @as(c_long, 200809);
pub const _POSIX_THREAD_PRIO_PROTECT = @as(c_long, 200809);
pub const _POSIX_THREAD_ROBUST_PRIO_INHERIT = @as(c_long, 200809);
pub const _POSIX_THREAD_ROBUST_PRIO_PROTECT = -@as(c_int, 1);
pub const _POSIX_SEMAPHORES = @as(c_long, 200809);
pub const _POSIX_REALTIME_SIGNALS = @as(c_long, 200809);
pub const _POSIX_ASYNCHRONOUS_IO = @as(c_long, 200809);
pub const _POSIX_ASYNC_IO = @as(c_int, 1);
pub const _LFS_ASYNCHRONOUS_IO = @as(c_int, 1);
pub const _POSIX_PRIORITIZED_IO = @as(c_long, 200809);
pub const _LFS64_ASYNCHRONOUS_IO = @as(c_int, 1);
pub const _LFS_LARGEFILE = @as(c_int, 1);
pub const _LFS64_LARGEFILE = @as(c_int, 1);
pub const _LFS64_STDIO = @as(c_int, 1);
pub const _POSIX_SHARED_MEMORY_OBJECTS = @as(c_long, 200809);
pub const _POSIX_CPUTIME = @as(c_int, 0);
pub const _POSIX_THREAD_CPUTIME = @as(c_int, 0);
pub const _POSIX_REGEXP = @as(c_int, 1);
pub const _POSIX_READER_WRITER_LOCKS = @as(c_long, 200809);
pub const _POSIX_SHELL = @as(c_int, 1);
pub const _POSIX_TIMEOUTS = @as(c_long, 200809);
pub const _POSIX_SPIN_LOCKS = @as(c_long, 200809);
pub const _POSIX_SPAWN = @as(c_long, 200809);
pub const _POSIX_TIMERS = @as(c_long, 200809);
pub const _POSIX_BARRIERS = @as(c_long, 200809);
pub const _POSIX_MESSAGE_PASSING = @as(c_long, 200809);
pub const _POSIX_THREAD_PROCESS_SHARED = @as(c_long, 200809);
pub const _POSIX_MONOTONIC_CLOCK = @as(c_int, 0);
pub const _POSIX_CLOCK_SELECTION = @as(c_long, 200809);
pub const _POSIX_ADVISORY_INFO = @as(c_long, 200809);
pub const _POSIX_IPV6 = @as(c_long, 200809);
pub const _POSIX_RAW_SOCKETS = @as(c_long, 200809);
pub const _POSIX2_CHAR_TERM = @as(c_long, 200809);
pub const _POSIX_SPORADIC_SERVER = -@as(c_int, 1);
pub const _POSIX_THREAD_SPORADIC_SERVER = -@as(c_int, 1);
pub const _POSIX_TRACE = -@as(c_int, 1);
pub const _POSIX_TRACE_EVENT_FILTER = -@as(c_int, 1);
pub const _POSIX_TRACE_INHERIT = -@as(c_int, 1);
pub const _POSIX_TRACE_LOG = -@as(c_int, 1);
pub const _POSIX_TYPED_MEMORY_OBJECTS = -@as(c_int, 1);
pub const _POSIX_V7_LPBIG_OFFBIG = -@as(c_int, 1);
pub const _POSIX_V6_LPBIG_OFFBIG = -@as(c_int, 1);
pub const _XBS5_LPBIG_OFFBIG = -@as(c_int, 1);
pub const _POSIX_V7_LP64_OFF64 = @as(c_int, 1);
pub const _POSIX_V6_LP64_OFF64 = @as(c_int, 1);
pub const _XBS5_LP64_OFF64 = @as(c_int, 1);
pub const __ILP32_OFF32_CFLAGS = "-m32";
pub const __ILP32_OFF32_LDFLAGS = "-m32";
pub const __ILP32_OFFBIG_CFLAGS = "-m32 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64";
pub const __ILP32_OFFBIG_LDFLAGS = "-m32";
pub const __LP64_OFF64_CFLAGS = "-m64";
pub const __LP64_OFF64_LDFLAGS = "-m64";
pub const STDIN_FILENO = @as(c_int, 0);
pub const STDOUT_FILENO = @as(c_int, 1);
pub const STDERR_FILENO = @as(c_int, 2);
pub const __need_NULL = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const __intptr_t_defined = "";
pub const __socklen_t_defined = "";
pub const R_OK = @as(c_int, 4);
pub const W_OK = @as(c_int, 2);
pub const X_OK = @as(c_int, 1);
pub const F_OK = @as(c_int, 0);
pub const SEEK_SET = @as(c_int, 0);
pub const SEEK_CUR = @as(c_int, 1);
pub const SEEK_END = @as(c_int, 2);
pub const SEEK_DATA = @as(c_int, 3);
pub const SEEK_HOLE = @as(c_int, 4);
pub const L_SET = SEEK_SET;
pub const L_INCR = SEEK_CUR;
pub const L_XTND = SEEK_END;
pub const _SC_PAGE_SIZE = _SC_PAGESIZE;
pub const _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS = _CS_V6_WIDTH_RESTRICTED_ENVS;
pub const _CS_POSIX_V5_WIDTH_RESTRICTED_ENVS = _CS_V5_WIDTH_RESTRICTED_ENVS;
pub const _CS_POSIX_V7_WIDTH_RESTRICTED_ENVS = _CS_V7_WIDTH_RESTRICTED_ENVS;
pub const _GETOPT_POSIX_H = @as(c_int, 1);
pub const _GETOPT_CORE_H = @as(c_int, 1);
pub const F_ULOCK = @as(c_int, 0);
pub const F_LOCK = @as(c_int, 1);
pub const F_TLOCK = @as(c_int, 2);
pub const F_TEST = @as(c_int, 3);
pub const TEMP_FAILURE_RETRY = @compileError("unable to translate macro: undefined identifier `__result`");
// /usr/include/unistd.h:1134:10
pub const _LINUX_CLOSE_RANGE_H = "";
pub const CLOSE_RANGE_UNSHARE = @as(c_uint, 1) << @as(c_int, 1);
pub const CLOSE_RANGE_CLOEXEC = @as(c_uint, 1) << @as(c_int, 2);
pub const __STDARG_H = "";
pub const __need___va_list = "";
pub const __need_va_list = "";
pub const __need_va_arg = "";
pub const __need___va_copy = "";
pub const __need_va_copy = "";
pub const __GNUC_VA_LIST = "";
pub const _VA_LIST = "";
pub const va_start = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`");
// /home/kaiwu/.local/share/zig-linux-x86_64-0.13.0/lib/include/__stdarg_va_arg.h:17:9
pub const va_end = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`");
// /home/kaiwu/.local/share/zig-linux-x86_64-0.13.0/lib/include/__stdarg_va_arg.h:19:9
pub const va_arg = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /home/kaiwu/.local/share/zig-linux-x86_64-0.13.0/lib/include/__stdarg_va_arg.h:20:9
pub const __va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /home/kaiwu/.local/share/zig-linux-x86_64-0.13.0/lib/include/__stdarg___va_copy.h:11:9
pub const va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /home/kaiwu/.local/share/zig-linux-x86_64-0.13.0/lib/include/__stdarg_va_copy.h:11:9
pub const __STDDEF_H = "";
pub const __need_ptrdiff_t = "";
pub const __need_wchar_t = "";
pub const __need_max_align_t = "";
pub const __need_offsetof = "";
pub const _PTRDIFF_T = "";
pub const _WCHAR_T = "";
pub const __CLANG_MAX_ALIGN_T_DEFINED = "";
pub const offsetof = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /home/kaiwu/.local/share/zig-linux-x86_64-0.13.0/lib/include/__stddef_offsetof.h:16:9
pub const _STDIO_H = @as(c_int, 1);
pub const __GLIBC_INTERNAL_STARTING_HEADER_IMPLEMENTATION = "";
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 1);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 1);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C23 = @as(c_int, 1);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 1);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 1);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C23 = @as(c_int, 1);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 1);
pub const _____fpos_t_defined = @as(c_int, 1);
pub const ____mbstate_t_defined = @as(c_int, 1);
pub const _____fpos64_t_defined = @as(c_int, 1);
pub const ____FILE_defined = @as(c_int, 1);
pub const __FILE_defined = @as(c_int, 1);
pub const __struct_FILE_defined = @as(c_int, 1);
pub const __getc_unlocked_body = @compileError("TODO postfix inc/dec expr");
// /usr/include/bits/types/struct_FILE.h:102:9
pub const __putc_unlocked_body = @compileError("TODO postfix inc/dec expr");
// /usr/include/bits/types/struct_FILE.h:106:9
pub const _IO_EOF_SEEN = @as(c_int, 0x0010);
pub inline fn __feof_unlocked_body(_fp: anytype) @TypeOf((_fp.*._flags & _IO_EOF_SEEN) != @as(c_int, 0)) {
    _ = &_fp;
    return (_fp.*._flags & _IO_EOF_SEEN) != @as(c_int, 0);
}
pub const _IO_ERR_SEEN = @as(c_int, 0x0020);
pub inline fn __ferror_unlocked_body(_fp: anytype) @TypeOf((_fp.*._flags & _IO_ERR_SEEN) != @as(c_int, 0)) {
    _ = &_fp;
    return (_fp.*._flags & _IO_ERR_SEEN) != @as(c_int, 0);
}
pub const _IO_USER_LOCK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const __cookie_io_functions_t_defined = @as(c_int, 1);
pub const _VA_LIST_DEFINED = "";
pub const _IOFBF = @as(c_int, 0);
pub const _IOLBF = @as(c_int, 1);
pub const _IONBF = @as(c_int, 2);
pub const BUFSIZ = @as(c_int, 8192);
pub const EOF = -@as(c_int, 1);
pub const P_tmpdir = "/tmp";
pub const L_tmpnam = @as(c_int, 20);
pub const TMP_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 238328, .decimal);
pub const _BITS_STDIO_LIM_H = @as(c_int, 1);
pub const FILENAME_MAX = @as(c_int, 4096);
pub const L_ctermid = @as(c_int, 9);
pub const L_cuserid = @as(c_int, 9);
pub const FOPEN_MAX = @as(c_int, 16);
pub const _PRINTF_NAN_LEN_MAX = @as(c_int, 4);
pub const RENAME_NOREPLACE = @as(c_int, 1) << @as(c_int, 0);
pub const RENAME_EXCHANGE = @as(c_int, 1) << @as(c_int, 1);
pub const RENAME_WHITEOUT = @as(c_int, 1) << @as(c_int, 2);
pub const __attr_dealloc_fclose = __attr_dealloc(fclose, @as(c_int, 1));
pub const _BITS_FLOATN_H = "";
pub const __HAVE_FLOAT128 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT128 = @as(c_int, 0);
pub const __HAVE_FLOAT64X = @as(c_int, 1);
pub const __HAVE_FLOAT64X_LONG_DOUBLE = @as(c_int, 1);
pub const _BITS_FLOATN_COMMON_H = "";
pub const __HAVE_FLOAT16 = @as(c_int, 0);
pub const __HAVE_FLOAT32 = @as(c_int, 1);
pub const __HAVE_FLOAT64 = @as(c_int, 1);
pub const __HAVE_FLOAT32X = @as(c_int, 1);
pub const __HAVE_FLOAT128X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT16 = __HAVE_FLOAT16;
pub const __HAVE_DISTINCT_FLOAT32 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT32X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT128X = __HAVE_FLOAT128X;
pub const __HAVE_FLOAT128_UNLIKE_LDBL = (__HAVE_DISTINCT_FLOAT128 != 0) and (__LDBL_MANT_DIG__ != @as(c_int, 113));
pub const __HAVE_FLOATN_NOT_TYPEDEF = @as(c_int, 0);
pub const __f32 = @import("std").zig.c_translation.Macros.F_SUFFIX;
pub inline fn __f64(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __f32x(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub const __f64x = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const __CFLOAT32 = @compileError("unable to translate: TODO _Complex");
// /usr/include/bits/floatn-common.h:149:12
pub const __CFLOAT64 = @compileError("unable to translate: TODO _Complex");
// /usr/include/bits/floatn-common.h:160:13
pub const __CFLOAT32X = @compileError("unable to translate: TODO _Complex");
// /usr/include/bits/floatn-common.h:169:12
pub const __CFLOAT64X = @compileError("unable to translate: TODO _Complex");
// /usr/include/bits/floatn-common.h:178:13
pub inline fn __builtin_huge_valf32() @TypeOf(__builtin_huge_valf()) {
    return __builtin_huge_valf();
}
pub inline fn __builtin_inff32() @TypeOf(__builtin_inff()) {
    return __builtin_inff();
}
pub inline fn __builtin_nanf32(x: anytype) @TypeOf(__builtin_nanf(x)) {
    _ = &x;
    return __builtin_nanf(x);
}
pub const __builtin_nansf32 = @compileError("unable to translate macro: undefined identifier `__builtin_nansf`");
// /usr/include/bits/floatn-common.h:221:12
pub const __builtin_huge_valf64 = @compileError("unable to translate macro: undefined identifier `__builtin_huge_val`");
// /usr/include/bits/floatn-common.h:255:13
pub const __builtin_inff64 = @compileError("unable to translate macro: undefined identifier `__builtin_inf`");
// /usr/include/bits/floatn-common.h:256:13
pub const __builtin_nanf64 = @compileError("unable to translate macro: undefined identifier `__builtin_nan`");
// /usr/include/bits/floatn-common.h:257:13
pub const __builtin_nansf64 = @compileError("unable to translate macro: undefined identifier `__builtin_nans`");
// /usr/include/bits/floatn-common.h:258:13
pub const __builtin_huge_valf32x = @compileError("unable to translate macro: undefined identifier `__builtin_huge_val`");
// /usr/include/bits/floatn-common.h:272:12
pub const __builtin_inff32x = @compileError("unable to translate macro: undefined identifier `__builtin_inf`");
// /usr/include/bits/floatn-common.h:273:12
pub const __builtin_nanf32x = @compileError("unable to translate macro: undefined identifier `__builtin_nan`");
// /usr/include/bits/floatn-common.h:274:12
pub const __builtin_nansf32x = @compileError("unable to translate macro: undefined identifier `__builtin_nans`");
// /usr/include/bits/floatn-common.h:275:12
pub const __builtin_huge_valf64x = @compileError("unable to translate macro: undefined identifier `__builtin_huge_vall`");
// /usr/include/bits/floatn-common.h:289:13
pub const __builtin_inff64x = @compileError("unable to translate macro: undefined identifier `__builtin_infl`");
// /usr/include/bits/floatn-common.h:290:13
pub const __builtin_nanf64x = @compileError("unable to translate macro: undefined identifier `__builtin_nanl`");
// /usr/include/bits/floatn-common.h:291:13
pub const __builtin_nansf64x = @compileError("unable to translate macro: undefined identifier `__builtin_nansl`");
// /usr/include/bits/floatn-common.h:292:13
pub const _STDLIB_H = @as(c_int, 1);
pub const WNOHANG = @as(c_int, 1);
pub const WUNTRACED = @as(c_int, 2);
pub const WSTOPPED = @as(c_int, 2);
pub const WEXITED = @as(c_int, 4);
pub const WCONTINUED = @as(c_int, 8);
pub const WNOWAIT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const __WNOTHREAD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const __WALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const __WCLONE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub inline fn __WEXITSTATUS(status: anytype) @TypeOf((status & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff00, .hex)) >> @as(c_int, 8)) {
    _ = &status;
    return (status & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff00, .hex)) >> @as(c_int, 8);
}
pub inline fn __WTERMSIG(status: anytype) @TypeOf(status & @as(c_int, 0x7f)) {
    _ = &status;
    return status & @as(c_int, 0x7f);
}
pub inline fn __WSTOPSIG(status: anytype) @TypeOf(__WEXITSTATUS(status)) {
    _ = &status;
    return __WEXITSTATUS(status);
}
pub inline fn __WIFEXITED(status: anytype) @TypeOf(__WTERMSIG(status) == @as(c_int, 0)) {
    _ = &status;
    return __WTERMSIG(status) == @as(c_int, 0);
}
pub inline fn __WIFSIGNALED(status: anytype) @TypeOf((@import("std").zig.c_translation.cast(i8, (status & @as(c_int, 0x7f)) + @as(c_int, 1)) >> @as(c_int, 1)) > @as(c_int, 0)) {
    _ = &status;
    return (@import("std").zig.c_translation.cast(i8, (status & @as(c_int, 0x7f)) + @as(c_int, 1)) >> @as(c_int, 1)) > @as(c_int, 0);
}
pub inline fn __WIFSTOPPED(status: anytype) @TypeOf((status & @as(c_int, 0xff)) == @as(c_int, 0x7f)) {
    _ = &status;
    return (status & @as(c_int, 0xff)) == @as(c_int, 0x7f);
}
pub inline fn __WIFCONTINUED(status: anytype) @TypeOf(status == __W_CONTINUED) {
    _ = &status;
    return status == __W_CONTINUED;
}
pub inline fn __WCOREDUMP(status: anytype) @TypeOf(status & __WCOREFLAG) {
    _ = &status;
    return status & __WCOREFLAG;
}
pub inline fn __W_EXITCODE(ret: anytype, sig: anytype) @TypeOf((ret << @as(c_int, 8)) | sig) {
    _ = &ret;
    _ = &sig;
    return (ret << @as(c_int, 8)) | sig;
}
pub inline fn __W_STOPCODE(sig: anytype) @TypeOf((sig << @as(c_int, 8)) | @as(c_int, 0x7f)) {
    _ = &sig;
    return (sig << @as(c_int, 8)) | @as(c_int, 0x7f);
}
pub const __W_CONTINUED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hex);
pub const __WCOREFLAG = @as(c_int, 0x80);
pub inline fn WEXITSTATUS(status: anytype) @TypeOf(__WEXITSTATUS(status)) {
    _ = &status;
    return __WEXITSTATUS(status);
}
pub inline fn WTERMSIG(status: anytype) @TypeOf(__WTERMSIG(status)) {
    _ = &status;
    return __WTERMSIG(status);
}
pub inline fn WSTOPSIG(status: anytype) @TypeOf(__WSTOPSIG(status)) {
    _ = &status;
    return __WSTOPSIG(status);
}
pub inline fn WIFEXITED(status: anytype) @TypeOf(__WIFEXITED(status)) {
    _ = &status;
    return __WIFEXITED(status);
}
pub inline fn WIFSIGNALED(status: anytype) @TypeOf(__WIFSIGNALED(status)) {
    _ = &status;
    return __WIFSIGNALED(status);
}
pub inline fn WIFSTOPPED(status: anytype) @TypeOf(__WIFSTOPPED(status)) {
    _ = &status;
    return __WIFSTOPPED(status);
}
pub inline fn WIFCONTINUED(status: anytype) @TypeOf(__WIFCONTINUED(status)) {
    _ = &status;
    return __WIFCONTINUED(status);
}
pub const __ldiv_t_defined = @as(c_int, 1);
pub const __lldiv_t_defined = @as(c_int, 1);
pub const RAND_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const EXIT_FAILURE = @as(c_int, 1);
pub const EXIT_SUCCESS = @as(c_int, 0);
pub const MB_CUR_MAX = __ctype_get_mb_cur_max();
pub const _BITS_TYPES_LOCALE_T_H = @as(c_int, 1);
pub const _BITS_TYPES___LOCALE_T_H = @as(c_int, 1);
pub const _ALLOCA_H = @as(c_int, 1);
pub const __COMPAR_FN_T = "";
pub const _CTYPE_H = @as(c_int, 1);
pub inline fn _ISbit(bit: anytype) @TypeOf(if (bit < @as(c_int, 8)) (@as(c_int, 1) << bit) << @as(c_int, 8) else (@as(c_int, 1) << bit) >> @as(c_int, 8)) {
    _ = &bit;
    return if (bit < @as(c_int, 8)) (@as(c_int, 1) << bit) << @as(c_int, 8) else (@as(c_int, 1) << bit) >> @as(c_int, 8);
}
pub inline fn __isctype(c: anytype, @"type": anytype) @TypeOf(__ctype_b_loc().*[@as(usize, @intCast(@import("std").zig.c_translation.cast(c_int, c)))] & @import("std").zig.c_translation.cast(c_ushort, @"type")) {
    _ = &c;
    _ = &@"type";
    return __ctype_b_loc().*[@as(usize, @intCast(@import("std").zig.c_translation.cast(c_int, c)))] & @import("std").zig.c_translation.cast(c_ushort, @"type");
}
pub inline fn __isascii(c: anytype) @TypeOf((c & ~@as(c_int, 0x7f)) == @as(c_int, 0)) {
    _ = &c;
    return (c & ~@as(c_int, 0x7f)) == @as(c_int, 0);
}
pub inline fn __toascii(c: anytype) @TypeOf(c & @as(c_int, 0x7f)) {
    _ = &c;
    return c & @as(c_int, 0x7f);
}
pub const __exctype = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/ctype.h:102:9
pub const __tobody = @compileError("unable to translate macro: undefined identifier `__res`");
// /usr/include/ctype.h:155:9
pub inline fn __isctype_l(c: anytype, @"type": anytype, locale: anytype) @TypeOf(locale.*.__ctype_b[@as(usize, @intCast(@import("std").zig.c_translation.cast(c_int, c)))] & @import("std").zig.c_translation.cast(c_ushort, @"type")) {
    _ = &c;
    _ = &@"type";
    _ = &locale;
    return locale.*.__ctype_b[@as(usize, @intCast(@import("std").zig.c_translation.cast(c_int, c)))] & @import("std").zig.c_translation.cast(c_ushort, @"type");
}
pub const __exctype_l = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/ctype.h:244:10
pub inline fn __isalnum_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISalnum, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISalnum, l);
}
pub inline fn __isalpha_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISalpha, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISalpha, l);
}
pub inline fn __iscntrl_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _IScntrl, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _IScntrl, l);
}
pub inline fn __isdigit_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISdigit, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISdigit, l);
}
pub inline fn __islower_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISlower, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISlower, l);
}
pub inline fn __isgraph_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISgraph, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISgraph, l);
}
pub inline fn __isprint_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISprint, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISprint, l);
}
pub inline fn __ispunct_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISpunct, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISpunct, l);
}
pub inline fn __isspace_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISspace, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISspace, l);
}
pub inline fn __isupper_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISupper, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISupper, l);
}
pub inline fn __isxdigit_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISxdigit, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISxdigit, l);
}
pub inline fn __isblank_l(c: anytype, l: anytype) @TypeOf(__isctype_l(c, _ISblank, l)) {
    _ = &c;
    _ = &l;
    return __isctype_l(c, _ISblank, l);
}
pub inline fn __isascii_l(c: anytype, l: anytype) @TypeOf(__isascii(c)) {
    _ = &c;
    _ = &l;
    return blk_1: {
        _ = &l;
        break :blk_1 __isascii(c);
    };
}
pub inline fn __toascii_l(c: anytype, l: anytype) @TypeOf(__toascii(c)) {
    _ = &c;
    _ = &l;
    return blk_1: {
        _ = &l;
        break :blk_1 __toascii(c);
    };
}
pub inline fn isascii_l(c: anytype, l: anytype) @TypeOf(__isascii_l(c, l)) {
    _ = &c;
    _ = &l;
    return __isascii_l(c, l);
}
pub inline fn toascii_l(c: anytype, l: anytype) @TypeOf(__toascii_l(c, l)) {
    _ = &c;
    _ = &l;
    return __toascii_l(c, l);
}
pub const _ERRNO_H = @as(c_int, 1);
pub const _BITS_ERRNO_H = @as(c_int, 1);
pub const _ASM_GENERIC_ERRNO_H = "";
pub const _ASM_GENERIC_ERRNO_BASE_H = "";
pub const EPERM = @as(c_int, 1);
pub const ENOENT = @as(c_int, 2);
pub const ESRCH = @as(c_int, 3);
pub const EINTR = @as(c_int, 4);
pub const EIO = @as(c_int, 5);
pub const ENXIO = @as(c_int, 6);
pub const E2BIG = @as(c_int, 7);
pub const ENOEXEC = @as(c_int, 8);
pub const EBADF = @as(c_int, 9);
pub const ECHILD = @as(c_int, 10);
pub const EAGAIN = @as(c_int, 11);
pub const ENOMEM = @as(c_int, 12);
pub const EACCES = @as(c_int, 13);
pub const EFAULT = @as(c_int, 14);
pub const ENOTBLK = @as(c_int, 15);
pub const EBUSY = @as(c_int, 16);
pub const EEXIST = @as(c_int, 17);
pub const EXDEV = @as(c_int, 18);
pub const ENODEV = @as(c_int, 19);
pub const ENOTDIR = @as(c_int, 20);
pub const EISDIR = @as(c_int, 21);
pub const EINVAL = @as(c_int, 22);
pub const ENFILE = @as(c_int, 23);
pub const EMFILE = @as(c_int, 24);
pub const ENOTTY = @as(c_int, 25);
pub const ETXTBSY = @as(c_int, 26);
pub const EFBIG = @as(c_int, 27);
pub const ENOSPC = @as(c_int, 28);
pub const ESPIPE = @as(c_int, 29);
pub const EROFS = @as(c_int, 30);
pub const EMLINK = @as(c_int, 31);
pub const EPIPE = @as(c_int, 32);
pub const EDOM = @as(c_int, 33);
pub const ERANGE = @as(c_int, 34);
pub const EDEADLK = @as(c_int, 35);
pub const ENAMETOOLONG = @as(c_int, 36);
pub const ENOLCK = @as(c_int, 37);
pub const ENOSYS = @as(c_int, 38);
pub const ENOTEMPTY = @as(c_int, 39);
pub const ELOOP = @as(c_int, 40);
pub const EWOULDBLOCK = EAGAIN;
pub const ENOMSG = @as(c_int, 42);
pub const EIDRM = @as(c_int, 43);
pub const ECHRNG = @as(c_int, 44);
pub const EL2NSYNC = @as(c_int, 45);
pub const EL3HLT = @as(c_int, 46);
pub const EL3RST = @as(c_int, 47);
pub const ELNRNG = @as(c_int, 48);
pub const EUNATCH = @as(c_int, 49);
pub const ENOCSI = @as(c_int, 50);
pub const EL2HLT = @as(c_int, 51);
pub const EBADE = @as(c_int, 52);
pub const EBADR = @as(c_int, 53);
pub const EXFULL = @as(c_int, 54);
pub const ENOANO = @as(c_int, 55);
pub const EBADRQC = @as(c_int, 56);
pub const EBADSLT = @as(c_int, 57);
pub const EDEADLOCK = EDEADLK;
pub const EBFONT = @as(c_int, 59);
pub const ENOSTR = @as(c_int, 60);
pub const ENODATA = @as(c_int, 61);
pub const ETIME = @as(c_int, 62);
pub const ENOSR = @as(c_int, 63);
pub const ENONET = @as(c_int, 64);
pub const ENOPKG = @as(c_int, 65);
pub const EREMOTE = @as(c_int, 66);
pub const ENOLINK = @as(c_int, 67);
pub const EADV = @as(c_int, 68);
pub const ESRMNT = @as(c_int, 69);
pub const ECOMM = @as(c_int, 70);
pub const EPROTO = @as(c_int, 71);
pub const EMULTIHOP = @as(c_int, 72);
pub const EDOTDOT = @as(c_int, 73);
pub const EBADMSG = @as(c_int, 74);
pub const EOVERFLOW = @as(c_int, 75);
pub const ENOTUNIQ = @as(c_int, 76);
pub const EBADFD = @as(c_int, 77);
pub const EREMCHG = @as(c_int, 78);
pub const ELIBACC = @as(c_int, 79);
pub const ELIBBAD = @as(c_int, 80);
pub const ELIBSCN = @as(c_int, 81);
pub const ELIBMAX = @as(c_int, 82);
pub const ELIBEXEC = @as(c_int, 83);
pub const EILSEQ = @as(c_int, 84);
pub const ERESTART = @as(c_int, 85);
pub const ESTRPIPE = @as(c_int, 86);
pub const EUSERS = @as(c_int, 87);
pub const ENOTSOCK = @as(c_int, 88);
pub const EDESTADDRREQ = @as(c_int, 89);
pub const EMSGSIZE = @as(c_int, 90);
pub const EPROTOTYPE = @as(c_int, 91);
pub const ENOPROTOOPT = @as(c_int, 92);
pub const EPROTONOSUPPORT = @as(c_int, 93);
pub const ESOCKTNOSUPPORT = @as(c_int, 94);
pub const EOPNOTSUPP = @as(c_int, 95);
pub const EPFNOSUPPORT = @as(c_int, 96);
pub const EAFNOSUPPORT = @as(c_int, 97);
pub const EADDRINUSE = @as(c_int, 98);
pub const EADDRNOTAVAIL = @as(c_int, 99);
pub const ENETDOWN = @as(c_int, 100);
pub const ENETUNREACH = @as(c_int, 101);
pub const ENETRESET = @as(c_int, 102);
pub const ECONNABORTED = @as(c_int, 103);
pub const ECONNRESET = @as(c_int, 104);
pub const ENOBUFS = @as(c_int, 105);
pub const EISCONN = @as(c_int, 106);
pub const ENOTCONN = @as(c_int, 107);
pub const ESHUTDOWN = @as(c_int, 108);
pub const ETOOMANYREFS = @as(c_int, 109);
pub const ETIMEDOUT = @as(c_int, 110);
pub const ECONNREFUSED = @as(c_int, 111);
pub const EHOSTDOWN = @as(c_int, 112);
pub const EHOSTUNREACH = @as(c_int, 113);
pub const EALREADY = @as(c_int, 114);
pub const EINPROGRESS = @as(c_int, 115);
pub const ESTALE = @as(c_int, 116);
pub const EUCLEAN = @as(c_int, 117);
pub const ENOTNAM = @as(c_int, 118);
pub const ENAVAIL = @as(c_int, 119);
pub const EISNAM = @as(c_int, 120);
pub const EREMOTEIO = @as(c_int, 121);
pub const EDQUOT = @as(c_int, 122);
pub const ENOMEDIUM = @as(c_int, 123);
pub const EMEDIUMTYPE = @as(c_int, 124);
pub const ECANCELED = @as(c_int, 125);
pub const ENOKEY = @as(c_int, 126);
pub const EKEYEXPIRED = @as(c_int, 127);
pub const EKEYREVOKED = @as(c_int, 128);
pub const EKEYREJECTED = @as(c_int, 129);
pub const EOWNERDEAD = @as(c_int, 130);
pub const ENOTRECOVERABLE = @as(c_int, 131);
pub const ERFKILL = @as(c_int, 132);
pub const EHWPOISON = @as(c_int, 133);
pub const ENOTSUP = EOPNOTSUPP;
pub const errno = __errno_location().*;
pub const __error_t_defined = @as(c_int, 1);
pub const _STRING_H = @as(c_int, 1);
pub const strdupa = @compileError("unable to translate macro: undefined identifier `__old`");
// /usr/include/string.h:201:10
pub const strndupa = @compileError("unable to translate macro: undefined identifier `__old`");
// /usr/include/string.h:211:10
pub const _STRINGS_H = @as(c_int, 1);
pub const _SIGNAL_H = "";
pub const _BITS_SIGNUM_GENERIC_H = @as(c_int, 1);
pub const SIG_ERR = @import("std").zig.c_translation.cast(__sighandler_t, -@as(c_int, 1));
pub const SIG_DFL = @import("std").zig.c_translation.cast(__sighandler_t, @as(c_int, 0));
pub const SIG_IGN = @import("std").zig.c_translation.cast(__sighandler_t, @as(c_int, 1));
pub const SIG_HOLD = @import("std").zig.c_translation.cast(__sighandler_t, @as(c_int, 2));
pub const SIGINT = @as(c_int, 2);
pub const SIGILL = @as(c_int, 4);
pub const SIGABRT = @as(c_int, 6);
pub const SIGFPE = @as(c_int, 8);
pub const SIGSEGV = @as(c_int, 11);
pub const SIGTERM = @as(c_int, 15);
pub const SIGHUP = @as(c_int, 1);
pub const SIGQUIT = @as(c_int, 3);
pub const SIGTRAP = @as(c_int, 5);
pub const SIGKILL = @as(c_int, 9);
pub const SIGPIPE = @as(c_int, 13);
pub const SIGALRM = @as(c_int, 14);
pub const SIGIO = SIGPOLL;
pub const SIGIOT = SIGABRT;
pub const SIGCLD = SIGCHLD;
pub const _BITS_SIGNUM_ARCH_H = @as(c_int, 1);
pub const SIGSTKFLT = @as(c_int, 16);
pub const SIGPWR = @as(c_int, 30);
pub const SIGBUS = @as(c_int, 7);
pub const SIGSYS = @as(c_int, 31);
pub const SIGURG = @as(c_int, 23);
pub const SIGSTOP = @as(c_int, 19);
pub const SIGTSTP = @as(c_int, 20);
pub const SIGCONT = @as(c_int, 18);
pub const SIGCHLD = @as(c_int, 17);
pub const SIGTTIN = @as(c_int, 21);
pub const SIGTTOU = @as(c_int, 22);
pub const SIGPOLL = @as(c_int, 29);
pub const SIGXFSZ = @as(c_int, 25);
pub const SIGXCPU = @as(c_int, 24);
pub const SIGVTALRM = @as(c_int, 26);
pub const SIGPROF = @as(c_int, 27);
pub const SIGUSR1 = @as(c_int, 10);
pub const SIGUSR2 = @as(c_int, 12);
pub const SIGWINCH = @as(c_int, 28);
pub const __SIGRTMIN = @as(c_int, 32);
pub const __SIGRTMAX = @as(c_int, 64);
pub const _NSIG = __SIGRTMAX + @as(c_int, 1);
pub const __sig_atomic_t_defined = @as(c_int, 1);
pub const __siginfo_t_defined = @as(c_int, 1);
pub const ____sigval_t_defined = "";
pub const __SI_MAX_SIZE = @as(c_int, 128);
pub const __SI_PAD_SIZE = @import("std").zig.c_translation.MacroArithmetic.div(__SI_MAX_SIZE, @import("std").zig.c_translation.sizeof(c_int)) - @as(c_int, 4);
pub const _BITS_SIGINFO_ARCH_H = @as(c_int, 1);
pub const __SI_ALIGNMENT = "";
pub const __SI_BAND_TYPE = c_long;
pub const __SI_CLOCK_T = __clock_t;
pub const __SI_ERRNO_THEN_CODE = @as(c_int, 1);
pub const __SI_HAVE_SIGSYS = @as(c_int, 1);
pub const __SI_SIGFAULT_ADDL = "";
pub const si_pid = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:128:9
pub const si_uid = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:129:9
pub const si_timerid = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:130:9
pub const si_overrun = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:131:9
pub const si_status = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:132:9
pub const si_utime = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:133:9
pub const si_stime = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:134:9
pub const si_value = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:135:9
pub const si_int = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:136:9
pub const si_ptr = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:137:9
pub const si_addr = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:138:9
pub const si_addr_lsb = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:139:9
pub const si_lower = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:140:9
pub const si_upper = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:141:9
pub const si_pkey = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:142:9
pub const si_band = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:143:9
pub const si_fd = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:144:9
pub const si_call_addr = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:146:10
pub const si_syscall = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:147:10
pub const si_arch = @compileError("unable to translate macro: undefined identifier `_sifields`");
// /usr/include/bits/types/siginfo_t.h:148:10
pub const _BITS_SIGINFO_CONSTS_H = @as(c_int, 1);
pub const __SI_ASYNCIO_AFTER_SIGIO = @as(c_int, 1);
pub const _BITS_SIGINFO_CONSTS_ARCH_H = @as(c_int, 1);
pub const __sigval_t_defined = "";
pub const __sigevent_t_defined = @as(c_int, 1);
pub const __SIGEV_MAX_SIZE = @as(c_int, 64);
pub const __SIGEV_PAD_SIZE = @import("std").zig.c_translation.MacroArithmetic.div(__SIGEV_MAX_SIZE, @import("std").zig.c_translation.sizeof(c_int)) - @as(c_int, 4);
pub const sigev_notify_function = @compileError("unable to translate macro: undefined identifier `_sigev_un`");
// /usr/include/bits/types/sigevent_t.h:45:9
pub const sigev_notify_attributes = @compileError("unable to translate macro: undefined identifier `_sigev_un`");
// /usr/include/bits/types/sigevent_t.h:46:9
pub const _BITS_SIGEVENT_CONSTS_H = @as(c_int, 1);
pub inline fn sigmask(sig: anytype) @TypeOf(__glibc_macro_warning("sigmask is deprecated")(@import("std").zig.c_translation.cast(c_int, @as(c_uint, 1) << (sig - @as(c_int, 1))))) {
    _ = &sig;
    return __glibc_macro_warning("sigmask is deprecated")(@import("std").zig.c_translation.cast(c_int, @as(c_uint, 1) << (sig - @as(c_int, 1))));
}
pub const NSIG = _NSIG;
pub const _BITS_SIGACTION_H = @as(c_int, 1);
pub const sa_handler = @compileError("unable to translate macro: undefined identifier `__sigaction_handler`");
// /usr/include/bits/sigaction.h:39:10
pub const sa_sigaction = @compileError("unable to translate macro: undefined identifier `__sigaction_handler`");
// /usr/include/bits/sigaction.h:40:10
pub const SA_NOCLDSTOP = @as(c_int, 1);
pub const SA_NOCLDWAIT = @as(c_int, 2);
pub const SA_SIGINFO = @as(c_int, 4);
pub const SA_ONSTACK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x08000000, .hex);
pub const SA_RESTART = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000000, .hex);
pub const SA_NODEFER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const SA_RESETHAND = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const SA_INTERRUPT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const SA_NOMASK = SA_NODEFER;
pub const SA_ONESHOT = SA_RESETHAND;
pub const SA_STACK = SA_ONSTACK;
pub const SIG_BLOCK = @as(c_int, 0);
pub const SIG_UNBLOCK = @as(c_int, 1);
pub const SIG_SETMASK = @as(c_int, 2);
pub const _BITS_SIGCONTEXT_H = @as(c_int, 1);
pub const FP_XSTATE_MAGIC1 = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x46505853, .hex);
pub const FP_XSTATE_MAGIC2 = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x46505845, .hex);
pub const FP_XSTATE_MAGIC2_SIZE = @import("std").zig.c_translation.sizeof(FP_XSTATE_MAGIC2);
pub const __stack_t_defined = @as(c_int, 1);
pub const _SYS_UCONTEXT_H = @as(c_int, 1);
pub inline fn __ctx(fld: anytype) @TypeOf(fld) {
    _ = &fld;
    return fld;
}
pub const __NGREG = @as(c_int, 23);
pub const NGREG = __NGREG;
pub const _BITS_SIGSTACK_H = @as(c_int, 1);
pub const MINSIGSTKSZ = @as(c_int, 2048);
pub const SIGSTKSZ = @as(c_int, 8192);
pub const _BITS_SS_FLAGS_H = @as(c_int, 1);
pub const __sigstack_defined = @as(c_int, 1);
pub const _BITS_SIGTHREAD_H = @as(c_int, 1);
pub const SIGRTMIN = __libc_current_sigrtmin();
pub const SIGRTMAX = __libc_current_sigrtmax();
pub const _PWD_H = @as(c_int, 1);
pub const NSS_BUFLEN_PASSWD = @as(c_int, 1024);
pub const _GRP_H = @as(c_int, 1);
pub const NSS_BUFLEN_GROUP = @as(c_int, 1024);
pub const _DIRENT_H = @as(c_int, 1);
pub const d_fileno = @compileError("unable to translate macro: undefined identifier `d_ino`");
// /usr/include/bits/dirent.h:47:9
pub const _DIRENT_HAVE_D_RECLEN = "";
pub const _DIRENT_HAVE_D_OFF = "";
pub const _DIRENT_HAVE_D_TYPE = "";
pub const _DIRENT_MATCHES_DIRENT64 = @as(c_int, 1);
pub inline fn _D_EXACT_NAMLEN(d: anytype) @TypeOf(strlen(d.*.d_name)) {
    _ = &d;
    return strlen(d.*.d_name);
}
pub inline fn _D_ALLOC_NAMLEN(d: anytype) @TypeOf((@import("std").zig.c_translation.cast([*c]u8, d) + d.*.d_reclen) - (&d.*.d_name[@as(usize, @intCast(@as(c_int, 0)))])) {
    _ = &d;
    return (@import("std").zig.c_translation.cast([*c]u8, d) + d.*.d_reclen) - (&d.*.d_name[@as(usize, @intCast(@as(c_int, 0)))]);
}
pub inline fn IFTODT(mode: anytype) @TypeOf((mode & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) >> @as(c_int, 12)) {
    _ = &mode;
    return (mode & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal)) >> @as(c_int, 12);
}
pub inline fn DTTOIF(dirtype: anytype) @TypeOf(dirtype << @as(c_int, 12)) {
    _ = &dirtype;
    return dirtype << @as(c_int, 12);
}
pub const _BITS_POSIX1_LIM_H = @as(c_int, 1);
pub const _POSIX_AIO_LISTIO_MAX = @as(c_int, 2);
pub const _POSIX_AIO_MAX = @as(c_int, 1);
pub const _POSIX_ARG_MAX = @as(c_int, 4096);
pub const _POSIX_CHILD_MAX = @as(c_int, 25);
pub const _POSIX_DELAYTIMER_MAX = @as(c_int, 32);
pub const _POSIX_HOST_NAME_MAX = @as(c_int, 255);
pub const _POSIX_LINK_MAX = @as(c_int, 8);
pub const _POSIX_LOGIN_NAME_MAX = @as(c_int, 9);
pub const _POSIX_MAX_CANON = @as(c_int, 255);
pub const _POSIX_MAX_INPUT = @as(c_int, 255);
pub const _POSIX_MQ_OPEN_MAX = @as(c_int, 8);
pub const _POSIX_MQ_PRIO_MAX = @as(c_int, 32);
pub const _POSIX_NAME_MAX = @as(c_int, 14);
pub const _POSIX_NGROUPS_MAX = @as(c_int, 8);
pub const _POSIX_OPEN_MAX = @as(c_int, 20);
pub const _POSIX_FD_SETSIZE = _POSIX_OPEN_MAX;
pub const _POSIX_PATH_MAX = @as(c_int, 256);
pub const _POSIX_PIPE_BUF = @as(c_int, 512);
pub const _POSIX_RE_DUP_MAX = @as(c_int, 255);
pub const _POSIX_RTSIG_MAX = @as(c_int, 8);
pub const _POSIX_SEM_NSEMS_MAX = @as(c_int, 256);
pub const _POSIX_SEM_VALUE_MAX = @as(c_int, 32767);
pub const _POSIX_SIGQUEUE_MAX = @as(c_int, 32);
pub const _POSIX_SSIZE_MAX = @as(c_int, 32767);
pub const _POSIX_STREAM_MAX = @as(c_int, 8);
pub const _POSIX_SYMLINK_MAX = @as(c_int, 255);
pub const _POSIX_SYMLOOP_MAX = @as(c_int, 8);
pub const _POSIX_TIMER_MAX = @as(c_int, 32);
pub const _POSIX_TTY_NAME_MAX = @as(c_int, 9);
pub const _POSIX_TZNAME_MAX = @as(c_int, 6);
pub const _POSIX_QLIMIT = @as(c_int, 1);
pub const _POSIX_HIWAT = _POSIX_PIPE_BUF;
pub const _POSIX_UIO_MAXIOV = @as(c_int, 16);
pub const _POSIX_CLOCKRES_MIN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 20000000, .decimal);
pub const __undef_NR_OPEN = "";
pub const __undef_LINK_MAX = "";
pub const __undef_OPEN_MAX = "";
pub const __undef_ARG_MAX = "";
pub const _LINUX_LIMITS_H = "";
pub const NR_OPEN = @as(c_int, 1024);
pub const NGROUPS_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub const ARG_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 131072, .decimal);
pub const LINK_MAX = @as(c_int, 127);
pub const MAX_CANON = @as(c_int, 255);
pub const MAX_INPUT = @as(c_int, 255);
pub const NAME_MAX = @as(c_int, 255);
pub const PATH_MAX = @as(c_int, 4096);
pub const PIPE_BUF = @as(c_int, 4096);
pub const XATTR_NAME_MAX = @as(c_int, 255);
pub const XATTR_SIZE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub const XATTR_LIST_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub const RTSIG_MAX = @as(c_int, 32);
pub const _POSIX_THREAD_KEYS_MAX = @as(c_int, 128);
pub const PTHREAD_KEYS_MAX = @as(c_int, 1024);
pub const _POSIX_THREAD_DESTRUCTOR_ITERATIONS = @as(c_int, 4);
pub const PTHREAD_DESTRUCTOR_ITERATIONS = _POSIX_THREAD_DESTRUCTOR_ITERATIONS;
pub const _POSIX_THREAD_THREADS_MAX = @as(c_int, 64);
pub const AIO_PRIO_DELTA_MAX = @as(c_int, 20);
pub const __SC_THREAD_STACK_MIN_VALUE = @as(c_int, 75);
pub const PTHREAD_STACK_MIN = __sysconf(__SC_THREAD_STACK_MIN_VALUE);
pub const DELAYTIMER_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const TTY_NAME_MAX = @as(c_int, 32);
pub const LOGIN_NAME_MAX = @as(c_int, 256);
pub const HOST_NAME_MAX = @as(c_int, 64);
pub const MQ_PRIO_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 32768, .decimal);
pub const SEM_VALUE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SSIZE_MAX = LONG_MAX;
pub const MAXNAMLEN = NAME_MAX;
pub const _GLOB_H = @as(c_int, 1);
pub const GLOB_ERR = @as(c_int, 1) << @as(c_int, 0);
pub const GLOB_MARK = @as(c_int, 1) << @as(c_int, 1);
pub const GLOB_NOSORT = @as(c_int, 1) << @as(c_int, 2);
pub const GLOB_DOOFFS = @as(c_int, 1) << @as(c_int, 3);
pub const GLOB_NOCHECK = @as(c_int, 1) << @as(c_int, 4);
pub const GLOB_APPEND = @as(c_int, 1) << @as(c_int, 5);
pub const GLOB_NOESCAPE = @as(c_int, 1) << @as(c_int, 6);
pub const GLOB_PERIOD = @as(c_int, 1) << @as(c_int, 7);
pub const GLOB_MAGCHAR = @as(c_int, 1) << @as(c_int, 8);
pub const GLOB_ALTDIRFUNC = @as(c_int, 1) << @as(c_int, 9);
pub const GLOB_BRACE = @as(c_int, 1) << @as(c_int, 10);
pub const GLOB_NOMAGIC = @as(c_int, 1) << @as(c_int, 11);
pub const GLOB_TILDE = @as(c_int, 1) << @as(c_int, 12);
pub const GLOB_ONLYDIR = @as(c_int, 1) << @as(c_int, 13);
pub const GLOB_TILDE_CHECK = @as(c_int, 1) << @as(c_int, 14);
pub const __GLOB_FLAGS = ((((((((((((GLOB_ERR | GLOB_MARK) | GLOB_NOSORT) | GLOB_DOOFFS) | GLOB_NOESCAPE) | GLOB_NOCHECK) | GLOB_APPEND) | GLOB_PERIOD) | GLOB_ALTDIRFUNC) | GLOB_BRACE) | GLOB_NOMAGIC) | GLOB_TILDE) | GLOB_ONLYDIR) | GLOB_TILDE_CHECK;
pub const GLOB_NOSPACE = @as(c_int, 1);
pub const GLOB_ABORTED = @as(c_int, 2);
pub const GLOB_NOMATCH = @as(c_int, 3);
pub const GLOB_NOSYS = @as(c_int, 4);
pub const GLOB_ABEND = GLOB_ABORTED;
pub const _SYS_STATFS_H = @as(c_int, 1);
pub const _STATFS_F_NAMELEN = "";
pub const _STATFS_F_FRSIZE = "";
pub const _STATFS_F_FLAGS = "";
pub const _SYS_UIO_H = @as(c_int, 1);
pub const __iovec_defined = @as(c_int, 1);
pub const _BITS_UIO_LIM_H = @as(c_int, 1);
pub const __IOV_MAX = @as(c_int, 1024);
pub const UIO_MAXIOV = __IOV_MAX;
pub const _BITS_UIO_EXT_H = @as(c_int, 1);
pub const RWF_HIPRI = @as(c_int, 0x00000001);
pub const RWF_DSYNC = @as(c_int, 0x00000002);
pub const RWF_SYNC = @as(c_int, 0x00000004);
pub const RWF_NOWAIT = @as(c_int, 0x00000008);
pub const RWF_APPEND = @as(c_int, 0x00000010);
pub const RWF_NOAPPEND = @as(c_int, 0x00000020);
pub const _SYS_STAT_H = @as(c_int, 1);
pub const _BITS_STAT_H = @as(c_int, 1);
pub const _BITS_STRUCT_STAT_H = @as(c_int, 1);
pub const st_atime = @compileError("unable to translate macro: undefined identifier `st_atim`");
// /usr/include/bits/struct_stat.h:77:11
pub const st_mtime = @compileError("unable to translate macro: undefined identifier `st_mtim`");
// /usr/include/bits/struct_stat.h:78:11
pub const st_ctime = @compileError("unable to translate macro: undefined identifier `st_ctim`");
// /usr/include/bits/struct_stat.h:79:11
pub const _STATBUF_ST_BLKSIZE = "";
pub const _STATBUF_ST_RDEV = "";
pub const _STATBUF_ST_NSEC = "";
pub const __S_IFMT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o170000, .octal);
pub const __S_IFDIR = @as(c_int, 0o040000);
pub const __S_IFCHR = @as(c_int, 0o020000);
pub const __S_IFBLK = @as(c_int, 0o060000);
pub const __S_IFREG = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o100000, .octal);
pub const __S_IFIFO = @as(c_int, 0o010000);
pub const __S_IFLNK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o120000, .octal);
pub const __S_IFSOCK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o140000, .octal);
pub inline fn __S_TYPEISMQ(buf: anytype) @TypeOf(buf.*.st_mode - buf.*.st_mode) {
    _ = &buf;
    return buf.*.st_mode - buf.*.st_mode;
}
pub inline fn __S_TYPEISSEM(buf: anytype) @TypeOf(buf.*.st_mode - buf.*.st_mode) {
    _ = &buf;
    return buf.*.st_mode - buf.*.st_mode;
}
pub inline fn __S_TYPEISSHM(buf: anytype) @TypeOf(buf.*.st_mode - buf.*.st_mode) {
    _ = &buf;
    return buf.*.st_mode - buf.*.st_mode;
}
pub const __S_ISUID = @as(c_int, 0o4000);
pub const __S_ISGID = @as(c_int, 0o2000);
pub const __S_ISVTX = @as(c_int, 0o1000);
pub const __S_IREAD = @as(c_int, 0o400);
pub const __S_IWRITE = @as(c_int, 0o200);
pub const __S_IEXEC = @as(c_int, 0o100);
pub const UTIME_NOW = (@as(c_long, 1) << @as(c_int, 30)) - @as(c_long, 1);
pub const UTIME_OMIT = (@as(c_long, 1) << @as(c_int, 30)) - @as(c_long, 2);
pub const S_IFMT = __S_IFMT;
pub const S_IFDIR = __S_IFDIR;
pub const S_IFCHR = __S_IFCHR;
pub const S_IFBLK = __S_IFBLK;
pub const S_IFREG = __S_IFREG;
pub const S_IFIFO = __S_IFIFO;
pub const S_IFLNK = __S_IFLNK;
pub const S_IFSOCK = __S_IFSOCK;
pub inline fn __S_ISTYPE(mode: anytype, mask: anytype) @TypeOf((mode & __S_IFMT) == mask) {
    _ = &mode;
    _ = &mask;
    return (mode & __S_IFMT) == mask;
}
pub inline fn S_ISDIR(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFDIR)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFDIR);
}
pub inline fn S_ISCHR(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFCHR)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFCHR);
}
pub inline fn S_ISBLK(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFBLK)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFBLK);
}
pub inline fn S_ISREG(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFREG)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFREG);
}
pub inline fn S_ISFIFO(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFIFO)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFIFO);
}
pub inline fn S_ISLNK(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFLNK)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFLNK);
}
pub inline fn S_ISSOCK(mode: anytype) @TypeOf(__S_ISTYPE(mode, __S_IFSOCK)) {
    _ = &mode;
    return __S_ISTYPE(mode, __S_IFSOCK);
}
pub inline fn S_TYPEISMQ(buf: anytype) @TypeOf(__S_TYPEISMQ(buf)) {
    _ = &buf;
    return __S_TYPEISMQ(buf);
}
pub inline fn S_TYPEISSEM(buf: anytype) @TypeOf(__S_TYPEISSEM(buf)) {
    _ = &buf;
    return __S_TYPEISSEM(buf);
}
pub inline fn S_TYPEISSHM(buf: anytype) @TypeOf(__S_TYPEISSHM(buf)) {
    _ = &buf;
    return __S_TYPEISSHM(buf);
}
pub const S_ISUID = __S_ISUID;
pub const S_ISGID = __S_ISGID;
pub const S_ISVTX = __S_ISVTX;
pub const S_IRUSR = __S_IREAD;
pub const S_IWUSR = __S_IWRITE;
pub const S_IXUSR = __S_IEXEC;
pub const S_IRWXU = (__S_IREAD | __S_IWRITE) | __S_IEXEC;
pub const S_IREAD = S_IRUSR;
pub const S_IWRITE = S_IWUSR;
pub const S_IEXEC = S_IXUSR;
pub const S_IRGRP = S_IRUSR >> @as(c_int, 3);
pub const S_IWGRP = S_IWUSR >> @as(c_int, 3);
pub const S_IXGRP = S_IXUSR >> @as(c_int, 3);
pub const S_IRWXG = S_IRWXU >> @as(c_int, 3);
pub const S_IROTH = S_IRGRP >> @as(c_int, 3);
pub const S_IWOTH = S_IWGRP >> @as(c_int, 3);
pub const S_IXOTH = S_IXGRP >> @as(c_int, 3);
pub const S_IRWXO = S_IRWXG >> @as(c_int, 3);
pub const ACCESSPERMS = (S_IRWXU | S_IRWXG) | S_IRWXO;
pub const ALLPERMS = ((((S_ISUID | S_ISGID) | S_ISVTX) | S_IRWXU) | S_IRWXG) | S_IRWXO;
pub const DEFFILEMODE = ((((S_IRUSR | S_IWUSR) | S_IRGRP) | S_IWGRP) | S_IROTH) | S_IWOTH;
pub const S_BLKSIZE = @as(c_int, 512);
pub const _LINUX_STAT_H = "";
pub const _LINUX_TYPES_H = "";
pub const _ASM_GENERIC_TYPES_H = "";
pub const _ASM_GENERIC_INT_LL64_H = "";
pub const __ASM_X86_BITSPERLONG_H = "";
pub const __BITS_PER_LONG = @as(c_int, 64);
pub const __ASM_GENERIC_BITS_PER_LONG = "";
pub const __BITS_PER_LONG_LONG = @as(c_int, 64);
pub const _LINUX_POSIX_TYPES_H = "";
pub const _LINUX_STDDEF_H = "";
pub const __struct_group = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /usr/include/linux/stddef.h:26:9
pub const __DECLARE_FLEX_ARRAY = @compileError("unable to translate macro: undefined identifier `__empty_`");
// /usr/include/linux/stddef.h:47:9
pub const __counted_by = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/linux/stddef.h:55:9
pub const __counted_by_le = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/linux/stddef.h:59:9
pub const __counted_by_be = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/linux/stddef.h:63:9
pub const _ASM_X86_POSIX_TYPES_64_H = "";
pub const __ASM_GENERIC_POSIX_TYPES_H = "";
pub const __bitwise = "";
pub const __bitwise__ = "";
pub const __aligned_u64 = @compileError("unable to translate macro: undefined identifier `aligned`");
// /usr/include/linux/types.h:50:9
pub const __aligned_be64 = @compileError("unable to translate macro: undefined identifier `aligned`");
// /usr/include/linux/types.h:51:9
pub const __aligned_le64 = @compileError("unable to translate macro: undefined identifier `aligned`");
// /usr/include/linux/types.h:52:9
pub const STATX_TYPE = @as(c_uint, 0x00000001);
pub const STATX_MODE = @as(c_uint, 0x00000002);
pub const STATX_NLINK = @as(c_uint, 0x00000004);
pub const STATX_UID = @as(c_uint, 0x00000008);
pub const STATX_GID = @as(c_uint, 0x00000010);
pub const STATX_ATIME = @as(c_uint, 0x00000020);
pub const STATX_MTIME = @as(c_uint, 0x00000040);
pub const STATX_CTIME = @as(c_uint, 0x00000080);
pub const STATX_INO = @as(c_uint, 0x00000100);
pub const STATX_SIZE = @as(c_uint, 0x00000200);
pub const STATX_BLOCKS = @as(c_uint, 0x00000400);
pub const STATX_BASIC_STATS = @as(c_uint, 0x000007ff);
pub const STATX_BTIME = @as(c_uint, 0x00000800);
pub const STATX_MNT_ID = @as(c_uint, 0x00001000);
pub const STATX_DIOALIGN = @as(c_uint, 0x00002000);
pub const STATX_MNT_ID_UNIQUE = @as(c_uint, 0x00004000);
pub const STATX_SUBVOL = @as(c_uint, 0x00008000);
pub const STATX__RESERVED = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x80000000, .hex);
pub const STATX_ALL = @as(c_uint, 0x00000fff);
pub const STATX_ATTR_COMPRESSED = @as(c_int, 0x00000004);
pub const STATX_ATTR_IMMUTABLE = @as(c_int, 0x00000010);
pub const STATX_ATTR_APPEND = @as(c_int, 0x00000020);
pub const STATX_ATTR_NODUMP = @as(c_int, 0x00000040);
pub const STATX_ATTR_ENCRYPTED = @as(c_int, 0x00000800);
pub const STATX_ATTR_AUTOMOUNT = @as(c_int, 0x00001000);
pub const STATX_ATTR_MOUNT_ROOT = @as(c_int, 0x00002000);
pub const STATX_ATTR_VERITY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00100000, .hex);
pub const STATX_ATTR_DAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00200000, .hex);
pub const __statx_timestamp_defined = @as(c_int, 1);
pub const __statx_defined = @as(c_int, 1);
pub const _FCNTL_H = @as(c_int, 1);
pub const __O_LARGEFILE = @as(c_int, 0);
pub const F_GETLK64 = @as(c_int, 5);
pub const F_SETLK64 = @as(c_int, 6);
pub const F_SETLKW64 = @as(c_int, 7);
pub const O_ACCMODE = @as(c_int, 0o003);
pub const O_RDONLY = @as(c_int, 0o0);
pub const O_WRONLY = @as(c_int, 0o1);
pub const O_RDWR = @as(c_int, 0o2);
pub const O_CREAT = @as(c_int, 0o100);
pub const O_EXCL = @as(c_int, 0o200);
pub const O_NOCTTY = @as(c_int, 0o400);
pub const O_TRUNC = @as(c_int, 0o1000);
pub const O_APPEND = @as(c_int, 0o2000);
pub const O_NONBLOCK = @as(c_int, 0o4000);
pub const O_NDELAY = O_NONBLOCK;
pub const O_SYNC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o4010000, .octal);
pub const O_FSYNC = O_SYNC;
pub const O_ASYNC = @as(c_int, 0o20000);
pub const __O_DIRECTORY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o200000, .octal);
pub const __O_NOFOLLOW = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o400000, .octal);
pub const __O_CLOEXEC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o2000000, .octal);
pub const __O_DIRECT = @as(c_int, 0o40000);
pub const __O_NOATIME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o1000000, .octal);
pub const __O_PATH = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o10000000, .octal);
pub const __O_DSYNC = @as(c_int, 0o10000);
pub const __O_TMPFILE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0o20000000, .octal) | __O_DIRECTORY;
pub const F_GETLK = F_GETLK64;
pub const F_SETLK = F_SETLK64;
pub const F_SETLKW = F_SETLKW64;
pub const F_OFD_GETLK = @as(c_int, 36);
pub const F_OFD_SETLK = @as(c_int, 37);
pub const F_OFD_SETLKW = @as(c_int, 38);
pub const O_LARGEFILE = __O_LARGEFILE;
pub const O_DIRECTORY = __O_DIRECTORY;
pub const O_NOFOLLOW = __O_NOFOLLOW;
pub const O_CLOEXEC = __O_CLOEXEC;
pub const O_DIRECT = __O_DIRECT;
pub const O_NOATIME = __O_NOATIME;
pub const O_PATH = __O_PATH;
pub const O_TMPFILE = __O_TMPFILE;
pub const O_DSYNC = __O_DSYNC;
pub const O_RSYNC = O_SYNC;
pub const F_DUPFD = @as(c_int, 0);
pub const F_GETFD = @as(c_int, 1);
pub const F_SETFD = @as(c_int, 2);
pub const F_GETFL = @as(c_int, 3);
pub const F_SETFL = @as(c_int, 4);
pub const __F_SETOWN = @as(c_int, 8);
pub const __F_GETOWN = @as(c_int, 9);
pub const F_SETOWN = __F_SETOWN;
pub const F_GETOWN = __F_GETOWN;
pub const __F_SETSIG = @as(c_int, 10);
pub const __F_GETSIG = @as(c_int, 11);
pub const __F_SETOWN_EX = @as(c_int, 15);
pub const __F_GETOWN_EX = @as(c_int, 16);
pub const F_SETSIG = __F_SETSIG;
pub const F_GETSIG = __F_GETSIG;
pub const F_SETOWN_EX = __F_SETOWN_EX;
pub const F_GETOWN_EX = __F_GETOWN_EX;
pub const F_SETLEASE = @as(c_int, 1024);
pub const F_GETLEASE = @as(c_int, 1025);
pub const F_NOTIFY = @as(c_int, 1026);
pub const F_SETPIPE_SZ = @as(c_int, 1031);
pub const F_GETPIPE_SZ = @as(c_int, 1032);
pub const F_ADD_SEALS = @as(c_int, 1033);
pub const F_GET_SEALS = @as(c_int, 1034);
pub const F_GET_RW_HINT = @as(c_int, 1035);
pub const F_SET_RW_HINT = @as(c_int, 1036);
pub const F_GET_FILE_RW_HINT = @as(c_int, 1037);
pub const F_SET_FILE_RW_HINT = @as(c_int, 1038);
pub const F_DUPFD_CLOEXEC = @as(c_int, 1030);
pub const FD_CLOEXEC = @as(c_int, 1);
pub const F_RDLCK = @as(c_int, 0);
pub const F_WRLCK = @as(c_int, 1);
pub const F_UNLCK = @as(c_int, 2);
pub const F_EXLCK = @as(c_int, 4);
pub const F_SHLCK = @as(c_int, 8);
pub const LOCK_SH = @as(c_int, 1);
pub const LOCK_EX = @as(c_int, 2);
pub const LOCK_NB = @as(c_int, 4);
pub const LOCK_UN = @as(c_int, 8);
pub const LOCK_MAND = @as(c_int, 32);
pub const LOCK_READ = @as(c_int, 64);
pub const LOCK_WRITE = @as(c_int, 128);
pub const LOCK_RW = @as(c_int, 192);
pub const DN_ACCESS = @as(c_int, 0x00000001);
pub const DN_MODIFY = @as(c_int, 0x00000002);
pub const DN_CREATE = @as(c_int, 0x00000004);
pub const DN_DELETE = @as(c_int, 0x00000008);
pub const DN_RENAME = @as(c_int, 0x00000010);
pub const DN_ATTRIB = @as(c_int, 0x00000020);
pub const DN_MULTISHOT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const F_SEAL_SEAL = @as(c_int, 0x0001);
pub const F_SEAL_SHRINK = @as(c_int, 0x0002);
pub const F_SEAL_GROW = @as(c_int, 0x0004);
pub const F_SEAL_WRITE = @as(c_int, 0x0008);
pub const F_SEAL_FUTURE_WRITE = @as(c_int, 0x0010);
pub const F_SEAL_EXEC = @as(c_int, 0x0020);
pub const RWH_WRITE_LIFE_NOT_SET = @as(c_int, 0);
pub const RWF_WRITE_LIFE_NOT_SET = RWH_WRITE_LIFE_NOT_SET;
pub const RWH_WRITE_LIFE_NONE = @as(c_int, 1);
pub const RWH_WRITE_LIFE_SHORT = @as(c_int, 2);
pub const RWH_WRITE_LIFE_MEDIUM = @as(c_int, 3);
pub const RWH_WRITE_LIFE_LONG = @as(c_int, 4);
pub const RWH_WRITE_LIFE_EXTREME = @as(c_int, 5);
pub const FAPPEND = O_APPEND;
pub const FFSYNC = O_FSYNC;
pub const FASYNC = O_ASYNC;
pub const FNONBLOCK = O_NONBLOCK;
pub const FNDELAY = O_NDELAY;
pub const __POSIX_FADV_DONTNEED = @as(c_int, 4);
pub const __POSIX_FADV_NOREUSE = @as(c_int, 5);
pub const POSIX_FADV_NORMAL = @as(c_int, 0);
pub const POSIX_FADV_RANDOM = @as(c_int, 1);
pub const POSIX_FADV_SEQUENTIAL = @as(c_int, 2);
pub const POSIX_FADV_WILLNEED = @as(c_int, 3);
pub const POSIX_FADV_DONTNEED = __POSIX_FADV_DONTNEED;
pub const POSIX_FADV_NOREUSE = __POSIX_FADV_NOREUSE;
pub const SYNC_FILE_RANGE_WAIT_BEFORE = @as(c_int, 1);
pub const SYNC_FILE_RANGE_WRITE = @as(c_int, 2);
pub const SYNC_FILE_RANGE_WAIT_AFTER = @as(c_int, 4);
pub const SYNC_FILE_RANGE_WRITE_AND_WAIT = (SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANGE_WAIT_BEFORE) | SYNC_FILE_RANGE_WAIT_AFTER;
pub const SPLICE_F_MOVE = @as(c_int, 1);
pub const SPLICE_F_NONBLOCK = @as(c_int, 2);
pub const SPLICE_F_MORE = @as(c_int, 4);
pub const SPLICE_F_GIFT = @as(c_int, 8);
pub const _FALLOC_H_ = "";
pub const FALLOC_FL_KEEP_SIZE = @as(c_int, 0x01);
pub const FALLOC_FL_PUNCH_HOLE = @as(c_int, 0x02);
pub const FALLOC_FL_NO_HIDE_STALE = @as(c_int, 0x04);
pub const FALLOC_FL_COLLAPSE_RANGE = @as(c_int, 0x08);
pub const FALLOC_FL_ZERO_RANGE = @as(c_int, 0x10);
pub const FALLOC_FL_INSERT_RANGE = @as(c_int, 0x20);
pub const FALLOC_FL_UNSHARE_RANGE = @as(c_int, 0x40);
pub const MAX_HANDLE_SZ = @as(c_int, 128);
pub const AT_HANDLE_FID = AT_REMOVEDIR;
pub inline fn __OPEN_NEEDS_MODE(oflag: anytype) @TypeOf(((oflag & O_CREAT) != @as(c_int, 0)) or ((oflag & __O_TMPFILE) == __O_TMPFILE)) {
    _ = &oflag;
    return ((oflag & O_CREAT) != @as(c_int, 0)) or ((oflag & __O_TMPFILE) == __O_TMPFILE);
}
pub const AT_FDCWD = -@as(c_int, 100);
pub const AT_SYMLINK_NOFOLLOW = @as(c_int, 0x100);
pub const AT_REMOVEDIR = @as(c_int, 0x200);
pub const AT_SYMLINK_FOLLOW = @as(c_int, 0x400);
pub const AT_NO_AUTOMOUNT = @as(c_int, 0x800);
pub const AT_EMPTY_PATH = @as(c_int, 0x1000);
pub const AT_STATX_SYNC_TYPE = @as(c_int, 0x6000);
pub const AT_STATX_SYNC_AS_STAT = @as(c_int, 0x0000);
pub const AT_STATX_FORCE_SYNC = @as(c_int, 0x2000);
pub const AT_STATX_DONT_SYNC = @as(c_int, 0x4000);
pub const AT_RECURSIVE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const AT_EACCESS = @as(c_int, 0x200);
pub const _SYS_WAIT_H = @as(c_int, 1);
pub const WCOREFLAG = __WCOREFLAG;
pub inline fn WCOREDUMP(status: anytype) @TypeOf(__WCOREDUMP(status)) {
    _ = &status;
    return __WCOREDUMP(status);
}
pub inline fn W_EXITCODE(ret: anytype, sig: anytype) @TypeOf(__W_EXITCODE(ret, sig)) {
    _ = &ret;
    _ = &sig;
    return __W_EXITCODE(ret, sig);
}
pub inline fn W_STOPCODE(sig: anytype) @TypeOf(__W_STOPCODE(sig)) {
    _ = &sig;
    return __W_STOPCODE(sig);
}
pub const __idtype_t_defined = "";
pub const WAIT_ANY = -@as(c_int, 1);
pub const WAIT_MYPGRP = @as(c_int, 0);
pub const _SYS_MMAN_H = @as(c_int, 1);
pub const MAP_32BIT = @as(c_int, 0x40);
pub const MAP_ABOVE4G = @as(c_int, 0x80);
pub const SHADOW_STACK_SET_TOKEN = @as(c_int, 0x1);
pub const MAP_GROWSDOWN = @as(c_int, 0x00100);
pub const MAP_DENYWRITE = @as(c_int, 0x00800);
pub const MAP_EXECUTABLE = @as(c_int, 0x01000);
pub const MAP_LOCKED = @as(c_int, 0x02000);
pub const MAP_NORESERVE = @as(c_int, 0x04000);
pub const MAP_POPULATE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x08000, .hex);
pub const MAP_NONBLOCK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000, .hex);
pub const MAP_STACK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000, .hex);
pub const MAP_HUGETLB = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000, .hex);
pub const MAP_SYNC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000, .hex);
pub const MAP_FIXED_NOREPLACE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000, .hex);
pub const PROT_READ = @as(c_int, 0x1);
pub const PROT_WRITE = @as(c_int, 0x2);
pub const PROT_EXEC = @as(c_int, 0x4);
pub const PROT_NONE = @as(c_int, 0x0);
pub const PROT_GROWSDOWN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const PROT_GROWSUP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const MAP_SHARED = @as(c_int, 0x01);
pub const MAP_PRIVATE = @as(c_int, 0x02);
pub const MAP_SHARED_VALIDATE = @as(c_int, 0x03);
pub const MAP_TYPE = @as(c_int, 0x0f);
pub const MAP_FIXED = @as(c_int, 0x10);
pub const MAP_FILE = @as(c_int, 0);
pub const MAP_ANONYMOUS = @as(c_int, 0x20);
pub const MAP_ANON = MAP_ANONYMOUS;
pub const MAP_HUGE_SHIFT = @as(c_int, 26);
pub const MAP_HUGE_MASK = @as(c_int, 0x3f);
pub const MAP_HUGE_16KB = @as(c_int, 14) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_64KB = @as(c_int, 16) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_512KB = @as(c_int, 19) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_1MB = @as(c_int, 20) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_2MB = @as(c_int, 21) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_8MB = @as(c_int, 23) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_16MB = @as(c_int, 24) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_32MB = @as(c_int, 25) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_256MB = @as(c_int, 28) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_512MB = @as(c_int, 29) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_1GB = @as(c_int, 30) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_2GB = @as(c_int, 31) << MAP_HUGE_SHIFT;
pub const MAP_HUGE_16GB = @as(c_uint, 34) << MAP_HUGE_SHIFT;
pub const MS_ASYNC = @as(c_int, 1);
pub const MS_SYNC = @as(c_int, 4);
pub const MS_INVALIDATE = @as(c_int, 2);
pub const MADV_NORMAL = @as(c_int, 0);
pub const MADV_RANDOM = @as(c_int, 1);
pub const MADV_SEQUENTIAL = @as(c_int, 2);
pub const MADV_WILLNEED = @as(c_int, 3);
pub const MADV_DONTNEED = @as(c_int, 4);
pub const MADV_FREE = @as(c_int, 8);
pub const MADV_REMOVE = @as(c_int, 9);
pub const MADV_DONTFORK = @as(c_int, 10);
pub const MADV_DOFORK = @as(c_int, 11);
pub const MADV_MERGEABLE = @as(c_int, 12);
pub const MADV_UNMERGEABLE = @as(c_int, 13);
pub const MADV_HUGEPAGE = @as(c_int, 14);
pub const MADV_NOHUGEPAGE = @as(c_int, 15);
pub const MADV_DONTDUMP = @as(c_int, 16);
pub const MADV_DODUMP = @as(c_int, 17);
pub const MADV_WIPEONFORK = @as(c_int, 18);
pub const MADV_KEEPONFORK = @as(c_int, 19);
pub const MADV_COLD = @as(c_int, 20);
pub const MADV_PAGEOUT = @as(c_int, 21);
pub const MADV_POPULATE_READ = @as(c_int, 22);
pub const MADV_POPULATE_WRITE = @as(c_int, 23);
pub const MADV_DONTNEED_LOCKED = @as(c_int, 24);
pub const MADV_COLLAPSE = @as(c_int, 25);
pub const MADV_HWPOISON = @as(c_int, 100);
pub const POSIX_MADV_NORMAL = @as(c_int, 0);
pub const POSIX_MADV_RANDOM = @as(c_int, 1);
pub const POSIX_MADV_SEQUENTIAL = @as(c_int, 2);
pub const POSIX_MADV_WILLNEED = @as(c_int, 3);
pub const POSIX_MADV_DONTNEED = @as(c_int, 4);
pub const MCL_CURRENT = @as(c_int, 1);
pub const MCL_FUTURE = @as(c_int, 2);
pub const MCL_ONFAULT = @as(c_int, 4);
pub const MREMAP_MAYMOVE = @as(c_int, 1);
pub const MREMAP_FIXED = @as(c_int, 2);
pub const MREMAP_DONTUNMAP = @as(c_int, 4);
pub const MFD_CLOEXEC = @as(c_uint, 1);
pub const MFD_ALLOW_SEALING = @as(c_uint, 2);
pub const MFD_HUGETLB = @as(c_uint, 4);
pub const MFD_NOEXEC_SEAL = @as(c_uint, 8);
pub const MFD_EXEC = @as(c_uint, 0x10);
pub const MLOCK_ONFAULT = @as(c_uint, 1);
pub const PKEY_DISABLE_ACCESS = @as(c_int, 0x1);
pub const PKEY_DISABLE_WRITE = @as(c_int, 0x2);
pub const MAP_FAILED = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_int, 1));
pub const _SYS_RESOURCE_H = @as(c_int, 1);
pub const RLIMIT_RSS = __RLIMIT_RSS;
pub const RLIMIT_OFILE = __RLIMIT_OFILE;
pub const RLIMIT_NPROC = __RLIMIT_NPROC;
pub const RLIMIT_MEMLOCK = __RLIMIT_MEMLOCK;
pub const RLIMIT_LOCKS = __RLIMIT_LOCKS;
pub const RLIMIT_SIGPENDING = __RLIMIT_SIGPENDING;
pub const RLIMIT_MSGQUEUE = __RLIMIT_MSGQUEUE;
pub const RLIMIT_NICE = __RLIMIT_NICE;
pub const RLIMIT_RTPRIO = __RLIMIT_RTPRIO;
pub const RLIMIT_RTTIME = __RLIMIT_RTTIME;
pub const RLIMIT_NLIMITS = __RLIMIT_NLIMITS;
pub const RLIM_NLIMITS = __RLIM_NLIMITS;
pub const RLIM_INFINITY = @as(c_ulonglong, 0xffffffffffffffff);
pub const RLIM64_INFINITY = @as(c_ulonglong, 0xffffffffffffffff);
pub const RLIM_SAVED_MAX = RLIM_INFINITY;
pub const RLIM_SAVED_CUR = RLIM_INFINITY;
pub const RUSAGE_LWP = RUSAGE_THREAD;
pub const __rusage_defined = @as(c_int, 1);
pub const PRIO_MIN = -@as(c_int, 20);
pub const PRIO_MAX = @as(c_int, 20);
pub const _SCHED_H = @as(c_int, 1);
pub const _BITS_SCHED_H = @as(c_int, 1);
pub const SCHED_OTHER = @as(c_int, 0);
pub const SCHED_FIFO = @as(c_int, 1);
pub const SCHED_RR = @as(c_int, 2);
pub const SCHED_BATCH = @as(c_int, 3);
pub const SCHED_ISO = @as(c_int, 4);
pub const SCHED_IDLE = @as(c_int, 5);
pub const SCHED_DEADLINE = @as(c_int, 6);
pub const SCHED_RESET_ON_FORK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const CSIGNAL = @as(c_int, 0x000000ff);
pub const CLONE_VM = @as(c_int, 0x00000100);
pub const CLONE_FS = @as(c_int, 0x00000200);
pub const CLONE_FILES = @as(c_int, 0x00000400);
pub const CLONE_SIGHAND = @as(c_int, 0x00000800);
pub const CLONE_PIDFD = @as(c_int, 0x00001000);
pub const CLONE_PTRACE = @as(c_int, 0x00002000);
pub const CLONE_VFORK = @as(c_int, 0x00004000);
pub const CLONE_PARENT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00008000, .hex);
pub const CLONE_THREAD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hex);
pub const CLONE_NEWNS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020000, .hex);
pub const CLONE_SYSVSEM = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040000, .hex);
pub const CLONE_SETTLS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00080000, .hex);
pub const CLONE_PARENT_SETTID = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00100000, .hex);
pub const CLONE_CHILD_CLEARTID = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00200000, .hex);
pub const CLONE_DETACHED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00400000, .hex);
pub const CLONE_UNTRACED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00800000, .hex);
pub const CLONE_CHILD_SETTID = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const CLONE_NEWCGROUP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const CLONE_NEWUTS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x04000000, .hex);
pub const CLONE_NEWIPC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x08000000, .hex);
pub const CLONE_NEWUSER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000000, .hex);
pub const CLONE_NEWPID = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const CLONE_NEWNET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const CLONE_IO = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const CLONE_NEWTIME = @as(c_int, 0x00000080);
pub const _BITS_TYPES_STRUCT_SCHED_PARAM = @as(c_int, 1);
pub const _BITS_CPU_SET_H = @as(c_int, 1);
pub const __CPU_SETSIZE = @as(c_int, 1024);
pub const __NCPUBITS = @as(c_int, 8) * @import("std").zig.c_translation.sizeof(__cpu_mask);
pub inline fn __CPUELT(cpu: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(cpu, __NCPUBITS)) {
    _ = &cpu;
    return @import("std").zig.c_translation.MacroArithmetic.div(cpu, __NCPUBITS);
}
pub inline fn __CPUMASK(cpu: anytype) @TypeOf(@import("std").zig.c_translation.cast(__cpu_mask, @as(c_int, 1)) << @import("std").zig.c_translation.MacroArithmetic.rem(cpu, __NCPUBITS)) {
    _ = &cpu;
    return @import("std").zig.c_translation.cast(__cpu_mask, @as(c_int, 1)) << @import("std").zig.c_translation.MacroArithmetic.rem(cpu, __NCPUBITS);
}
pub const __CPU_ZERO_S = @compileError("unable to translate C expr: unexpected token 'do'");
// /usr/include/bits/cpu-set.h:46:10
pub const __CPU_SET_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/bits/cpu-set.h:58:9
pub const __CPU_CLR_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/bits/cpu-set.h:65:9
pub const __CPU_ISSET_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/bits/cpu-set.h:72:9
pub inline fn __CPU_COUNT_S(setsize: anytype, cpusetp: anytype) @TypeOf(__sched_cpucount(setsize, cpusetp)) {
    _ = &setsize;
    _ = &cpusetp;
    return __sched_cpucount(setsize, cpusetp);
}
pub const __CPU_EQUAL_S = @compileError("unable to translate macro: undefined identifier `__builtin_memcmp`");
// /usr/include/bits/cpu-set.h:84:10
pub const __CPU_OP_S = @compileError("unable to translate macro: undefined identifier `__dest`");
// /usr/include/bits/cpu-set.h:99:9
pub inline fn __CPU_ALLOC_SIZE(count: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * @import("std").zig.c_translation.sizeof(__cpu_mask)) {
    _ = &count;
    return @import("std").zig.c_translation.MacroArithmetic.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * @import("std").zig.c_translation.sizeof(__cpu_mask);
}
pub inline fn __CPU_ALLOC(count: anytype) @TypeOf(__sched_cpualloc(count)) {
    _ = &count;
    return __sched_cpualloc(count);
}
pub inline fn __CPU_FREE(cpuset: anytype) @TypeOf(__sched_cpufree(cpuset)) {
    _ = &cpuset;
    return __sched_cpufree(cpuset);
}
pub const __sched_priority = @compileError("unable to translate macro: undefined identifier `sched_priority`");
// /usr/include/sched.h:48:9
pub const CPU_SETSIZE = __CPU_SETSIZE;
pub inline fn CPU_SET(cpu: anytype, cpusetp: anytype) @TypeOf(__CPU_SET_S(cpu, @import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp)) {
    _ = &cpu;
    _ = &cpusetp;
    return __CPU_SET_S(cpu, @import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp);
}
pub inline fn CPU_CLR(cpu: anytype, cpusetp: anytype) @TypeOf(__CPU_CLR_S(cpu, @import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp)) {
    _ = &cpu;
    _ = &cpusetp;
    return __CPU_CLR_S(cpu, @import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp);
}
pub inline fn CPU_ISSET(cpu: anytype, cpusetp: anytype) @TypeOf(__CPU_ISSET_S(cpu, @import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp)) {
    _ = &cpu;
    _ = &cpusetp;
    return __CPU_ISSET_S(cpu, @import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp);
}
pub inline fn CPU_ZERO(cpusetp: anytype) @TypeOf(__CPU_ZERO_S(@import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp)) {
    _ = &cpusetp;
    return __CPU_ZERO_S(@import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp);
}
pub inline fn CPU_COUNT(cpusetp: anytype) @TypeOf(__CPU_COUNT_S(@import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp)) {
    _ = &cpusetp;
    return __CPU_COUNT_S(@import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp);
}
pub inline fn CPU_SET_S(cpu: anytype, setsize: anytype, cpusetp: anytype) @TypeOf(__CPU_SET_S(cpu, setsize, cpusetp)) {
    _ = &cpu;
    _ = &setsize;
    _ = &cpusetp;
    return __CPU_SET_S(cpu, setsize, cpusetp);
}
pub inline fn CPU_CLR_S(cpu: anytype, setsize: anytype, cpusetp: anytype) @TypeOf(__CPU_CLR_S(cpu, setsize, cpusetp)) {
    _ = &cpu;
    _ = &setsize;
    _ = &cpusetp;
    return __CPU_CLR_S(cpu, setsize, cpusetp);
}
pub inline fn CPU_ISSET_S(cpu: anytype, setsize: anytype, cpusetp: anytype) @TypeOf(__CPU_ISSET_S(cpu, setsize, cpusetp)) {
    _ = &cpu;
    _ = &setsize;
    _ = &cpusetp;
    return __CPU_ISSET_S(cpu, setsize, cpusetp);
}
pub inline fn CPU_ZERO_S(setsize: anytype, cpusetp: anytype) @TypeOf(__CPU_ZERO_S(setsize, cpusetp)) {
    _ = &setsize;
    _ = &cpusetp;
    return __CPU_ZERO_S(setsize, cpusetp);
}
pub inline fn CPU_COUNT_S(setsize: anytype, cpusetp: anytype) @TypeOf(__CPU_COUNT_S(setsize, cpusetp)) {
    _ = &setsize;
    _ = &cpusetp;
    return __CPU_COUNT_S(setsize, cpusetp);
}
pub inline fn CPU_EQUAL(cpusetp1: anytype, cpusetp2: anytype) @TypeOf(__CPU_EQUAL_S(@import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp1, cpusetp2)) {
    _ = &cpusetp1;
    _ = &cpusetp2;
    return __CPU_EQUAL_S(@import("std").zig.c_translation.sizeof(cpu_set_t), cpusetp1, cpusetp2);
}
pub inline fn CPU_EQUAL_S(setsize: anytype, cpusetp1: anytype, cpusetp2: anytype) @TypeOf(__CPU_EQUAL_S(setsize, cpusetp1, cpusetp2)) {
    _ = &setsize;
    _ = &cpusetp1;
    _ = &cpusetp2;
    return __CPU_EQUAL_S(setsize, cpusetp1, cpusetp2);
}
pub const CPU_AND = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/sched.h:111:10
pub const CPU_OR = @compileError("unable to translate C expr: unexpected token '|'");
// /usr/include/sched.h:113:10
pub const CPU_XOR = @compileError("unable to translate C expr: unexpected token '^'");
// /usr/include/sched.h:115:10
pub const CPU_AND_S = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/sched.h:117:10
pub const CPU_OR_S = @compileError("unable to translate C expr: unexpected token '|'");
// /usr/include/sched.h:119:10
pub const CPU_XOR_S = @compileError("unable to translate C expr: unexpected token '^'");
// /usr/include/sched.h:121:10
pub inline fn CPU_ALLOC_SIZE(count: anytype) @TypeOf(__CPU_ALLOC_SIZE(count)) {
    _ = &count;
    return __CPU_ALLOC_SIZE(count);
}
pub inline fn CPU_ALLOC(count: anytype) @TypeOf(__CPU_ALLOC(count)) {
    _ = &count;
    return __CPU_ALLOC(count);
}
pub inline fn CPU_FREE(cpuset: anytype) @TypeOf(__CPU_FREE(cpuset)) {
    _ = &cpuset;
    return __CPU_FREE(cpuset);
}
pub const _SYS_SOCKET_H = @as(c_int, 1);
pub const __BITS_SOCKET_H = "";
pub const PF_UNSPEC = @as(c_int, 0);
pub const PF_LOCAL = @as(c_int, 1);
pub const PF_UNIX = PF_LOCAL;
pub const PF_FILE = PF_LOCAL;
pub const PF_INET = @as(c_int, 2);
pub const PF_AX25 = @as(c_int, 3);
pub const PF_IPX = @as(c_int, 4);
pub const PF_APPLETALK = @as(c_int, 5);
pub const PF_NETROM = @as(c_int, 6);
pub const PF_BRIDGE = @as(c_int, 7);
pub const PF_ATMPVC = @as(c_int, 8);
pub const PF_X25 = @as(c_int, 9);
pub const PF_INET6 = @as(c_int, 10);
pub const PF_ROSE = @as(c_int, 11);
pub const PF_DECnet = @as(c_int, 12);
pub const PF_NETBEUI = @as(c_int, 13);
pub const PF_SECURITY = @as(c_int, 14);
pub const PF_KEY = @as(c_int, 15);
pub const PF_NETLINK = @as(c_int, 16);
pub const PF_ROUTE = PF_NETLINK;
pub const PF_PACKET = @as(c_int, 17);
pub const PF_ASH = @as(c_int, 18);
pub const PF_ECONET = @as(c_int, 19);
pub const PF_ATMSVC = @as(c_int, 20);
pub const PF_RDS = @as(c_int, 21);
pub const PF_SNA = @as(c_int, 22);
pub const PF_IRDA = @as(c_int, 23);
pub const PF_PPPOX = @as(c_int, 24);
pub const PF_WANPIPE = @as(c_int, 25);
pub const PF_LLC = @as(c_int, 26);
pub const PF_IB = @as(c_int, 27);
pub const PF_MPLS = @as(c_int, 28);
pub const PF_CAN = @as(c_int, 29);
pub const PF_TIPC = @as(c_int, 30);
pub const PF_BLUETOOTH = @as(c_int, 31);
pub const PF_IUCV = @as(c_int, 32);
pub const PF_RXRPC = @as(c_int, 33);
pub const PF_ISDN = @as(c_int, 34);
pub const PF_PHONET = @as(c_int, 35);
pub const PF_IEEE802154 = @as(c_int, 36);
pub const PF_CAIF = @as(c_int, 37);
pub const PF_ALG = @as(c_int, 38);
pub const PF_NFC = @as(c_int, 39);
pub const PF_VSOCK = @as(c_int, 40);
pub const PF_KCM = @as(c_int, 41);
pub const PF_QIPCRTR = @as(c_int, 42);
pub const PF_SMC = @as(c_int, 43);
pub const PF_XDP = @as(c_int, 44);
pub const PF_MCTP = @as(c_int, 45);
pub const PF_MAX = @as(c_int, 46);
pub const AF_UNSPEC = PF_UNSPEC;
pub const AF_LOCAL = PF_LOCAL;
pub const AF_UNIX = PF_UNIX;
pub const AF_FILE = PF_FILE;
pub const AF_INET = PF_INET;
pub const AF_AX25 = PF_AX25;
pub const AF_IPX = PF_IPX;
pub const AF_APPLETALK = PF_APPLETALK;
pub const AF_NETROM = PF_NETROM;
pub const AF_BRIDGE = PF_BRIDGE;
pub const AF_ATMPVC = PF_ATMPVC;
pub const AF_X25 = PF_X25;
pub const AF_INET6 = PF_INET6;
pub const AF_ROSE = PF_ROSE;
pub const AF_DECnet = PF_DECnet;
pub const AF_NETBEUI = PF_NETBEUI;
pub const AF_SECURITY = PF_SECURITY;
pub const AF_KEY = PF_KEY;
pub const AF_NETLINK = PF_NETLINK;
pub const AF_ROUTE = PF_ROUTE;
pub const AF_PACKET = PF_PACKET;
pub const AF_ASH = PF_ASH;
pub const AF_ECONET = PF_ECONET;
pub const AF_ATMSVC = PF_ATMSVC;
pub const AF_RDS = PF_RDS;
pub const AF_SNA = PF_SNA;
pub const AF_IRDA = PF_IRDA;
pub const AF_PPPOX = PF_PPPOX;
pub const AF_WANPIPE = PF_WANPIPE;
pub const AF_LLC = PF_LLC;
pub const AF_IB = PF_IB;
pub const AF_MPLS = PF_MPLS;
pub const AF_CAN = PF_CAN;
pub const AF_TIPC = PF_TIPC;
pub const AF_BLUETOOTH = PF_BLUETOOTH;
pub const AF_IUCV = PF_IUCV;
pub const AF_RXRPC = PF_RXRPC;
pub const AF_ISDN = PF_ISDN;
pub const AF_PHONET = PF_PHONET;
pub const AF_IEEE802154 = PF_IEEE802154;
pub const AF_CAIF = PF_CAIF;
pub const AF_ALG = PF_ALG;
pub const AF_NFC = PF_NFC;
pub const AF_VSOCK = PF_VSOCK;
pub const AF_KCM = PF_KCM;
pub const AF_QIPCRTR = PF_QIPCRTR;
pub const AF_SMC = PF_SMC;
pub const AF_XDP = PF_XDP;
pub const AF_MCTP = PF_MCTP;
pub const AF_MAX = PF_MAX;
pub const SOL_RAW = @as(c_int, 255);
pub const SOL_DECNET = @as(c_int, 261);
pub const SOL_X25 = @as(c_int, 262);
pub const SOL_PACKET = @as(c_int, 263);
pub const SOL_ATM = @as(c_int, 264);
pub const SOL_AAL = @as(c_int, 265);
pub const SOL_IRDA = @as(c_int, 266);
pub const SOL_NETBEUI = @as(c_int, 267);
pub const SOL_LLC = @as(c_int, 268);
pub const SOL_DCCP = @as(c_int, 269);
pub const SOL_NETLINK = @as(c_int, 270);
pub const SOL_TIPC = @as(c_int, 271);
pub const SOL_RXRPC = @as(c_int, 272);
pub const SOL_PPPOL2TP = @as(c_int, 273);
pub const SOL_BLUETOOTH = @as(c_int, 274);
pub const SOL_PNPIPE = @as(c_int, 275);
pub const SOL_RDS = @as(c_int, 276);
pub const SOL_IUCV = @as(c_int, 277);
pub const SOL_CAIF = @as(c_int, 278);
pub const SOL_ALG = @as(c_int, 279);
pub const SOL_NFC = @as(c_int, 280);
pub const SOL_KCM = @as(c_int, 281);
pub const SOL_TLS = @as(c_int, 282);
pub const SOL_XDP = @as(c_int, 283);
pub const SOL_MPTCP = @as(c_int, 284);
pub const SOL_MCTP = @as(c_int, 285);
pub const SOL_SMC = @as(c_int, 286);
pub const SOL_VSOCK = @as(c_int, 287);
pub const SOMAXCONN = @as(c_int, 4096);
pub const _BITS_SOCKADDR_H = @as(c_int, 1);
pub const __SOCKADDR_COMMON = @compileError("unable to translate macro: undefined identifier `family`");
// /usr/include/bits/sockaddr.h:34:9
pub const __SOCKADDR_COMMON_SIZE = @import("std").zig.c_translation.sizeof(c_ushort);
pub const _SS_SIZE = @as(c_int, 128);
pub const __ss_aligntype = c_ulong;
pub const _SS_PADSIZE = (_SS_SIZE - __SOCKADDR_COMMON_SIZE) - @import("std").zig.c_translation.sizeof(__ss_aligntype);
pub inline fn CMSG_DATA(cmsg: anytype) @TypeOf(cmsg.*.__cmsg_data) {
    _ = &cmsg;
    return cmsg.*.__cmsg_data;
}
pub inline fn CMSG_NXTHDR(mhdr: anytype, cmsg: anytype) @TypeOf(__cmsg_nxthdr(mhdr, cmsg)) {
    _ = &mhdr;
    _ = &cmsg;
    return __cmsg_nxthdr(mhdr, cmsg);
}
pub inline fn CMSG_FIRSTHDR(mhdr: anytype) @TypeOf(if (@import("std").zig.c_translation.cast(usize, mhdr.*.msg_controllen) >= @import("std").zig.c_translation.sizeof(struct_cmsghdr)) @import("std").zig.c_translation.cast([*c]struct_cmsghdr, mhdr.*.msg_control) else @import("std").zig.c_translation.cast([*c]struct_cmsghdr, @as(c_int, 0))) {
    _ = &mhdr;
    return if (@import("std").zig.c_translation.cast(usize, mhdr.*.msg_controllen) >= @import("std").zig.c_translation.sizeof(struct_cmsghdr)) @import("std").zig.c_translation.cast([*c]struct_cmsghdr, mhdr.*.msg_control) else @import("std").zig.c_translation.cast([*c]struct_cmsghdr, @as(c_int, 0));
}
pub inline fn CMSG_ALIGN(len: anytype) @TypeOf(((len + @import("std").zig.c_translation.sizeof(usize)) - @as(c_int, 1)) & @import("std").zig.c_translation.cast(usize, ~(@import("std").zig.c_translation.sizeof(usize) - @as(c_int, 1)))) {
    _ = &len;
    return ((len + @import("std").zig.c_translation.sizeof(usize)) - @as(c_int, 1)) & @import("std").zig.c_translation.cast(usize, ~(@import("std").zig.c_translation.sizeof(usize) - @as(c_int, 1)));
}
pub inline fn CMSG_SPACE(len: anytype) @TypeOf(CMSG_ALIGN(len) + CMSG_ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr))) {
    _ = &len;
    return CMSG_ALIGN(len) + CMSG_ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr));
}
pub inline fn CMSG_LEN(len: anytype) @TypeOf(CMSG_ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr)) + len) {
    _ = &len;
    return CMSG_ALIGN(@import("std").zig.c_translation.sizeof(struct_cmsghdr)) + len;
}
pub inline fn __CMSG_PADDING(len: anytype) @TypeOf((@import("std").zig.c_translation.sizeof(usize) - (len & (@import("std").zig.c_translation.sizeof(usize) - @as(c_int, 1)))) & (@import("std").zig.c_translation.sizeof(usize) - @as(c_int, 1))) {
    _ = &len;
    return (@import("std").zig.c_translation.sizeof(usize) - (len & (@import("std").zig.c_translation.sizeof(usize) - @as(c_int, 1)))) & (@import("std").zig.c_translation.sizeof(usize) - @as(c_int, 1));
}
pub const __ASM_GENERIC_SOCKET_H = "";
pub const __ASM_GENERIC_SOCKIOS_H = "";
pub const FIOSETOWN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8901, .hex);
pub const SIOCSPGRP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8902, .hex);
pub const FIOGETOWN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8903, .hex);
pub const SIOCGPGRP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8904, .hex);
pub const SIOCATMARK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8905, .hex);
pub const SIOCGSTAMP_OLD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8906, .hex);
pub const SIOCGSTAMPNS_OLD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8907, .hex);
pub const SOL_SOCKET = @as(c_int, 1);
pub const SO_DEBUG = @as(c_int, 1);
pub const SO_REUSEADDR = @as(c_int, 2);
pub const SO_TYPE = @as(c_int, 3);
pub const SO_ERROR = @as(c_int, 4);
pub const SO_DONTROUTE = @as(c_int, 5);
pub const SO_BROADCAST = @as(c_int, 6);
pub const SO_SNDBUF = @as(c_int, 7);
pub const SO_RCVBUF = @as(c_int, 8);
pub const SO_SNDBUFFORCE = @as(c_int, 32);
pub const SO_RCVBUFFORCE = @as(c_int, 33);
pub const SO_KEEPALIVE = @as(c_int, 9);
pub const SO_OOBINLINE = @as(c_int, 10);
pub const SO_NO_CHECK = @as(c_int, 11);
pub const SO_PRIORITY = @as(c_int, 12);
pub const SO_LINGER = @as(c_int, 13);
pub const SO_BSDCOMPAT = @as(c_int, 14);
pub const SO_REUSEPORT = @as(c_int, 15);
pub const SO_PASSCRED = @as(c_int, 16);
pub const SO_PEERCRED = @as(c_int, 17);
pub const SO_RCVLOWAT = @as(c_int, 18);
pub const SO_SNDLOWAT = @as(c_int, 19);
pub const SO_RCVTIMEO_OLD = @as(c_int, 20);
pub const SO_SNDTIMEO_OLD = @as(c_int, 21);
pub const SO_SECURITY_AUTHENTICATION = @as(c_int, 22);
pub const SO_SECURITY_ENCRYPTION_TRANSPORT = @as(c_int, 23);
pub const SO_SECURITY_ENCRYPTION_NETWORK = @as(c_int, 24);
pub const SO_BINDTODEVICE = @as(c_int, 25);
pub const SO_ATTACH_FILTER = @as(c_int, 26);
pub const SO_DETACH_FILTER = @as(c_int, 27);
pub const SO_GET_FILTER = SO_ATTACH_FILTER;
pub const SO_PEERNAME = @as(c_int, 28);
pub const SO_ACCEPTCONN = @as(c_int, 30);
pub const SO_PEERSEC = @as(c_int, 31);
pub const SO_PASSSEC = @as(c_int, 34);
pub const SO_MARK = @as(c_int, 36);
pub const SO_PROTOCOL = @as(c_int, 38);
pub const SO_DOMAIN = @as(c_int, 39);
pub const SO_RXQ_OVFL = @as(c_int, 40);
pub const SO_WIFI_STATUS = @as(c_int, 41);
pub const SCM_WIFI_STATUS = SO_WIFI_STATUS;
pub const SO_PEEK_OFF = @as(c_int, 42);
pub const SO_NOFCS = @as(c_int, 43);
pub const SO_LOCK_FILTER = @as(c_int, 44);
pub const SO_SELECT_ERR_QUEUE = @as(c_int, 45);
pub const SO_BUSY_POLL = @as(c_int, 46);
pub const SO_MAX_PACING_RATE = @as(c_int, 47);
pub const SO_BPF_EXTENSIONS = @as(c_int, 48);
pub const SO_INCOMING_CPU = @as(c_int, 49);
pub const SO_ATTACH_BPF = @as(c_int, 50);
pub const SO_DETACH_BPF = SO_DETACH_FILTER;
pub const SO_ATTACH_REUSEPORT_CBPF = @as(c_int, 51);
pub const SO_ATTACH_REUSEPORT_EBPF = @as(c_int, 52);
pub const SO_CNX_ADVICE = @as(c_int, 53);
pub const SCM_TIMESTAMPING_OPT_STATS = @as(c_int, 54);
pub const SO_MEMINFO = @as(c_int, 55);
pub const SO_INCOMING_NAPI_ID = @as(c_int, 56);
pub const SO_COOKIE = @as(c_int, 57);
pub const SCM_TIMESTAMPING_PKTINFO = @as(c_int, 58);
pub const SO_PEERGROUPS = @as(c_int, 59);
pub const SO_ZEROCOPY = @as(c_int, 60);
pub const SO_TXTIME = @as(c_int, 61);
pub const SCM_TXTIME = SO_TXTIME;
pub const SO_BINDTOIFINDEX = @as(c_int, 62);
pub const SO_TIMESTAMP_OLD = @as(c_int, 29);
pub const SO_TIMESTAMPNS_OLD = @as(c_int, 35);
pub const SO_TIMESTAMPING_OLD = @as(c_int, 37);
pub const SO_TIMESTAMP_NEW = @as(c_int, 63);
pub const SO_TIMESTAMPNS_NEW = @as(c_int, 64);
pub const SO_TIMESTAMPING_NEW = @as(c_int, 65);
pub const SO_RCVTIMEO_NEW = @as(c_int, 66);
pub const SO_SNDTIMEO_NEW = @as(c_int, 67);
pub const SO_DETACH_REUSEPORT_BPF = @as(c_int, 68);
pub const SO_PREFER_BUSY_POLL = @as(c_int, 69);
pub const SO_BUSY_POLL_BUDGET = @as(c_int, 70);
pub const SO_NETNS_COOKIE = @as(c_int, 71);
pub const SO_BUF_LOCK = @as(c_int, 72);
pub const SO_RESERVE_MEM = @as(c_int, 73);
pub const SO_TXREHASH = @as(c_int, 74);
pub const SO_RCVMARK = @as(c_int, 75);
pub const SO_PASSPIDFD = @as(c_int, 76);
pub const SO_PEERPIDFD = @as(c_int, 77);
pub const SO_TIMESTAMP = SO_TIMESTAMP_OLD;
pub const SO_TIMESTAMPNS = SO_TIMESTAMPNS_OLD;
pub const SO_TIMESTAMPING = SO_TIMESTAMPING_OLD;
pub const SO_RCVTIMEO = SO_RCVTIMEO_OLD;
pub const SO_SNDTIMEO = SO_SNDTIMEO_OLD;
pub const SCM_TIMESTAMP = SO_TIMESTAMP;
pub const SCM_TIMESTAMPNS = SO_TIMESTAMPNS;
pub const SCM_TIMESTAMPING = SO_TIMESTAMPING;
pub const __osockaddr_defined = @as(c_int, 1);
pub const __SOCKADDR_ALLTYPES = @compileError("unable to translate macro: undefined identifier `sockaddr_at`");
// /usr/include/sys/socket.h:63:10
pub const __SOCKADDR_ONETYPE = @compileError("unable to translate macro: untranslatable usage of arg `type`");
// /usr/include/sys/socket.h:78:10
pub const _NETINET_IN_H = @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const __USE_KERNEL_IPV6_DEFS = @as(c_int, 0);
pub const IP_OPTIONS = @as(c_int, 4);
pub const IP_HDRINCL = @as(c_int, 3);
pub const IP_TOS = @as(c_int, 1);
pub const IP_TTL = @as(c_int, 2);
pub const IP_RECVOPTS = @as(c_int, 6);
pub const IP_RECVRETOPTS = IP_RETOPTS;
pub const IP_RETOPTS = @as(c_int, 7);
pub const IP_MULTICAST_IF = @as(c_int, 32);
pub const IP_MULTICAST_TTL = @as(c_int, 33);
pub const IP_MULTICAST_LOOP = @as(c_int, 34);
pub const IP_ADD_MEMBERSHIP = @as(c_int, 35);
pub const IP_DROP_MEMBERSHIP = @as(c_int, 36);
pub const IP_UNBLOCK_SOURCE = @as(c_int, 37);
pub const IP_BLOCK_SOURCE = @as(c_int, 38);
pub const IP_ADD_SOURCE_MEMBERSHIP = @as(c_int, 39);
pub const IP_DROP_SOURCE_MEMBERSHIP = @as(c_int, 40);
pub const IP_MSFILTER = @as(c_int, 41);
pub const MCAST_JOIN_GROUP = @as(c_int, 42);
pub const MCAST_BLOCK_SOURCE = @as(c_int, 43);
pub const MCAST_UNBLOCK_SOURCE = @as(c_int, 44);
pub const MCAST_LEAVE_GROUP = @as(c_int, 45);
pub const MCAST_JOIN_SOURCE_GROUP = @as(c_int, 46);
pub const MCAST_LEAVE_SOURCE_GROUP = @as(c_int, 47);
pub const MCAST_MSFILTER = @as(c_int, 48);
pub const IP_MULTICAST_ALL = @as(c_int, 49);
pub const IP_UNICAST_IF = @as(c_int, 50);
pub const MCAST_EXCLUDE = @as(c_int, 0);
pub const MCAST_INCLUDE = @as(c_int, 1);
pub const IP_ROUTER_ALERT = @as(c_int, 5);
pub const IP_PKTINFO = @as(c_int, 8);
pub const IP_PKTOPTIONS = @as(c_int, 9);
pub const IP_PMTUDISC = @as(c_int, 10);
pub const IP_MTU_DISCOVER = @as(c_int, 10);
pub const IP_RECVERR = @as(c_int, 11);
pub const IP_RECVTTL = @as(c_int, 12);
pub const IP_RECVTOS = @as(c_int, 13);
pub const IP_MTU = @as(c_int, 14);
pub const IP_FREEBIND = @as(c_int, 15);
pub const IP_IPSEC_POLICY = @as(c_int, 16);
pub const IP_XFRM_POLICY = @as(c_int, 17);
pub const IP_PASSSEC = @as(c_int, 18);
pub const IP_TRANSPARENT = @as(c_int, 19);
pub const IP_ORIGDSTADDR = @as(c_int, 20);
pub const IP_RECVORIGDSTADDR = IP_ORIGDSTADDR;
pub const IP_MINTTL = @as(c_int, 21);
pub const IP_NODEFRAG = @as(c_int, 22);
pub const IP_CHECKSUM = @as(c_int, 23);
pub const IP_BIND_ADDRESS_NO_PORT = @as(c_int, 24);
pub const IP_RECVFRAGSIZE = @as(c_int, 25);
pub const IP_RECVERR_RFC4884 = @as(c_int, 26);
pub const IP_PMTUDISC_DONT = @as(c_int, 0);
pub const IP_PMTUDISC_WANT = @as(c_int, 1);
pub const IP_PMTUDISC_DO = @as(c_int, 2);
pub const IP_PMTUDISC_PROBE = @as(c_int, 3);
pub const IP_PMTUDISC_INTERFACE = @as(c_int, 4);
pub const IP_PMTUDISC_OMIT = @as(c_int, 5);
pub const IP_LOCAL_PORT_RANGE = @as(c_int, 51);
pub const IP_PROTOCOL = @as(c_int, 52);
pub const SOL_IP = @as(c_int, 0);
pub const IP_DEFAULT_MULTICAST_TTL = @as(c_int, 1);
pub const IP_DEFAULT_MULTICAST_LOOP = @as(c_int, 1);
pub const IP_MAX_MEMBERSHIPS = @as(c_int, 20);
pub const IPV6_ADDRFORM = @as(c_int, 1);
pub const IPV6_2292PKTINFO = @as(c_int, 2);
pub const IPV6_2292HOPOPTS = @as(c_int, 3);
pub const IPV6_2292DSTOPTS = @as(c_int, 4);
pub const IPV6_2292RTHDR = @as(c_int, 5);
pub const IPV6_2292PKTOPTIONS = @as(c_int, 6);
pub const IPV6_CHECKSUM = @as(c_int, 7);
pub const IPV6_2292HOPLIMIT = @as(c_int, 8);
pub const SCM_SRCRT = @compileError("unable to translate macro: undefined identifier `IPV6_RXSRCRT`");
// /usr/include/bits/in.h:172:9
pub const IPV6_NEXTHOP = @as(c_int, 9);
pub const IPV6_AUTHHDR = @as(c_int, 10);
pub const IPV6_UNICAST_HOPS = @as(c_int, 16);
pub const IPV6_MULTICAST_IF = @as(c_int, 17);
pub const IPV6_MULTICAST_HOPS = @as(c_int, 18);
pub const IPV6_MULTICAST_LOOP = @as(c_int, 19);
pub const IPV6_JOIN_GROUP = @as(c_int, 20);
pub const IPV6_LEAVE_GROUP = @as(c_int, 21);
pub const IPV6_ROUTER_ALERT = @as(c_int, 22);
pub const IPV6_MTU_DISCOVER = @as(c_int, 23);
pub const IPV6_MTU = @as(c_int, 24);
pub const IPV6_RECVERR = @as(c_int, 25);
pub const IPV6_V6ONLY = @as(c_int, 26);
pub const IPV6_JOIN_ANYCAST = @as(c_int, 27);
pub const IPV6_LEAVE_ANYCAST = @as(c_int, 28);
pub const IPV6_MULTICAST_ALL = @as(c_int, 29);
pub const IPV6_ROUTER_ALERT_ISOLATE = @as(c_int, 30);
pub const IPV6_RECVERR_RFC4884 = @as(c_int, 31);
pub const IPV6_IPSEC_POLICY = @as(c_int, 34);
pub const IPV6_XFRM_POLICY = @as(c_int, 35);
pub const IPV6_HDRINCL = @as(c_int, 36);
pub const IPV6_RECVPKTINFO = @as(c_int, 49);
pub const IPV6_PKTINFO = @as(c_int, 50);
pub const IPV6_RECVHOPLIMIT = @as(c_int, 51);
pub const IPV6_HOPLIMIT = @as(c_int, 52);
pub const IPV6_RECVHOPOPTS = @as(c_int, 53);
pub const IPV6_HOPOPTS = @as(c_int, 54);
pub const IPV6_RTHDRDSTOPTS = @as(c_int, 55);
pub const IPV6_RECVRTHDR = @as(c_int, 56);
pub const IPV6_RTHDR = @as(c_int, 57);
pub const IPV6_RECVDSTOPTS = @as(c_int, 58);
pub const IPV6_DSTOPTS = @as(c_int, 59);
pub const IPV6_RECVPATHMTU = @as(c_int, 60);
pub const IPV6_PATHMTU = @as(c_int, 61);
pub const IPV6_DONTFRAG = @as(c_int, 62);
pub const IPV6_RECVTCLASS = @as(c_int, 66);
pub const IPV6_TCLASS = @as(c_int, 67);
pub const IPV6_AUTOFLOWLABEL = @as(c_int, 70);
pub const IPV6_ADDR_PREFERENCES = @as(c_int, 72);
pub const IPV6_MINHOPCOUNT = @as(c_int, 73);
pub const IPV6_ORIGDSTADDR = @as(c_int, 74);
pub const IPV6_RECVORIGDSTADDR = IPV6_ORIGDSTADDR;
pub const IPV6_TRANSPARENT = @as(c_int, 75);
pub const IPV6_UNICAST_IF = @as(c_int, 76);
pub const IPV6_RECVFRAGSIZE = @as(c_int, 77);
pub const IPV6_FREEBIND = @as(c_int, 78);
pub const IPV6_ADD_MEMBERSHIP = IPV6_JOIN_GROUP;
pub const IPV6_DROP_MEMBERSHIP = IPV6_LEAVE_GROUP;
pub const IPV6_RXHOPOPTS = IPV6_HOPOPTS;
pub const IPV6_RXDSTOPTS = IPV6_DSTOPTS;
pub const IPV6_PMTUDISC_DONT = @as(c_int, 0);
pub const IPV6_PMTUDISC_WANT = @as(c_int, 1);
pub const IPV6_PMTUDISC_DO = @as(c_int, 2);
pub const IPV6_PMTUDISC_PROBE = @as(c_int, 3);
pub const IPV6_PMTUDISC_INTERFACE = @as(c_int, 4);
pub const IPV6_PMTUDISC_OMIT = @as(c_int, 5);
pub const SOL_IPV6 = @as(c_int, 41);
pub const SOL_ICMPV6 = @as(c_int, 58);
pub const IPV6_RTHDR_LOOSE = @as(c_int, 0);
pub const IPV6_RTHDR_STRICT = @as(c_int, 1);
pub const IPV6_RTHDR_TYPE_0 = @as(c_int, 0);
pub inline fn IN_CLASSA(a: anytype) @TypeOf((@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex)) == @as(c_int, 0)) {
    _ = &a;
    return (@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex)) == @as(c_int, 0);
}
pub const IN_CLASSA_NET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff000000, .hex);
pub const IN_CLASSA_NSHIFT = @as(c_int, 24);
pub const IN_CLASSA_HOST = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hex) & ~IN_CLASSA_NET;
pub const IN_CLASSA_MAX = @as(c_int, 128);
pub inline fn IN_CLASSB(a: anytype) @TypeOf((@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex)) {
    _ = &a;
    return (@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
}
pub const IN_CLASSB_NET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff0000, .hex);
pub const IN_CLASSB_NSHIFT = @as(c_int, 16);
pub const IN_CLASSB_HOST = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hex) & ~IN_CLASSB_NET;
pub const IN_CLASSB_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub inline fn IN_CLASSC(a: anytype) @TypeOf((@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hex)) {
    _ = &a;
    return (@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000000, .hex);
}
pub const IN_CLASSC_NET = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffff00, .hex);
pub const IN_CLASSC_NSHIFT = @as(c_int, 8);
pub const IN_CLASSC_HOST = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hex) & ~IN_CLASSC_NET;
pub inline fn IN_CLASSD(a: anytype) @TypeOf((@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex)) {
    _ = &a;
    return (@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex);
}
pub inline fn IN_MULTICAST(a: anytype) @TypeOf(IN_CLASSD(a)) {
    _ = &a;
    return IN_CLASSD(a);
}
pub inline fn IN_EXPERIMENTAL(a: anytype) @TypeOf((@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex)) {
    _ = &a;
    return (@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex);
}
pub inline fn IN_BADCLASS(a: anytype) @TypeOf((@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hex)) {
    _ = &a;
    return (@import("std").zig.c_translation.cast(in_addr_t, a) & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hex)) == @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xf0000000, .hex);
}
pub const INADDR_ANY = @import("std").zig.c_translation.cast(in_addr_t, @as(c_int, 0x00000000));
pub const INADDR_BROADCAST = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hex));
pub const INADDR_NONE = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hex));
pub const INADDR_DUMMY = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xc0000008, .hex));
pub const IN_LOOPBACKNET = @as(c_int, 127);
pub const INADDR_LOOPBACK = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7f000001, .hex));
pub const INADDR_UNSPEC_GROUP = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000000, .hex));
pub const INADDR_ALLHOSTS_GROUP = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000001, .hex));
pub const INADDR_ALLRTRS_GROUP = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe0000002, .hex));
pub const INADDR_ALLSNOOPERS_GROUP = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe000006a, .hex));
pub const INADDR_MAX_LOCAL_GROUP = @import("std").zig.c_translation.cast(in_addr_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xe00000ff, .hex));
pub const s6_addr = @compileError("unable to translate macro: undefined identifier `__in6_u`");
// /usr/include/netinet/in.h:229:9
pub const s6_addr16 = @compileError("unable to translate macro: undefined identifier `__in6_u`");
// /usr/include/netinet/in.h:231:10
pub const s6_addr32 = @compileError("unable to translate macro: undefined identifier `__in6_u`");
// /usr/include/netinet/in.h:232:10
pub const IN6ADDR_ANY_INIT = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/netinet/in.h:239:9
pub const IN6ADDR_LOOPBACK_INIT = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/netinet/in.h:240:9
pub const INET_ADDRSTRLEN = @as(c_int, 16);
pub const INET6_ADDRSTRLEN = @as(c_int, 46);
pub inline fn IP_MSFILTER_SIZE(numsrc: anytype) @TypeOf((@import("std").zig.c_translation.sizeof(struct_ip_msfilter) - @import("std").zig.c_translation.sizeof(struct_in_addr)) + (numsrc * @import("std").zig.c_translation.sizeof(struct_in_addr))) {
    _ = &numsrc;
    return (@import("std").zig.c_translation.sizeof(struct_ip_msfilter) - @import("std").zig.c_translation.sizeof(struct_in_addr)) + (numsrc * @import("std").zig.c_translation.sizeof(struct_in_addr));
}
pub inline fn GROUP_FILTER_SIZE(numsrc: anytype) @TypeOf((@import("std").zig.c_translation.sizeof(struct_group_filter) - @import("std").zig.c_translation.sizeof(struct_sockaddr_storage)) + (numsrc * @import("std").zig.c_translation.sizeof(struct_sockaddr_storage))) {
    _ = &numsrc;
    return (@import("std").zig.c_translation.sizeof(struct_group_filter) - @import("std").zig.c_translation.sizeof(struct_sockaddr_storage)) + (numsrc * @import("std").zig.c_translation.sizeof(struct_sockaddr_storage));
}
pub const IN6_IS_ADDR_UNSPECIFIED = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:435:10
pub const IN6_IS_ADDR_LOOPBACK = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:443:10
pub const IN6_IS_ADDR_LINKLOCAL = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:451:10
pub const IN6_IS_ADDR_SITELOCAL = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:456:10
pub const IN6_IS_ADDR_V4MAPPED = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:461:10
pub const IN6_IS_ADDR_V4COMPAT = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:468:10
pub const IN6_ARE_ADDR_EQUAL = @compileError("unable to translate macro: undefined identifier `__a`");
// /usr/include/netinet/in.h:476:10
pub const IN6_IS_ADDR_MULTICAST = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/netinet/in.h:523:9
pub const IN6_IS_ADDR_MC_NODELOCAL = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/netinet/in.h:535:9
pub const IN6_IS_ADDR_MC_LINKLOCAL = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/netinet/in.h:539:9
pub const IN6_IS_ADDR_MC_SITELOCAL = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/netinet/in.h:543:9
pub const IN6_IS_ADDR_MC_ORGLOCAL = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/netinet/in.h:547:9
pub const IN6_IS_ADDR_MC_GLOBAL = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/netinet/in.h:551:9
pub const _NETINET_TCP_H = @as(c_int, 1);
pub const TCP_NODELAY = @as(c_int, 1);
pub const TCP_MAXSEG = @as(c_int, 2);
pub const TCP_CORK = @as(c_int, 3);
pub const TCP_KEEPIDLE = @as(c_int, 4);
pub const TCP_KEEPINTVL = @as(c_int, 5);
pub const TCP_KEEPCNT = @as(c_int, 6);
pub const TCP_SYNCNT = @as(c_int, 7);
pub const TCP_LINGER2 = @as(c_int, 8);
pub const TCP_DEFER_ACCEPT = @as(c_int, 9);
pub const TCP_WINDOW_CLAMP = @as(c_int, 10);
pub const TCP_INFO = @as(c_int, 11);
pub const TCP_QUICKACK = @as(c_int, 12);
pub const TCP_CONGESTION = @as(c_int, 13);
pub const TCP_MD5SIG = @as(c_int, 14);
pub const TCP_COOKIE_TRANSACTIONS = @as(c_int, 15);
pub const TCP_THIN_LINEAR_TIMEOUTS = @as(c_int, 16);
pub const TCP_THIN_DUPACK = @as(c_int, 17);
pub const TCP_USER_TIMEOUT = @as(c_int, 18);
pub const TCP_REPAIR = @as(c_int, 19);
pub const TCP_REPAIR_QUEUE = @as(c_int, 20);
pub const TCP_QUEUE_SEQ = @as(c_int, 21);
pub const TCP_REPAIR_OPTIONS = @as(c_int, 22);
pub const TCP_FASTOPEN = @as(c_int, 23);
pub const TCP_TIMESTAMP = @as(c_int, 24);
pub const TCP_NOTSENT_LOWAT = @as(c_int, 25);
pub const TCP_CC_INFO = @as(c_int, 26);
pub const TCP_SAVE_SYN = @as(c_int, 27);
pub const TCP_SAVED_SYN = @as(c_int, 28);
pub const TCP_REPAIR_WINDOW = @as(c_int, 29);
pub const TCP_FASTOPEN_CONNECT = @as(c_int, 30);
pub const TCP_ULP = @as(c_int, 31);
pub const TCP_MD5SIG_EXT = @as(c_int, 32);
pub const TCP_FASTOPEN_KEY = @as(c_int, 33);
pub const TCP_FASTOPEN_NO_COOKIE = @as(c_int, 34);
pub const TCP_ZEROCOPY_RECEIVE = @as(c_int, 35);
pub const TCP_INQ = @as(c_int, 36);
pub const TCP_CM_INQ = TCP_INQ;
pub const TCP_TX_DELAY = @as(c_int, 37);
pub const TCP_REPAIR_ON = @as(c_int, 1);
pub const TCP_REPAIR_OFF = @as(c_int, 0);
pub const TCP_REPAIR_OFF_NO_WP = -@as(c_int, 1);
pub const _STDINT_H = @as(c_int, 1);
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_LEAST_H = @as(c_int, 1);
pub const __INT64_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const __UINT64_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = @import("std").zig.c_translation.Macros.U_SUFFIX;
pub const UINT64_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const INTMAX_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const UINTMAX_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const INT8_WIDTH = @as(c_int, 8);
pub const UINT8_WIDTH = @as(c_int, 8);
pub const INT16_WIDTH = @as(c_int, 16);
pub const UINT16_WIDTH = @as(c_int, 16);
pub const INT32_WIDTH = @as(c_int, 32);
pub const UINT32_WIDTH = @as(c_int, 32);
pub const INT64_WIDTH = @as(c_int, 64);
pub const UINT64_WIDTH = @as(c_int, 64);
pub const INT_LEAST8_WIDTH = @as(c_int, 8);
pub const UINT_LEAST8_WIDTH = @as(c_int, 8);
pub const INT_LEAST16_WIDTH = @as(c_int, 16);
pub const UINT_LEAST16_WIDTH = @as(c_int, 16);
pub const INT_LEAST32_WIDTH = @as(c_int, 32);
pub const UINT_LEAST32_WIDTH = @as(c_int, 32);
pub const INT_LEAST64_WIDTH = @as(c_int, 64);
pub const UINT_LEAST64_WIDTH = @as(c_int, 64);
pub const INT_FAST8_WIDTH = @as(c_int, 8);
pub const UINT_FAST8_WIDTH = @as(c_int, 8);
pub const INT_FAST16_WIDTH = __WORDSIZE;
pub const UINT_FAST16_WIDTH = __WORDSIZE;
pub const INT_FAST32_WIDTH = __WORDSIZE;
pub const UINT_FAST32_WIDTH = __WORDSIZE;
pub const INT_FAST64_WIDTH = @as(c_int, 64);
pub const UINT_FAST64_WIDTH = @as(c_int, 64);
pub const INTPTR_WIDTH = __WORDSIZE;
pub const UINTPTR_WIDTH = __WORDSIZE;
pub const INTMAX_WIDTH = @as(c_int, 64);
pub const UINTMAX_WIDTH = @as(c_int, 64);
pub const PTRDIFF_WIDTH = __WORDSIZE;
pub const SIG_ATOMIC_WIDTH = @as(c_int, 32);
pub const SIZE_WIDTH = __WORDSIZE;
pub const WCHAR_WIDTH = @as(c_int, 32);
pub const WINT_WIDTH = @as(c_int, 32);
pub const TH_FIN = @as(c_int, 0x01);
pub const TH_SYN = @as(c_int, 0x02);
pub const TH_RST = @as(c_int, 0x04);
pub const TH_PUSH = @as(c_int, 0x08);
pub const TH_ACK = @as(c_int, 0x10);
pub const TH_URG = @as(c_int, 0x20);
pub const TCPOPT_EOL = @as(c_int, 0);
pub const TCPOPT_NOP = @as(c_int, 1);
pub const TCPOPT_MAXSEG = @as(c_int, 2);
pub const TCPOLEN_MAXSEG = @as(c_int, 4);
pub const TCPOPT_WINDOW = @as(c_int, 3);
pub const TCPOLEN_WINDOW = @as(c_int, 3);
pub const TCPOPT_SACK_PERMITTED = @as(c_int, 4);
pub const TCPOLEN_SACK_PERMITTED = @as(c_int, 2);
pub const TCPOPT_SACK = @as(c_int, 5);
pub const TCPOPT_TIMESTAMP = @as(c_int, 8);
pub const TCPOLEN_TIMESTAMP = @as(c_int, 10);
pub const TCPOLEN_TSTAMP_APPA = TCPOLEN_TIMESTAMP + @as(c_int, 2);
pub const TCPOPT_TSTAMP_HDR = (((TCPOPT_NOP << @as(c_int, 24)) | (TCPOPT_NOP << @as(c_int, 16))) | (TCPOPT_TIMESTAMP << @as(c_int, 8))) | TCPOLEN_TIMESTAMP;
pub const TCP_MSS = @as(c_int, 512);
pub const TCP_MAXWIN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const TCP_MAX_WINSHIFT = @as(c_int, 14);
pub const SOL_TCP = @as(c_int, 6);
pub const TCPI_OPT_TIMESTAMPS = @as(c_int, 1);
pub const TCPI_OPT_SACK = @as(c_int, 2);
pub const TCPI_OPT_WSCALE = @as(c_int, 4);
pub const TCPI_OPT_ECN = @as(c_int, 8);
pub const TCPI_OPT_ECN_SEEN = @as(c_int, 16);
pub const TCPI_OPT_SYN_DATA = @as(c_int, 32);
pub const TCP_MD5SIG_MAXKEYLEN = @as(c_int, 80);
pub const TCP_MD5SIG_FLAG_PREFIX = @as(c_int, 1);
pub const TCP_MD5SIG_FLAG_IFINDEX = @as(c_int, 2);
pub const TCP_COOKIE_MIN = @as(c_int, 8);
pub const TCP_COOKIE_MAX = @as(c_int, 16);
pub const TCP_COOKIE_PAIR_SIZE = @as(c_int, 2) * TCP_COOKIE_MAX;
pub const TCP_COOKIE_IN_ALWAYS = @as(c_int, 1) << @as(c_int, 0);
pub const TCP_COOKIE_OUT_NEVER = @as(c_int, 1) << @as(c_int, 1);
pub const TCP_S_DATA_IN = @as(c_int, 1) << @as(c_int, 2);
pub const TCP_S_DATA_OUT = @as(c_int, 1) << @as(c_int, 3);
pub const TCP_MSS_DEFAULT = @as(c_uint, 536);
pub const TCP_MSS_DESIRED = @as(c_uint, 1220);
pub const _ARPA_INET_H = @as(c_int, 1);
pub const _NETDB_H = @as(c_int, 1);
pub const _RPC_NETDB_H = @as(c_int, 1);
pub const _PATH_HEQUIV = "/etc/hosts.equiv";
pub const _PATH_HOSTS = "/etc/hosts";
pub const _PATH_NETWORKS = "/etc/networks";
pub const _PATH_NSSWITCH_CONF = "/etc/nsswitch.conf";
pub const _PATH_PROTOCOLS = "/etc/protocols";
pub const _PATH_SERVICES = "/etc/services";
pub const h_errno = __h_errno_location().*;
pub const HOST_NOT_FOUND = @as(c_int, 1);
pub const TRY_AGAIN = @as(c_int, 2);
pub const NO_RECOVERY = @as(c_int, 3);
pub const NO_DATA = @as(c_int, 4);
pub const NETDB_INTERNAL = -@as(c_int, 1);
pub const NETDB_SUCCESS = @as(c_int, 0);
pub const NO_ADDRESS = NO_DATA;
pub const SCOPE_DELIMITER = '%';
pub const h_addr = @compileError("unable to translate macro: undefined identifier `h_addr_list`");
// /usr/include/netdb.h:106:10
pub const GAI_WAIT = @as(c_int, 0);
pub const GAI_NOWAIT = @as(c_int, 1);
pub const AI_PASSIVE = @as(c_int, 0x0001);
pub const AI_CANONNAME = @as(c_int, 0x0002);
pub const AI_NUMERICHOST = @as(c_int, 0x0004);
pub const AI_V4MAPPED = @as(c_int, 0x0008);
pub const AI_ALL = @as(c_int, 0x0010);
pub const AI_ADDRCONFIG = @as(c_int, 0x0020);
pub const AI_IDN = @as(c_int, 0x0040);
pub const AI_CANONIDN = @as(c_int, 0x0080);
pub const AI_IDN_ALLOW_UNASSIGNED = @compileError("unable to translate C expr: unexpected token 'A number'");
// /usr/include/netdb.h:608:11
pub const AI_IDN_USE_STD3_ASCII_RULES = @compileError("unable to translate C expr: unexpected token 'A number'");
// /usr/include/netdb.h:610:11
pub const AI_NUMERICSERV = @as(c_int, 0x0400);
pub const EAI_BADFLAGS = -@as(c_int, 1);
pub const EAI_NONAME = -@as(c_int, 2);
pub const EAI_AGAIN = -@as(c_int, 3);
pub const EAI_FAIL = -@as(c_int, 4);
pub const EAI_FAMILY = -@as(c_int, 6);
pub const EAI_SOCKTYPE = -@as(c_int, 7);
pub const EAI_SERVICE = -@as(c_int, 8);
pub const EAI_MEMORY = -@as(c_int, 10);
pub const EAI_SYSTEM = -@as(c_int, 11);
pub const EAI_OVERFLOW = -@as(c_int, 12);
pub const EAI_NODATA = -@as(c_int, 5);
pub const EAI_ADDRFAMILY = -@as(c_int, 9);
pub const EAI_INPROGRESS = -@as(c_int, 100);
pub const EAI_CANCELED = -@as(c_int, 101);
pub const EAI_NOTCANCELED = -@as(c_int, 102);
pub const EAI_ALLDONE = -@as(c_int, 103);
pub const EAI_INTR = -@as(c_int, 104);
pub const EAI_IDN_ENCODE = -@as(c_int, 105);
pub const NI_MAXHOST = @as(c_int, 1025);
pub const NI_MAXSERV = @as(c_int, 32);
pub const NI_NUMERICHOST = @as(c_int, 1);
pub const NI_NUMERICSERV = @as(c_int, 2);
pub const NI_NOFQDN = @as(c_int, 4);
pub const NI_NAMEREQD = @as(c_int, 8);
pub const NI_DGRAM = @as(c_int, 16);
pub const NI_IDN = @as(c_int, 32);
pub const NI_IDN_ALLOW_UNASSIGNED = @compileError("unable to translate C expr: unexpected token 'A number'");
// /usr/include/netdb.h:649:11
pub const NI_IDN_USE_STD3_ASCII_RULES = @compileError("unable to translate C expr: unexpected token 'A number'");
// /usr/include/netdb.h:651:11
pub const _SYS_UN_H = @as(c_int, 1);
pub const SUN_LEN = @compileError("unable to translate macro: undefined identifier `sun_path`");
// /usr/include/sys/un.h:41:10
pub const _TIME_H = @as(c_int, 1);
pub const _BITS_TIME_H = @as(c_int, 1);
pub const CLOCKS_PER_SEC = @import("std").zig.c_translation.cast(__clock_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 1000000, .decimal));
pub const CLOCK_REALTIME = @as(c_int, 0);
pub const CLOCK_MONOTONIC = @as(c_int, 1);
pub const CLOCK_PROCESS_CPUTIME_ID = @as(c_int, 2);
pub const CLOCK_THREAD_CPUTIME_ID = @as(c_int, 3);
pub const CLOCK_MONOTONIC_RAW = @as(c_int, 4);
pub const CLOCK_REALTIME_COARSE = @as(c_int, 5);
pub const CLOCK_MONOTONIC_COARSE = @as(c_int, 6);
pub const CLOCK_BOOTTIME = @as(c_int, 7);
pub const CLOCK_REALTIME_ALARM = @as(c_int, 8);
pub const CLOCK_BOOTTIME_ALARM = @as(c_int, 9);
pub const CLOCK_TAI = @as(c_int, 11);
pub const TIMER_ABSTIME = @as(c_int, 1);
pub const _BITS_TIMEX_H = @as(c_int, 1);
pub const ADJ_OFFSET = @as(c_int, 0x0001);
pub const ADJ_FREQUENCY = @as(c_int, 0x0002);
pub const ADJ_MAXERROR = @as(c_int, 0x0004);
pub const ADJ_ESTERROR = @as(c_int, 0x0008);
pub const ADJ_STATUS = @as(c_int, 0x0010);
pub const ADJ_TIMECONST = @as(c_int, 0x0020);
pub const ADJ_TAI = @as(c_int, 0x0080);
pub const ADJ_SETOFFSET = @as(c_int, 0x0100);
pub const ADJ_MICRO = @as(c_int, 0x1000);
pub const ADJ_NANO = @as(c_int, 0x2000);
pub const ADJ_TICK = @as(c_int, 0x4000);
pub const ADJ_OFFSET_SINGLESHOT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8001, .hex);
pub const ADJ_OFFSET_SS_READ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xa001, .hex);
pub const MOD_OFFSET = ADJ_OFFSET;
pub const MOD_FREQUENCY = ADJ_FREQUENCY;
pub const MOD_MAXERROR = ADJ_MAXERROR;
pub const MOD_ESTERROR = ADJ_ESTERROR;
pub const MOD_STATUS = ADJ_STATUS;
pub const MOD_TIMECONST = ADJ_TIMECONST;
pub const MOD_CLKB = ADJ_TICK;
pub const MOD_CLKA = ADJ_OFFSET_SINGLESHOT;
pub const MOD_TAI = ADJ_TAI;
pub const MOD_MICRO = ADJ_MICRO;
pub const MOD_NANO = ADJ_NANO;
pub const STA_PLL = @as(c_int, 0x0001);
pub const STA_PPSFREQ = @as(c_int, 0x0002);
pub const STA_PPSTIME = @as(c_int, 0x0004);
pub const STA_FLL = @as(c_int, 0x0008);
pub const STA_INS = @as(c_int, 0x0010);
pub const STA_DEL = @as(c_int, 0x0020);
pub const STA_UNSYNC = @as(c_int, 0x0040);
pub const STA_FREQHOLD = @as(c_int, 0x0080);
pub const STA_PPSSIGNAL = @as(c_int, 0x0100);
pub const STA_PPSJITTER = @as(c_int, 0x0200);
pub const STA_PPSWANDER = @as(c_int, 0x0400);
pub const STA_PPSERROR = @as(c_int, 0x0800);
pub const STA_CLOCKERR = @as(c_int, 0x1000);
pub const STA_NANO = @as(c_int, 0x2000);
pub const STA_MODE = @as(c_int, 0x4000);
pub const STA_CLK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const STA_RONLY = ((((((STA_PPSSIGNAL | STA_PPSJITTER) | STA_PPSWANDER) | STA_PPSERROR) | STA_CLOCKERR) | STA_NANO) | STA_MODE) | STA_CLK;
pub const __struct_tm_defined = @as(c_int, 1);
pub const __itimerspec_defined = @as(c_int, 1);
pub const TIME_UTC = @as(c_int, 1);
pub inline fn __isleap(year: anytype) @TypeOf((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 400)) == @as(c_int, 0)))) {
    _ = &year;
    return (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 400)) == @as(c_int, 0)));
}
pub const _MALLOC_H = @as(c_int, 1);
pub const __MALLOC_HOOK_VOLATILE = @compileError("unable to translate C expr: unexpected token 'volatile'");
// /usr/include/malloc.h:31:10
pub const __MALLOC_DEPRECATED = __attribute_deprecated__;
pub const M_MXFAST = @as(c_int, 1);
pub const M_NLBLKS = @as(c_int, 2);
pub const M_GRAIN = @as(c_int, 3);
pub const M_KEEP = @as(c_int, 4);
pub const M_TRIM_THRESHOLD = -@as(c_int, 1);
pub const M_TOP_PAD = -@as(c_int, 2);
pub const M_MMAP_THRESHOLD = -@as(c_int, 3);
pub const M_MMAP_MAX = -@as(c_int, 4);
pub const M_CHECK_ACTION = -@as(c_int, 5);
pub const M_PERTURB = -@as(c_int, 6);
pub const M_ARENA_TEST = -@as(c_int, 7);
pub const M_ARENA_MAX = -@as(c_int, 8);
pub const _LIBC_LIMITS_H_ = @as(c_int, 1);
pub const MB_LEN_MAX = @as(c_int, 16);
pub const __CLANG_LIMITS_H = "";
pub const _GCC_LIMITS_H_ = "";
pub const SCHAR_MAX = __SCHAR_MAX__;
pub const SHRT_MAX = __SHRT_MAX__;
pub const INT_MAX = __INT_MAX__;
pub const LONG_MAX = __LONG_MAX__;
pub const SCHAR_MIN = -__SCHAR_MAX__ - @as(c_int, 1);
pub const SHRT_MIN = -__SHRT_MAX__ - @as(c_int, 1);
pub const INT_MIN = -__INT_MAX__ - @as(c_int, 1);
pub const LONG_MIN = -__LONG_MAX__ - @as(c_long, 1);
pub const UCHAR_MAX = (__SCHAR_MAX__ * @as(c_int, 2)) + @as(c_int, 1);
pub const USHRT_MAX = (__SHRT_MAX__ * @as(c_int, 2)) + @as(c_int, 1);
pub const UINT_MAX = (__INT_MAX__ * @as(c_uint, 2)) + @as(c_uint, 1);
pub const ULONG_MAX = (__LONG_MAX__ * @as(c_ulong, 2)) + @as(c_ulong, 1);
pub const CHAR_BIT = __CHAR_BIT__;
pub const CHAR_MIN = SCHAR_MIN;
pub const CHAR_MAX = __SCHAR_MAX__;
pub const LLONG_MAX = __LONG_LONG_MAX__;
pub const LLONG_MIN = -__LONG_LONG_MAX__ - @as(c_longlong, 1);
pub const ULLONG_MAX = (__LONG_LONG_MAX__ * @as(c_ulonglong, 2)) + @as(c_ulonglong, 1);
pub const LONG_LONG_MAX = __LONG_LONG_MAX__;
pub const LONG_LONG_MIN = -__LONG_LONG_MAX__ - @as(c_longlong, 1);
pub const ULONG_LONG_MAX = (__LONG_LONG_MAX__ * @as(c_ulonglong, 2)) + @as(c_ulonglong, 1);
pub const CHAR_WIDTH = @as(c_int, 8);
pub const SCHAR_WIDTH = @as(c_int, 8);
pub const UCHAR_WIDTH = @as(c_int, 8);
pub const SHRT_WIDTH = @as(c_int, 16);
pub const USHRT_WIDTH = @as(c_int, 16);
pub const INT_WIDTH = @as(c_int, 32);
pub const UINT_WIDTH = @as(c_int, 32);
pub const LONG_WIDTH = __WORDSIZE;
pub const ULONG_WIDTH = __WORDSIZE;
pub const LLONG_WIDTH = @as(c_int, 64);
pub const ULLONG_WIDTH = @as(c_int, 64);
pub const BOOL_MAX = @as(c_int, 1);
pub const BOOL_WIDTH = @as(c_int, 1);
pub const _BITS_POSIX2_LIM_H = @as(c_int, 1);
pub const _POSIX2_BC_BASE_MAX = @as(c_int, 99);
pub const _POSIX2_BC_DIM_MAX = @as(c_int, 2048);
pub const _POSIX2_BC_SCALE_MAX = @as(c_int, 99);
pub const _POSIX2_BC_STRING_MAX = @as(c_int, 1000);
pub const _POSIX2_COLL_WEIGHTS_MAX = @as(c_int, 2);
pub const _POSIX2_EXPR_NEST_MAX = @as(c_int, 32);
pub const _POSIX2_LINE_MAX = @as(c_int, 2048);
pub const _POSIX2_RE_DUP_MAX = @as(c_int, 255);
pub const _POSIX2_CHARCLASS_NAME_MAX = @as(c_int, 14);
pub const BC_BASE_MAX = _POSIX2_BC_BASE_MAX;
pub const BC_DIM_MAX = _POSIX2_BC_DIM_MAX;
pub const BC_SCALE_MAX = _POSIX2_BC_SCALE_MAX;
pub const BC_STRING_MAX = _POSIX2_BC_STRING_MAX;
pub const COLL_WEIGHTS_MAX = @as(c_int, 255);
pub const EXPR_NEST_MAX = _POSIX2_EXPR_NEST_MAX;
pub const LINE_MAX = _POSIX2_LINE_MAX;
pub const CHARCLASS_NAME_MAX = @as(c_int, 2048);
pub const RE_DUP_MAX = @as(c_int, 0x7fff);
pub const _XOPEN_LIM_H = @as(c_int, 1);
pub const _XOPEN_IOV_MAX = _POSIX_UIO_MAXIOV;
pub const IOV_MAX = __IOV_MAX;
pub const NL_ARGMAX = _POSIX_ARG_MAX;
pub const NL_LANGMAX = _POSIX2_LINE_MAX;
pub const NL_MSGMAX = INT_MAX;
pub const NL_NMAX = INT_MAX;
pub const NL_SETMAX = INT_MAX;
pub const NL_TEXTMAX = INT_MAX;
pub const NZERO = @as(c_int, 20);
pub const WORD_BIT = @as(c_int, 32);
pub const LONG_BIT = @as(c_int, 64);
pub const _SYS_IOCTL_H = @as(c_int, 1);
pub const __ASM_GENERIC_IOCTLS_H = "";
pub const _LINUX_IOCTL_H = "";
pub const _ASM_GENERIC_IOCTL_H = "";
pub const _IOC_NRBITS = @as(c_int, 8);
pub const _IOC_TYPEBITS = @as(c_int, 8);
pub const _IOC_SIZEBITS = @as(c_int, 14);
pub const _IOC_DIRBITS = @as(c_int, 2);
pub const _IOC_NRMASK = (@as(c_int, 1) << _IOC_NRBITS) - @as(c_int, 1);
pub const _IOC_TYPEMASK = (@as(c_int, 1) << _IOC_TYPEBITS) - @as(c_int, 1);
pub const _IOC_SIZEMASK = (@as(c_int, 1) << _IOC_SIZEBITS) - @as(c_int, 1);
pub const _IOC_DIRMASK = (@as(c_int, 1) << _IOC_DIRBITS) - @as(c_int, 1);
pub const _IOC_NRSHIFT = @as(c_int, 0);
pub const _IOC_TYPESHIFT = _IOC_NRSHIFT + _IOC_NRBITS;
pub const _IOC_SIZESHIFT = _IOC_TYPESHIFT + _IOC_TYPEBITS;
pub const _IOC_DIRSHIFT = _IOC_SIZESHIFT + _IOC_SIZEBITS;
pub const _IOC_NONE = @as(c_uint, 0);
pub const _IOC_WRITE = @as(c_uint, 1);
pub const _IOC_READ = @as(c_uint, 2);
pub inline fn _IOC(dir: anytype, @"type": anytype, nr: anytype, size: anytype) @TypeOf((((dir << _IOC_DIRSHIFT) | (@"type" << _IOC_TYPESHIFT)) | (nr << _IOC_NRSHIFT)) | (size << _IOC_SIZESHIFT)) {
    _ = &dir;
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return (((dir << _IOC_DIRSHIFT) | (@"type" << _IOC_TYPESHIFT)) | (nr << _IOC_NRSHIFT)) | (size << _IOC_SIZESHIFT);
}
pub inline fn _IOC_TYPECHECK(t: anytype) @TypeOf(@import("std").zig.c_translation.sizeof(t)) {
    _ = &t;
    return @import("std").zig.c_translation.sizeof(t);
}
pub inline fn _IO(@"type": anytype, nr: anytype) @TypeOf(_IOC(_IOC_NONE, @"type", nr, @as(c_int, 0))) {
    _ = &@"type";
    _ = &nr;
    return _IOC(_IOC_NONE, @"type", nr, @as(c_int, 0));
}
pub inline fn _IOR(@"type": anytype, nr: anytype, size: anytype) @TypeOf(_IOC(_IOC_READ, @"type", nr, _IOC_TYPECHECK(size))) {
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return _IOC(_IOC_READ, @"type", nr, _IOC_TYPECHECK(size));
}
pub inline fn _IOW(@"type": anytype, nr: anytype, size: anytype) @TypeOf(_IOC(_IOC_WRITE, @"type", nr, _IOC_TYPECHECK(size))) {
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return _IOC(_IOC_WRITE, @"type", nr, _IOC_TYPECHECK(size));
}
pub inline fn _IOWR(@"type": anytype, nr: anytype, size: anytype) @TypeOf(_IOC(_IOC_READ | _IOC_WRITE, @"type", nr, _IOC_TYPECHECK(size))) {
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return _IOC(_IOC_READ | _IOC_WRITE, @"type", nr, _IOC_TYPECHECK(size));
}
pub inline fn _IOR_BAD(@"type": anytype, nr: anytype, size: anytype) @TypeOf(_IOC(_IOC_READ, @"type", nr, @import("std").zig.c_translation.sizeof(size))) {
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return _IOC(_IOC_READ, @"type", nr, @import("std").zig.c_translation.sizeof(size));
}
pub inline fn _IOW_BAD(@"type": anytype, nr: anytype, size: anytype) @TypeOf(_IOC(_IOC_WRITE, @"type", nr, @import("std").zig.c_translation.sizeof(size))) {
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return _IOC(_IOC_WRITE, @"type", nr, @import("std").zig.c_translation.sizeof(size));
}
pub inline fn _IOWR_BAD(@"type": anytype, nr: anytype, size: anytype) @TypeOf(_IOC(_IOC_READ | _IOC_WRITE, @"type", nr, @import("std").zig.c_translation.sizeof(size))) {
    _ = &@"type";
    _ = &nr;
    _ = &size;
    return _IOC(_IOC_READ | _IOC_WRITE, @"type", nr, @import("std").zig.c_translation.sizeof(size));
}
pub inline fn _IOC_DIR(nr: anytype) @TypeOf((nr >> _IOC_DIRSHIFT) & _IOC_DIRMASK) {
    _ = &nr;
    return (nr >> _IOC_DIRSHIFT) & _IOC_DIRMASK;
}
pub inline fn _IOC_TYPE(nr: anytype) @TypeOf((nr >> _IOC_TYPESHIFT) & _IOC_TYPEMASK) {
    _ = &nr;
    return (nr >> _IOC_TYPESHIFT) & _IOC_TYPEMASK;
}
pub inline fn _IOC_NR(nr: anytype) @TypeOf((nr >> _IOC_NRSHIFT) & _IOC_NRMASK) {
    _ = &nr;
    return (nr >> _IOC_NRSHIFT) & _IOC_NRMASK;
}
pub inline fn _IOC_SIZE(nr: anytype) @TypeOf((nr >> _IOC_SIZESHIFT) & _IOC_SIZEMASK) {
    _ = &nr;
    return (nr >> _IOC_SIZESHIFT) & _IOC_SIZEMASK;
}
pub const IOC_IN = _IOC_WRITE << _IOC_DIRSHIFT;
pub const IOC_OUT = _IOC_READ << _IOC_DIRSHIFT;
pub const IOC_INOUT = (_IOC_WRITE | _IOC_READ) << _IOC_DIRSHIFT;
pub const IOCSIZE_MASK = _IOC_SIZEMASK << _IOC_SIZESHIFT;
pub const IOCSIZE_SHIFT = _IOC_SIZESHIFT;
pub const TCGETS = @as(c_int, 0x5401);
pub const TCSETS = @as(c_int, 0x5402);
pub const TCSETSW = @as(c_int, 0x5403);
pub const TCSETSF = @as(c_int, 0x5404);
pub const TCGETA = @as(c_int, 0x5405);
pub const TCSETA = @as(c_int, 0x5406);
pub const TCSETAW = @as(c_int, 0x5407);
pub const TCSETAF = @as(c_int, 0x5408);
pub const TCSBRK = @as(c_int, 0x5409);
pub const TCXONC = @as(c_int, 0x540A);
pub const TCFLSH = @as(c_int, 0x540B);
pub const TIOCEXCL = @as(c_int, 0x540C);
pub const TIOCNXCL = @as(c_int, 0x540D);
pub const TIOCSCTTY = @as(c_int, 0x540E);
pub const TIOCGPGRP = @as(c_int, 0x540F);
pub const TIOCSPGRP = @as(c_int, 0x5410);
pub const TIOCOUTQ = @as(c_int, 0x5411);
pub const TIOCSTI = @as(c_int, 0x5412);
pub const TIOCGWINSZ = @as(c_int, 0x5413);
pub const TIOCSWINSZ = @as(c_int, 0x5414);
pub const TIOCMGET = @as(c_int, 0x5415);
pub const TIOCMBIS = @as(c_int, 0x5416);
pub const TIOCMBIC = @as(c_int, 0x5417);
pub const TIOCMSET = @as(c_int, 0x5418);
pub const TIOCGSOFTCAR = @as(c_int, 0x5419);
pub const TIOCSSOFTCAR = @as(c_int, 0x541A);
pub const FIONREAD = @as(c_int, 0x541B);
pub const TIOCINQ = FIONREAD;
pub const TIOCLINUX = @as(c_int, 0x541C);
pub const TIOCCONS = @as(c_int, 0x541D);
pub const TIOCGSERIAL = @as(c_int, 0x541E);
pub const TIOCSSERIAL = @as(c_int, 0x541F);
pub const TIOCPKT = @as(c_int, 0x5420);
pub const FIONBIO = @as(c_int, 0x5421);
pub const TIOCNOTTY = @as(c_int, 0x5422);
pub const TIOCSETD = @as(c_int, 0x5423);
pub const TIOCGETD = @as(c_int, 0x5424);
pub const TCSBRKP = @as(c_int, 0x5425);
pub const TIOCSBRK = @as(c_int, 0x5427);
pub const TIOCCBRK = @as(c_int, 0x5428);
pub const TIOCGSID = @as(c_int, 0x5429);
pub const TCGETS2 = @compileError("unable to translate macro: undefined identifier `termios2`");
// /usr/include/asm-generic/ioctls.h:61:9
pub const TCSETS2 = @compileError("unable to translate macro: undefined identifier `termios2`");
// /usr/include/asm-generic/ioctls.h:62:9
pub const TCSETSW2 = @compileError("unable to translate macro: undefined identifier `termios2`");
// /usr/include/asm-generic/ioctls.h:63:9
pub const TCSETSF2 = @compileError("unable to translate macro: undefined identifier `termios2`");
// /usr/include/asm-generic/ioctls.h:64:9
pub const TIOCGRS485 = @as(c_int, 0x542E);
pub const TIOCSRS485 = @as(c_int, 0x542F);
pub const TIOCGPTN = _IOR('T', @as(c_int, 0x30), c_uint);
pub const TIOCSPTLCK = _IOW('T', @as(c_int, 0x31), c_int);
pub const TIOCGDEV = _IOR('T', @as(c_int, 0x32), c_uint);
pub const TCGETX = @as(c_int, 0x5432);
pub const TCSETX = @as(c_int, 0x5433);
pub const TCSETXF = @as(c_int, 0x5434);
pub const TCSETXW = @as(c_int, 0x5435);
pub const TIOCSIG = _IOW('T', @as(c_int, 0x36), c_int);
pub const TIOCVHANGUP = @as(c_int, 0x5437);
pub const TIOCGPKT = _IOR('T', @as(c_int, 0x38), c_int);
pub const TIOCGPTLCK = _IOR('T', @as(c_int, 0x39), c_int);
pub const TIOCGEXCL = _IOR('T', @as(c_int, 0x40), c_int);
pub const TIOCGPTPEER = _IO('T', @as(c_int, 0x41));
pub const TIOCGISO7816 = @compileError("unable to translate macro: undefined identifier `serial_iso7816`");
// /usr/include/asm-generic/ioctls.h:82:9
pub const TIOCSISO7816 = @compileError("unable to translate macro: undefined identifier `serial_iso7816`");
// /usr/include/asm-generic/ioctls.h:83:9
pub const FIONCLEX = @as(c_int, 0x5450);
pub const FIOCLEX = @as(c_int, 0x5451);
pub const FIOASYNC = @as(c_int, 0x5452);
pub const TIOCSERCONFIG = @as(c_int, 0x5453);
pub const TIOCSERGWILD = @as(c_int, 0x5454);
pub const TIOCSERSWILD = @as(c_int, 0x5455);
pub const TIOCGLCKTRMIOS = @as(c_int, 0x5456);
pub const TIOCSLCKTRMIOS = @as(c_int, 0x5457);
pub const TIOCSERGSTRUCT = @as(c_int, 0x5458);
pub const TIOCSERGETLSR = @as(c_int, 0x5459);
pub const TIOCSERGETMULTI = @as(c_int, 0x545A);
pub const TIOCSERSETMULTI = @as(c_int, 0x545B);
pub const TIOCMIWAIT = @as(c_int, 0x545C);
pub const TIOCGICOUNT = @as(c_int, 0x545D);
pub const FIOQSIZE = @as(c_int, 0x5460);
pub const TIOCPKT_DATA = @as(c_int, 0);
pub const TIOCPKT_FLUSHREAD = @as(c_int, 1);
pub const TIOCPKT_FLUSHWRITE = @as(c_int, 2);
pub const TIOCPKT_STOP = @as(c_int, 4);
pub const TIOCPKT_START = @as(c_int, 8);
pub const TIOCPKT_NOSTOP = @as(c_int, 16);
pub const TIOCPKT_DOSTOP = @as(c_int, 32);
pub const TIOCPKT_IOCTL = @as(c_int, 64);
pub const TIOCSER_TEMT = @as(c_int, 0x01);
pub const SIOCADDRT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x890B, .hex);
pub const SIOCDELRT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x890C, .hex);
pub const SIOCRTMSG = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x890D, .hex);
pub const SIOCGIFNAME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8910, .hex);
pub const SIOCSIFLINK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8911, .hex);
pub const SIOCGIFCONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8912, .hex);
pub const SIOCGIFFLAGS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8913, .hex);
pub const SIOCSIFFLAGS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8914, .hex);
pub const SIOCGIFADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8915, .hex);
pub const SIOCSIFADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8916, .hex);
pub const SIOCGIFDSTADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8917, .hex);
pub const SIOCSIFDSTADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8918, .hex);
pub const SIOCGIFBRDADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8919, .hex);
pub const SIOCSIFBRDADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x891a, .hex);
pub const SIOCGIFNETMASK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x891b, .hex);
pub const SIOCSIFNETMASK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x891c, .hex);
pub const SIOCGIFMETRIC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x891d, .hex);
pub const SIOCSIFMETRIC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x891e, .hex);
pub const SIOCGIFMEM = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x891f, .hex);
pub const SIOCSIFMEM = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8920, .hex);
pub const SIOCGIFMTU = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8921, .hex);
pub const SIOCSIFMTU = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8922, .hex);
pub const SIOCSIFNAME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8923, .hex);
pub const SIOCSIFHWADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8924, .hex);
pub const SIOCGIFENCAP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8925, .hex);
pub const SIOCSIFENCAP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8926, .hex);
pub const SIOCGIFHWADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8927, .hex);
pub const SIOCGIFSLAVE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8929, .hex);
pub const SIOCSIFSLAVE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8930, .hex);
pub const SIOCADDMULTI = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8931, .hex);
pub const SIOCDELMULTI = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8932, .hex);
pub const SIOCGIFINDEX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8933, .hex);
pub const SIOGIFINDEX = SIOCGIFINDEX;
pub const SIOCSIFPFLAGS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8934, .hex);
pub const SIOCGIFPFLAGS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8935, .hex);
pub const SIOCDIFADDR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8936, .hex);
pub const SIOCSIFHWBROADCAST = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8937, .hex);
pub const SIOCGIFCOUNT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8938, .hex);
pub const SIOCGIFBR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8940, .hex);
pub const SIOCSIFBR = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8941, .hex);
pub const SIOCGIFTXQLEN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8942, .hex);
pub const SIOCSIFTXQLEN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8943, .hex);
pub const SIOCDARP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8953, .hex);
pub const SIOCGARP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8954, .hex);
pub const SIOCSARP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8955, .hex);
pub const SIOCDRARP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8960, .hex);
pub const SIOCGRARP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8961, .hex);
pub const SIOCSRARP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8962, .hex);
pub const SIOCGIFMAP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8970, .hex);
pub const SIOCSIFMAP = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8971, .hex);
pub const SIOCADDDLCI = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8980, .hex);
pub const SIOCDELDLCI = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8981, .hex);
pub const SIOCDEVPRIVATE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x89F0, .hex);
pub const SIOCPROTOPRIVATE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x89E0, .hex);
pub const NCC = @as(c_int, 8);
pub const TIOCM_LE = @as(c_int, 0x001);
pub const TIOCM_DTR = @as(c_int, 0x002);
pub const TIOCM_RTS = @as(c_int, 0x004);
pub const TIOCM_ST = @as(c_int, 0x008);
pub const TIOCM_SR = @as(c_int, 0x010);
pub const TIOCM_CTS = @as(c_int, 0x020);
pub const TIOCM_CAR = @as(c_int, 0x040);
pub const TIOCM_RNG = @as(c_int, 0x080);
pub const TIOCM_DSR = @as(c_int, 0x100);
pub const TIOCM_CD = TIOCM_CAR;
pub const TIOCM_RI = TIOCM_RNG;
pub const N_TTY = @as(c_int, 0);
pub const N_SLIP = @as(c_int, 1);
pub const N_MOUSE = @as(c_int, 2);
pub const N_PPP = @as(c_int, 3);
pub const N_STRIP = @as(c_int, 4);
pub const N_AX25 = @as(c_int, 5);
pub const N_X25 = @as(c_int, 6);
pub const N_6PACK = @as(c_int, 7);
pub const N_MASC = @as(c_int, 8);
pub const N_R3964 = @as(c_int, 9);
pub const N_PROFIBUS_FDL = @as(c_int, 10);
pub const N_IRDA = @as(c_int, 11);
pub const N_SMSBLOCK = @as(c_int, 12);
pub const N_HDLC = @as(c_int, 13);
pub const N_SYNC_PPP = @as(c_int, 14);
pub const N_HCI = @as(c_int, 15);
pub const _SYS_TTYDEFAULTS_H_ = "";
pub const TTYDEF_IFLAG = @compileError("unable to translate macro: undefined identifier `BRKINT`");
// /usr/include/sys/ttydefaults.h:46:9
pub const TTYDEF_OFLAG = @compileError("unable to translate macro: undefined identifier `OPOST`");
// /usr/include/sys/ttydefaults.h:47:9
pub const TTYDEF_LFLAG = @compileError("unable to translate macro: undefined identifier `ECHO`");
// /usr/include/sys/ttydefaults.h:48:9
pub const TTYDEF_CFLAG = @compileError("unable to translate macro: undefined identifier `CREAD`");
// /usr/include/sys/ttydefaults.h:49:9
pub const TTYDEF_SPEED = @compileError("unable to translate macro: undefined identifier `B9600`");
// /usr/include/sys/ttydefaults.h:50:9
pub inline fn CTRL(x: anytype) @TypeOf(x & @as(c_int, 0o37)) {
    _ = &x;
    return x & @as(c_int, 0o37);
}
pub const CEOF = CTRL('d');
pub const CEOL = _POSIX_VDISABLE;
pub const CERASE = @as(c_int, 0o177);
pub const CINTR = CTRL('c');
pub const CSTATUS = _POSIX_VDISABLE;
pub const CKILL = CTRL('u');
pub const CMIN = @as(c_int, 1);
pub const CQUIT = @as(c_int, 0o34);
pub const CSUSP = CTRL('z');
pub const CTIME = @as(c_int, 0);
pub const CDSUSP = CTRL('y');
pub const CSTART = CTRL('q');
pub const CSTOP = CTRL('s');
pub const CLNEXT = CTRL('v');
pub const CDISCARD = CTRL('o');
pub const CWERASE = CTRL('w');
pub const CREPRINT = CTRL('r');
pub const CEOT = CEOF;
pub const CBRK = CEOL;
pub const CRPRNT = CREPRINT;
pub const CFLUSH = CDISCARD;
pub const _CRYPT_H = @as(c_int, 1);
pub const CRYPT_OUTPUT_SIZE = @as(c_int, 384);
pub const CRYPT_MAX_PASSPHRASE_SIZE = @as(c_int, 512);
pub const CRYPT_GENSALT_OUTPUT_SIZE = @as(c_int, 192);
pub const CRYPT_DATA_RESERVED_SIZE = @as(c_int, 767);
pub const CRYPT_DATA_INTERNAL_SIZE = @as(c_int, 30720);
pub const CRYPT_SALT_OK = @as(c_int, 0);
pub const CRYPT_SALT_INVALID = @as(c_int, 1);
pub const CRYPT_SALT_METHOD_DISABLED = @as(c_int, 2);
pub const CRYPT_SALT_METHOD_LEGACY = @as(c_int, 3);
pub const CRYPT_SALT_TOO_CHEAP = @as(c_int, 4);
pub const CRYPT_GENSALT_IMPLEMENTS_DEFAULT_PREFIX = @as(c_int, 1);
pub const CRYPT_GENSALT_IMPLEMENTS_AUTO_ENTROPY = @as(c_int, 1);
pub const CRYPT_CHECKSALT_AVAILABLE = @as(c_int, 1);
pub const CRYPT_PREFERRED_METHOD_AVAILABLE = @as(c_int, 1);
pub const XCRYPT_VERSION_MAJOR = @as(c_int, 4);
pub const XCRYPT_VERSION_MINOR = @as(c_int, 4);
pub const XCRYPT_VERSION_NUM = (XCRYPT_VERSION_MAJOR << @as(c_int, 16)) | XCRYPT_VERSION_MINOR;
pub const XCRYPT_VERSION_STR = "4.4.37";
pub const _SYS_UTSNAME_H = @as(c_int, 1);
pub const _UTSNAME_LENGTH = @as(c_int, 65);
pub const _UTSNAME_DOMAIN_LENGTH = _UTSNAME_LENGTH;
pub const _UTSNAME_SYSNAME_LENGTH = _UTSNAME_LENGTH;
pub const _UTSNAME_NODENAME_LENGTH = _UTSNAME_LENGTH;
pub const _UTSNAME_RELEASE_LENGTH = _UTSNAME_LENGTH;
pub const _UTSNAME_VERSION_LENGTH = _UTSNAME_LENGTH;
pub const _UTSNAME_MACHINE_LENGTH = _UTSNAME_LENGTH;
pub const SYS_NMLN = _UTSNAME_LENGTH;
pub const _DLFCN_H = @as(c_int, 1);
pub const RTLD_LAZY = @as(c_int, 0x00001);
pub const RTLD_NOW = @as(c_int, 0x00002);
pub const RTLD_BINDING_MASK = @as(c_int, 0x3);
pub const RTLD_NOLOAD = @as(c_int, 0x00004);
pub const RTLD_DEEPBIND = @as(c_int, 0x00008);
pub const RTLD_GLOBAL = @as(c_int, 0x00100);
pub const RTLD_LOCAL = @as(c_int, 0);
pub const RTLD_NODELETE = @as(c_int, 0x01000);
pub inline fn DL_CALL_FCT(fctp: anytype, args: anytype) @TypeOf(fctp.* ++ args) {
    _ = &fctp;
    _ = &args;
    return blk_1: {
        _ = _dl_mcount_wrapper_check(@import("std").zig.c_translation.cast(?*anyopaque, fctp));
        break :blk_1 fctp.* ++ args;
    };
}
pub const DLFO_STRUCT_HAS_EH_DBASE = @as(c_int, 0);
pub const DLFO_STRUCT_HAS_EH_COUNT = @as(c_int, 0);
pub const DLFO_EH_SEGMENT_TYPE = @compileError("unable to translate macro: undefined identifier `PT_GNU_EH_FRAME`");
// /usr/include/bits/dl_find_object.h:29:9
pub const LM_ID_BASE = @as(c_int, 0);
pub const LM_ID_NEWLM = -@as(c_int, 1);
pub const RTLD_NEXT = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_long, 1));
pub const RTLD_DEFAULT = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const NGX_CONFIGURE = " --with-openssl=/usr/include/openssl-1.1/";
pub const NGX_COMPILER = "gcc 14.2.1 20240910 (GCC) ";
pub const NGX_HAVE_GCC_ATOMIC = @as(c_int, 1);
pub const NGX_HAVE_C99_VARIADIC_MACROS = @as(c_int, 1);
pub const NGX_HAVE_GCC_VARIADIC_MACROS = @as(c_int, 1);
pub const NGX_HAVE_GCC_BSWAP64 = @as(c_int, 1);
pub const NGX_HAVE_EPOLL = @as(c_int, 1);
pub const NGX_HAVE_CLEAR_EVENT = @as(c_int, 1);
pub const NGX_HAVE_EPOLLRDHUP = @as(c_int, 1);
pub const NGX_HAVE_EPOLLEXCLUSIVE = @as(c_int, 1);
pub const NGX_HAVE_EVENTFD = @as(c_int, 1);
pub const NGX_HAVE_SYS_EVENTFD_H = @as(c_int, 1);
pub const NGX_HAVE_O_PATH = @as(c_int, 1);
pub const NGX_HAVE_SENDFILE = @as(c_int, 1);
pub const NGX_HAVE_SENDFILE64 = @as(c_int, 1);
pub const NGX_HAVE_PR_SET_DUMPABLE = @as(c_int, 1);
pub const NGX_HAVE_PR_SET_KEEPCAPS = @as(c_int, 1);
pub const NGX_HAVE_CAPABILITIES = @as(c_int, 1);
pub const NGX_HAVE_GNU_CRYPT_R = @as(c_int, 1);
pub const NGX_HAVE_BPF = @as(c_int, 1);
pub const NGX_HAVE_SO_COOKIE = @as(c_int, 1);
pub const NGX_HAVE_UDP_SEGMENT = @as(c_int, 1);
pub const NGX_HAVE_NONALIGNED = @as(c_int, 1);
pub const NGX_CPU_CACHE_LINE = @as(c_int, 64);
pub const NGX_KQUEUE_UDATA_T = @compileError("unable to translate C expr: unexpected token ''");
// objs/ngx_auto_config.h:118:9
pub const NGX_HAVE_POSIX_FADVISE = @as(c_int, 1);
pub const NGX_HAVE_O_DIRECT = @as(c_int, 1);
pub const NGX_HAVE_ALIGNED_DIRECTIO = @as(c_int, 1);
pub const NGX_HAVE_STATFS = @as(c_int, 1);
pub const NGX_HAVE_STATVFS = @as(c_int, 1);
pub const NGX_HAVE_DLOPEN = @as(c_int, 1);
pub const NGX_HAVE_SCHED_YIELD = @as(c_int, 1);
pub const NGX_HAVE_SCHED_SETAFFINITY = @as(c_int, 1);
pub const NGX_HAVE_REUSEPORT = @as(c_int, 1);
pub const NGX_HAVE_TRANSPARENT_PROXY = @as(c_int, 1);
pub const NGX_HAVE_IP_BIND_ADDRESS_NO_PORT = @as(c_int, 1);
pub const NGX_HAVE_IP_PKTINFO = @as(c_int, 1);
pub const NGX_HAVE_IPV6_RECVPKTINFO = @as(c_int, 1);
pub const NGX_HAVE_IP_MTU_DISCOVER = @as(c_int, 1);
pub const NGX_HAVE_IPV6_MTU_DISCOVER = @as(c_int, 1);
pub const NGX_HAVE_IPV6_DONTFRAG = @as(c_int, 1);
pub const NGX_HAVE_DEFERRED_ACCEPT = @as(c_int, 1);
pub const NGX_HAVE_KEEPALIVE_TUNABLE = @as(c_int, 1);
pub const NGX_HAVE_TCP_FASTOPEN = @as(c_int, 1);
pub const NGX_HAVE_TCP_INFO = @as(c_int, 1);
pub const NGX_HAVE_ACCEPT4 = @as(c_int, 1);
pub const NGX_HAVE_UNIX_DOMAIN = @as(c_int, 1);
pub const NGX_PTR_SIZE = @as(c_int, 8);
pub const NGX_SIG_ATOMIC_T_SIZE = @as(c_int, 4);
pub const NGX_HAVE_LITTLE_ENDIAN = @as(c_int, 1);
pub const NGX_MAX_SIZE_T_VALUE = @as(c_longlong, 9223372036854775807);
pub const NGX_SIZE_T_LEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// objs/ngx_auto_config.h:252:9
pub const NGX_MAX_OFF_T_VALUE = @as(c_longlong, 9223372036854775807);
pub const NGX_OFF_T_LEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// objs/ngx_auto_config.h:262:9
pub const NGX_TIME_T_SIZE = @as(c_int, 8);
pub const NGX_TIME_T_LEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// objs/ngx_auto_config.h:272:9
pub const NGX_MAX_TIME_T_VALUE = @as(c_longlong, 9223372036854775807);
pub const NGX_HAVE_INET6 = @as(c_int, 1);
pub const NGX_HAVE_PREAD = @as(c_int, 1);
pub const NGX_HAVE_PWRITE = @as(c_int, 1);
pub const NGX_HAVE_PWRITEV = @as(c_int, 1);
pub const NGX_HAVE_STRERRORDESC_NP = @as(c_int, 1);
pub const NGX_HAVE_LOCALTIME_R = @as(c_int, 1);
pub const NGX_HAVE_CLOCK_MONOTONIC = @as(c_int, 1);
pub const NGX_HAVE_POSIX_MEMALIGN = @as(c_int, 1);
pub const NGX_HAVE_MEMALIGN = @as(c_int, 1);
pub const NGX_HAVE_MAP_ANON = @as(c_int, 1);
pub const NGX_HAVE_MAP_DEVZERO = @as(c_int, 1);
pub const NGX_HAVE_SYSVSHM = @as(c_int, 1);
pub const NGX_HAVE_POSIX_SEM = @as(c_int, 1);
pub const NGX_HAVE_MSGHDR_MSG_CONTROL = @as(c_int, 1);
pub const NGX_HAVE_FIONBIO = @as(c_int, 1);
pub const NGX_HAVE_FIONREAD = @as(c_int, 1);
pub const NGX_HAVE_GMTOFF = @as(c_int, 1);
pub const NGX_HAVE_D_TYPE = @as(c_int, 1);
pub const NGX_HAVE_SC_NPROCESSORS_ONLN = @as(c_int, 1);
pub const NGX_HAVE_LEVEL1_DCACHE_LINESIZE = @as(c_int, 1);
pub const NGX_HAVE_OPENAT = @as(c_int, 1);
pub const NGX_HAVE_GETADDRINFO = @as(c_int, 1);
pub const NGX_HTTP_CACHE = @as(c_int, 1);
pub const NGX_HTTP_GZIP = @as(c_int, 1);
pub const NGX_HTTP_SSI = @as(c_int, 1);
pub const NGX_CRYPT = @as(c_int, 1);
pub const NGX_HTTP_X_FORWARDED_FOR = @as(c_int, 1);
pub const NGX_HTTP_UPSTREAM_ZONE = @as(c_int, 1);
pub const NGX_PCRE2 = @as(c_int, 1);
pub const NGX_PCRE = @as(c_int, 1);
pub const NGX_ZLIB = @as(c_int, 1);
pub const NGX_PREFIX = "/usr/local/nginx/";
pub const NGX_CONF_PREFIX = "conf/";
pub const NGX_SBIN_PATH = "sbin/nginx";
pub const NGX_CONF_PATH = "conf/nginx.conf";
pub const NGX_PID_PATH = "logs/nginx.pid";
pub const NGX_LOCK_PATH = "logs/nginx.lock";
pub const NGX_ERROR_LOG_PATH = "logs/error.log";
pub const NGX_HTTP_LOG_PATH = "logs/access.log";
pub const NGX_HTTP_CLIENT_TEMP_PATH = "client_body_temp";
pub const NGX_HTTP_PROXY_TEMP_PATH = "proxy_temp";
pub const NGX_HTTP_FASTCGI_TEMP_PATH = "fastcgi_temp";
pub const NGX_HTTP_UWSGI_TEMP_PATH = "uwsgi_temp";
pub const NGX_HTTP_SCGI_TEMP_PATH = "scgi_temp";
pub const NGX_SUPPRESS_WARN = @as(c_int, 1);
pub const NGX_SMP = @as(c_int, 1);
pub const NGX_USER = "nobody";
pub const NGX_GROUP = "nobody";
pub const _SEMAPHORE_H = @as(c_int, 1);
pub const __SIZEOF_SEM_T = @as(c_int, 32);
pub const SEM_FAILED = @import("std").zig.c_translation.cast([*c]sem_t, @as(c_int, 0));
pub const _SYS_PRCTL_H = @as(c_int, 1);
pub const _LINUX_PRCTL_H = "";
pub const PR_SET_PDEATHSIG = @as(c_int, 1);
pub const PR_GET_PDEATHSIG = @as(c_int, 2);
pub const PR_GET_DUMPABLE = @as(c_int, 3);
pub const PR_SET_DUMPABLE = @as(c_int, 4);
pub const PR_GET_UNALIGN = @as(c_int, 5);
pub const PR_SET_UNALIGN = @as(c_int, 6);
pub const PR_UNALIGN_NOPRINT = @as(c_int, 1);
pub const PR_UNALIGN_SIGBUS = @as(c_int, 2);
pub const PR_GET_KEEPCAPS = @as(c_int, 7);
pub const PR_SET_KEEPCAPS = @as(c_int, 8);
pub const PR_GET_FPEMU = @as(c_int, 9);
pub const PR_SET_FPEMU = @as(c_int, 10);
pub const PR_FPEMU_NOPRINT = @as(c_int, 1);
pub const PR_FPEMU_SIGFPE = @as(c_int, 2);
pub const PR_GET_FPEXC = @as(c_int, 11);
pub const PR_SET_FPEXC = @as(c_int, 12);
pub const PR_FP_EXC_SW_ENABLE = @as(c_int, 0x80);
pub const PR_FP_EXC_DIV = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x010000, .hex);
pub const PR_FP_EXC_OVF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x020000, .hex);
pub const PR_FP_EXC_UND = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x040000, .hex);
pub const PR_FP_EXC_RES = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x080000, .hex);
pub const PR_FP_EXC_INV = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000, .hex);
pub const PR_FP_EXC_DISABLED = @as(c_int, 0);
pub const PR_FP_EXC_NONRECOV = @as(c_int, 1);
pub const PR_FP_EXC_ASYNC = @as(c_int, 2);
pub const PR_FP_EXC_PRECISE = @as(c_int, 3);
pub const PR_GET_TIMING = @as(c_int, 13);
pub const PR_SET_TIMING = @as(c_int, 14);
pub const PR_TIMING_STATISTICAL = @as(c_int, 0);
pub const PR_TIMING_TIMESTAMP = @as(c_int, 1);
pub const PR_SET_NAME = @as(c_int, 15);
pub const PR_GET_NAME = @as(c_int, 16);
pub const PR_GET_ENDIAN = @as(c_int, 19);
pub const PR_SET_ENDIAN = @as(c_int, 20);
pub const PR_ENDIAN_BIG = @as(c_int, 0);
pub const PR_ENDIAN_LITTLE = @as(c_int, 1);
pub const PR_ENDIAN_PPC_LITTLE = @as(c_int, 2);
pub const PR_GET_SECCOMP = @as(c_int, 21);
pub const PR_SET_SECCOMP = @as(c_int, 22);
pub const PR_CAPBSET_READ = @as(c_int, 23);
pub const PR_CAPBSET_DROP = @as(c_int, 24);
pub const PR_GET_TSC = @as(c_int, 25);
pub const PR_SET_TSC = @as(c_int, 26);
pub const PR_TSC_ENABLE = @as(c_int, 1);
pub const PR_TSC_SIGSEGV = @as(c_int, 2);
pub const PR_GET_SECUREBITS = @as(c_int, 27);
pub const PR_SET_SECUREBITS = @as(c_int, 28);
pub const PR_SET_TIMERSLACK = @as(c_int, 29);
pub const PR_GET_TIMERSLACK = @as(c_int, 30);
pub const PR_TASK_PERF_EVENTS_DISABLE = @as(c_int, 31);
pub const PR_TASK_PERF_EVENTS_ENABLE = @as(c_int, 32);
pub const PR_MCE_KILL = @as(c_int, 33);
pub const PR_MCE_KILL_CLEAR = @as(c_int, 0);
pub const PR_MCE_KILL_SET = @as(c_int, 1);
pub const PR_MCE_KILL_LATE = @as(c_int, 0);
pub const PR_MCE_KILL_EARLY = @as(c_int, 1);
pub const PR_MCE_KILL_DEFAULT = @as(c_int, 2);
pub const PR_MCE_KILL_GET = @as(c_int, 34);
pub const PR_SET_MM = @as(c_int, 35);
pub const PR_SET_MM_START_CODE = @as(c_int, 1);
pub const PR_SET_MM_END_CODE = @as(c_int, 2);
pub const PR_SET_MM_START_DATA = @as(c_int, 3);
pub const PR_SET_MM_END_DATA = @as(c_int, 4);
pub const PR_SET_MM_START_STACK = @as(c_int, 5);
pub const PR_SET_MM_START_BRK = @as(c_int, 6);
pub const PR_SET_MM_BRK = @as(c_int, 7);
pub const PR_SET_MM_ARG_START = @as(c_int, 8);
pub const PR_SET_MM_ARG_END = @as(c_int, 9);
pub const PR_SET_MM_ENV_START = @as(c_int, 10);
pub const PR_SET_MM_ENV_END = @as(c_int, 11);
pub const PR_SET_MM_AUXV = @as(c_int, 12);
pub const PR_SET_MM_EXE_FILE = @as(c_int, 13);
pub const PR_SET_MM_MAP = @as(c_int, 14);
pub const PR_SET_MM_MAP_SIZE = @as(c_int, 15);
pub const PR_SET_PTRACER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x59616d61, .hex);
pub const PR_SET_PTRACER_ANY = @import("std").zig.c_translation.cast(c_ulong, -@as(c_int, 1));
pub const PR_SET_CHILD_SUBREAPER = @as(c_int, 36);
pub const PR_GET_CHILD_SUBREAPER = @as(c_int, 37);
pub const PR_SET_NO_NEW_PRIVS = @as(c_int, 38);
pub const PR_GET_NO_NEW_PRIVS = @as(c_int, 39);
pub const PR_GET_TID_ADDRESS = @as(c_int, 40);
pub const PR_SET_THP_DISABLE = @as(c_int, 41);
pub const PR_GET_THP_DISABLE = @as(c_int, 42);
pub const PR_MPX_ENABLE_MANAGEMENT = @as(c_int, 43);
pub const PR_MPX_DISABLE_MANAGEMENT = @as(c_int, 44);
pub const PR_SET_FP_MODE = @as(c_int, 45);
pub const PR_GET_FP_MODE = @as(c_int, 46);
pub const PR_FP_MODE_FR = @as(c_int, 1) << @as(c_int, 0);
pub const PR_FP_MODE_FRE = @as(c_int, 1) << @as(c_int, 1);
pub const PR_CAP_AMBIENT = @as(c_int, 47);
pub const PR_CAP_AMBIENT_IS_SET = @as(c_int, 1);
pub const PR_CAP_AMBIENT_RAISE = @as(c_int, 2);
pub const PR_CAP_AMBIENT_LOWER = @as(c_int, 3);
pub const PR_CAP_AMBIENT_CLEAR_ALL = @as(c_int, 4);
pub const PR_SVE_SET_VL = @as(c_int, 50);
pub const PR_SVE_SET_VL_ONEXEC = @as(c_int, 1) << @as(c_int, 18);
pub const PR_SVE_GET_VL = @as(c_int, 51);
pub const PR_SVE_VL_LEN_MASK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hex);
pub const PR_SVE_VL_INHERIT = @as(c_int, 1) << @as(c_int, 17);
pub const PR_GET_SPECULATION_CTRL = @as(c_int, 52);
pub const PR_SET_SPECULATION_CTRL = @as(c_int, 53);
pub const PR_SPEC_STORE_BYPASS = @as(c_int, 0);
pub const PR_SPEC_INDIRECT_BRANCH = @as(c_int, 1);
pub const PR_SPEC_L1D_FLUSH = @as(c_int, 2);
pub const PR_SPEC_NOT_AFFECTED = @as(c_int, 0);
pub const PR_SPEC_PRCTL = @as(c_ulong, 1) << @as(c_int, 0);
pub const PR_SPEC_ENABLE = @as(c_ulong, 1) << @as(c_int, 1);
pub const PR_SPEC_DISABLE = @as(c_ulong, 1) << @as(c_int, 2);
pub const PR_SPEC_FORCE_DISABLE = @as(c_ulong, 1) << @as(c_int, 3);
pub const PR_SPEC_DISABLE_NOEXEC = @as(c_ulong, 1) << @as(c_int, 4);
pub const PR_PAC_RESET_KEYS = @as(c_int, 54);
pub const PR_PAC_APIAKEY = @as(c_ulong, 1) << @as(c_int, 0);
pub const PR_PAC_APIBKEY = @as(c_ulong, 1) << @as(c_int, 1);
pub const PR_PAC_APDAKEY = @as(c_ulong, 1) << @as(c_int, 2);
pub const PR_PAC_APDBKEY = @as(c_ulong, 1) << @as(c_int, 3);
pub const PR_PAC_APGAKEY = @as(c_ulong, 1) << @as(c_int, 4);
pub const PR_SET_TAGGED_ADDR_CTRL = @as(c_int, 55);
pub const PR_GET_TAGGED_ADDR_CTRL = @as(c_int, 56);
pub const PR_TAGGED_ADDR_ENABLE = @as(c_ulong, 1) << @as(c_int, 0);
pub const PR_MTE_TCF_NONE = @as(c_ulong, 0);
pub const PR_MTE_TCF_SYNC = @as(c_ulong, 1) << @as(c_int, 1);
pub const PR_MTE_TCF_ASYNC = @as(c_ulong, 1) << @as(c_int, 2);
pub const PR_MTE_TCF_MASK = PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC;
pub const PR_MTE_TAG_SHIFT = @as(c_int, 3);
pub const PR_MTE_TAG_MASK = @as(c_ulong, 0xffff) << PR_MTE_TAG_SHIFT;
pub const PR_MTE_TCF_SHIFT = @as(c_int, 1);
pub const PR_SET_IO_FLUSHER = @as(c_int, 57);
pub const PR_GET_IO_FLUSHER = @as(c_int, 58);
pub const PR_SET_SYSCALL_USER_DISPATCH = @as(c_int, 59);
pub const PR_SYS_DISPATCH_OFF = @as(c_int, 0);
pub const PR_SYS_DISPATCH_ON = @as(c_int, 1);
pub const SYSCALL_DISPATCH_FILTER_ALLOW = @as(c_int, 0);
pub const SYSCALL_DISPATCH_FILTER_BLOCK = @as(c_int, 1);
pub const PR_PAC_SET_ENABLED_KEYS = @as(c_int, 60);
pub const PR_PAC_GET_ENABLED_KEYS = @as(c_int, 61);
pub const PR_SCHED_CORE = @as(c_int, 62);
pub const PR_SCHED_CORE_GET = @as(c_int, 0);
pub const PR_SCHED_CORE_CREATE = @as(c_int, 1);
pub const PR_SCHED_CORE_SHARE_TO = @as(c_int, 2);
pub const PR_SCHED_CORE_SHARE_FROM = @as(c_int, 3);
pub const PR_SCHED_CORE_MAX = @as(c_int, 4);
pub const PR_SCHED_CORE_SCOPE_THREAD = @as(c_int, 0);
pub const PR_SCHED_CORE_SCOPE_THREAD_GROUP = @as(c_int, 1);
pub const PR_SCHED_CORE_SCOPE_PROCESS_GROUP = @as(c_int, 2);
pub const PR_SME_SET_VL = @as(c_int, 63);
pub const PR_SME_SET_VL_ONEXEC = @as(c_int, 1) << @as(c_int, 18);
pub const PR_SME_GET_VL = @as(c_int, 64);
pub const PR_SME_VL_LEN_MASK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hex);
pub const PR_SME_VL_INHERIT = @as(c_int, 1) << @as(c_int, 17);
pub const PR_SET_MDWE = @as(c_int, 65);
pub const PR_MDWE_REFUSE_EXEC_GAIN = @as(c_ulong, 1) << @as(c_int, 0);
pub const PR_MDWE_NO_INHERIT = @as(c_ulong, 1) << @as(c_int, 1);
pub const PR_GET_MDWE = @as(c_int, 66);
pub const PR_SET_VMA = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x53564d41, .hex);
pub const PR_SET_VMA_ANON_NAME = @as(c_int, 0);
pub const PR_GET_AUXV = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x41555856, .hex);
pub const PR_SET_MEMORY_MERGE = @as(c_int, 67);
pub const PR_GET_MEMORY_MERGE = @as(c_int, 68);
pub const PR_RISCV_V_SET_CONTROL = @as(c_int, 69);
pub const PR_RISCV_V_GET_CONTROL = @as(c_int, 70);
pub const PR_RISCV_V_VSTATE_CTRL_DEFAULT = @as(c_int, 0);
pub const PR_RISCV_V_VSTATE_CTRL_OFF = @as(c_int, 1);
pub const PR_RISCV_V_VSTATE_CTRL_ON = @as(c_int, 2);
pub const PR_RISCV_V_VSTATE_CTRL_INHERIT = @as(c_int, 1) << @as(c_int, 4);
pub const PR_RISCV_V_VSTATE_CTRL_CUR_MASK = @as(c_int, 0x3);
pub const PR_RISCV_V_VSTATE_CTRL_NEXT_MASK = @as(c_int, 0xc);
pub const PR_RISCV_V_VSTATE_CTRL_MASK = @as(c_int, 0x1f);
pub const PR_RISCV_SET_ICACHE_FLUSH_CTX = @as(c_int, 71);
pub const PR_RISCV_CTX_SW_FENCEI_ON = @as(c_int, 0);
pub const PR_RISCV_CTX_SW_FENCEI_OFF = @as(c_int, 1);
pub const PR_RISCV_SCOPE_PER_PROCESS = @as(c_int, 0);
pub const PR_RISCV_SCOPE_PER_THREAD = @as(c_int, 1);
pub const PR_PPC_GET_DEXCR = @as(c_int, 72);
pub const PR_PPC_SET_DEXCR = @as(c_int, 73);
pub const PR_PPC_DEXCR_SBHE = @as(c_int, 0);
pub const PR_PPC_DEXCR_IBRTPD = @as(c_int, 1);
pub const PR_PPC_DEXCR_SRAPD = @as(c_int, 2);
pub const PR_PPC_DEXCR_NPHIE = @as(c_int, 3);
pub const PR_PPC_DEXCR_CTRL_EDITABLE = @as(c_int, 0x1);
pub const PR_PPC_DEXCR_CTRL_SET = @as(c_int, 0x2);
pub const PR_PPC_DEXCR_CTRL_CLEAR = @as(c_int, 0x4);
pub const PR_PPC_DEXCR_CTRL_SET_ONEXEC = @as(c_int, 0x8);
pub const PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC = @as(c_int, 0x10);
pub const PR_PPC_DEXCR_CTRL_MASK = @as(c_int, 0x1f);
pub const _SYS_SENDFILE_H = @as(c_int, 1);
pub const _SYS_EPOLL_H = @as(c_int, 1);
pub const __EPOLL_PACKED = @compileError("unable to translate macro: undefined identifier `__packed__`");
// /usr/include/bits/epoll.h:29:9
pub const EPOLL_CTL_ADD = @as(c_int, 1);
pub const EPOLL_CTL_DEL = @as(c_int, 2);
pub const EPOLL_CTL_MOD = @as(c_int, 3);
pub const EPOLL_IOC_TYPE = @as(c_int, 0x8A);
pub const EPIOCSPARAMS = _IOW(EPOLL_IOC_TYPE, @as(c_int, 0x01), struct_epoll_params);
pub const EPIOCGPARAMS = _IOR(EPOLL_IOC_TYPE, @as(c_int, 0x02), struct_epoll_params);
pub const _SYS_EVENTFD_H = @as(c_int, 1);
pub const _SYSCALL_H = @as(c_int, 1);
pub const _ASM_X86_UNISTD_H = "";
pub const __X32_SYSCALL_BIT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const _ASM_UNISTD_64_H = "";
pub const __NR_read = @as(c_int, 0);
pub const __NR_write = @as(c_int, 1);
pub const __NR_open = @as(c_int, 2);
pub const __NR_close = @as(c_int, 3);
pub const __NR_stat = @as(c_int, 4);
pub const __NR_fstat = @as(c_int, 5);
pub const __NR_lstat = @as(c_int, 6);
pub const __NR_poll = @as(c_int, 7);
pub const __NR_lseek = @as(c_int, 8);
pub const __NR_mmap = @as(c_int, 9);
pub const __NR_mprotect = @as(c_int, 10);
pub const __NR_munmap = @as(c_int, 11);
pub const __NR_brk = @as(c_int, 12);
pub const __NR_rt_sigaction = @as(c_int, 13);
pub const __NR_rt_sigprocmask = @as(c_int, 14);
pub const __NR_rt_sigreturn = @as(c_int, 15);
pub const __NR_ioctl = @as(c_int, 16);
pub const __NR_pread64 = @as(c_int, 17);
pub const __NR_pwrite64 = @as(c_int, 18);
pub const __NR_readv = @as(c_int, 19);
pub const __NR_writev = @as(c_int, 20);
pub const __NR_access = @as(c_int, 21);
pub const __NR_pipe = @as(c_int, 22);
pub const __NR_select = @as(c_int, 23);
pub const __NR_sched_yield = @as(c_int, 24);
pub const __NR_mremap = @as(c_int, 25);
pub const __NR_msync = @as(c_int, 26);
pub const __NR_mincore = @as(c_int, 27);
pub const __NR_madvise = @as(c_int, 28);
pub const __NR_shmget = @as(c_int, 29);
pub const __NR_shmat = @as(c_int, 30);
pub const __NR_shmctl = @as(c_int, 31);
pub const __NR_dup = @as(c_int, 32);
pub const __NR_dup2 = @as(c_int, 33);
pub const __NR_pause = @as(c_int, 34);
pub const __NR_nanosleep = @as(c_int, 35);
pub const __NR_getitimer = @as(c_int, 36);
pub const __NR_alarm = @as(c_int, 37);
pub const __NR_setitimer = @as(c_int, 38);
pub const __NR_getpid = @as(c_int, 39);
pub const __NR_sendfile = @as(c_int, 40);
pub const __NR_socket = @as(c_int, 41);
pub const __NR_connect = @as(c_int, 42);
pub const __NR_accept = @as(c_int, 43);
pub const __NR_sendto = @as(c_int, 44);
pub const __NR_recvfrom = @as(c_int, 45);
pub const __NR_sendmsg = @as(c_int, 46);
pub const __NR_recvmsg = @as(c_int, 47);
pub const __NR_shutdown = @as(c_int, 48);
pub const __NR_bind = @as(c_int, 49);
pub const __NR_listen = @as(c_int, 50);
pub const __NR_getsockname = @as(c_int, 51);
pub const __NR_getpeername = @as(c_int, 52);
pub const __NR_socketpair = @as(c_int, 53);
pub const __NR_setsockopt = @as(c_int, 54);
pub const __NR_getsockopt = @as(c_int, 55);
pub const __NR_clone = @as(c_int, 56);
pub const __NR_fork = @as(c_int, 57);
pub const __NR_vfork = @as(c_int, 58);
pub const __NR_execve = @as(c_int, 59);
pub const __NR_exit = @as(c_int, 60);
pub const __NR_wait4 = @as(c_int, 61);
pub const __NR_kill = @as(c_int, 62);
pub const __NR_uname = @as(c_int, 63);
pub const __NR_semget = @as(c_int, 64);
pub const __NR_semop = @as(c_int, 65);
pub const __NR_semctl = @as(c_int, 66);
pub const __NR_shmdt = @as(c_int, 67);
pub const __NR_msgget = @as(c_int, 68);
pub const __NR_msgsnd = @as(c_int, 69);
pub const __NR_msgrcv = @as(c_int, 70);
pub const __NR_msgctl = @as(c_int, 71);
pub const __NR_fcntl = @as(c_int, 72);
pub const __NR_flock = @as(c_int, 73);
pub const __NR_fsync = @as(c_int, 74);
pub const __NR_fdatasync = @as(c_int, 75);
pub const __NR_truncate = @as(c_int, 76);
pub const __NR_ftruncate = @as(c_int, 77);
pub const __NR_getdents = @as(c_int, 78);
pub const __NR_getcwd = @as(c_int, 79);
pub const __NR_chdir = @as(c_int, 80);
pub const __NR_fchdir = @as(c_int, 81);
pub const __NR_rename = @as(c_int, 82);
pub const __NR_mkdir = @as(c_int, 83);
pub const __NR_rmdir = @as(c_int, 84);
pub const __NR_creat = @as(c_int, 85);
pub const __NR_link = @as(c_int, 86);
pub const __NR_unlink = @as(c_int, 87);
pub const __NR_symlink = @as(c_int, 88);
pub const __NR_readlink = @as(c_int, 89);
pub const __NR_chmod = @as(c_int, 90);
pub const __NR_fchmod = @as(c_int, 91);
pub const __NR_chown = @as(c_int, 92);
pub const __NR_fchown = @as(c_int, 93);
pub const __NR_lchown = @as(c_int, 94);
pub const __NR_umask = @as(c_int, 95);
pub const __NR_gettimeofday = @as(c_int, 96);
pub const __NR_getrlimit = @as(c_int, 97);
pub const __NR_getrusage = @as(c_int, 98);
pub const __NR_sysinfo = @as(c_int, 99);
pub const __NR_times = @as(c_int, 100);
pub const __NR_ptrace = @as(c_int, 101);
pub const __NR_getuid = @as(c_int, 102);
pub const __NR_syslog = @as(c_int, 103);
pub const __NR_getgid = @as(c_int, 104);
pub const __NR_setuid = @as(c_int, 105);
pub const __NR_setgid = @as(c_int, 106);
pub const __NR_geteuid = @as(c_int, 107);
pub const __NR_getegid = @as(c_int, 108);
pub const __NR_setpgid = @as(c_int, 109);
pub const __NR_getppid = @as(c_int, 110);
pub const __NR_getpgrp = @as(c_int, 111);
pub const __NR_setsid = @as(c_int, 112);
pub const __NR_setreuid = @as(c_int, 113);
pub const __NR_setregid = @as(c_int, 114);
pub const __NR_getgroups = @as(c_int, 115);
pub const __NR_setgroups = @as(c_int, 116);
pub const __NR_setresuid = @as(c_int, 117);
pub const __NR_getresuid = @as(c_int, 118);
pub const __NR_setresgid = @as(c_int, 119);
pub const __NR_getresgid = @as(c_int, 120);
pub const __NR_getpgid = @as(c_int, 121);
pub const __NR_setfsuid = @as(c_int, 122);
pub const __NR_setfsgid = @as(c_int, 123);
pub const __NR_getsid = @as(c_int, 124);
pub const __NR_capget = @as(c_int, 125);
pub const __NR_capset = @as(c_int, 126);
pub const __NR_rt_sigpending = @as(c_int, 127);
pub const __NR_rt_sigtimedwait = @as(c_int, 128);
pub const __NR_rt_sigqueueinfo = @as(c_int, 129);
pub const __NR_rt_sigsuspend = @as(c_int, 130);
pub const __NR_sigaltstack = @as(c_int, 131);
pub const __NR_utime = @as(c_int, 132);
pub const __NR_mknod = @as(c_int, 133);
pub const __NR_uselib = @as(c_int, 134);
pub const __NR_personality = @as(c_int, 135);
pub const __NR_ustat = @as(c_int, 136);
pub const __NR_statfs = @as(c_int, 137);
pub const __NR_fstatfs = @as(c_int, 138);
pub const __NR_sysfs = @as(c_int, 139);
pub const __NR_getpriority = @as(c_int, 140);
pub const __NR_setpriority = @as(c_int, 141);
pub const __NR_sched_setparam = @as(c_int, 142);
pub const __NR_sched_getparam = @as(c_int, 143);
pub const __NR_sched_setscheduler = @as(c_int, 144);
pub const __NR_sched_getscheduler = @as(c_int, 145);
pub const __NR_sched_get_priority_max = @as(c_int, 146);
pub const __NR_sched_get_priority_min = @as(c_int, 147);
pub const __NR_sched_rr_get_interval = @as(c_int, 148);
pub const __NR_mlock = @as(c_int, 149);
pub const __NR_munlock = @as(c_int, 150);
pub const __NR_mlockall = @as(c_int, 151);
pub const __NR_munlockall = @as(c_int, 152);
pub const __NR_vhangup = @as(c_int, 153);
pub const __NR_modify_ldt = @as(c_int, 154);
pub const __NR_pivot_root = @as(c_int, 155);
pub const __NR__sysctl = @as(c_int, 156);
pub const __NR_prctl = @as(c_int, 157);
pub const __NR_arch_prctl = @as(c_int, 158);
pub const __NR_adjtimex = @as(c_int, 159);
pub const __NR_setrlimit = @as(c_int, 160);
pub const __NR_chroot = @as(c_int, 161);
pub const __NR_sync = @as(c_int, 162);
pub const __NR_acct = @as(c_int, 163);
pub const __NR_settimeofday = @as(c_int, 164);
pub const __NR_mount = @as(c_int, 165);
pub const __NR_umount2 = @as(c_int, 166);
pub const __NR_swapon = @as(c_int, 167);
pub const __NR_swapoff = @as(c_int, 168);
pub const __NR_reboot = @as(c_int, 169);
pub const __NR_sethostname = @as(c_int, 170);
pub const __NR_setdomainname = @as(c_int, 171);
pub const __NR_iopl = @as(c_int, 172);
pub const __NR_ioperm = @as(c_int, 173);
pub const __NR_create_module = @as(c_int, 174);
pub const __NR_init_module = @as(c_int, 175);
pub const __NR_delete_module = @as(c_int, 176);
pub const __NR_get_kernel_syms = @as(c_int, 177);
pub const __NR_query_module = @as(c_int, 178);
pub const __NR_quotactl = @as(c_int, 179);
pub const __NR_nfsservctl = @as(c_int, 180);
pub const __NR_getpmsg = @as(c_int, 181);
pub const __NR_putpmsg = @as(c_int, 182);
pub const __NR_afs_syscall = @as(c_int, 183);
pub const __NR_tuxcall = @as(c_int, 184);
pub const __NR_security = @as(c_int, 185);
pub const __NR_gettid = @as(c_int, 186);
pub const __NR_readahead = @as(c_int, 187);
pub const __NR_setxattr = @as(c_int, 188);
pub const __NR_lsetxattr = @as(c_int, 189);
pub const __NR_fsetxattr = @as(c_int, 190);
pub const __NR_getxattr = @as(c_int, 191);
pub const __NR_lgetxattr = @as(c_int, 192);
pub const __NR_fgetxattr = @as(c_int, 193);
pub const __NR_listxattr = @as(c_int, 194);
pub const __NR_llistxattr = @as(c_int, 195);
pub const __NR_flistxattr = @as(c_int, 196);
pub const __NR_removexattr = @as(c_int, 197);
pub const __NR_lremovexattr = @as(c_int, 198);
pub const __NR_fremovexattr = @as(c_int, 199);
pub const __NR_tkill = @as(c_int, 200);
pub const __NR_time = @as(c_int, 201);
pub const __NR_futex = @as(c_int, 202);
pub const __NR_sched_setaffinity = @as(c_int, 203);
pub const __NR_sched_getaffinity = @as(c_int, 204);
pub const __NR_set_thread_area = @as(c_int, 205);
pub const __NR_io_setup = @as(c_int, 206);
pub const __NR_io_destroy = @as(c_int, 207);
pub const __NR_io_getevents = @as(c_int, 208);
pub const __NR_io_submit = @as(c_int, 209);
pub const __NR_io_cancel = @as(c_int, 210);
pub const __NR_get_thread_area = @as(c_int, 211);
pub const __NR_lookup_dcookie = @as(c_int, 212);
pub const __NR_epoll_create = @as(c_int, 213);
pub const __NR_epoll_ctl_old = @as(c_int, 214);
pub const __NR_epoll_wait_old = @as(c_int, 215);
pub const __NR_remap_file_pages = @as(c_int, 216);
pub const __NR_getdents64 = @as(c_int, 217);
pub const __NR_set_tid_address = @as(c_int, 218);
pub const __NR_restart_syscall = @as(c_int, 219);
pub const __NR_semtimedop = @as(c_int, 220);
pub const __NR_fadvise64 = @as(c_int, 221);
pub const __NR_timer_create = @as(c_int, 222);
pub const __NR_timer_settime = @as(c_int, 223);
pub const __NR_timer_gettime = @as(c_int, 224);
pub const __NR_timer_getoverrun = @as(c_int, 225);
pub const __NR_timer_delete = @as(c_int, 226);
pub const __NR_clock_settime = @as(c_int, 227);
pub const __NR_clock_gettime = @as(c_int, 228);
pub const __NR_clock_getres = @as(c_int, 229);
pub const __NR_clock_nanosleep = @as(c_int, 230);
pub const __NR_exit_group = @as(c_int, 231);
pub const __NR_epoll_wait = @as(c_int, 232);
pub const __NR_epoll_ctl = @as(c_int, 233);
pub const __NR_tgkill = @as(c_int, 234);
pub const __NR_utimes = @as(c_int, 235);
pub const __NR_vserver = @as(c_int, 236);
pub const __NR_mbind = @as(c_int, 237);
pub const __NR_set_mempolicy = @as(c_int, 238);
pub const __NR_get_mempolicy = @as(c_int, 239);
pub const __NR_mq_open = @as(c_int, 240);
pub const __NR_mq_unlink = @as(c_int, 241);
pub const __NR_mq_timedsend = @as(c_int, 242);
pub const __NR_mq_timedreceive = @as(c_int, 243);
pub const __NR_mq_notify = @as(c_int, 244);
pub const __NR_mq_getsetattr = @as(c_int, 245);
pub const __NR_kexec_load = @as(c_int, 246);
pub const __NR_waitid = @as(c_int, 247);
pub const __NR_add_key = @as(c_int, 248);
pub const __NR_request_key = @as(c_int, 249);
pub const __NR_keyctl = @as(c_int, 250);
pub const __NR_ioprio_set = @as(c_int, 251);
pub const __NR_ioprio_get = @as(c_int, 252);
pub const __NR_inotify_init = @as(c_int, 253);
pub const __NR_inotify_add_watch = @as(c_int, 254);
pub const __NR_inotify_rm_watch = @as(c_int, 255);
pub const __NR_migrate_pages = @as(c_int, 256);
pub const __NR_openat = @as(c_int, 257);
pub const __NR_mkdirat = @as(c_int, 258);
pub const __NR_mknodat = @as(c_int, 259);
pub const __NR_fchownat = @as(c_int, 260);
pub const __NR_futimesat = @as(c_int, 261);
pub const __NR_newfstatat = @as(c_int, 262);
pub const __NR_unlinkat = @as(c_int, 263);
pub const __NR_renameat = @as(c_int, 264);
pub const __NR_linkat = @as(c_int, 265);
pub const __NR_symlinkat = @as(c_int, 266);
pub const __NR_readlinkat = @as(c_int, 267);
pub const __NR_fchmodat = @as(c_int, 268);
pub const __NR_faccessat = @as(c_int, 269);
pub const __NR_pselect6 = @as(c_int, 270);
pub const __NR_ppoll = @as(c_int, 271);
pub const __NR_unshare = @as(c_int, 272);
pub const __NR_set_robust_list = @as(c_int, 273);
pub const __NR_get_robust_list = @as(c_int, 274);
pub const __NR_splice = @as(c_int, 275);
pub const __NR_tee = @as(c_int, 276);
pub const __NR_sync_file_range = @as(c_int, 277);
pub const __NR_vmsplice = @as(c_int, 278);
pub const __NR_move_pages = @as(c_int, 279);
pub const __NR_utimensat = @as(c_int, 280);
pub const __NR_epoll_pwait = @as(c_int, 281);
pub const __NR_signalfd = @as(c_int, 282);
pub const __NR_timerfd_create = @as(c_int, 283);
pub const __NR_eventfd = @as(c_int, 284);
pub const __NR_fallocate = @as(c_int, 285);
pub const __NR_timerfd_settime = @as(c_int, 286);
pub const __NR_timerfd_gettime = @as(c_int, 287);
pub const __NR_accept4 = @as(c_int, 288);
pub const __NR_signalfd4 = @as(c_int, 289);
pub const __NR_eventfd2 = @as(c_int, 290);
pub const __NR_epoll_create1 = @as(c_int, 291);
pub const __NR_dup3 = @as(c_int, 292);
pub const __NR_pipe2 = @as(c_int, 293);
pub const __NR_inotify_init1 = @as(c_int, 294);
pub const __NR_preadv = @as(c_int, 295);
pub const __NR_pwritev = @as(c_int, 296);
pub const __NR_rt_tgsigqueueinfo = @as(c_int, 297);
pub const __NR_perf_event_open = @as(c_int, 298);
pub const __NR_recvmmsg = @as(c_int, 299);
pub const __NR_fanotify_init = @as(c_int, 300);
pub const __NR_fanotify_mark = @as(c_int, 301);
pub const __NR_prlimit64 = @as(c_int, 302);
pub const __NR_name_to_handle_at = @as(c_int, 303);
pub const __NR_open_by_handle_at = @as(c_int, 304);
pub const __NR_clock_adjtime = @as(c_int, 305);
pub const __NR_syncfs = @as(c_int, 306);
pub const __NR_sendmmsg = @as(c_int, 307);
pub const __NR_setns = @as(c_int, 308);
pub const __NR_getcpu = @as(c_int, 309);
pub const __NR_process_vm_readv = @as(c_int, 310);
pub const __NR_process_vm_writev = @as(c_int, 311);
pub const __NR_kcmp = @as(c_int, 312);
pub const __NR_finit_module = @as(c_int, 313);
pub const __NR_sched_setattr = @as(c_int, 314);
pub const __NR_sched_getattr = @as(c_int, 315);
pub const __NR_renameat2 = @as(c_int, 316);
pub const __NR_seccomp = @as(c_int, 317);
pub const __NR_getrandom = @as(c_int, 318);
pub const __NR_memfd_create = @as(c_int, 319);
pub const __NR_kexec_file_load = @as(c_int, 320);
pub const __NR_bpf = @as(c_int, 321);
pub const __NR_execveat = @as(c_int, 322);
pub const __NR_userfaultfd = @as(c_int, 323);
pub const __NR_membarrier = @as(c_int, 324);
pub const __NR_mlock2 = @as(c_int, 325);
pub const __NR_copy_file_range = @as(c_int, 326);
pub const __NR_preadv2 = @as(c_int, 327);
pub const __NR_pwritev2 = @as(c_int, 328);
pub const __NR_pkey_mprotect = @as(c_int, 329);
pub const __NR_pkey_alloc = @as(c_int, 330);
pub const __NR_pkey_free = @as(c_int, 331);
pub const __NR_statx = @as(c_int, 332);
pub const __NR_io_pgetevents = @as(c_int, 333);
pub const __NR_rseq = @as(c_int, 334);
pub const __NR_pidfd_send_signal = @as(c_int, 424);
pub const __NR_io_uring_setup = @as(c_int, 425);
pub const __NR_io_uring_enter = @as(c_int, 426);
pub const __NR_io_uring_register = @as(c_int, 427);
pub const __NR_open_tree = @as(c_int, 428);
pub const __NR_move_mount = @as(c_int, 429);
pub const __NR_fsopen = @as(c_int, 430);
pub const __NR_fsconfig = @as(c_int, 431);
pub const __NR_fsmount = @as(c_int, 432);
pub const __NR_fspick = @as(c_int, 433);
pub const __NR_pidfd_open = @as(c_int, 434);
pub const __NR_clone3 = @as(c_int, 435);
pub const __NR_close_range = @as(c_int, 436);
pub const __NR_openat2 = @as(c_int, 437);
pub const __NR_pidfd_getfd = @as(c_int, 438);
pub const __NR_faccessat2 = @as(c_int, 439);
pub const __NR_process_madvise = @as(c_int, 440);
pub const __NR_epoll_pwait2 = @as(c_int, 441);
pub const __NR_mount_setattr = @as(c_int, 442);
pub const __NR_quotactl_fd = @as(c_int, 443);
pub const __NR_landlock_create_ruleset = @as(c_int, 444);
pub const __NR_landlock_add_rule = @as(c_int, 445);
pub const __NR_landlock_restrict_self = @as(c_int, 446);
pub const __NR_memfd_secret = @as(c_int, 447);
pub const __NR_process_mrelease = @as(c_int, 448);
pub const __NR_futex_waitv = @as(c_int, 449);
pub const __NR_set_mempolicy_home_node = @as(c_int, 450);
pub const __NR_cachestat = @as(c_int, 451);
pub const __NR_fchmodat2 = @as(c_int, 452);
pub const __NR_map_shadow_stack = @as(c_int, 453);
pub const __NR_futex_wake = @as(c_int, 454);
pub const __NR_futex_wait = @as(c_int, 455);
pub const __NR_futex_requeue = @as(c_int, 456);
pub const __NR_statmount = @as(c_int, 457);
pub const __NR_listmount = @as(c_int, 458);
pub const __NR_lsm_get_self_attr = @as(c_int, 459);
pub const __NR_lsm_set_self_attr = @as(c_int, 460);
pub const __NR_lsm_list_modules = @as(c_int, 461);
pub const __NR_mseal = @as(c_int, 462);
pub const __GLIBC_LINUX_VERSION_CODE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 395520, .decimal);
pub const SYS__sysctl = __NR__sysctl;
pub const SYS_accept = __NR_accept;
pub const SYS_accept4 = __NR_accept4;
pub const SYS_access = __NR_access;
pub const SYS_acct = __NR_acct;
pub const SYS_add_key = __NR_add_key;
pub const SYS_adjtimex = __NR_adjtimex;
pub const SYS_afs_syscall = __NR_afs_syscall;
pub const SYS_alarm = __NR_alarm;
pub const SYS_arch_prctl = __NR_arch_prctl;
pub const SYS_bind = __NR_bind;
pub const SYS_bpf = __NR_bpf;
pub const SYS_brk = __NR_brk;
pub const SYS_cachestat = __NR_cachestat;
pub const SYS_capget = __NR_capget;
pub const SYS_capset = __NR_capset;
pub const SYS_chdir = __NR_chdir;
pub const SYS_chmod = __NR_chmod;
pub const SYS_chown = __NR_chown;
pub const SYS_chroot = __NR_chroot;
pub const SYS_clock_adjtime = __NR_clock_adjtime;
pub const SYS_clock_getres = __NR_clock_getres;
pub const SYS_clock_gettime = __NR_clock_gettime;
pub const SYS_clock_nanosleep = __NR_clock_nanosleep;
pub const SYS_clock_settime = __NR_clock_settime;
pub const SYS_clone = __NR_clone;
pub const SYS_clone3 = __NR_clone3;
pub const SYS_close = __NR_close;
pub const SYS_close_range = __NR_close_range;
pub const SYS_connect = __NR_connect;
pub const SYS_copy_file_range = __NR_copy_file_range;
pub const SYS_creat = __NR_creat;
pub const SYS_create_module = __NR_create_module;
pub const SYS_delete_module = __NR_delete_module;
pub const SYS_dup = __NR_dup;
pub const SYS_dup2 = __NR_dup2;
pub const SYS_dup3 = __NR_dup3;
pub const SYS_epoll_create = __NR_epoll_create;
pub const SYS_epoll_create1 = __NR_epoll_create1;
pub const SYS_epoll_ctl = __NR_epoll_ctl;
pub const SYS_epoll_ctl_old = __NR_epoll_ctl_old;
pub const SYS_epoll_pwait = __NR_epoll_pwait;
pub const SYS_epoll_pwait2 = __NR_epoll_pwait2;
pub const SYS_epoll_wait = __NR_epoll_wait;
pub const SYS_epoll_wait_old = __NR_epoll_wait_old;
pub const SYS_eventfd = __NR_eventfd;
pub const SYS_eventfd2 = __NR_eventfd2;
pub const SYS_execve = __NR_execve;
pub const SYS_execveat = __NR_execveat;
pub const SYS_exit = __NR_exit;
pub const SYS_exit_group = __NR_exit_group;
pub const SYS_faccessat = __NR_faccessat;
pub const SYS_faccessat2 = __NR_faccessat2;
pub const SYS_fadvise64 = __NR_fadvise64;
pub const SYS_fallocate = __NR_fallocate;
pub const SYS_fanotify_init = __NR_fanotify_init;
pub const SYS_fanotify_mark = __NR_fanotify_mark;
pub const SYS_fchdir = __NR_fchdir;
pub const SYS_fchmod = __NR_fchmod;
pub const SYS_fchmodat = __NR_fchmodat;
pub const SYS_fchmodat2 = __NR_fchmodat2;
pub const SYS_fchown = __NR_fchown;
pub const SYS_fchownat = __NR_fchownat;
pub const SYS_fcntl = __NR_fcntl;
pub const SYS_fdatasync = __NR_fdatasync;
pub const SYS_fgetxattr = __NR_fgetxattr;
pub const SYS_finit_module = __NR_finit_module;
pub const SYS_flistxattr = __NR_flistxattr;
pub const SYS_flock = __NR_flock;
pub const SYS_fork = __NR_fork;
pub const SYS_fremovexattr = __NR_fremovexattr;
pub const SYS_fsconfig = __NR_fsconfig;
pub const SYS_fsetxattr = __NR_fsetxattr;
pub const SYS_fsmount = __NR_fsmount;
pub const SYS_fsopen = __NR_fsopen;
pub const SYS_fspick = __NR_fspick;
pub const SYS_fstat = __NR_fstat;
pub const SYS_fstatfs = __NR_fstatfs;
pub const SYS_fsync = __NR_fsync;
pub const SYS_ftruncate = __NR_ftruncate;
pub const SYS_futex = __NR_futex;
pub const SYS_futex_requeue = __NR_futex_requeue;
pub const SYS_futex_wait = __NR_futex_wait;
pub const SYS_futex_waitv = __NR_futex_waitv;
pub const SYS_futex_wake = __NR_futex_wake;
pub const SYS_futimesat = __NR_futimesat;
pub const SYS_get_kernel_syms = __NR_get_kernel_syms;
pub const SYS_get_mempolicy = __NR_get_mempolicy;
pub const SYS_get_robust_list = __NR_get_robust_list;
pub const SYS_get_thread_area = __NR_get_thread_area;
pub const SYS_getcpu = __NR_getcpu;
pub const SYS_getcwd = __NR_getcwd;
pub const SYS_getdents = __NR_getdents;
pub const SYS_getdents64 = __NR_getdents64;
pub const SYS_getegid = __NR_getegid;
pub const SYS_geteuid = __NR_geteuid;
pub const SYS_getgid = __NR_getgid;
pub const SYS_getgroups = __NR_getgroups;
pub const SYS_getitimer = __NR_getitimer;
pub const SYS_getpeername = __NR_getpeername;
pub const SYS_getpgid = __NR_getpgid;
pub const SYS_getpgrp = __NR_getpgrp;
pub const SYS_getpid = __NR_getpid;
pub const SYS_getpmsg = __NR_getpmsg;
pub const SYS_getppid = __NR_getppid;
pub const SYS_getpriority = __NR_getpriority;
pub const SYS_getrandom = __NR_getrandom;
pub const SYS_getresgid = __NR_getresgid;
pub const SYS_getresuid = __NR_getresuid;
pub const SYS_getrlimit = __NR_getrlimit;
pub const SYS_getrusage = __NR_getrusage;
pub const SYS_getsid = __NR_getsid;
pub const SYS_getsockname = __NR_getsockname;
pub const SYS_getsockopt = __NR_getsockopt;
pub const SYS_gettid = __NR_gettid;
pub const SYS_gettimeofday = __NR_gettimeofday;
pub const SYS_getuid = __NR_getuid;
pub const SYS_getxattr = __NR_getxattr;
pub const SYS_init_module = __NR_init_module;
pub const SYS_inotify_add_watch = __NR_inotify_add_watch;
pub const SYS_inotify_init = __NR_inotify_init;
pub const SYS_inotify_init1 = __NR_inotify_init1;
pub const SYS_inotify_rm_watch = __NR_inotify_rm_watch;
pub const SYS_io_cancel = __NR_io_cancel;
pub const SYS_io_destroy = __NR_io_destroy;
pub const SYS_io_getevents = __NR_io_getevents;
pub const SYS_io_pgetevents = __NR_io_pgetevents;
pub const SYS_io_setup = __NR_io_setup;
pub const SYS_io_submit = __NR_io_submit;
pub const SYS_io_uring_enter = __NR_io_uring_enter;
pub const SYS_io_uring_register = __NR_io_uring_register;
pub const SYS_io_uring_setup = __NR_io_uring_setup;
pub const SYS_ioctl = __NR_ioctl;
pub const SYS_ioperm = __NR_ioperm;
pub const SYS_iopl = __NR_iopl;
pub const SYS_ioprio_get = __NR_ioprio_get;
pub const SYS_ioprio_set = __NR_ioprio_set;
pub const SYS_kcmp = __NR_kcmp;
pub const SYS_kexec_file_load = __NR_kexec_file_load;
pub const SYS_kexec_load = __NR_kexec_load;
pub const SYS_keyctl = __NR_keyctl;
pub const SYS_kill = __NR_kill;
pub const SYS_landlock_add_rule = __NR_landlock_add_rule;
pub const SYS_landlock_create_ruleset = __NR_landlock_create_ruleset;
pub const SYS_landlock_restrict_self = __NR_landlock_restrict_self;
pub const SYS_lchown = __NR_lchown;
pub const SYS_lgetxattr = __NR_lgetxattr;
pub const SYS_link = __NR_link;
pub const SYS_linkat = __NR_linkat;
pub const SYS_listen = __NR_listen;
pub const SYS_listmount = __NR_listmount;
pub const SYS_listxattr = __NR_listxattr;
pub const SYS_llistxattr = __NR_llistxattr;
pub const SYS_lookup_dcookie = __NR_lookup_dcookie;
pub const SYS_lremovexattr = __NR_lremovexattr;
pub const SYS_lseek = __NR_lseek;
pub const SYS_lsetxattr = __NR_lsetxattr;
pub const SYS_lsm_get_self_attr = __NR_lsm_get_self_attr;
pub const SYS_lsm_list_modules = __NR_lsm_list_modules;
pub const SYS_lsm_set_self_attr = __NR_lsm_set_self_attr;
pub const SYS_lstat = __NR_lstat;
pub const SYS_madvise = __NR_madvise;
pub const SYS_map_shadow_stack = __NR_map_shadow_stack;
pub const SYS_mbind = __NR_mbind;
pub const SYS_membarrier = __NR_membarrier;
pub const SYS_memfd_create = __NR_memfd_create;
pub const SYS_memfd_secret = __NR_memfd_secret;
pub const SYS_migrate_pages = __NR_migrate_pages;
pub const SYS_mincore = __NR_mincore;
pub const SYS_mkdir = __NR_mkdir;
pub const SYS_mkdirat = __NR_mkdirat;
pub const SYS_mknod = __NR_mknod;
pub const SYS_mknodat = __NR_mknodat;
pub const SYS_mlock = __NR_mlock;
pub const SYS_mlock2 = __NR_mlock2;
pub const SYS_mlockall = __NR_mlockall;
pub const SYS_mmap = __NR_mmap;
pub const SYS_modify_ldt = __NR_modify_ldt;
pub const SYS_mount = __NR_mount;
pub const SYS_mount_setattr = __NR_mount_setattr;
pub const SYS_move_mount = __NR_move_mount;
pub const SYS_move_pages = __NR_move_pages;
pub const SYS_mprotect = __NR_mprotect;
pub const SYS_mq_getsetattr = __NR_mq_getsetattr;
pub const SYS_mq_notify = __NR_mq_notify;
pub const SYS_mq_open = __NR_mq_open;
pub const SYS_mq_timedreceive = __NR_mq_timedreceive;
pub const SYS_mq_timedsend = __NR_mq_timedsend;
pub const SYS_mq_unlink = __NR_mq_unlink;
pub const SYS_mremap = __NR_mremap;
pub const SYS_msgctl = __NR_msgctl;
pub const SYS_msgget = __NR_msgget;
pub const SYS_msgrcv = __NR_msgrcv;
pub const SYS_msgsnd = __NR_msgsnd;
pub const SYS_msync = __NR_msync;
pub const SYS_munlock = __NR_munlock;
pub const SYS_munlockall = __NR_munlockall;
pub const SYS_munmap = __NR_munmap;
pub const SYS_name_to_handle_at = __NR_name_to_handle_at;
pub const SYS_nanosleep = __NR_nanosleep;
pub const SYS_newfstatat = __NR_newfstatat;
pub const SYS_nfsservctl = __NR_nfsservctl;
pub const SYS_open = __NR_open;
pub const SYS_open_by_handle_at = __NR_open_by_handle_at;
pub const SYS_open_tree = __NR_open_tree;
pub const SYS_openat = __NR_openat;
pub const SYS_openat2 = __NR_openat2;
pub const SYS_pause = __NR_pause;
pub const SYS_perf_event_open = __NR_perf_event_open;
pub const SYS_personality = __NR_personality;
pub const SYS_pidfd_getfd = __NR_pidfd_getfd;
pub const SYS_pidfd_open = __NR_pidfd_open;
pub const SYS_pidfd_send_signal = __NR_pidfd_send_signal;
pub const SYS_pipe = __NR_pipe;
pub const SYS_pipe2 = __NR_pipe2;
pub const SYS_pivot_root = __NR_pivot_root;
pub const SYS_pkey_alloc = __NR_pkey_alloc;
pub const SYS_pkey_free = __NR_pkey_free;
pub const SYS_pkey_mprotect = __NR_pkey_mprotect;
pub const SYS_poll = __NR_poll;
pub const SYS_ppoll = __NR_ppoll;
pub const SYS_prctl = __NR_prctl;
pub const SYS_pread64 = __NR_pread64;
pub const SYS_preadv = __NR_preadv;
pub const SYS_preadv2 = __NR_preadv2;
pub const SYS_prlimit64 = __NR_prlimit64;
pub const SYS_process_madvise = __NR_process_madvise;
pub const SYS_process_mrelease = __NR_process_mrelease;
pub const SYS_process_vm_readv = __NR_process_vm_readv;
pub const SYS_process_vm_writev = __NR_process_vm_writev;
pub const SYS_pselect6 = __NR_pselect6;
pub const SYS_ptrace = __NR_ptrace;
pub const SYS_putpmsg = __NR_putpmsg;
pub const SYS_pwrite64 = __NR_pwrite64;
pub const SYS_pwritev = __NR_pwritev;
pub const SYS_pwritev2 = __NR_pwritev2;
pub const SYS_query_module = __NR_query_module;
pub const SYS_quotactl = __NR_quotactl;
pub const SYS_quotactl_fd = __NR_quotactl_fd;
pub const SYS_read = __NR_read;
pub const SYS_readahead = __NR_readahead;
pub const SYS_readlink = __NR_readlink;
pub const SYS_readlinkat = __NR_readlinkat;
pub const SYS_readv = __NR_readv;
pub const SYS_reboot = __NR_reboot;
pub const SYS_recvfrom = __NR_recvfrom;
pub const SYS_recvmmsg = __NR_recvmmsg;
pub const SYS_recvmsg = __NR_recvmsg;
pub const SYS_remap_file_pages = __NR_remap_file_pages;
pub const SYS_removexattr = __NR_removexattr;
pub const SYS_rename = __NR_rename;
pub const SYS_renameat = __NR_renameat;
pub const SYS_renameat2 = __NR_renameat2;
pub const SYS_request_key = __NR_request_key;
pub const SYS_restart_syscall = __NR_restart_syscall;
pub const SYS_rmdir = __NR_rmdir;
pub const SYS_rseq = __NR_rseq;
pub const SYS_rt_sigaction = __NR_rt_sigaction;
pub const SYS_rt_sigpending = __NR_rt_sigpending;
pub const SYS_rt_sigprocmask = __NR_rt_sigprocmask;
pub const SYS_rt_sigqueueinfo = __NR_rt_sigqueueinfo;
pub const SYS_rt_sigreturn = __NR_rt_sigreturn;
pub const SYS_rt_sigsuspend = __NR_rt_sigsuspend;
pub const SYS_rt_sigtimedwait = __NR_rt_sigtimedwait;
pub const SYS_rt_tgsigqueueinfo = __NR_rt_tgsigqueueinfo;
pub const SYS_sched_get_priority_max = __NR_sched_get_priority_max;
pub const SYS_sched_get_priority_min = __NR_sched_get_priority_min;
pub const SYS_sched_getaffinity = __NR_sched_getaffinity;
pub const SYS_sched_getattr = __NR_sched_getattr;
pub const SYS_sched_getparam = __NR_sched_getparam;
pub const SYS_sched_getscheduler = __NR_sched_getscheduler;
pub const SYS_sched_rr_get_interval = __NR_sched_rr_get_interval;
pub const SYS_sched_setaffinity = __NR_sched_setaffinity;
pub const SYS_sched_setattr = __NR_sched_setattr;
pub const SYS_sched_setparam = __NR_sched_setparam;
pub const SYS_sched_setscheduler = __NR_sched_setscheduler;
pub const SYS_sched_yield = __NR_sched_yield;
pub const SYS_seccomp = __NR_seccomp;
pub const SYS_security = __NR_security;
pub const SYS_select = __NR_select;
pub const SYS_semctl = __NR_semctl;
pub const SYS_semget = __NR_semget;
pub const SYS_semop = __NR_semop;
pub const SYS_semtimedop = __NR_semtimedop;
pub const SYS_sendfile = __NR_sendfile;
pub const SYS_sendmmsg = __NR_sendmmsg;
pub const SYS_sendmsg = __NR_sendmsg;
pub const SYS_sendto = __NR_sendto;
pub const SYS_set_mempolicy = __NR_set_mempolicy;
pub const SYS_set_mempolicy_home_node = __NR_set_mempolicy_home_node;
pub const SYS_set_robust_list = __NR_set_robust_list;
pub const SYS_set_thread_area = __NR_set_thread_area;
pub const SYS_set_tid_address = __NR_set_tid_address;
pub const SYS_setdomainname = __NR_setdomainname;
pub const SYS_setfsgid = __NR_setfsgid;
pub const SYS_setfsuid = __NR_setfsuid;
pub const SYS_setgid = __NR_setgid;
pub const SYS_setgroups = __NR_setgroups;
pub const SYS_sethostname = __NR_sethostname;
pub const SYS_setitimer = __NR_setitimer;
pub const SYS_setns = __NR_setns;
pub const SYS_setpgid = __NR_setpgid;
pub const SYS_setpriority = __NR_setpriority;
pub const SYS_setregid = __NR_setregid;
pub const SYS_setresgid = __NR_setresgid;
pub const SYS_setresuid = __NR_setresuid;
pub const SYS_setreuid = __NR_setreuid;
pub const SYS_setrlimit = __NR_setrlimit;
pub const SYS_setsid = __NR_setsid;
pub const SYS_setsockopt = __NR_setsockopt;
pub const SYS_settimeofday = __NR_settimeofday;
pub const SYS_setuid = __NR_setuid;
pub const SYS_setxattr = __NR_setxattr;
pub const SYS_shmat = __NR_shmat;
pub const SYS_shmctl = __NR_shmctl;
pub const SYS_shmdt = __NR_shmdt;
pub const SYS_shmget = __NR_shmget;
pub const SYS_shutdown = __NR_shutdown;
pub const SYS_sigaltstack = __NR_sigaltstack;
pub const SYS_signalfd = __NR_signalfd;
pub const SYS_signalfd4 = __NR_signalfd4;
pub const SYS_socket = __NR_socket;
pub const SYS_socketpair = __NR_socketpair;
pub const SYS_splice = __NR_splice;
pub const SYS_stat = __NR_stat;
pub const SYS_statfs = __NR_statfs;
pub const SYS_statmount = __NR_statmount;
pub const SYS_statx = __NR_statx;
pub const SYS_swapoff = __NR_swapoff;
pub const SYS_swapon = __NR_swapon;
pub const SYS_symlink = __NR_symlink;
pub const SYS_symlinkat = __NR_symlinkat;
pub const SYS_sync = __NR_sync;
pub const SYS_sync_file_range = __NR_sync_file_range;
pub const SYS_syncfs = __NR_syncfs;
pub const SYS_sysfs = __NR_sysfs;
pub const SYS_sysinfo = __NR_sysinfo;
pub const SYS_syslog = __NR_syslog;
pub const SYS_tee = __NR_tee;
pub const SYS_tgkill = __NR_tgkill;
pub const SYS_time = __NR_time;
pub const SYS_timer_create = __NR_timer_create;
pub const SYS_timer_delete = __NR_timer_delete;
pub const SYS_timer_getoverrun = __NR_timer_getoverrun;
pub const SYS_timer_gettime = __NR_timer_gettime;
pub const SYS_timer_settime = __NR_timer_settime;
pub const SYS_timerfd_create = __NR_timerfd_create;
pub const SYS_timerfd_gettime = __NR_timerfd_gettime;
pub const SYS_timerfd_settime = __NR_timerfd_settime;
pub const SYS_times = __NR_times;
pub const SYS_tkill = __NR_tkill;
pub const SYS_truncate = __NR_truncate;
pub const SYS_tuxcall = __NR_tuxcall;
pub const SYS_umask = __NR_umask;
pub const SYS_umount2 = __NR_umount2;
pub const SYS_uname = __NR_uname;
pub const SYS_unlink = __NR_unlink;
pub const SYS_unlinkat = __NR_unlinkat;
pub const SYS_unshare = __NR_unshare;
pub const SYS_uselib = __NR_uselib;
pub const SYS_userfaultfd = __NR_userfaultfd;
pub const SYS_ustat = __NR_ustat;
pub const SYS_utime = __NR_utime;
pub const SYS_utimensat = __NR_utimensat;
pub const SYS_utimes = __NR_utimes;
pub const SYS_vfork = __NR_vfork;
pub const SYS_vhangup = __NR_vhangup;
pub const SYS_vmsplice = __NR_vmsplice;
pub const SYS_vserver = __NR_vserver;
pub const SYS_wait4 = __NR_wait4;
pub const SYS_waitid = __NR_waitid;
pub const SYS_write = __NR_write;
pub const SYS_writev = __NR_writev;
pub const _LINUX_CAPABILITY_H = "";
pub const _LINUX_CAPABILITY_VERSION_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x19980330, .hex);
pub const _LINUX_CAPABILITY_U32S_1 = @as(c_int, 1);
pub const _LINUX_CAPABILITY_VERSION_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20071026, .hex);
pub const _LINUX_CAPABILITY_U32S_2 = @as(c_int, 2);
pub const _LINUX_CAPABILITY_VERSION_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20080522, .hex);
pub const _LINUX_CAPABILITY_U32S_3 = @as(c_int, 2);
pub const VFS_CAP_REVISION_MASK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFF000000, .hex);
pub const VFS_CAP_REVISION_SHIFT = @as(c_int, 24);
pub const VFS_CAP_FLAGS_MASK = ~VFS_CAP_REVISION_MASK;
pub const VFS_CAP_FLAGS_EFFECTIVE = @as(c_int, 0x000001);
pub const VFS_CAP_REVISION_1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const VFS_CAP_U32_1 = @as(c_int, 1);
pub const XATTR_CAPS_SZ_1 = @import("std").zig.c_translation.sizeof(__le32) * (@as(c_int, 1) + (@as(c_int, 2) * VFS_CAP_U32_1));
pub const VFS_CAP_REVISION_2 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const VFS_CAP_U32_2 = @as(c_int, 2);
pub const XATTR_CAPS_SZ_2 = @import("std").zig.c_translation.sizeof(__le32) * (@as(c_int, 1) + (@as(c_int, 2) * VFS_CAP_U32_2));
pub const VFS_CAP_REVISION_3 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x03000000, .hex);
pub const VFS_CAP_U32_3 = @as(c_int, 2);
pub const XATTR_CAPS_SZ_3 = @import("std").zig.c_translation.sizeof(__le32) * (@as(c_int, 2) + (@as(c_int, 2) * VFS_CAP_U32_3));
pub const XATTR_CAPS_SZ = XATTR_CAPS_SZ_3;
pub const VFS_CAP_U32 = VFS_CAP_U32_3;
pub const VFS_CAP_REVISION = VFS_CAP_REVISION_3;
pub const _LINUX_CAPABILITY_VERSION = _LINUX_CAPABILITY_VERSION_1;
pub const _LINUX_CAPABILITY_U32S = _LINUX_CAPABILITY_U32S_1;
pub const CAP_CHOWN = @as(c_int, 0);
pub const CAP_DAC_OVERRIDE = @as(c_int, 1);
pub const CAP_DAC_READ_SEARCH = @as(c_int, 2);
pub const CAP_FOWNER = @as(c_int, 3);
pub const CAP_FSETID = @as(c_int, 4);
pub const CAP_KILL = @as(c_int, 5);
pub const CAP_SETGID = @as(c_int, 6);
pub const CAP_SETUID = @as(c_int, 7);
pub const CAP_SETPCAP = @as(c_int, 8);
pub const CAP_LINUX_IMMUTABLE = @as(c_int, 9);
pub const CAP_NET_BIND_SERVICE = @as(c_int, 10);
pub const CAP_NET_BROADCAST = @as(c_int, 11);
pub const CAP_NET_ADMIN = @as(c_int, 12);
pub const CAP_NET_RAW = @as(c_int, 13);
pub const CAP_IPC_LOCK = @as(c_int, 14);
pub const CAP_IPC_OWNER = @as(c_int, 15);
pub const CAP_SYS_MODULE = @as(c_int, 16);
pub const CAP_SYS_RAWIO = @as(c_int, 17);
pub const CAP_SYS_CHROOT = @as(c_int, 18);
pub const CAP_SYS_PTRACE = @as(c_int, 19);
pub const CAP_SYS_PACCT = @as(c_int, 20);
pub const CAP_SYS_ADMIN = @as(c_int, 21);
pub const CAP_SYS_BOOT = @as(c_int, 22);
pub const CAP_SYS_NICE = @as(c_int, 23);
pub const CAP_SYS_RESOURCE = @as(c_int, 24);
pub const CAP_SYS_TIME = @as(c_int, 25);
pub const CAP_SYS_TTY_CONFIG = @as(c_int, 26);
pub const CAP_MKNOD = @as(c_int, 27);
pub const CAP_LEASE = @as(c_int, 28);
pub const CAP_AUDIT_WRITE = @as(c_int, 29);
pub const CAP_AUDIT_CONTROL = @as(c_int, 30);
pub const CAP_SETFCAP = @as(c_int, 31);
pub const CAP_MAC_OVERRIDE = @as(c_int, 32);
pub const CAP_MAC_ADMIN = @as(c_int, 33);
pub const CAP_SYSLOG = @as(c_int, 34);
pub const CAP_WAKE_ALARM = @as(c_int, 35);
pub const CAP_BLOCK_SUSPEND = @as(c_int, 36);
pub const CAP_AUDIT_READ = @as(c_int, 37);
pub const CAP_PERFMON = @as(c_int, 38);
pub const CAP_BPF = @as(c_int, 39);
pub const CAP_CHECKPOINT_RESTORE = @as(c_int, 40);
pub const CAP_LAST_CAP = CAP_CHECKPOINT_RESTORE;
pub inline fn cap_valid(x: anytype) @TypeOf((x >= @as(c_int, 0)) and (x <= CAP_LAST_CAP)) {
    _ = &x;
    return (x >= @as(c_int, 0)) and (x <= CAP_LAST_CAP);
}
pub inline fn CAP_TO_INDEX(x: anytype) @TypeOf(x >> @as(c_int, 5)) {
    _ = &x;
    return x >> @as(c_int, 5);
}
pub inline fn CAP_TO_MASK(x: anytype) @TypeOf(@as(c_uint, 1) << (x & @as(c_int, 31))) {
    _ = &x;
    return @as(c_uint, 1) << (x & @as(c_int, 31));
}
pub const __NETINET_UDP_H = @as(c_int, 1);
pub const UDP_CORK = @as(c_int, 1);
pub const UDP_ENCAP = @as(c_int, 100);
pub const UDP_NO_CHECK6_TX = @as(c_int, 101);
pub const UDP_NO_CHECK6_RX = @as(c_int, 102);
pub const UDP_SEGMENT = @as(c_int, 103);
pub const UDP_GRO = @as(c_int, 104);
pub const UDP_ENCAP_ESPINUDP_NON_IKE = @as(c_int, 1);
pub const UDP_ENCAP_ESPINUDP = @as(c_int, 2);
pub const UDP_ENCAP_L2TPINUDP = @as(c_int, 3);
pub const UDP_ENCAP_GTP0 = @as(c_int, 4);
pub const UDP_ENCAP_GTP1U = @as(c_int, 5);
pub const SOL_UDP = @as(c_int, 17);
pub const NGX_LISTEN_BACKLOG = @as(c_int, 511);
pub const NGX_HAVE_SO_SNDLOWAT = @as(c_int, 0);
pub const NGX_HAVE_INHERITED_NONBLOCK = @as(c_int, 0);
pub const NGX_HAVE_OS_SPECIFIC_INIT = @as(c_int, 1);
pub const ngx_debug_init = @compileError("unable to translate C expr: unexpected token ''");
// src/os/unix/ngx_linux_config.h:126:9
pub const ngx_signal_helper = @compileError("unable to translate macro: undefined identifier `SIG`");
// src/core/ngx_config.h:54:9
pub inline fn ngx_signal_value(n: anytype) @TypeOf(ngx_signal_helper(n)) {
    _ = &n;
    return ngx_signal_helper(n);
}
pub const ngx_random = random;
pub const NGX_SHUTDOWN_SIGNAL = @compileError("unable to translate macro: undefined identifier `QUIT`");
// src/core/ngx_config.h:60:9
pub const NGX_TERMINATE_SIGNAL = @compileError("unable to translate macro: undefined identifier `TERM`");
// src/core/ngx_config.h:61:9
pub const NGX_NOACCEPT_SIGNAL = @compileError("unable to translate macro: undefined identifier `WINCH`");
// src/core/ngx_config.h:62:9
pub const NGX_RECONFIGURE_SIGNAL = @compileError("unable to translate macro: undefined identifier `HUP`");
// src/core/ngx_config.h:63:9
pub const NGX_REOPEN_SIGNAL = @compileError("unable to translate macro: undefined identifier `USR1`");
// src/core/ngx_config.h:69:9
pub const NGX_CHANGEBIN_SIGNAL = @compileError("unable to translate macro: undefined identifier `USR2`");
// src/core/ngx_config.h:70:9
pub const ngx_cdecl = "";
pub const ngx_libc_cdecl = "";
pub const NGX_INT32_LEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// src/core/ngx_config.h:83:9
pub const NGX_INT64_LEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// src/core/ngx_config.h:84:9
pub const NGX_INT_T_LEN = NGX_INT64_LEN;
pub const NGX_MAX_INT_T_VALUE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal);
pub const NGX_ALIGNMENT = @import("std").zig.c_translation.sizeof(c_ulong);
pub inline fn ngx_align(d: anytype, a: anytype) @TypeOf((d + (a - @as(c_int, 1))) & ~(a - @as(c_int, 1))) {
    _ = &d;
    _ = &a;
    return (d + (a - @as(c_int, 1))) & ~(a - @as(c_int, 1));
}
pub inline fn ngx_align_ptr(p: anytype, a: anytype) [*c]u_char {
    _ = &p;
    _ = &a;
    return @import("std").zig.c_translation.cast([*c]u_char, (@import("std").zig.c_translation.cast(usize, p) + (@import("std").zig.c_translation.cast(usize, a) - @as(c_int, 1))) & ~(@import("std").zig.c_translation.cast(usize, a) - @as(c_int, 1)));
}
pub const ngx_abort = abort;
pub const NGX_INVALID_ARRAY_INDEX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const ngx_inline = @compileError("unable to translate C expr: unexpected token 'inline'");
// src/core/ngx_config.h:114:9
pub const NGX_MAXHOSTNAMELEN = @as(c_int, 256);
pub const NGX_MAX_UINT32_VALUE = @import("std").zig.c_translation.cast(u32, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffffffff, .hex));
pub const NGX_MAX_INT32_VALUE = @import("std").zig.c_translation.cast(u32, @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7fffffff, .hex));
pub const NGX_COMPAT_BEGIN = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_config.h:139:9
pub const NGX_COMPAT_END = "";
pub const _NGX_CORE_H_INCLUDED_ = "";
pub const NGX_OK = @as(c_int, 0);
pub const NGX_ERROR = -@as(c_int, 1);
pub const NGX_AGAIN = -@as(c_int, 2);
pub const NGX_BUSY = -@as(c_int, 3);
pub const NGX_DONE = -@as(c_int, 4);
pub const NGX_DECLINED = -@as(c_int, 5);
pub const NGX_ABORT = -@as(c_int, 6);
pub const _NGX_ERRNO_H_INCLUDED_ = "";
pub const NGX_EPERM = EPERM;
pub const NGX_ENOENT = ENOENT;
pub const NGX_ENOPATH = ENOENT;
pub const NGX_ESRCH = ESRCH;
pub const NGX_EINTR = EINTR;
pub const NGX_ECHILD = ECHILD;
pub const NGX_ENOMEM = ENOMEM;
pub const NGX_EACCES = EACCES;
pub const NGX_EBUSY = EBUSY;
pub const NGX_EEXIST = EEXIST;
pub const NGX_EEXIST_FILE = EEXIST;
pub const NGX_EXDEV = EXDEV;
pub const NGX_ENOTDIR = ENOTDIR;
pub const NGX_EISDIR = EISDIR;
pub const NGX_EINVAL = EINVAL;
pub const NGX_ENFILE = ENFILE;
pub const NGX_EMFILE = EMFILE;
pub const NGX_ENOSPC = ENOSPC;
pub const NGX_EPIPE = EPIPE;
pub const NGX_EINPROGRESS = EINPROGRESS;
pub const NGX_ENOPROTOOPT = ENOPROTOOPT;
pub const NGX_EOPNOTSUPP = EOPNOTSUPP;
pub const NGX_EADDRINUSE = EADDRINUSE;
pub const NGX_ECONNABORTED = ECONNABORTED;
pub const NGX_ECONNRESET = ECONNRESET;
pub const NGX_ENOTCONN = ENOTCONN;
pub const NGX_ETIMEDOUT = ETIMEDOUT;
pub const NGX_ECONNREFUSED = ECONNREFUSED;
pub const NGX_ENAMETOOLONG = ENAMETOOLONG;
pub const NGX_ENETDOWN = ENETDOWN;
pub const NGX_ENETUNREACH = ENETUNREACH;
pub const NGX_EHOSTDOWN = EHOSTDOWN;
pub const NGX_EHOSTUNREACH = EHOSTUNREACH;
pub const NGX_ENOSYS = ENOSYS;
pub const NGX_ECANCELED = ECANCELED;
pub const NGX_EILSEQ = EILSEQ;
pub const NGX_ENOMOREFILES = @as(c_int, 0);
pub const NGX_ELOOP = ELOOP;
pub const NGX_EBADF = EBADF;
pub const NGX_EMSGSIZE = EMSGSIZE;
pub const NGX_EMLINK = EMLINK;
pub const NGX_EAGAIN = EAGAIN;
pub const ngx_errno = errno;
pub const ngx_socket_errno = errno;
pub const ngx_set_errno = @compileError("unable to translate C expr: unexpected token '='");
// src/os/unix/ngx_errno.h:72:9
pub const ngx_set_socket_errno = @compileError("unable to translate C expr: unexpected token '='");
// src/os/unix/ngx_errno.h:73:9
pub const _NGX_ATOMIC_H_INCLUDED_ = "";
pub const NGX_HAVE_ATOMIC_OPS = @as(c_int, 1);
pub const NGX_ATOMIC_T_LEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// src/os/unix/ngx_atomic.h:51:9
pub const ngx_atomic_cmp_set = @compileError("unable to translate macro: undefined identifier `__sync_bool_compare_and_swap`");
// src/os/unix/ngx_atomic.h:59:9
pub const ngx_atomic_fetch_add = @compileError("unable to translate macro: undefined identifier `__sync_fetch_and_add`");
// src/os/unix/ngx_atomic.h:62:9
pub const ngx_memory_barrier = @compileError("unable to translate macro: undefined identifier `__sync_synchronize`");
// src/os/unix/ngx_atomic.h:65:9
pub const ngx_cpu_pause = @compileError("unable to translate C expr: unexpected token '__asm__'");
// src/os/unix/ngx_atomic.h:68:9
pub inline fn ngx_trylock(lock: anytype) @TypeOf((lock.* == @as(c_int, 0)) and (ngx_atomic_cmp_set(lock, @as(c_int, 0), @as(c_int, 1)) != 0)) {
    _ = &lock;
    return (lock.* == @as(c_int, 0)) and (ngx_atomic_cmp_set(lock, @as(c_int, 0), @as(c_int, 1)) != 0);
}
pub const ngx_unlock = @compileError("unable to translate C expr: unexpected token '='");
// src/os/unix/ngx_atomic.h:310:9
pub const _NGX_THREAD_H_INCLUDED_ = "";
pub const ngx_log_tid = @as(c_int, 0);
pub const NGX_TID_T_FMT = "%d";
pub const _NGX_RBTREE_H_INCLUDED_ = "";
pub const ngx_rbtree_init = @compileError("unable to translate C expr: unexpected token ';'");
// src/core/ngx_rbtree.h:44:9
pub const ngx_rbtree_data = @compileError("unable to translate C expr: unexpected token ')'");
// src/core/ngx_rbtree.h:50:9
pub const ngx_rbt_red = @compileError("unable to translate C expr: expected ')' instead got '='");
// src/core/ngx_rbtree.h:64:9
pub const ngx_rbt_black = @compileError("unable to translate C expr: expected ')' instead got '='");
// src/core/ngx_rbtree.h:65:9
pub inline fn ngx_rbt_is_red(node: anytype) @TypeOf(node.*.color) {
    _ = &node;
    return node.*.color;
}
pub inline fn ngx_rbt_is_black(node: anytype) @TypeOf(!(ngx_rbt_is_red(node) != 0)) {
    _ = &node;
    return !(ngx_rbt_is_red(node) != 0);
}
pub const ngx_rbt_copy_color = @compileError("unable to translate C expr: expected ')' instead got '='");
// src/core/ngx_rbtree.h:68:9
pub inline fn ngx_rbtree_sentinel_init(node: anytype) @TypeOf(ngx_rbt_black(node)) {
    _ = &node;
    return ngx_rbt_black(node);
}
pub const _NGX_TIME_H_INCLUDED_ = "";
pub const ngx_tm_sec = @compileError("unable to translate macro: undefined identifier `tm_sec`");
// src/os/unix/ngx_time.h:21:9
pub const ngx_tm_min = @compileError("unable to translate macro: undefined identifier `tm_min`");
// src/os/unix/ngx_time.h:22:9
pub const ngx_tm_hour = @compileError("unable to translate macro: undefined identifier `tm_hour`");
// src/os/unix/ngx_time.h:23:9
pub const ngx_tm_mday = @compileError("unable to translate macro: undefined identifier `tm_mday`");
// src/os/unix/ngx_time.h:24:9
pub const ngx_tm_mon = @compileError("unable to translate macro: undefined identifier `tm_mon`");
// src/os/unix/ngx_time.h:25:9
pub const ngx_tm_year = @compileError("unable to translate macro: undefined identifier `tm_year`");
// src/os/unix/ngx_time.h:26:9
pub const ngx_tm_wday = @compileError("unable to translate macro: undefined identifier `tm_wday`");
// src/os/unix/ngx_time.h:27:9
pub const ngx_tm_isdst = @compileError("unable to translate macro: undefined identifier `tm_isdst`");
// src/os/unix/ngx_time.h:28:9
pub const ngx_tm_sec_t = c_int;
pub const ngx_tm_min_t = c_int;
pub const ngx_tm_hour_t = c_int;
pub const ngx_tm_mday_t = c_int;
pub const ngx_tm_mon_t = c_int;
pub const ngx_tm_year_t = c_int;
pub const ngx_tm_wday_t = c_int;
pub const ngx_tm_gmtoff = @compileError("unable to translate macro: undefined identifier `tm_gmtoff`");
// src/os/unix/ngx_time.h:40:9
pub const ngx_tm_zone = @compileError("unable to translate macro: undefined identifier `tm_zone`");
// src/os/unix/ngx_time.h:41:9
pub inline fn ngx_timezone(isdst: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(-(if (isdst) timezone + @as(c_int, 3600) else timezone), @as(c_int, 60))) {
    _ = &isdst;
    return @import("std").zig.c_translation.MacroArithmetic.div(-(if (isdst) timezone + @as(c_int, 3600) else timezone), @as(c_int, 60));
}
pub const ngx_gettimeofday = @compileError("unable to translate C expr: unexpected token ';'");
// src/os/unix/ngx_time.h:61:9
pub inline fn ngx_msleep(ms: anytype) anyopaque {
    _ = &ms;
    return @import("std").zig.c_translation.cast(anyopaque, usleep(ms * @as(c_int, 1000)));
}
pub inline fn ngx_sleep(s: anytype) anyopaque {
    _ = &s;
    return @import("std").zig.c_translation.cast(anyopaque, sleep(s));
}
pub const _NGX_SOCKET_H_INCLUDED_ = "";
pub const NGX_WRITE_SHUTDOWN = SHUT_WR;
pub const NGX_READ_SHUTDOWN = SHUT_RD;
pub const NGX_RDWR_SHUTDOWN = SHUT_RDWR;
pub const ngx_socket = socket;
pub const ngx_socket_n = "socket()";
pub const ngx_nonblocking_n = "ioctl(FIONBIO)";
pub const ngx_blocking_n = "ioctl(!FIONBIO)";
pub inline fn ngx_socket_nread(s: anytype, n: anytype) @TypeOf(ioctl(s, FIONREAD, n)) {
    _ = &s;
    _ = &n;
    return ioctl(s, FIONREAD, n);
}
pub const ngx_socket_nread_n = "ioctl(FIONREAD)";
pub const ngx_tcp_nopush_n = "setsockopt(TCP_CORK)";
pub const ngx_tcp_push_n = "setsockopt(!TCP_CORK)";
pub const ngx_shutdown_socket = shutdown;
pub const ngx_shutdown_socket_n = "shutdown()";
pub const ngx_close_socket = close;
pub const ngx_close_socket_n = "close() socket";
pub const _NGX_STRING_H_INCLUDED_ = "";
pub const ngx_string = @compileError("unable to translate C expr: unexpected token '{'");
// src/core/ngx_string.h:40:9
pub const ngx_null_string = @compileError("unable to translate C expr: unexpected token '{'");
// src/core/ngx_string.h:41:9
pub const ngx_str_set = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_string.h:42:9
pub const ngx_str_null = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_string.h:44:9
pub inline fn ngx_tolower(c: anytype) u_char {
    _ = &c;
    return @import("std").zig.c_translation.cast(u_char, if ((c >= 'A') and (c <= 'Z')) c | @as(c_int, 0x20) else c);
}
pub inline fn ngx_toupper(c: anytype) u_char {
    _ = &c;
    return @import("std").zig.c_translation.cast(u_char, if ((c >= 'a') and (c <= 'z')) c & ~@as(c_int, 0x20) else c);
}
pub const ngx_strncmp = @compileError("unable to translate C expr: unexpected token 'const'");
// src/core/ngx_string.h:53:9
pub const ngx_strcmp = @compileError("unable to translate C expr: unexpected token 'const'");
// src/core/ngx_string.h:57:9
pub const ngx_strstr = @compileError("unable to translate C expr: unexpected token 'const'");
// src/core/ngx_string.h:60:9
pub const ngx_strlen = @compileError("unable to translate C expr: unexpected token 'const'");
// src/core/ngx_string.h:61:9
pub const ngx_strchr = @compileError("unable to translate C expr: unexpected token 'const'");
// src/core/ngx_string.h:65:9
pub inline fn ngx_memzero(buf: anytype, n: anytype) anyopaque {
    _ = &buf;
    _ = &n;
    return @import("std").zig.c_translation.cast(anyopaque, memset(buf, @as(c_int, 0), n));
}
pub inline fn ngx_memset(buf: anytype, c: anytype, n: anytype) anyopaque {
    _ = &buf;
    _ = &c;
    _ = &n;
    return @import("std").zig.c_translation.cast(anyopaque, memset(buf, c, n));
}
pub inline fn ngx_memcpy(dst: anytype, src: anytype, n: anytype) anyopaque {
    _ = &dst;
    _ = &src;
    _ = &n;
    return @import("std").zig.c_translation.cast(anyopaque, memcpy(dst, src, n));
}
pub inline fn ngx_cpymem(dst: anytype, src: anytype, n: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]u_char, memcpy(dst, src, n)) + n) {
    _ = &dst;
    _ = &src;
    _ = &n;
    return @import("std").zig.c_translation.cast([*c]u_char, memcpy(dst, src, n)) + n;
}
pub const ngx_copy = ngx_cpymem;
pub inline fn ngx_memmove(dst: anytype, src: anytype, n: anytype) anyopaque {
    _ = &dst;
    _ = &src;
    _ = &n;
    return @import("std").zig.c_translation.cast(anyopaque, memmove(dst, src, n));
}
pub inline fn ngx_movemem(dst: anytype, src: anytype, n: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]u_char, memmove(dst, src, n)) + n) {
    _ = &dst;
    _ = &src;
    _ = &n;
    return @import("std").zig.c_translation.cast([*c]u_char, memmove(dst, src, n)) + n;
}
pub inline fn ngx_memcmp(s1: anytype, s2: anytype, n: anytype) @TypeOf(memcmp(s1, s2, n)) {
    _ = &s1;
    _ = &s2;
    _ = &n;
    return memcmp(s1, s2, n);
}
pub inline fn ngx_vsnprintf(buf: anytype, max: anytype, fmt: anytype, args: anytype) @TypeOf(ngx_vslprintf(buf, buf + max, fmt, args)) {
    _ = &buf;
    _ = &max;
    _ = &fmt;
    _ = &args;
    return ngx_vslprintf(buf, buf + max, fmt, args);
}
pub inline fn ngx_base64_encoded_length(len: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(len + @as(c_int, 2), @as(c_int, 3)) * @as(c_int, 4)) {
    _ = &len;
    return @import("std").zig.c_translation.MacroArithmetic.div(len + @as(c_int, 2), @as(c_int, 3)) * @as(c_int, 4);
}
pub inline fn ngx_base64_decoded_length(len: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(len + @as(c_int, 3), @as(c_int, 4)) * @as(c_int, 3)) {
    _ = &len;
    return @import("std").zig.c_translation.MacroArithmetic.div(len + @as(c_int, 3), @as(c_int, 4)) * @as(c_int, 3);
}
pub const NGX_ESCAPE_URI = @as(c_int, 0);
pub const NGX_ESCAPE_ARGS = @as(c_int, 1);
pub const NGX_ESCAPE_URI_COMPONENT = @as(c_int, 2);
pub const NGX_ESCAPE_HTML = @as(c_int, 3);
pub const NGX_ESCAPE_REFRESH = @as(c_int, 4);
pub const NGX_ESCAPE_MEMCACHED = @as(c_int, 5);
pub const NGX_ESCAPE_MAIL_AUTH = @as(c_int, 6);
pub const NGX_UNESCAPE_URI = @as(c_int, 1);
pub const NGX_UNESCAPE_REDIRECT = @as(c_int, 2);
pub const ngx_qsort = qsort;
pub const ngx_value_helper = @compileError("unable to translate C expr: unexpected token '#'");
// src/core/ngx_string.h:234:9
pub inline fn ngx_value(n: anytype) @TypeOf(ngx_value_helper(n)) {
    _ = &n;
    return ngx_value_helper(n);
}
pub const _NGX_FILES_H_INCLUDED_ = "";
pub const NGX_INVALID_FILE = -@as(c_int, 1);
pub const NGX_FILE_ERROR = -@as(c_int, 1);
pub const ngx_open_file = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:65:9
pub const ngx_open_file_n = "open()";
pub const NGX_FILE_RDONLY = O_RDONLY;
pub const NGX_FILE_WRONLY = O_WRONLY;
pub const NGX_FILE_RDWR = O_RDWR;
pub const NGX_FILE_CREATE_OR_OPEN = O_CREAT;
pub const NGX_FILE_OPEN = @as(c_int, 0);
pub const NGX_FILE_TRUNCATE = O_CREAT | O_TRUNC;
pub const NGX_FILE_APPEND = O_WRONLY | O_APPEND;
pub const NGX_FILE_NONBLOCK = O_NONBLOCK;
pub const NGX_FILE_NOFOLLOW = O_NOFOLLOW;
pub const NGX_FILE_DIRECTORY = O_DIRECTORY;
pub const NGX_FILE_SEARCH = (O_PATH | O_RDONLY) | NGX_FILE_DIRECTORY;
pub const NGX_FILE_DEFAULT_ACCESS = @as(c_int, 0o644);
pub const NGX_FILE_OWNER_ACCESS = @as(c_int, 0o600);
pub const ngx_close_file = close;
pub const ngx_close_file_n = "close()";
pub const ngx_delete_file = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:113:9
pub const ngx_delete_file_n = "unlink()";
pub const ngx_open_tempfile_n = "open()";
pub const ngx_read_file_n = "pread()";
pub const ngx_read_fd = read;
pub const ngx_read_fd_n = "read()";
pub const ngx_write_fd_n = "write()";
pub const ngx_write_console = ngx_write_fd;
pub const ngx_linefeed = @compileError("TODO postfix inc/dec expr");
// src/os/unix/ngx_files.h:156:9
pub const NGX_LINEFEED_SIZE = @as(c_int, 1);
pub const NGX_LINEFEED = "\x0a";
pub const ngx_rename_file = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:161:9
pub const ngx_rename_file_n = "rename()";
pub const ngx_change_file_access = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:165:9
pub const ngx_change_file_access_n = "chmod()";
pub const ngx_set_file_time_n = "utimes()";
pub const ngx_file_info = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:173:9
pub const ngx_file_info_n = "stat()";
pub inline fn ngx_fd_info(fd: anytype, sb: anytype) @TypeOf(fstat(fd, sb)) {
    _ = &fd;
    _ = &sb;
    return fstat(fd, sb);
}
pub const ngx_fd_info_n = "fstat()";
pub const ngx_link_info = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:179:9
pub const ngx_link_info_n = "lstat()";
pub inline fn ngx_is_dir(sb: anytype) @TypeOf(S_ISDIR(sb.*.st_mode)) {
    _ = &sb;
    return S_ISDIR(sb.*.st_mode);
}
pub inline fn ngx_is_file(sb: anytype) @TypeOf(S_ISREG(sb.*.st_mode)) {
    _ = &sb;
    return S_ISREG(sb.*.st_mode);
}
pub inline fn ngx_is_link(sb: anytype) @TypeOf(S_ISLNK(sb.*.st_mode)) {
    _ = &sb;
    return S_ISLNK(sb.*.st_mode);
}
pub inline fn ngx_is_exec(sb: anytype) @TypeOf((sb.*.st_mode & S_IXUSR) == S_IXUSR) {
    _ = &sb;
    return (sb.*.st_mode & S_IXUSR) == S_IXUSR;
}
pub inline fn ngx_file_access(sb: anytype) @TypeOf(sb.*.st_mode & @as(c_int, 0o777)) {
    _ = &sb;
    return sb.*.st_mode & @as(c_int, 0o777);
}
pub inline fn ngx_file_size(sb: anytype) @TypeOf(sb.*.st_size) {
    _ = &sb;
    return sb.*.st_size;
}
pub inline fn ngx_file_fs_size(sb: anytype) @TypeOf(if (((sb.*.st_blocks * @as(c_int, 512)) > sb.*.st_size) and ((sb.*.st_blocks * @as(c_int, 512)) < (sb.*.st_size + (@as(c_int, 8) * sb.*.st_blksize)))) sb.*.st_blocks * @as(c_int, 512) else sb.*.st_size) {
    _ = &sb;
    return if (((sb.*.st_blocks * @as(c_int, 512)) > sb.*.st_size) and ((sb.*.st_blocks * @as(c_int, 512)) < (sb.*.st_size + (@as(c_int, 8) * sb.*.st_blksize)))) sb.*.st_blocks * @as(c_int, 512) else sb.*.st_size;
}
pub inline fn ngx_file_mtime(sb: anytype) @TypeOf(sb.*.st_mtime) {
    _ = &sb;
    return sb.*.st_mtime;
}
pub inline fn ngx_file_uniq(sb: anytype) @TypeOf(sb.*.st_ino) {
    _ = &sb;
    return sb.*.st_ino;
}
pub inline fn ngx_realpath(p: anytype, r: anytype) [*c]u_char {
    _ = &p;
    _ = &r;
    return @import("std").zig.c_translation.cast([*c]u_char, realpath(@import("std").zig.c_translation.cast([*c]u8, p), @import("std").zig.c_translation.cast([*c]u8, r)));
}
pub const ngx_realpath_n = "realpath()";
pub inline fn ngx_getcwd(buf: anytype, size: anytype) @TypeOf(getcwd(@import("std").zig.c_translation.cast([*c]u8, buf), size) != NULL) {
    _ = &buf;
    _ = &size;
    return getcwd(@import("std").zig.c_translation.cast([*c]u8, buf), size) != NULL;
}
pub const ngx_getcwd_n = "getcwd()";
pub inline fn ngx_path_separator(c: anytype) @TypeOf(c == '/') {
    _ = &c;
    return c == '/';
}
pub const NGX_HAVE_MAX_PATH = @as(c_int, 1);
pub const NGX_MAX_PATH = PATH_MAX;
pub const ngx_open_dir_n = "opendir()";
pub inline fn ngx_close_dir(d: anytype) @TypeOf(closedir(d.*.dir)) {
    _ = &d;
    return closedir(d.*.dir);
}
pub const ngx_close_dir_n = "closedir()";
pub const ngx_read_dir_n = "readdir()";
pub const ngx_create_dir = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:231:9
pub const ngx_create_dir_n = "mkdir()";
pub const ngx_delete_dir = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:235:9
pub const ngx_delete_dir_n = "rmdir()";
pub inline fn ngx_dir_access(a: anytype) @TypeOf(a | ((a & @as(c_int, 0o444)) >> @as(c_int, 2))) {
    _ = &a;
    return a | ((a & @as(c_int, 0o444)) >> @as(c_int, 2));
}
pub inline fn ngx_de_name(dir: anytype) [*c]u_char {
    _ = &dir;
    return @import("std").zig.c_translation.cast([*c]u_char, dir.*.de.*.d_name);
}
pub inline fn ngx_de_namelen(dir: anytype) @TypeOf(ngx_strlen(dir.*.de.*.d_name)) {
    _ = &dir;
    return ngx_strlen(dir.*.de.*.d_name);
}
pub const ngx_de_info_n = "stat()";
pub const ngx_de_link_info = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:257:9
pub const ngx_de_link_info_n = "lstat()";
pub inline fn ngx_de_is_dir(dir: anytype) @TypeOf(if (dir.*.type) dir.*.type == DT_DIR else S_ISDIR(dir.*.info.st_mode)) {
    _ = &dir;
    return if (dir.*.type) dir.*.type == DT_DIR else S_ISDIR(dir.*.info.st_mode);
}
pub inline fn ngx_de_is_file(dir: anytype) @TypeOf(if (dir.*.type) dir.*.type == DT_REG else S_ISREG(dir.*.info.st_mode)) {
    _ = &dir;
    return if (dir.*.type) dir.*.type == DT_REG else S_ISREG(dir.*.info.st_mode);
}
pub inline fn ngx_de_is_link(dir: anytype) @TypeOf(if (dir.*.type) dir.*.type == DT_LNK else S_ISLNK(dir.*.info.st_mode)) {
    _ = &dir;
    return if (dir.*.type) dir.*.type == DT_LNK else S_ISLNK(dir.*.info.st_mode);
}
pub inline fn ngx_de_access(dir: anytype) @TypeOf(dir.*.info.st_mode & @as(c_int, 0o777)) {
    _ = &dir;
    return dir.*.info.st_mode & @as(c_int, 0o777);
}
pub inline fn ngx_de_size(dir: anytype) @TypeOf(dir.*.info.st_size) {
    _ = &dir;
    return dir.*.info.st_size;
}
pub inline fn ngx_de_fs_size(dir: anytype) @TypeOf(ngx_max(dir.*.info.st_size, dir.*.info.st_blocks * @as(c_int, 512))) {
    _ = &dir;
    return ngx_max(dir.*.info.st_size, dir.*.info.st_blocks * @as(c_int, 512));
}
pub inline fn ngx_de_mtime(dir: anytype) @TypeOf(dir.*.info.st_mtime) {
    _ = &dir;
    return dir.*.info.st_mtime;
}
pub const ngx_open_glob_n = "glob()";
pub const ngx_trylock_fd_n = "fcntl(F_SETLK, F_WRLCK)";
pub const ngx_lock_fd_n = "fcntl(F_SETLKW, F_WRLCK)";
pub const ngx_unlock_fd_n = "fcntl(F_SETLK, F_UNLCK)";
pub const NGX_HAVE_READ_AHEAD = @as(c_int, 1);
pub const ngx_read_ahead_n = "posix_fadvise(POSIX_FADV_SEQUENTIAL)";
pub const ngx_directio_on_n = "fcntl(O_DIRECT)";
pub const ngx_directio_off_n = "fcntl(!O_DIRECT)";
pub const ngx_openat_file = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:357:9
pub const ngx_openat_file_n = "openat()";
pub const ngx_file_at_info = @compileError("unable to translate C expr: unexpected token 'const'");
// src/os/unix/ngx_files.h:362:9
pub const ngx_file_at_info_n = "fstatat()";
pub const NGX_AT_FDCWD = @import("std").zig.c_translation.cast(ngx_fd_t, AT_FDCWD);
pub const ngx_stdout = STDOUT_FILENO;
pub const ngx_stderr = STDERR_FILENO;
pub inline fn ngx_set_stderr(fd: anytype) @TypeOf(dup2(fd, STDERR_FILENO)) {
    _ = &fd;
    return dup2(fd, STDERR_FILENO);
}
pub const ngx_set_stderr_n = "dup2(STDERR_FILENO)";
pub const _NGX_SHMEM_H_INCLUDED_ = "";
pub const _NGX_PROCESS_H_INCLUDED_ = "";
pub const _NGX_SETAFFINITY_H_INCLUDED_ = "";
pub const NGX_HAVE_CPU_AFFINITY = @as(c_int, 1);
pub const _NGX_SETPROCTITLE_H_INCLUDED_ = "";
pub const NGX_SETPROCTITLE_USES_ENV = @as(c_int, 1);
pub const NGX_SETPROCTITLE_PAD = '\x00';
pub const NGX_INVALID_PID = -@as(c_int, 1);
pub const NGX_MAX_PROCESSES = @as(c_int, 1024);
pub const NGX_PROCESS_NORESPAWN = -@as(c_int, 1);
pub const NGX_PROCESS_JUST_SPAWN = -@as(c_int, 2);
pub const NGX_PROCESS_RESPAWN = -@as(c_int, 3);
pub const NGX_PROCESS_JUST_RESPAWN = -@as(c_int, 4);
pub const NGX_PROCESS_DETACHED = -@as(c_int, 5);
pub const ngx_getpid = getpid;
pub const ngx_getppid = getppid;
// src/os/unix/ngx_process.h:60:9: warning: macro 'ngx_log_pid' contains a runtime value, translated to function
pub inline fn ngx_log_pid() @TypeOf(ngx_pid) {
    return ngx_pid;
}
pub inline fn ngx_sched_yield() @TypeOf(sched_yield()) {
    return sched_yield();
}
pub const _NGX_USER_H_INCLUDED_ = "";
pub const _NGX_DLOPEN_H_INCLUDED_ = "";
pub inline fn ngx_dlopen(path: anytype) @TypeOf(dlopen(@import("std").zig.c_translation.cast([*c]u8, path), RTLD_NOW | RTLD_GLOBAL)) {
    _ = &path;
    return dlopen(@import("std").zig.c_translation.cast([*c]u8, path), RTLD_NOW | RTLD_GLOBAL);
}
pub const ngx_dlopen_n = "dlopen()";
pub inline fn ngx_dlsym(handle: anytype, symbol: anytype) @TypeOf(dlsym(handle, symbol)) {
    _ = &handle;
    _ = &symbol;
    return dlsym(handle, symbol);
}
pub const ngx_dlsym_n = "dlsym()";
pub inline fn ngx_dlclose(handle: anytype) @TypeOf(dlclose(handle)) {
    _ = &handle;
    return dlclose(handle);
}
pub const ngx_dlclose_n = "dlclose()";
pub const _NGX_PARSE_H_INCLUDED_ = "";
pub const _NGX_PARSE_TIME_H_INCLUDED_ = "";
pub inline fn ngx_http_parse_time(value: anytype, len: anytype) @TypeOf(ngx_parse_http_time(value, len)) {
    _ = &value;
    _ = &len;
    return ngx_parse_http_time(value, len);
}
pub const _NGX_LOG_H_INCLUDED_ = "";
pub const NGX_LOG_STDERR = @as(c_int, 0);
pub const NGX_LOG_EMERG = @as(c_int, 1);
pub const NGX_LOG_ALERT = @as(c_int, 2);
pub const NGX_LOG_CRIT = @as(c_int, 3);
pub const NGX_LOG_ERR = @as(c_int, 4);
pub const NGX_LOG_WARN = @as(c_int, 5);
pub const NGX_LOG_NOTICE = @as(c_int, 6);
pub const NGX_LOG_INFO = @as(c_int, 7);
pub const NGX_LOG_DEBUG = @as(c_int, 8);
pub const NGX_LOG_DEBUG_CORE = @as(c_int, 0x010);
pub const NGX_LOG_DEBUG_ALLOC = @as(c_int, 0x020);
pub const NGX_LOG_DEBUG_MUTEX = @as(c_int, 0x040);
pub const NGX_LOG_DEBUG_EVENT = @as(c_int, 0x080);
pub const NGX_LOG_DEBUG_HTTP = @as(c_int, 0x100);
pub const NGX_LOG_DEBUG_MAIL = @as(c_int, 0x200);
pub const NGX_LOG_DEBUG_STREAM = @as(c_int, 0x400);
pub const NGX_LOG_DEBUG_FIRST = NGX_LOG_DEBUG_CORE;
pub const NGX_LOG_DEBUG_LAST = NGX_LOG_DEBUG_STREAM;
pub const NGX_LOG_DEBUG_CONNECTION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const NGX_LOG_DEBUG_ALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x7ffffff0, .hex);
pub const NGX_MAX_ERROR_STR = @as(c_int, 2048);
pub const NGX_HAVE_VARIADIC_MACROS = @as(c_int, 1);
pub const ngx_log_error = @compileError("unable to translate C expr: expected ')' instead got '...'");
// src/core/ngx_log.h:85:9
pub const ngx_log_debug = @compileError("unable to translate C expr: expected ')' instead got '...'");
// src/core/ngx_log.h:91:9
pub const ngx_log_debug0 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:215:9
pub const ngx_log_debug1 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:216:9
pub const ngx_log_debug2 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:217:9
pub const ngx_log_debug3 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:218:9
pub const ngx_log_debug4 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:219:9
pub const ngx_log_debug5 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:220:9
pub const ngx_log_debug6 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:221:9
pub const ngx_log_debug7 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:222:9
pub const ngx_log_debug8 = @compileError("unable to translate C expr: unexpected token ''");
// src/core/ngx_log.h:224:9
pub const _NGX_ALLOC_H_INCLUDED_ = "";
pub const ngx_free = free;
pub const _NGX_PALLOC_H_INCLUDED_ = "";
// src/core/ngx_palloc.h:20:9: warning: macro 'NGX_MAX_ALLOC_FROM_POOL' contains a runtime value, translated to function
pub inline fn NGX_MAX_ALLOC_FROM_POOL() @TypeOf(ngx_pagesize - @as(c_int, 1)) {
    return ngx_pagesize - @as(c_int, 1);
}
pub const NGX_DEFAULT_POOL_SIZE = @as(c_int, 16) * @as(c_int, 1024);
pub const NGX_POOL_ALIGNMENT = @as(c_int, 16);
pub const NGX_MIN_POOL_SIZE = ngx_align(@import("std").zig.c_translation.sizeof(ngx_pool_t) + (@as(c_int, 2) * @import("std").zig.c_translation.sizeof(ngx_pool_large_t)), NGX_POOL_ALIGNMENT);
pub const _NGX_BUF_H_INCLUDED_ = "";
pub const NGX_CHAIN_ERROR = @import("std").zig.c_translation.cast([*c]ngx_chain_t, NGX_ERROR);
pub inline fn ngx_buf_in_memory(b: anytype) @TypeOf(((b.*.temporary != 0) or (b.*.memory != 0)) or (b.*.mmap != 0)) {
    _ = &b;
    return ((b.*.temporary != 0) or (b.*.memory != 0)) or (b.*.mmap != 0);
}
pub inline fn ngx_buf_in_memory_only(b: anytype) @TypeOf((ngx_buf_in_memory(b) != 0) and !(b.*.in_file != 0)) {
    _ = &b;
    return (ngx_buf_in_memory(b) != 0) and !(b.*.in_file != 0);
}
pub inline fn ngx_buf_special(b: anytype) @TypeOf(((((b.*.flush != 0) or (b.*.last_buf != 0)) or (b.*.sync != 0)) and !(ngx_buf_in_memory(b) != 0)) and !(b.*.in_file != 0)) {
    _ = &b;
    return ((((b.*.flush != 0) or (b.*.last_buf != 0)) or (b.*.sync != 0)) and !(ngx_buf_in_memory(b) != 0)) and !(b.*.in_file != 0);
}
pub inline fn ngx_buf_sync_only(b: anytype) @TypeOf(((((b.*.sync != 0) and !(ngx_buf_in_memory(b) != 0)) and !(b.*.in_file != 0)) and !(b.*.flush != 0)) and !(b.*.last_buf != 0)) {
    _ = &b;
    return ((((b.*.sync != 0) and !(ngx_buf_in_memory(b) != 0)) and !(b.*.in_file != 0)) and !(b.*.flush != 0)) and !(b.*.last_buf != 0);
}
pub inline fn ngx_buf_size(b: anytype) @TypeOf(if (ngx_buf_in_memory(b)) @import("std").zig.c_translation.cast(off_t, b.*.last - b.*.pos) else b.*.file_last - b.*.file_pos) {
    _ = &b;
    return if (ngx_buf_in_memory(b)) @import("std").zig.c_translation.cast(off_t, b.*.last - b.*.pos) else b.*.file_last - b.*.file_pos;
}
pub inline fn ngx_alloc_buf(pool: anytype) @TypeOf(ngx_palloc(pool, @import("std").zig.c_translation.sizeof(ngx_buf_t))) {
    _ = &pool;
    return ngx_palloc(pool, @import("std").zig.c_translation.sizeof(ngx_buf_t));
}
pub inline fn ngx_calloc_buf(pool: anytype) @TypeOf(ngx_pcalloc(pool, @import("std").zig.c_translation.sizeof(ngx_buf_t))) {
    _ = &pool;
    return ngx_pcalloc(pool, @import("std").zig.c_translation.sizeof(ngx_buf_t));
}
pub const ngx_free_chain = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_buf.h:148:9
pub const _NGX_QUEUE_H_INCLUDED_ = "";
pub const ngx_queue_init = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_queue.h:24:9
pub inline fn ngx_queue_empty(h: anytype) @TypeOf(h == h.*.prev) {
    _ = &h;
    return h == h.*.prev;
}
pub const ngx_queue_insert_head = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_queue.h:33:9
pub const ngx_queue_insert_after = ngx_queue_insert_head;
pub const ngx_queue_insert_tail = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_queue.h:43:9
pub const ngx_queue_insert_before = ngx_queue_insert_tail;
pub inline fn ngx_queue_head(h: anytype) @TypeOf(h.*.next) {
    _ = &h;
    return h.*.next;
}
pub inline fn ngx_queue_last(h: anytype) @TypeOf(h.*.prev) {
    _ = &h;
    return h.*.prev;
}
pub inline fn ngx_queue_sentinel(h: anytype) @TypeOf(h) {
    _ = &h;
    return h;
}
pub inline fn ngx_queue_next(q: anytype) @TypeOf(q.*.next) {
    _ = &q;
    return q.*.next;
}
pub inline fn ngx_queue_prev(q: anytype) @TypeOf(q.*.prev) {
    _ = &q;
    return q.*.prev;
}
pub const ngx_queue_remove = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_queue.h:83:9
pub const ngx_queue_split = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_queue.h:90:9
pub const ngx_queue_add = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_queue.h:99:9
pub const ngx_queue_data = @compileError("unable to translate C expr: unexpected token ')'");
// src/core/ngx_queue.h:106:9
pub const _NGX_ARRAY_H_INCLUDED_ = "";
pub const _NGX_LIST_H_INCLUDED_ = "";
pub const _NGX_HASH_H_INCLUDED_ = "";
pub const NGX_HASH_SMALL = @as(c_int, 1);
pub const NGX_HASH_LARGE = @as(c_int, 2);
pub const NGX_HASH_LARGE_ASIZE = @as(c_int, 16384);
pub const NGX_HASH_LARGE_HSIZE = @as(c_int, 10007);
pub const NGX_HASH_WILDCARD_KEY = @as(c_int, 1);
pub const NGX_HASH_READONLY_KEY = @as(c_int, 2);
pub inline fn ngx_hash(key: anytype, c: anytype) @TypeOf((@import("std").zig.c_translation.cast(ngx_uint_t, key) * @as(c_int, 31)) + c) {
    _ = &key;
    _ = &c;
    return (@import("std").zig.c_translation.cast(ngx_uint_t, key) * @as(c_int, 31)) + c;
}
pub const _NGX_FILE_H_INCLUDED_ = "";
pub const NGX_MAX_PATH_LEVEL = @as(c_int, 3);
pub const _NGX_CRC_H_INCLUDED_ = "";
pub const _NGX_CRC32_H_INCLUDED_ = "";
pub const ngx_crc32_init = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_crc32.h:53:9
pub const ngx_crc32_final = @compileError("unable to translate C expr: unexpected token '^='");
// src/core/ngx_crc32.h:72:9
pub const _NGX_MURMURHASH_H_INCLUDED_ = "";
pub const _NGX_REGEX_H_INCLUDED_ = "";
pub const PCRE2_CODE_UNIT_WIDTH = @as(c_int, 8);
pub const PCRE2_H_IDEMPOTENT_GUARD = "";
pub const PCRE2_MAJOR = @as(c_int, 10);
pub const PCRE2_MINOR = @as(c_int, 44);
pub const PCRE2_PRERELEASE = "";
pub const PCRE2_DATE = (@as(c_int, 2024) - @as(c_int, 0o6)) - @as(c_int, 0o7);
pub const PCRE2_EXP_DECL = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/pcre2.h:66:13
pub const PCRE2_CALL_CONVENTION = "";
pub const _INTTYPES_H = @as(c_int, 1);
pub const ____gwchar_t_defined = @as(c_int, 1);
pub const __PRI64_PREFIX = "l";
pub const __PRIPTR_PREFIX = "l";
pub const PRId8 = "d";
pub const PRId16 = "d";
pub const PRId32 = "d";
pub const PRId64 = __PRI64_PREFIX ++ "d";
pub const PRIdLEAST8 = "d";
pub const PRIdLEAST16 = "d";
pub const PRIdLEAST32 = "d";
pub const PRIdLEAST64 = __PRI64_PREFIX ++ "d";
pub const PRIdFAST8 = "d";
pub const PRIdFAST16 = __PRIPTR_PREFIX ++ "d";
pub const PRIdFAST32 = __PRIPTR_PREFIX ++ "d";
pub const PRIdFAST64 = __PRI64_PREFIX ++ "d";
pub const PRIi8 = "i";
pub const PRIi16 = "i";
pub const PRIi32 = "i";
pub const PRIi64 = __PRI64_PREFIX ++ "i";
pub const PRIiLEAST8 = "i";
pub const PRIiLEAST16 = "i";
pub const PRIiLEAST32 = "i";
pub const PRIiLEAST64 = __PRI64_PREFIX ++ "i";
pub const PRIiFAST8 = "i";
pub const PRIiFAST16 = __PRIPTR_PREFIX ++ "i";
pub const PRIiFAST32 = __PRIPTR_PREFIX ++ "i";
pub const PRIiFAST64 = __PRI64_PREFIX ++ "i";
pub const PRIo8 = "o";
pub const PRIo16 = "o";
pub const PRIo32 = "o";
pub const PRIo64 = __PRI64_PREFIX ++ "o";
pub const PRIoLEAST8 = "o";
pub const PRIoLEAST16 = "o";
pub const PRIoLEAST32 = "o";
pub const PRIoLEAST64 = __PRI64_PREFIX ++ "o";
pub const PRIoFAST8 = "o";
pub const PRIoFAST16 = __PRIPTR_PREFIX ++ "o";
pub const PRIoFAST32 = __PRIPTR_PREFIX ++ "o";
pub const PRIoFAST64 = __PRI64_PREFIX ++ "o";
pub const PRIu8 = "u";
pub const PRIu16 = "u";
pub const PRIu32 = "u";
pub const PRIu64 = __PRI64_PREFIX ++ "u";
pub const PRIuLEAST8 = "u";
pub const PRIuLEAST16 = "u";
pub const PRIuLEAST32 = "u";
pub const PRIuLEAST64 = __PRI64_PREFIX ++ "u";
pub const PRIuFAST8 = "u";
pub const PRIuFAST16 = __PRIPTR_PREFIX ++ "u";
pub const PRIuFAST32 = __PRIPTR_PREFIX ++ "u";
pub const PRIuFAST64 = __PRI64_PREFIX ++ "u";
pub const PRIx8 = "x";
pub const PRIx16 = "x";
pub const PRIx32 = "x";
pub const PRIx64 = __PRI64_PREFIX ++ "x";
pub const PRIxLEAST8 = "x";
pub const PRIxLEAST16 = "x";
pub const PRIxLEAST32 = "x";
pub const PRIxLEAST64 = __PRI64_PREFIX ++ "x";
pub const PRIxFAST8 = "x";
pub const PRIxFAST16 = __PRIPTR_PREFIX ++ "x";
pub const PRIxFAST32 = __PRIPTR_PREFIX ++ "x";
pub const PRIxFAST64 = __PRI64_PREFIX ++ "x";
pub const PRIX8 = "X";
pub const PRIX16 = "X";
pub const PRIX32 = "X";
pub const PRIX64 = __PRI64_PREFIX ++ "X";
pub const PRIXLEAST8 = "X";
pub const PRIXLEAST16 = "X";
pub const PRIXLEAST32 = "X";
pub const PRIXLEAST64 = __PRI64_PREFIX ++ "X";
pub const PRIXFAST8 = "X";
pub const PRIXFAST16 = __PRIPTR_PREFIX ++ "X";
pub const PRIXFAST32 = __PRIPTR_PREFIX ++ "X";
pub const PRIXFAST64 = __PRI64_PREFIX ++ "X";
pub const PRIdMAX = __PRI64_PREFIX ++ "d";
pub const PRIiMAX = __PRI64_PREFIX ++ "i";
pub const PRIoMAX = __PRI64_PREFIX ++ "o";
pub const PRIuMAX = __PRI64_PREFIX ++ "u";
pub const PRIxMAX = __PRI64_PREFIX ++ "x";
pub const PRIXMAX = __PRI64_PREFIX ++ "X";
pub const PRIdPTR = __PRIPTR_PREFIX ++ "d";
pub const PRIiPTR = __PRIPTR_PREFIX ++ "i";
pub const PRIoPTR = __PRIPTR_PREFIX ++ "o";
pub const PRIuPTR = __PRIPTR_PREFIX ++ "u";
pub const PRIxPTR = __PRIPTR_PREFIX ++ "x";
pub const PRIXPTR = __PRIPTR_PREFIX ++ "X";
pub const PRIb8 = "b";
pub const PRIb16 = "b";
pub const PRIb32 = "b";
pub const PRIb64 = __PRI64_PREFIX ++ "b";
pub const PRIbLEAST8 = "b";
pub const PRIbLEAST16 = "b";
pub const PRIbLEAST32 = "b";
pub const PRIbLEAST64 = __PRI64_PREFIX ++ "b";
pub const PRIbFAST8 = "b";
pub const PRIbFAST16 = __PRIPTR_PREFIX ++ "b";
pub const PRIbFAST32 = __PRIPTR_PREFIX ++ "b";
pub const PRIbFAST64 = __PRI64_PREFIX ++ "b";
pub const PRIbMAX = __PRI64_PREFIX ++ "b";
pub const PRIbPTR = __PRIPTR_PREFIX ++ "b";
pub const PRIB8 = "B";
pub const PRIB16 = "B";
pub const PRIB32 = "B";
pub const PRIB64 = __PRI64_PREFIX ++ "B";
pub const PRIBLEAST8 = "B";
pub const PRIBLEAST16 = "B";
pub const PRIBLEAST32 = "B";
pub const PRIBLEAST64 = __PRI64_PREFIX ++ "B";
pub const PRIBFAST8 = "B";
pub const PRIBFAST16 = __PRIPTR_PREFIX ++ "B";
pub const PRIBFAST32 = __PRIPTR_PREFIX ++ "B";
pub const PRIBFAST64 = __PRI64_PREFIX ++ "B";
pub const PRIBMAX = __PRI64_PREFIX ++ "B";
pub const PRIBPTR = __PRIPTR_PREFIX ++ "B";
pub const SCNd8 = "hhd";
pub const SCNd16 = "hd";
pub const SCNd32 = "d";
pub const SCNd64 = __PRI64_PREFIX ++ "d";
pub const SCNdLEAST8 = "hhd";
pub const SCNdLEAST16 = "hd";
pub const SCNdLEAST32 = "d";
pub const SCNdLEAST64 = __PRI64_PREFIX ++ "d";
pub const SCNdFAST8 = "hhd";
pub const SCNdFAST16 = __PRIPTR_PREFIX ++ "d";
pub const SCNdFAST32 = __PRIPTR_PREFIX ++ "d";
pub const SCNdFAST64 = __PRI64_PREFIX ++ "d";
pub const SCNi8 = "hhi";
pub const SCNi16 = "hi";
pub const SCNi32 = "i";
pub const SCNi64 = __PRI64_PREFIX ++ "i";
pub const SCNiLEAST8 = "hhi";
pub const SCNiLEAST16 = "hi";
pub const SCNiLEAST32 = "i";
pub const SCNiLEAST64 = __PRI64_PREFIX ++ "i";
pub const SCNiFAST8 = "hhi";
pub const SCNiFAST16 = __PRIPTR_PREFIX ++ "i";
pub const SCNiFAST32 = __PRIPTR_PREFIX ++ "i";
pub const SCNiFAST64 = __PRI64_PREFIX ++ "i";
pub const SCNu8 = "hhu";
pub const SCNu16 = "hu";
pub const SCNu32 = "u";
pub const SCNu64 = __PRI64_PREFIX ++ "u";
pub const SCNuLEAST8 = "hhu";
pub const SCNuLEAST16 = "hu";
pub const SCNuLEAST32 = "u";
pub const SCNuLEAST64 = __PRI64_PREFIX ++ "u";
pub const SCNuFAST8 = "hhu";
pub const SCNuFAST16 = __PRIPTR_PREFIX ++ "u";
pub const SCNuFAST32 = __PRIPTR_PREFIX ++ "u";
pub const SCNuFAST64 = __PRI64_PREFIX ++ "u";
pub const SCNo8 = "hho";
pub const SCNo16 = "ho";
pub const SCNo32 = "o";
pub const SCNo64 = __PRI64_PREFIX ++ "o";
pub const SCNoLEAST8 = "hho";
pub const SCNoLEAST16 = "ho";
pub const SCNoLEAST32 = "o";
pub const SCNoLEAST64 = __PRI64_PREFIX ++ "o";
pub const SCNoFAST8 = "hho";
pub const SCNoFAST16 = __PRIPTR_PREFIX ++ "o";
pub const SCNoFAST32 = __PRIPTR_PREFIX ++ "o";
pub const SCNoFAST64 = __PRI64_PREFIX ++ "o";
pub const SCNx8 = "hhx";
pub const SCNx16 = "hx";
pub const SCNx32 = "x";
pub const SCNx64 = __PRI64_PREFIX ++ "x";
pub const SCNxLEAST8 = "hhx";
pub const SCNxLEAST16 = "hx";
pub const SCNxLEAST32 = "x";
pub const SCNxLEAST64 = __PRI64_PREFIX ++ "x";
pub const SCNxFAST8 = "hhx";
pub const SCNxFAST16 = __PRIPTR_PREFIX ++ "x";
pub const SCNxFAST32 = __PRIPTR_PREFIX ++ "x";
pub const SCNxFAST64 = __PRI64_PREFIX ++ "x";
pub const SCNdMAX = __PRI64_PREFIX ++ "d";
pub const SCNiMAX = __PRI64_PREFIX ++ "i";
pub const SCNoMAX = __PRI64_PREFIX ++ "o";
pub const SCNuMAX = __PRI64_PREFIX ++ "u";
pub const SCNxMAX = __PRI64_PREFIX ++ "x";
pub const SCNdPTR = __PRIPTR_PREFIX ++ "d";
pub const SCNiPTR = __PRIPTR_PREFIX ++ "i";
pub const SCNoPTR = __PRIPTR_PREFIX ++ "o";
pub const SCNuPTR = __PRIPTR_PREFIX ++ "u";
pub const SCNxPTR = __PRIPTR_PREFIX ++ "x";
pub const SCNb8 = "hhb";
pub const SCNb16 = "hb";
pub const SCNb32 = "b";
pub const SCNb64 = __PRI64_PREFIX ++ "b";
pub const SCNbLEAST8 = "hhb";
pub const SCNbLEAST16 = "hb";
pub const SCNbLEAST32 = "b";
pub const SCNbLEAST64 = __PRI64_PREFIX ++ "b";
pub const SCNbFAST8 = "hhb";
pub const SCNbFAST16 = __PRIPTR_PREFIX ++ "b";
pub const SCNbFAST32 = __PRIPTR_PREFIX ++ "b";
pub const SCNbFAST64 = __PRI64_PREFIX ++ "b";
pub const SCNbMAX = __PRI64_PREFIX ++ "b";
pub const SCNbPTR = __PRIPTR_PREFIX ++ "b";
pub const PCRE2_ANCHORED = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x80000000, .hex);
pub const PCRE2_NO_UTF_CHECK = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x40000000, .hex);
pub const PCRE2_ENDANCHORED = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x20000000, .hex);
pub const PCRE2_ALLOW_EMPTY_CLASS = @as(c_uint, 0x00000001);
pub const PCRE2_ALT_BSUX = @as(c_uint, 0x00000002);
pub const PCRE2_AUTO_CALLOUT = @as(c_uint, 0x00000004);
pub const PCRE2_CASELESS = @as(c_uint, 0x00000008);
pub const PCRE2_DOLLAR_ENDONLY = @as(c_uint, 0x00000010);
pub const PCRE2_DOTALL = @as(c_uint, 0x00000020);
pub const PCRE2_DUPNAMES = @as(c_uint, 0x00000040);
pub const PCRE2_EXTENDED = @as(c_uint, 0x00000080);
pub const PCRE2_FIRSTLINE = @as(c_uint, 0x00000100);
pub const PCRE2_MATCH_UNSET_BACKREF = @as(c_uint, 0x00000200);
pub const PCRE2_MULTILINE = @as(c_uint, 0x00000400);
pub const PCRE2_NEVER_UCP = @as(c_uint, 0x00000800);
pub const PCRE2_NEVER_UTF = @as(c_uint, 0x00001000);
pub const PCRE2_NO_AUTO_CAPTURE = @as(c_uint, 0x00002000);
pub const PCRE2_NO_AUTO_POSSESS = @as(c_uint, 0x00004000);
pub const PCRE2_NO_DOTSTAR_ANCHOR = @as(c_uint, 0x00008000);
pub const PCRE2_NO_START_OPTIMIZE = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00010000, .hex);
pub const PCRE2_UCP = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00020000, .hex);
pub const PCRE2_UNGREEDY = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00040000, .hex);
pub const PCRE2_UTF = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00080000, .hex);
pub const PCRE2_NEVER_BACKSLASH_C = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00100000, .hex);
pub const PCRE2_ALT_CIRCUMFLEX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00200000, .hex);
pub const PCRE2_ALT_VERBNAMES = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00400000, .hex);
pub const PCRE2_USE_OFFSET_LIMIT = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00800000, .hex);
pub const PCRE2_EXTENDED_MORE = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x01000000, .hex);
pub const PCRE2_LITERAL = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x02000000, .hex);
pub const PCRE2_MATCH_INVALID_UTF = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x04000000, .hex);
pub const PCRE2_EXTRA_ALLOW_SURROGATE_ESCAPES = @as(c_uint, 0x00000001);
pub const PCRE2_EXTRA_BAD_ESCAPE_IS_LITERAL = @as(c_uint, 0x00000002);
pub const PCRE2_EXTRA_MATCH_WORD = @as(c_uint, 0x00000004);
pub const PCRE2_EXTRA_MATCH_LINE = @as(c_uint, 0x00000008);
pub const PCRE2_EXTRA_ESCAPED_CR_IS_LF = @as(c_uint, 0x00000010);
pub const PCRE2_EXTRA_ALT_BSUX = @as(c_uint, 0x00000020);
pub const PCRE2_EXTRA_ALLOW_LOOKAROUND_BSK = @as(c_uint, 0x00000040);
pub const PCRE2_EXTRA_CASELESS_RESTRICT = @as(c_uint, 0x00000080);
pub const PCRE2_EXTRA_ASCII_BSD = @as(c_uint, 0x00000100);
pub const PCRE2_EXTRA_ASCII_BSS = @as(c_uint, 0x00000200);
pub const PCRE2_EXTRA_ASCII_BSW = @as(c_uint, 0x00000400);
pub const PCRE2_EXTRA_ASCII_POSIX = @as(c_uint, 0x00000800);
pub const PCRE2_EXTRA_ASCII_DIGIT = @as(c_uint, 0x00001000);
pub const PCRE2_JIT_COMPLETE = @as(c_uint, 0x00000001);
pub const PCRE2_JIT_PARTIAL_SOFT = @as(c_uint, 0x00000002);
pub const PCRE2_JIT_PARTIAL_HARD = @as(c_uint, 0x00000004);
pub const PCRE2_JIT_INVALID_UTF = @as(c_uint, 0x00000100);
pub const PCRE2_NOTBOL = @as(c_uint, 0x00000001);
pub const PCRE2_NOTEOL = @as(c_uint, 0x00000002);
pub const PCRE2_NOTEMPTY = @as(c_uint, 0x00000004);
pub const PCRE2_NOTEMPTY_ATSTART = @as(c_uint, 0x00000008);
pub const PCRE2_PARTIAL_SOFT = @as(c_uint, 0x00000010);
pub const PCRE2_PARTIAL_HARD = @as(c_uint, 0x00000020);
pub const PCRE2_DFA_RESTART = @as(c_uint, 0x00000040);
pub const PCRE2_DFA_SHORTEST = @as(c_uint, 0x00000080);
pub const PCRE2_SUBSTITUTE_GLOBAL = @as(c_uint, 0x00000100);
pub const PCRE2_SUBSTITUTE_EXTENDED = @as(c_uint, 0x00000200);
pub const PCRE2_SUBSTITUTE_UNSET_EMPTY = @as(c_uint, 0x00000400);
pub const PCRE2_SUBSTITUTE_UNKNOWN_UNSET = @as(c_uint, 0x00000800);
pub const PCRE2_SUBSTITUTE_OVERFLOW_LENGTH = @as(c_uint, 0x00001000);
pub const PCRE2_NO_JIT = @as(c_uint, 0x00002000);
pub const PCRE2_COPY_MATCHED_SUBJECT = @as(c_uint, 0x00004000);
pub const PCRE2_SUBSTITUTE_LITERAL = @as(c_uint, 0x00008000);
pub const PCRE2_SUBSTITUTE_MATCHED = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00010000, .hex);
pub const PCRE2_SUBSTITUTE_REPLACEMENT_ONLY = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00020000, .hex);
pub const PCRE2_DISABLE_RECURSELOOP_CHECK = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00040000, .hex);
pub const PCRE2_CONVERT_UTF = @as(c_uint, 0x00000001);
pub const PCRE2_CONVERT_NO_UTF_CHECK = @as(c_uint, 0x00000002);
pub const PCRE2_CONVERT_POSIX_BASIC = @as(c_uint, 0x00000004);
pub const PCRE2_CONVERT_POSIX_EXTENDED = @as(c_uint, 0x00000008);
pub const PCRE2_CONVERT_GLOB = @as(c_uint, 0x00000010);
pub const PCRE2_CONVERT_GLOB_NO_WILD_SEPARATOR = @as(c_uint, 0x00000030);
pub const PCRE2_CONVERT_GLOB_NO_STARSTAR = @as(c_uint, 0x00000050);
pub const PCRE2_NEWLINE_CR = @as(c_int, 1);
pub const PCRE2_NEWLINE_LF = @as(c_int, 2);
pub const PCRE2_NEWLINE_CRLF = @as(c_int, 3);
pub const PCRE2_NEWLINE_ANY = @as(c_int, 4);
pub const PCRE2_NEWLINE_ANYCRLF = @as(c_int, 5);
pub const PCRE2_NEWLINE_NUL = @as(c_int, 6);
pub const PCRE2_BSR_UNICODE = @as(c_int, 1);
pub const PCRE2_BSR_ANYCRLF = @as(c_int, 2);
pub const PCRE2_ERROR_END_BACKSLASH = @as(c_int, 101);
pub const PCRE2_ERROR_END_BACKSLASH_C = @as(c_int, 102);
pub const PCRE2_ERROR_UNKNOWN_ESCAPE = @as(c_int, 103);
pub const PCRE2_ERROR_QUANTIFIER_OUT_OF_ORDER = @as(c_int, 104);
pub const PCRE2_ERROR_QUANTIFIER_TOO_BIG = @as(c_int, 105);
pub const PCRE2_ERROR_MISSING_SQUARE_BRACKET = @as(c_int, 106);
pub const PCRE2_ERROR_ESCAPE_INVALID_IN_CLASS = @as(c_int, 107);
pub const PCRE2_ERROR_CLASS_RANGE_ORDER = @as(c_int, 108);
pub const PCRE2_ERROR_QUANTIFIER_INVALID = @as(c_int, 109);
pub const PCRE2_ERROR_INTERNAL_UNEXPECTED_REPEAT = @as(c_int, 110);
pub const PCRE2_ERROR_INVALID_AFTER_PARENS_QUERY = @as(c_int, 111);
pub const PCRE2_ERROR_POSIX_CLASS_NOT_IN_CLASS = @as(c_int, 112);
pub const PCRE2_ERROR_POSIX_NO_SUPPORT_COLLATING = @as(c_int, 113);
pub const PCRE2_ERROR_MISSING_CLOSING_PARENTHESIS = @as(c_int, 114);
pub const PCRE2_ERROR_BAD_SUBPATTERN_REFERENCE = @as(c_int, 115);
pub const PCRE2_ERROR_NULL_PATTERN = @as(c_int, 116);
pub const PCRE2_ERROR_BAD_OPTIONS = @as(c_int, 117);
pub const PCRE2_ERROR_MISSING_COMMENT_CLOSING = @as(c_int, 118);
pub const PCRE2_ERROR_PARENTHESES_NEST_TOO_DEEP = @as(c_int, 119);
pub const PCRE2_ERROR_PATTERN_TOO_LARGE = @as(c_int, 120);
pub const PCRE2_ERROR_HEAP_FAILED = @as(c_int, 121);
pub const PCRE2_ERROR_UNMATCHED_CLOSING_PARENTHESIS = @as(c_int, 122);
pub const PCRE2_ERROR_INTERNAL_CODE_OVERFLOW = @as(c_int, 123);
pub const PCRE2_ERROR_MISSING_CONDITION_CLOSING = @as(c_int, 124);
pub const PCRE2_ERROR_LOOKBEHIND_NOT_FIXED_LENGTH = @as(c_int, 125);
pub const PCRE2_ERROR_ZERO_RELATIVE_REFERENCE = @as(c_int, 126);
pub const PCRE2_ERROR_TOO_MANY_CONDITION_BRANCHES = @as(c_int, 127);
pub const PCRE2_ERROR_CONDITION_ASSERTION_EXPECTED = @as(c_int, 128);
pub const PCRE2_ERROR_BAD_RELATIVE_REFERENCE = @as(c_int, 129);
pub const PCRE2_ERROR_UNKNOWN_POSIX_CLASS = @as(c_int, 130);
pub const PCRE2_ERROR_INTERNAL_STUDY_ERROR = @as(c_int, 131);
pub const PCRE2_ERROR_UNICODE_NOT_SUPPORTED = @as(c_int, 132);
pub const PCRE2_ERROR_PARENTHESES_STACK_CHECK = @as(c_int, 133);
pub const PCRE2_ERROR_CODE_POINT_TOO_BIG = @as(c_int, 134);
pub const PCRE2_ERROR_LOOKBEHIND_TOO_COMPLICATED = @as(c_int, 135);
pub const PCRE2_ERROR_LOOKBEHIND_INVALID_BACKSLASH_C = @as(c_int, 136);
pub const PCRE2_ERROR_UNSUPPORTED_ESCAPE_SEQUENCE = @as(c_int, 137);
pub const PCRE2_ERROR_CALLOUT_NUMBER_TOO_BIG = @as(c_int, 138);
pub const PCRE2_ERROR_MISSING_CALLOUT_CLOSING = @as(c_int, 139);
pub const PCRE2_ERROR_ESCAPE_INVALID_IN_VERB = @as(c_int, 140);
pub const PCRE2_ERROR_UNRECOGNIZED_AFTER_QUERY_P = @as(c_int, 141);
pub const PCRE2_ERROR_MISSING_NAME_TERMINATOR = @as(c_int, 142);
pub const PCRE2_ERROR_DUPLICATE_SUBPATTERN_NAME = @as(c_int, 143);
pub const PCRE2_ERROR_INVALID_SUBPATTERN_NAME = @as(c_int, 144);
pub const PCRE2_ERROR_UNICODE_PROPERTIES_UNAVAILABLE = @as(c_int, 145);
pub const PCRE2_ERROR_MALFORMED_UNICODE_PROPERTY = @as(c_int, 146);
pub const PCRE2_ERROR_UNKNOWN_UNICODE_PROPERTY = @as(c_int, 147);
pub const PCRE2_ERROR_SUBPATTERN_NAME_TOO_LONG = @as(c_int, 148);
pub const PCRE2_ERROR_TOO_MANY_NAMED_SUBPATTERNS = @as(c_int, 149);
pub const PCRE2_ERROR_CLASS_INVALID_RANGE = @as(c_int, 150);
pub const PCRE2_ERROR_OCTAL_BYTE_TOO_BIG = @as(c_int, 151);
pub const PCRE2_ERROR_INTERNAL_OVERRAN_WORKSPACE = @as(c_int, 152);
pub const PCRE2_ERROR_INTERNAL_MISSING_SUBPATTERN = @as(c_int, 153);
pub const PCRE2_ERROR_DEFINE_TOO_MANY_BRANCHES = @as(c_int, 154);
pub const PCRE2_ERROR_BACKSLASH_O_MISSING_BRACE = @as(c_int, 155);
pub const PCRE2_ERROR_INTERNAL_UNKNOWN_NEWLINE = @as(c_int, 156);
pub const PCRE2_ERROR_BACKSLASH_G_SYNTAX = @as(c_int, 157);
pub const PCRE2_ERROR_PARENS_QUERY_R_MISSING_CLOSING = @as(c_int, 158);
pub const PCRE2_ERROR_VERB_ARGUMENT_NOT_ALLOWED = @as(c_int, 159);
pub const PCRE2_ERROR_VERB_UNKNOWN = @as(c_int, 160);
pub const PCRE2_ERROR_SUBPATTERN_NUMBER_TOO_BIG = @as(c_int, 161);
pub const PCRE2_ERROR_SUBPATTERN_NAME_EXPECTED = @as(c_int, 162);
pub const PCRE2_ERROR_INTERNAL_PARSED_OVERFLOW = @as(c_int, 163);
pub const PCRE2_ERROR_INVALID_OCTAL = @as(c_int, 164);
pub const PCRE2_ERROR_SUBPATTERN_NAMES_MISMATCH = @as(c_int, 165);
pub const PCRE2_ERROR_MARK_MISSING_ARGUMENT = @as(c_int, 166);
pub const PCRE2_ERROR_INVALID_HEXADECIMAL = @as(c_int, 167);
pub const PCRE2_ERROR_BACKSLASH_C_SYNTAX = @as(c_int, 168);
pub const PCRE2_ERROR_BACKSLASH_K_SYNTAX = @as(c_int, 169);
pub const PCRE2_ERROR_INTERNAL_BAD_CODE_LOOKBEHINDS = @as(c_int, 170);
pub const PCRE2_ERROR_BACKSLASH_N_IN_CLASS = @as(c_int, 171);
pub const PCRE2_ERROR_CALLOUT_STRING_TOO_LONG = @as(c_int, 172);
pub const PCRE2_ERROR_UNICODE_DISALLOWED_CODE_POINT = @as(c_int, 173);
pub const PCRE2_ERROR_UTF_IS_DISABLED = @as(c_int, 174);
pub const PCRE2_ERROR_UCP_IS_DISABLED = @as(c_int, 175);
pub const PCRE2_ERROR_VERB_NAME_TOO_LONG = @as(c_int, 176);
pub const PCRE2_ERROR_BACKSLASH_U_CODE_POINT_TOO_BIG = @as(c_int, 177);
pub const PCRE2_ERROR_MISSING_OCTAL_OR_HEX_DIGITS = @as(c_int, 178);
pub const PCRE2_ERROR_VERSION_CONDITION_SYNTAX = @as(c_int, 179);
pub const PCRE2_ERROR_INTERNAL_BAD_CODE_AUTO_POSSESS = @as(c_int, 180);
pub const PCRE2_ERROR_CALLOUT_NO_STRING_DELIMITER = @as(c_int, 181);
pub const PCRE2_ERROR_CALLOUT_BAD_STRING_DELIMITER = @as(c_int, 182);
pub const PCRE2_ERROR_BACKSLASH_C_CALLER_DISABLED = @as(c_int, 183);
pub const PCRE2_ERROR_QUERY_BARJX_NEST_TOO_DEEP = @as(c_int, 184);
pub const PCRE2_ERROR_BACKSLASH_C_LIBRARY_DISABLED = @as(c_int, 185);
pub const PCRE2_ERROR_PATTERN_TOO_COMPLICATED = @as(c_int, 186);
pub const PCRE2_ERROR_LOOKBEHIND_TOO_LONG = @as(c_int, 187);
pub const PCRE2_ERROR_PATTERN_STRING_TOO_LONG = @as(c_int, 188);
pub const PCRE2_ERROR_INTERNAL_BAD_CODE = @as(c_int, 189);
pub const PCRE2_ERROR_INTERNAL_BAD_CODE_IN_SKIP = @as(c_int, 190);
pub const PCRE2_ERROR_NO_SURROGATES_IN_UTF16 = @as(c_int, 191);
pub const PCRE2_ERROR_BAD_LITERAL_OPTIONS = @as(c_int, 192);
pub const PCRE2_ERROR_SUPPORTED_ONLY_IN_UNICODE = @as(c_int, 193);
pub const PCRE2_ERROR_INVALID_HYPHEN_IN_OPTIONS = @as(c_int, 194);
pub const PCRE2_ERROR_ALPHA_ASSERTION_UNKNOWN = @as(c_int, 195);
pub const PCRE2_ERROR_SCRIPT_RUN_NOT_AVAILABLE = @as(c_int, 196);
pub const PCRE2_ERROR_TOO_MANY_CAPTURES = @as(c_int, 197);
pub const PCRE2_ERROR_CONDITION_ATOMIC_ASSERTION_EXPECTED = @as(c_int, 198);
pub const PCRE2_ERROR_BACKSLASH_K_IN_LOOKAROUND = @as(c_int, 199);
pub const PCRE2_ERROR_NOMATCH = -@as(c_int, 1);
pub const PCRE2_ERROR_PARTIAL = -@as(c_int, 2);
pub const PCRE2_ERROR_UTF8_ERR1 = -@as(c_int, 3);
pub const PCRE2_ERROR_UTF8_ERR2 = -@as(c_int, 4);
pub const PCRE2_ERROR_UTF8_ERR3 = -@as(c_int, 5);
pub const PCRE2_ERROR_UTF8_ERR4 = -@as(c_int, 6);
pub const PCRE2_ERROR_UTF8_ERR5 = -@as(c_int, 7);
pub const PCRE2_ERROR_UTF8_ERR6 = -@as(c_int, 8);
pub const PCRE2_ERROR_UTF8_ERR7 = -@as(c_int, 9);
pub const PCRE2_ERROR_UTF8_ERR8 = -@as(c_int, 10);
pub const PCRE2_ERROR_UTF8_ERR9 = -@as(c_int, 11);
pub const PCRE2_ERROR_UTF8_ERR10 = -@as(c_int, 12);
pub const PCRE2_ERROR_UTF8_ERR11 = -@as(c_int, 13);
pub const PCRE2_ERROR_UTF8_ERR12 = -@as(c_int, 14);
pub const PCRE2_ERROR_UTF8_ERR13 = -@as(c_int, 15);
pub const PCRE2_ERROR_UTF8_ERR14 = -@as(c_int, 16);
pub const PCRE2_ERROR_UTF8_ERR15 = -@as(c_int, 17);
pub const PCRE2_ERROR_UTF8_ERR16 = -@as(c_int, 18);
pub const PCRE2_ERROR_UTF8_ERR17 = -@as(c_int, 19);
pub const PCRE2_ERROR_UTF8_ERR18 = -@as(c_int, 20);
pub const PCRE2_ERROR_UTF8_ERR19 = -@as(c_int, 21);
pub const PCRE2_ERROR_UTF8_ERR20 = -@as(c_int, 22);
pub const PCRE2_ERROR_UTF8_ERR21 = -@as(c_int, 23);
pub const PCRE2_ERROR_UTF16_ERR1 = -@as(c_int, 24);
pub const PCRE2_ERROR_UTF16_ERR2 = -@as(c_int, 25);
pub const PCRE2_ERROR_UTF16_ERR3 = -@as(c_int, 26);
pub const PCRE2_ERROR_UTF32_ERR1 = -@as(c_int, 27);
pub const PCRE2_ERROR_UTF32_ERR2 = -@as(c_int, 28);
pub const PCRE2_ERROR_BADDATA = -@as(c_int, 29);
pub const PCRE2_ERROR_MIXEDTABLES = -@as(c_int, 30);
pub const PCRE2_ERROR_BADMAGIC = -@as(c_int, 31);
pub const PCRE2_ERROR_BADMODE = -@as(c_int, 32);
pub const PCRE2_ERROR_BADOFFSET = -@as(c_int, 33);
pub const PCRE2_ERROR_BADOPTION = -@as(c_int, 34);
pub const PCRE2_ERROR_BADREPLACEMENT = -@as(c_int, 35);
pub const PCRE2_ERROR_BADUTFOFFSET = -@as(c_int, 36);
pub const PCRE2_ERROR_CALLOUT = -@as(c_int, 37);
pub const PCRE2_ERROR_DFA_BADRESTART = -@as(c_int, 38);
pub const PCRE2_ERROR_DFA_RECURSE = -@as(c_int, 39);
pub const PCRE2_ERROR_DFA_UCOND = -@as(c_int, 40);
pub const PCRE2_ERROR_DFA_UFUNC = -@as(c_int, 41);
pub const PCRE2_ERROR_DFA_UITEM = -@as(c_int, 42);
pub const PCRE2_ERROR_DFA_WSSIZE = -@as(c_int, 43);
pub const PCRE2_ERROR_INTERNAL = -@as(c_int, 44);
pub const PCRE2_ERROR_JIT_BADOPTION = -@as(c_int, 45);
pub const PCRE2_ERROR_JIT_STACKLIMIT = -@as(c_int, 46);
pub const PCRE2_ERROR_MATCHLIMIT = -@as(c_int, 47);
pub const PCRE2_ERROR_NOMEMORY = -@as(c_int, 48);
pub const PCRE2_ERROR_NOSUBSTRING = -@as(c_int, 49);
pub const PCRE2_ERROR_NOUNIQUESUBSTRING = -@as(c_int, 50);
pub const PCRE2_ERROR_NULL = -@as(c_int, 51);
pub const PCRE2_ERROR_RECURSELOOP = -@as(c_int, 52);
pub const PCRE2_ERROR_DEPTHLIMIT = -@as(c_int, 53);
pub const PCRE2_ERROR_RECURSIONLIMIT = -@as(c_int, 53);
pub const PCRE2_ERROR_UNAVAILABLE = -@as(c_int, 54);
pub const PCRE2_ERROR_UNSET = -@as(c_int, 55);
pub const PCRE2_ERROR_BADOFFSETLIMIT = -@as(c_int, 56);
pub const PCRE2_ERROR_BADREPESCAPE = -@as(c_int, 57);
pub const PCRE2_ERROR_REPMISSINGBRACE = -@as(c_int, 58);
pub const PCRE2_ERROR_BADSUBSTITUTION = -@as(c_int, 59);
pub const PCRE2_ERROR_BADSUBSPATTERN = -@as(c_int, 60);
pub const PCRE2_ERROR_TOOMANYREPLACE = -@as(c_int, 61);
pub const PCRE2_ERROR_BADSERIALIZEDDATA = -@as(c_int, 62);
pub const PCRE2_ERROR_HEAPLIMIT = -@as(c_int, 63);
pub const PCRE2_ERROR_CONVERT_SYNTAX = -@as(c_int, 64);
pub const PCRE2_ERROR_INTERNAL_DUPMATCH = -@as(c_int, 65);
pub const PCRE2_ERROR_DFA_UINVALID_UTF = -@as(c_int, 66);
pub const PCRE2_ERROR_INVALIDOFFSET = -@as(c_int, 67);
pub const PCRE2_INFO_ALLOPTIONS = @as(c_int, 0);
pub const PCRE2_INFO_ARGOPTIONS = @as(c_int, 1);
pub const PCRE2_INFO_BACKREFMAX = @as(c_int, 2);
pub const PCRE2_INFO_BSR = @as(c_int, 3);
pub const PCRE2_INFO_CAPTURECOUNT = @as(c_int, 4);
pub const PCRE2_INFO_FIRSTCODEUNIT = @as(c_int, 5);
pub const PCRE2_INFO_FIRSTCODETYPE = @as(c_int, 6);
pub const PCRE2_INFO_FIRSTBITMAP = @as(c_int, 7);
pub const PCRE2_INFO_HASCRORLF = @as(c_int, 8);
pub const PCRE2_INFO_JCHANGED = @as(c_int, 9);
pub const PCRE2_INFO_JITSIZE = @as(c_int, 10);
pub const PCRE2_INFO_LASTCODEUNIT = @as(c_int, 11);
pub const PCRE2_INFO_LASTCODETYPE = @as(c_int, 12);
pub const PCRE2_INFO_MATCHEMPTY = @as(c_int, 13);
pub const PCRE2_INFO_MATCHLIMIT = @as(c_int, 14);
pub const PCRE2_INFO_MAXLOOKBEHIND = @as(c_int, 15);
pub const PCRE2_INFO_MINLENGTH = @as(c_int, 16);
pub const PCRE2_INFO_NAMECOUNT = @as(c_int, 17);
pub const PCRE2_INFO_NAMEENTRYSIZE = @as(c_int, 18);
pub const PCRE2_INFO_NAMETABLE = @as(c_int, 19);
pub const PCRE2_INFO_NEWLINE = @as(c_int, 20);
pub const PCRE2_INFO_DEPTHLIMIT = @as(c_int, 21);
pub const PCRE2_INFO_RECURSIONLIMIT = @as(c_int, 21);
pub const PCRE2_INFO_SIZE = @as(c_int, 22);
pub const PCRE2_INFO_HASBACKSLASHC = @as(c_int, 23);
pub const PCRE2_INFO_FRAMESIZE = @as(c_int, 24);
pub const PCRE2_INFO_HEAPLIMIT = @as(c_int, 25);
pub const PCRE2_INFO_EXTRAOPTIONS = @as(c_int, 26);
pub const PCRE2_CONFIG_BSR = @as(c_int, 0);
pub const PCRE2_CONFIG_JIT = @as(c_int, 1);
pub const PCRE2_CONFIG_JITTARGET = @as(c_int, 2);
pub const PCRE2_CONFIG_LINKSIZE = @as(c_int, 3);
pub const PCRE2_CONFIG_MATCHLIMIT = @as(c_int, 4);
pub const PCRE2_CONFIG_NEWLINE = @as(c_int, 5);
pub const PCRE2_CONFIG_PARENSLIMIT = @as(c_int, 6);
pub const PCRE2_CONFIG_DEPTHLIMIT = @as(c_int, 7);
pub const PCRE2_CONFIG_RECURSIONLIMIT = @as(c_int, 7);
pub const PCRE2_CONFIG_STACKRECURSE = @as(c_int, 8);
pub const PCRE2_CONFIG_UNICODE = @as(c_int, 9);
pub const PCRE2_CONFIG_UNICODE_VERSION = @as(c_int, 10);
pub const PCRE2_CONFIG_VERSION = @as(c_int, 11);
pub const PCRE2_CONFIG_HEAPLIMIT = @as(c_int, 12);
pub const PCRE2_CONFIG_NEVER_BACKSLASH_C = @as(c_int, 13);
pub const PCRE2_CONFIG_COMPILED_WIDTHS = @as(c_int, 14);
pub const PCRE2_CONFIG_TABLES_LENGTH = @as(c_int, 15);
pub const PCRE2_SIZE = usize;
pub const PCRE2_SIZE_MAX = SIZE_MAX;
pub const PCRE2_ZERO_TERMINATED = @compileError("unable to translate C expr: expected ')' instead got 'A number'");
// /usr/include/pcre2.h:481:9
pub const PCRE2_UNSET = @compileError("unable to translate C expr: expected ')' instead got 'A number'");
// /usr/include/pcre2.h:482:9
pub const PCRE2_TYPES_LIST = @compileError("unable to translate C expr: unexpected token ';'");
// /usr/include/pcre2.h:487:9
pub const PCRE2_CALLOUT_STARTMATCH = @as(c_uint, 0x00000001);
pub const PCRE2_CALLOUT_BACKTRACK = @as(c_uint, 0x00000002);
pub const PCRE2_STRUCTURE_LIST = @compileError("unable to translate macro: undefined identifier `version`");
// /usr/include/pcre2.h:523:9
pub const PCRE2_GENERAL_INFO_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:576:9
pub const PCRE2_GENERAL_CONTEXT_FUNCTIONS = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/pcre2.h:582:9
pub const PCRE2_COMPILE_CONTEXT_FUNCTIONS = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/pcre2.h:591:9
pub const PCRE2_MATCH_CONTEXT_FUNCTIONS = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/pcre2.h:618:9
pub const PCRE2_CONVERT_CONTEXT_FUNCTIONS = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/pcre2.h:645:9
pub const PCRE2_COMPILE_FUNCTIONS = @compileError("unable to translate C expr: unexpected token ','");
// /usr/include/pcre2.h:660:9
pub const PCRE2_PATTERN_INFO_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:674:9
pub const PCRE2_MATCH_FUNCTIONS = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/pcre2.h:684:9
pub const PCRE2_SUBSTRING_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:714:9
pub const PCRE2_SERIALIZE_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/pcre2.h:745:9
pub const PCRE2_SUBSTITUTE_FUNCTION = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:760:9
pub const PCRE2_CONVERT_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:769:9
pub const PCRE2_JIT_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:779:9
pub const PCRE2_OTHER_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'int'");
// /usr/include/pcre2.h:797:9
pub const PCRE2_JOIN = @compileError("unable to translate C expr: unexpected token '##'");
// /usr/include/pcre2.h:812:9
pub inline fn PCRE2_GLUE(a: anytype, b: anytype) @TypeOf(PCRE2_JOIN(a, b)) {
    _ = &a;
    _ = &b;
    return PCRE2_JOIN(a, b);
}
pub inline fn PCRE2_SUFFIX(a: anytype) @TypeOf(PCRE2_GLUE(a, PCRE2_LOCAL_WIDTH)) {
    _ = &a;
    return PCRE2_GLUE(a, PCRE2_LOCAL_WIDTH);
}
pub const PCRE2_UCHAR = PCRE2_SUFFIX(PCRE2_UCHAR);
pub const PCRE2_SPTR = PCRE2_SUFFIX(PCRE2_SPTR);
pub const pcre2_code = @compileError("unable to translate macro: undefined identifier `pcre2_code_`");
// /usr/include/pcre2.h:822:9
pub const pcre2_jit_callback = @compileError("unable to translate macro: undefined identifier `pcre2_jit_callback_`");
// /usr/include/pcre2.h:823:9
pub const pcre2_jit_stack = @compileError("unable to translate macro: undefined identifier `pcre2_jit_stack_`");
// /usr/include/pcre2.h:824:9
pub const pcre2_real_code = @compileError("unable to translate macro: undefined identifier `pcre2_real_code_`");
// /usr/include/pcre2.h:826:9
pub const pcre2_real_general_context = @compileError("unable to translate macro: undefined identifier `pcre2_real_general_context_`");
// /usr/include/pcre2.h:827:9
pub const pcre2_real_compile_context = @compileError("unable to translate macro: undefined identifier `pcre2_real_compile_context_`");
// /usr/include/pcre2.h:828:9
pub const pcre2_real_convert_context = @compileError("unable to translate macro: undefined identifier `pcre2_real_convert_context_`");
// /usr/include/pcre2.h:829:9
pub const pcre2_real_match_context = @compileError("unable to translate macro: undefined identifier `pcre2_real_match_context_`");
// /usr/include/pcre2.h:830:9
pub const pcre2_real_jit_stack = @compileError("unable to translate macro: undefined identifier `pcre2_real_jit_stack_`");
// /usr/include/pcre2.h:831:9
pub const pcre2_real_match_data = @compileError("unable to translate macro: undefined identifier `pcre2_real_match_data_`");
// /usr/include/pcre2.h:832:9
pub const pcre2_callout_block = @compileError("unable to translate macro: undefined identifier `pcre2_callout_block_`");
// /usr/include/pcre2.h:837:9
pub const pcre2_callout_enumerate_block = @compileError("unable to translate macro: undefined identifier `pcre2_callout_enumerate_block_`");
// /usr/include/pcre2.h:838:9
pub const pcre2_substitute_callout_block = @compileError("unable to translate macro: undefined identifier `pcre2_substitute_callout_block_`");
// /usr/include/pcre2.h:839:9
pub const pcre2_general_context = @compileError("unable to translate macro: undefined identifier `pcre2_general_context_`");
// /usr/include/pcre2.h:840:9
pub const pcre2_compile_context = @compileError("unable to translate macro: undefined identifier `pcre2_compile_context_`");
// /usr/include/pcre2.h:841:9
pub const pcre2_convert_context = @compileError("unable to translate macro: undefined identifier `pcre2_convert_context_`");
// /usr/include/pcre2.h:842:9
pub const pcre2_match_context = @compileError("unable to translate macro: undefined identifier `pcre2_match_context_`");
// /usr/include/pcre2.h:843:9
pub const pcre2_match_data = @compileError("unable to translate macro: undefined identifier `pcre2_match_data_`");
// /usr/include/pcre2.h:844:9
pub const pcre2_callout_enumerate = @compileError("unable to translate macro: undefined identifier `pcre2_callout_enumerate_`");
// /usr/include/pcre2.h:849:9
pub const pcre2_code_copy = @compileError("unable to translate macro: undefined identifier `pcre2_code_copy_`");
// /usr/include/pcre2.h:850:9
pub const pcre2_code_copy_with_tables = @compileError("unable to translate macro: undefined identifier `pcre2_code_copy_with_tables_`");
// /usr/include/pcre2.h:851:9
pub const pcre2_code_free = @compileError("unable to translate macro: undefined identifier `pcre2_code_free_`");
// /usr/include/pcre2.h:852:9
pub const pcre2_compile = @compileError("unable to translate macro: undefined identifier `pcre2_compile_`");
// /usr/include/pcre2.h:853:9
pub const pcre2_compile_context_copy = @compileError("unable to translate macro: undefined identifier `pcre2_compile_context_copy_`");
// /usr/include/pcre2.h:854:9
pub const pcre2_compile_context_create = @compileError("unable to translate macro: undefined identifier `pcre2_compile_context_create_`");
// /usr/include/pcre2.h:855:9
pub const pcre2_compile_context_free = @compileError("unable to translate macro: undefined identifier `pcre2_compile_context_free_`");
// /usr/include/pcre2.h:856:9
pub const pcre2_config = @compileError("unable to translate macro: undefined identifier `pcre2_config_`");
// /usr/include/pcre2.h:857:9
pub const pcre2_convert_context_copy = @compileError("unable to translate macro: undefined identifier `pcre2_convert_context_copy_`");
// /usr/include/pcre2.h:858:9
pub const pcre2_convert_context_create = @compileError("unable to translate macro: undefined identifier `pcre2_convert_context_create_`");
// /usr/include/pcre2.h:859:9
pub const pcre2_convert_context_free = @compileError("unable to translate macro: undefined identifier `pcre2_convert_context_free_`");
// /usr/include/pcre2.h:860:9
pub const pcre2_converted_pattern_free = @compileError("unable to translate macro: undefined identifier `pcre2_converted_pattern_free_`");
// /usr/include/pcre2.h:861:9
pub const pcre2_dfa_match = @compileError("unable to translate macro: undefined identifier `pcre2_dfa_match_`");
// /usr/include/pcre2.h:862:9
pub const pcre2_general_context_copy = @compileError("unable to translate macro: undefined identifier `pcre2_general_context_copy_`");
// /usr/include/pcre2.h:863:9
pub const pcre2_general_context_create = @compileError("unable to translate macro: undefined identifier `pcre2_general_context_create_`");
// /usr/include/pcre2.h:864:9
pub const pcre2_general_context_free = @compileError("unable to translate macro: undefined identifier `pcre2_general_context_free_`");
// /usr/include/pcre2.h:865:9
pub const pcre2_get_error_message = @compileError("unable to translate macro: undefined identifier `pcre2_get_error_message_`");
// /usr/include/pcre2.h:866:9
pub const pcre2_get_mark = @compileError("unable to translate macro: undefined identifier `pcre2_get_mark_`");
// /usr/include/pcre2.h:867:9
pub const pcre2_get_match_data_heapframes_size = @compileError("unable to translate macro: undefined identifier `pcre2_get_match_data_heapframes_size_`");
// /usr/include/pcre2.h:868:9
pub const pcre2_get_match_data_size = @compileError("unable to translate macro: undefined identifier `pcre2_get_match_data_size_`");
// /usr/include/pcre2.h:869:9
pub const pcre2_get_ovector_pointer = @compileError("unable to translate macro: undefined identifier `pcre2_get_ovector_pointer_`");
// /usr/include/pcre2.h:870:9
pub const pcre2_get_ovector_count = @compileError("unable to translate macro: undefined identifier `pcre2_get_ovector_count_`");
// /usr/include/pcre2.h:871:9
pub const pcre2_get_startchar = @compileError("unable to translate macro: undefined identifier `pcre2_get_startchar_`");
// /usr/include/pcre2.h:872:9
pub const pcre2_jit_compile = @compileError("unable to translate macro: undefined identifier `pcre2_jit_compile_`");
// /usr/include/pcre2.h:873:9
pub const pcre2_jit_match = @compileError("unable to translate macro: undefined identifier `pcre2_jit_match_`");
// /usr/include/pcre2.h:874:9
pub const pcre2_jit_free_unused_memory = @compileError("unable to translate macro: undefined identifier `pcre2_jit_free_unused_memory_`");
// /usr/include/pcre2.h:875:9
pub const pcre2_jit_stack_assign = @compileError("unable to translate macro: undefined identifier `pcre2_jit_stack_assign_`");
// /usr/include/pcre2.h:876:9
pub const pcre2_jit_stack_create = @compileError("unable to translate macro: undefined identifier `pcre2_jit_stack_create_`");
// /usr/include/pcre2.h:877:9
pub const pcre2_jit_stack_free = @compileError("unable to translate macro: undefined identifier `pcre2_jit_stack_free_`");
// /usr/include/pcre2.h:878:9
pub const pcre2_maketables = @compileError("unable to translate macro: undefined identifier `pcre2_maketables_`");
// /usr/include/pcre2.h:879:9
pub const pcre2_maketables_free = @compileError("unable to translate macro: undefined identifier `pcre2_maketables_free_`");
// /usr/include/pcre2.h:880:9
pub const pcre2_match = @compileError("unable to translate macro: undefined identifier `pcre2_match_`");
// /usr/include/pcre2.h:881:9
pub const pcre2_match_context_copy = @compileError("unable to translate macro: undefined identifier `pcre2_match_context_copy_`");
// /usr/include/pcre2.h:882:9
pub const pcre2_match_context_create = @compileError("unable to translate macro: undefined identifier `pcre2_match_context_create_`");
// /usr/include/pcre2.h:883:9
pub const pcre2_match_context_free = @compileError("unable to translate macro: undefined identifier `pcre2_match_context_free_`");
// /usr/include/pcre2.h:884:9
pub const pcre2_match_data_create = @compileError("unable to translate macro: undefined identifier `pcre2_match_data_create_`");
// /usr/include/pcre2.h:885:9
pub const pcre2_match_data_create_from_pattern = @compileError("unable to translate macro: undefined identifier `pcre2_match_data_create_from_pattern_`");
// /usr/include/pcre2.h:886:9
pub const pcre2_match_data_free = @compileError("unable to translate macro: undefined identifier `pcre2_match_data_free_`");
// /usr/include/pcre2.h:887:9
pub const pcre2_pattern_convert = @compileError("unable to translate macro: undefined identifier `pcre2_pattern_convert_`");
// /usr/include/pcre2.h:888:9
pub const pcre2_pattern_info = @compileError("unable to translate macro: undefined identifier `pcre2_pattern_info_`");
// /usr/include/pcre2.h:889:9
pub const pcre2_serialize_decode = @compileError("unable to translate macro: undefined identifier `pcre2_serialize_decode_`");
// /usr/include/pcre2.h:890:9
pub const pcre2_serialize_encode = @compileError("unable to translate macro: undefined identifier `pcre2_serialize_encode_`");
// /usr/include/pcre2.h:891:9
pub const pcre2_serialize_free = @compileError("unable to translate macro: undefined identifier `pcre2_serialize_free_`");
// /usr/include/pcre2.h:892:9
pub const pcre2_serialize_get_number_of_codes = @compileError("unable to translate macro: undefined identifier `pcre2_serialize_get_number_of_codes_`");
// /usr/include/pcre2.h:893:9
pub const pcre2_set_bsr = @compileError("unable to translate macro: undefined identifier `pcre2_set_bsr_`");
// /usr/include/pcre2.h:894:9
pub const pcre2_set_callout = @compileError("unable to translate macro: undefined identifier `pcre2_set_callout_`");
// /usr/include/pcre2.h:895:9
pub const pcre2_set_character_tables = @compileError("unable to translate macro: undefined identifier `pcre2_set_character_tables_`");
// /usr/include/pcre2.h:896:9
pub const pcre2_set_compile_extra_options = @compileError("unable to translate macro: undefined identifier `pcre2_set_compile_extra_options_`");
// /usr/include/pcre2.h:897:9
pub const pcre2_set_compile_recursion_guard = @compileError("unable to translate macro: undefined identifier `pcre2_set_compile_recursion_guard_`");
// /usr/include/pcre2.h:898:9
pub const pcre2_set_depth_limit = @compileError("unable to translate macro: undefined identifier `pcre2_set_depth_limit_`");
// /usr/include/pcre2.h:899:9
pub const pcre2_set_glob_escape = @compileError("unable to translate macro: undefined identifier `pcre2_set_glob_escape_`");
// /usr/include/pcre2.h:900:9
pub const pcre2_set_glob_separator = @compileError("unable to translate macro: undefined identifier `pcre2_set_glob_separator_`");
// /usr/include/pcre2.h:901:9
pub const pcre2_set_heap_limit = @compileError("unable to translate macro: undefined identifier `pcre2_set_heap_limit_`");
// /usr/include/pcre2.h:902:9
pub const pcre2_set_match_limit = @compileError("unable to translate macro: undefined identifier `pcre2_set_match_limit_`");
// /usr/include/pcre2.h:903:9
pub const pcre2_set_max_varlookbehind = @compileError("unable to translate macro: undefined identifier `pcre2_set_max_varlookbehind_`");
// /usr/include/pcre2.h:904:9
pub const pcre2_set_max_pattern_length = @compileError("unable to translate macro: undefined identifier `pcre2_set_max_pattern_length_`");
// /usr/include/pcre2.h:905:9
pub const pcre2_set_max_pattern_compiled_length = @compileError("unable to translate macro: undefined identifier `pcre2_set_max_pattern_compiled_length_`");
// /usr/include/pcre2.h:906:9
pub const pcre2_set_newline = @compileError("unable to translate macro: undefined identifier `pcre2_set_newline_`");
// /usr/include/pcre2.h:907:9
pub const pcre2_set_parens_nest_limit = @compileError("unable to translate macro: undefined identifier `pcre2_set_parens_nest_limit_`");
// /usr/include/pcre2.h:908:9
pub const pcre2_set_offset_limit = @compileError("unable to translate macro: undefined identifier `pcre2_set_offset_limit_`");
// /usr/include/pcre2.h:909:9
pub const pcre2_set_substitute_callout = @compileError("unable to translate macro: undefined identifier `pcre2_set_substitute_callout_`");
// /usr/include/pcre2.h:910:9
pub const pcre2_substitute = @compileError("unable to translate macro: undefined identifier `pcre2_substitute_`");
// /usr/include/pcre2.h:911:9
pub const pcre2_substring_copy_byname = @compileError("unable to translate macro: undefined identifier `pcre2_substring_copy_byname_`");
// /usr/include/pcre2.h:912:9
pub const pcre2_substring_copy_bynumber = @compileError("unable to translate macro: undefined identifier `pcre2_substring_copy_bynumber_`");
// /usr/include/pcre2.h:913:9
pub const pcre2_substring_free = @compileError("unable to translate macro: undefined identifier `pcre2_substring_free_`");
// /usr/include/pcre2.h:914:9
pub const pcre2_substring_get_byname = @compileError("unable to translate macro: undefined identifier `pcre2_substring_get_byname_`");
// /usr/include/pcre2.h:915:9
pub const pcre2_substring_get_bynumber = @compileError("unable to translate macro: undefined identifier `pcre2_substring_get_bynumber_`");
// /usr/include/pcre2.h:916:9
pub const pcre2_substring_length_byname = @compileError("unable to translate macro: undefined identifier `pcre2_substring_length_byname_`");
// /usr/include/pcre2.h:917:9
pub const pcre2_substring_length_bynumber = @compileError("unable to translate macro: undefined identifier `pcre2_substring_length_bynumber_`");
// /usr/include/pcre2.h:918:9
pub const pcre2_substring_list_get = @compileError("unable to translate macro: undefined identifier `pcre2_substring_list_get_`");
// /usr/include/pcre2.h:919:9
pub const pcre2_substring_list_free = @compileError("unable to translate macro: undefined identifier `pcre2_substring_list_free_`");
// /usr/include/pcre2.h:920:9
pub const pcre2_substring_nametable_scan = @compileError("unable to translate macro: undefined identifier `pcre2_substring_nametable_scan_`");
// /usr/include/pcre2.h:921:9
pub const pcre2_substring_number_from_name = @compileError("unable to translate macro: undefined identifier `pcre2_substring_number_from_name_`");
// /usr/include/pcre2.h:922:9
pub const pcre2_set_recursion_limit = @compileError("unable to translate macro: undefined identifier `pcre2_set_recursion_limit_`");
// /usr/include/pcre2.h:925:9
pub const pcre2_set_recursion_memory_management = @compileError("unable to translate macro: undefined identifier `pcre2_set_recursion_memory_management_`");
// /usr/include/pcre2.h:928:9
pub const PCRE2_TYPES_STRUCTURES_AND_FUNCTIONS = PCRE2_TYPES_LIST ++ PCRE2_STRUCTURE_LIST ++ PCRE2_GENERAL_INFO_FUNCTIONS ++ PCRE2_GENERAL_CONTEXT_FUNCTIONS ++ PCRE2_COMPILE_CONTEXT_FUNCTIONS ++ PCRE2_CONVERT_CONTEXT_FUNCTIONS ++ PCRE2_CONVERT_FUNCTIONS ++ PCRE2_MATCH_CONTEXT_FUNCTIONS ++ PCRE2_COMPILE_FUNCTIONS ++ PCRE2_PATTERN_INFO_FUNCTIONS ++ PCRE2_MATCH_FUNCTIONS ++ PCRE2_SUBSTRING_FUNCTIONS ++ PCRE2_SERIALIZE_FUNCTIONS ++ PCRE2_SUBSTITUTE_FUNCTION ++ PCRE2_JIT_FUNCTIONS ++ PCRE2_OTHER_FUNCTIONS;
pub const PCRE2_LOCAL_WIDTH = @as(c_int, 8);
pub const NGX_REGEX_NO_MATCHED = PCRE2_ERROR_NOMATCH;
pub const NGX_REGEX_CASELESS = @as(c_int, 0x00000001);
pub const NGX_REGEX_MULTILINE = @as(c_int, 0x00000002);
pub const ngx_regex_exec_n = "pcre2_match()";
pub const _NGX_RADIX_TREE_H_INCLUDED_ = "";
pub const NGX_RADIX_NO_VALUE = @import("std").zig.c_translation.cast(usize, -@as(c_int, 1));
pub const _NGX_TIMES_H_INCLUDED_ = "";
pub const ngx_next_time_n = "mktime()";
pub inline fn ngx_time() @TypeOf(ngx_cached_time.*.sec) {
    return ngx_cached_time.*.sec;
}
pub inline fn ngx_timeofday() [*c]ngx_time_t {
    return @import("std").zig.c_translation.cast([*c]ngx_time_t, ngx_cached_time);
}
pub const _NGX_RWLOCK_H_INCLUDED_ = "";
pub const _NGX_SHMTX_H_INCLUDED_ = "";
pub const _NGX_SLAB_H_INCLUDED_ = "";
pub const _NGX_INET_H_INCLUDED_ = "";
pub const NGX_INET_ADDRSTRLEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// src/core/ngx_inet.h:16:9
pub const NGX_INET6_ADDRSTRLEN = @compileError("unable to translate C expr: unexpected token 'a string literal'");
// src/core/ngx_inet.h:17:9
pub const NGX_UNIX_ADDRSTRLEN = @compileError("unable to translate macro: undefined identifier `sun_path`");
// src/core/ngx_inet.h:19:9
pub const NGX_SOCKADDR_STRLEN = NGX_UNIX_ADDRSTRLEN;
pub const NGX_SOCKADDRLEN = @import("std").zig.c_translation.sizeof(ngx_sockaddr_t);
pub const _NGX_CYCLE_H_INCLUDED_ = "";
pub const NGX_CYCLE_POOL_SIZE = NGX_DEFAULT_POOL_SIZE;
pub const NGX_DEBUG_POINTS_STOP = @as(c_int, 1);
pub const NGX_DEBUG_POINTS_ABORT = @as(c_int, 2);
pub inline fn ngx_is_init_cycle(cycle: anytype) @TypeOf(cycle.*.conf_ctx == NULL) {
    _ = &cycle;
    return cycle.*.conf_ctx == NULL;
}
pub const _NGX_RESOLVER_H_INCLUDED_ = "";
pub const NGX_RESOLVE_A = @as(c_int, 1);
pub const NGX_RESOLVE_CNAME = @as(c_int, 5);
pub const NGX_RESOLVE_PTR = @as(c_int, 12);
pub const NGX_RESOLVE_MX = @as(c_int, 15);
pub const NGX_RESOLVE_TXT = @as(c_int, 16);
pub const NGX_RESOLVE_AAAA = @as(c_int, 28);
pub const NGX_RESOLVE_SRV = @as(c_int, 33);
pub const NGX_RESOLVE_DNAME = @as(c_int, 39);
pub const NGX_RESOLVE_FORMERR = @as(c_int, 1);
pub const NGX_RESOLVE_SERVFAIL = @as(c_int, 2);
pub const NGX_RESOLVE_NXDOMAIN = @as(c_int, 3);
pub const NGX_RESOLVE_NOTIMP = @as(c_int, 4);
pub const NGX_RESOLVE_REFUSED = @as(c_int, 5);
pub const NGX_RESOLVE_TIMEDOUT = NGX_ETIMEDOUT;
pub const NGX_NO_RESOLVER = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_int, 1));
pub const NGX_RESOLVER_MAX_RECURSION = @as(c_int, 50);
pub const _NGX_PROCESS_CYCLE_H_INCLUDED_ = "";
pub const NGX_CMD_OPEN_CHANNEL = @as(c_int, 1);
pub const NGX_CMD_CLOSE_CHANNEL = @as(c_int, 2);
pub const NGX_CMD_QUIT = @as(c_int, 3);
pub const NGX_CMD_TERMINATE = @as(c_int, 4);
pub const NGX_CMD_REOPEN = @as(c_int, 5);
pub const NGX_PROCESS_SINGLE = @as(c_int, 0);
pub const NGX_PROCESS_MASTER = @as(c_int, 1);
pub const NGX_PROCESS_SIGNALLER = @as(c_int, 2);
pub const NGX_PROCESS_WORKER = @as(c_int, 3);
pub const NGX_PROCESS_HELPER = @as(c_int, 4);
pub const _NGX_CONF_FILE_H_INCLUDED_ = "";
pub const NGX_CONF_NOARGS = @as(c_int, 0x00000001);
pub const NGX_CONF_TAKE1 = @as(c_int, 0x00000002);
pub const NGX_CONF_TAKE2 = @as(c_int, 0x00000004);
pub const NGX_CONF_TAKE3 = @as(c_int, 0x00000008);
pub const NGX_CONF_TAKE4 = @as(c_int, 0x00000010);
pub const NGX_CONF_TAKE5 = @as(c_int, 0x00000020);
pub const NGX_CONF_TAKE6 = @as(c_int, 0x00000040);
pub const NGX_CONF_TAKE7 = @as(c_int, 0x00000080);
pub const NGX_CONF_MAX_ARGS = @as(c_int, 8);
pub const NGX_CONF_TAKE12 = NGX_CONF_TAKE1 | NGX_CONF_TAKE2;
pub const NGX_CONF_TAKE13 = NGX_CONF_TAKE1 | NGX_CONF_TAKE3;
pub const NGX_CONF_TAKE23 = NGX_CONF_TAKE2 | NGX_CONF_TAKE3;
pub const NGX_CONF_TAKE123 = (NGX_CONF_TAKE1 | NGX_CONF_TAKE2) | NGX_CONF_TAKE3;
pub const NGX_CONF_TAKE1234 = ((NGX_CONF_TAKE1 | NGX_CONF_TAKE2) | NGX_CONF_TAKE3) | NGX_CONF_TAKE4;
pub const NGX_CONF_ARGS_NUMBER = @as(c_int, 0x000000ff);
pub const NGX_CONF_BLOCK = @as(c_int, 0x00000100);
pub const NGX_CONF_FLAG = @as(c_int, 0x00000200);
pub const NGX_CONF_ANY = @as(c_int, 0x00000400);
pub const NGX_CONF_1MORE = @as(c_int, 0x00000800);
pub const NGX_CONF_2MORE = @as(c_int, 0x00001000);
pub const NGX_DIRECT_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hex);
pub const NGX_MAIN_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const NGX_ANY_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFF000000, .hex);
pub const NGX_CONF_UNSET = -@as(c_int, 1);
pub const NGX_CONF_UNSET_UINT = @import("std").zig.c_translation.cast(ngx_uint_t, -@as(c_int, 1));
pub const NGX_CONF_UNSET_PTR = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_int, 1));
pub const NGX_CONF_UNSET_SIZE = @import("std").zig.c_translation.cast(usize, -@as(c_int, 1));
pub const NGX_CONF_UNSET_MSEC = @import("std").zig.c_translation.cast(ngx_msec_t, -@as(c_int, 1));
pub const NGX_CONF_OK = NULL;
pub const NGX_CONF_ERROR = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_int, 1));
pub const NGX_CONF_BLOCK_START = @as(c_int, 1);
pub const NGX_CONF_BLOCK_DONE = @as(c_int, 2);
pub const NGX_CONF_FILE_DONE = @as(c_int, 3);
pub const NGX_CORE_MODULE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x45524F43, .hex);
pub const NGX_CONF_MODULE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x464E4F43, .hex);
pub const NGX_MAX_CONF_ERRSTR = @as(c_int, 1024);
pub const ngx_null_command = @compileError("unable to translate C expr: unexpected token '{'");
// src/core/ngx_conf_file.h:86:9
pub const NGX_CONF_BITMASK_SET = @as(c_int, 1);
pub inline fn ngx_get_conf(conf_ctx: anytype, module: anytype) @TypeOf(conf_ctx[@as(usize, @intCast(module.index))]) {
    _ = &conf_ctx;
    _ = &module;
    return conf_ctx[@as(usize, @intCast(module.index))];
}
pub const ngx_conf_init_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:180:9
pub const ngx_conf_init_ptr_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:185:9
pub const ngx_conf_init_uint_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:190:9
pub const ngx_conf_init_size_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:195:9
pub const ngx_conf_init_msec_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:200:9
pub const ngx_conf_merge_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:205:9
pub const ngx_conf_merge_ptr_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:210:9
pub const ngx_conf_merge_uint_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:215:9
pub const ngx_conf_merge_msec_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:220:9
pub const ngx_conf_merge_sec_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:225:9
pub const ngx_conf_merge_size_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:230:9
pub const ngx_conf_merge_off_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:235:9
pub const ngx_conf_merge_str_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:240:9
pub const ngx_conf_merge_bufs_value = @compileError("unable to translate C expr: unexpected token 'if'");
// src/core/ngx_conf_file.h:251:9
pub const ngx_conf_merge_bitmask_value = @compileError("unable to translate C expr: expected ')' instead got 'default'");
// src/core/ngx_conf_file.h:262:9
pub const _NGX_MODULE_H_INCLUDED_ = "";
pub const _NGINX_H_INCLUDED_ = "";
pub const nginx_version = @import("std").zig.c_translation.promoteIntLiteral(c_int, 1027004, .decimal);
pub const NGINX_VERSION = "1.27.4";
pub const NGINX_VER = "nginx/" ++ NGINX_VERSION;
pub const NGINX_VER_BUILD = NGINX_VER;
pub const NGINX_VAR = "NGINX";
pub const NGX_OLDPID_EXT = ".oldbin";
pub const NGX_MODULE_UNSET_INDEX = @import("std").zig.c_translation.cast(ngx_uint_t, -@as(c_int, 1));
pub const NGX_MODULE_SIGNATURE_0 = ngx_value(NGX_PTR_SIZE) ++ "," ++ ngx_value(NGX_SIG_ATOMIC_T_SIZE) ++ "," ++ ngx_value(NGX_TIME_T_SIZE) ++ ",";
pub const NGX_MODULE_SIGNATURE_1 = "0";
pub const NGX_MODULE_SIGNATURE_2 = "0";
pub const NGX_MODULE_SIGNATURE_3 = "0";
pub const NGX_MODULE_SIGNATURE_4 = "0";
pub const NGX_MODULE_SIGNATURE_5 = "1";
pub const NGX_MODULE_SIGNATURE_6 = "1";
pub const NGX_MODULE_SIGNATURE_7 = "1";
pub const NGX_MODULE_SIGNATURE_8 = "1";
pub const NGX_MODULE_SIGNATURE_9 = "1";
pub const NGX_MODULE_SIGNATURE_10 = "1";
pub const NGX_MODULE_SIGNATURE_11 = "0";
pub const NGX_MODULE_SIGNATURE_12 = "1";
pub const NGX_MODULE_SIGNATURE_13 = "0";
pub const NGX_MODULE_SIGNATURE_14 = "1";
pub const NGX_MODULE_SIGNATURE_15 = "1";
pub const NGX_MODULE_SIGNATURE_16 = "1";
pub const NGX_MODULE_SIGNATURE_17 = "0";
pub const NGX_MODULE_SIGNATURE_18 = "0";
pub const NGX_MODULE_SIGNATURE_19 = "1";
pub const NGX_MODULE_SIGNATURE_20 = "1";
pub const NGX_MODULE_SIGNATURE_21 = "1";
pub const NGX_MODULE_SIGNATURE_22 = "0";
pub const NGX_MODULE_SIGNATURE_23 = "1";
pub const NGX_MODULE_SIGNATURE_24 = "0";
pub const NGX_MODULE_SIGNATURE_25 = "1";
pub const NGX_MODULE_SIGNATURE_26 = "1";
pub const NGX_MODULE_SIGNATURE_27 = "1";
pub const NGX_MODULE_SIGNATURE_28 = "1";
pub const NGX_MODULE_SIGNATURE_29 = "0";
pub const NGX_MODULE_SIGNATURE_30 = "0";
pub const NGX_MODULE_SIGNATURE_31 = "0";
pub const NGX_MODULE_SIGNATURE_32 = "1";
pub const NGX_MODULE_SIGNATURE_33 = "1";
pub const NGX_MODULE_SIGNATURE_34 = "0";
pub const NGX_MODULE_SIGNATURE = NGX_MODULE_SIGNATURE_0 ++ NGX_MODULE_SIGNATURE_1 ++ NGX_MODULE_SIGNATURE_2 ++ NGX_MODULE_SIGNATURE_3 ++ NGX_MODULE_SIGNATURE_4 ++ NGX_MODULE_SIGNATURE_5 ++ NGX_MODULE_SIGNATURE_6 ++ NGX_MODULE_SIGNATURE_7 ++ NGX_MODULE_SIGNATURE_8 ++ NGX_MODULE_SIGNATURE_9 ++ NGX_MODULE_SIGNATURE_10 ++ NGX_MODULE_SIGNATURE_11 ++ NGX_MODULE_SIGNATURE_12 ++ NGX_MODULE_SIGNATURE_13 ++ NGX_MODULE_SIGNATURE_14 ++ NGX_MODULE_SIGNATURE_15 ++ NGX_MODULE_SIGNATURE_16 ++ NGX_MODULE_SIGNATURE_17 ++ NGX_MODULE_SIGNATURE_18 ++ NGX_MODULE_SIGNATURE_19 ++ NGX_MODULE_SIGNATURE_20 ++ NGX_MODULE_SIGNATURE_21 ++ NGX_MODULE_SIGNATURE_22 ++ NGX_MODULE_SIGNATURE_23 ++ NGX_MODULE_SIGNATURE_24 ++ NGX_MODULE_SIGNATURE_25 ++ NGX_MODULE_SIGNATURE_26 ++ NGX_MODULE_SIGNATURE_27 ++ NGX_MODULE_SIGNATURE_28 ++ NGX_MODULE_SIGNATURE_29 ++ NGX_MODULE_SIGNATURE_30 ++ NGX_MODULE_SIGNATURE_31 ++ NGX_MODULE_SIGNATURE_32 ++ NGX_MODULE_SIGNATURE_33 ++ NGX_MODULE_SIGNATURE_34;
pub const NGX_MODULE_V1 = blk: {
    _ = &NGX_MODULE_UNSET_INDEX;
    _ = &NGX_MODULE_UNSET_INDEX;
    _ = &NULL;
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    _ = &nginx_version;
    break :blk NGX_MODULE_SIGNATURE;
};
pub const NGX_MODULE_V1_PADDING = blk: {
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    _ = @as(c_int, 0);
    break :blk @as(c_int, 0);
};
pub const _NGX_OPEN_FILE_CACHE_H_INCLUDED_ = "";
pub const NGX_OPEN_FILE_DIRECTIO_OFF = NGX_MAX_OFF_T_VALUE;
pub const _NGX_OS_H_INCLUDED_ = "";
pub const NGX_IO_SENDFILE = @as(c_int, 1);
pub const NGX_IOVS_PREALLOCATE = @as(c_int, 64);
pub const _NGX_LINUX_H_INCLUDED_ = "";
pub const _NGX_CONNECTION_H_INCLUDED_ = "";
pub const NGX_LOWLEVEL_BUFFERED = @as(c_int, 0x0f);
pub const NGX_SSL_BUFFERED = @as(c_int, 0x01);
pub const NGX_HTTP_V2_BUFFERED = @as(c_int, 0x02);
pub const ngx_set_connection_log = @compileError("unable to translate C expr: unexpected token '='");
// src/core/ngx_connection.h:206:9
pub const _NGX_SYSLOG_H_INCLUDED_ = "";
pub const _NGX_PROXY_PROTOCOL_H_INCLUDED_ = "";
pub const NGX_PROXY_PROTOCOL_V1_MAX_HEADER = @as(c_int, 107);
pub const NGX_PROXY_PROTOCOL_MAX_HEADER = @as(c_int, 4096);
pub const _NGX_BPF_H_INCLUDED_ = "";
pub const __LINUX_BPF_H__ = "";
pub const __LINUX_BPF_COMMON_H__ = "";
pub inline fn BPF_CLASS(code: anytype) @TypeOf(code & @as(c_int, 0x07)) {
    _ = &code;
    return code & @as(c_int, 0x07);
}
pub const BPF_LD = @as(c_int, 0x00);
pub const BPF_LDX = @as(c_int, 0x01);
pub const BPF_ST = @as(c_int, 0x02);
pub const BPF_STX = @as(c_int, 0x03);
pub const BPF_ALU = @as(c_int, 0x04);
pub const BPF_JMP = @as(c_int, 0x05);
pub const BPF_RET = @as(c_int, 0x06);
pub const BPF_MISC = @as(c_int, 0x07);
pub inline fn BPF_SIZE(code: anytype) @TypeOf(code & @as(c_int, 0x18)) {
    _ = &code;
    return code & @as(c_int, 0x18);
}
pub const BPF_W = @as(c_int, 0x00);
pub const BPF_H = @as(c_int, 0x08);
pub const BPF_B = @as(c_int, 0x10);
pub inline fn BPF_MODE(code: anytype) @TypeOf(code & @as(c_int, 0xe0)) {
    _ = &code;
    return code & @as(c_int, 0xe0);
}
pub const BPF_IMM = @as(c_int, 0x00);
pub const BPF_ABS = @as(c_int, 0x20);
pub const BPF_IND = @as(c_int, 0x40);
pub const BPF_MEM = @as(c_int, 0x60);
pub const BPF_LEN = @as(c_int, 0x80);
pub const BPF_MSH = @as(c_int, 0xa0);
pub inline fn BPF_OP(code: anytype) @TypeOf(code & @as(c_int, 0xf0)) {
    _ = &code;
    return code & @as(c_int, 0xf0);
}
pub const BPF_ADD = @as(c_int, 0x00);
pub const BPF_SUB = @as(c_int, 0x10);
pub const BPF_MUL = @as(c_int, 0x20);
pub const BPF_DIV = @as(c_int, 0x30);
pub const BPF_OR = @as(c_int, 0x40);
pub const BPF_AND = @as(c_int, 0x50);
pub const BPF_LSH = @as(c_int, 0x60);
pub const BPF_RSH = @as(c_int, 0x70);
pub const BPF_NEG = @as(c_int, 0x80);
pub const BPF_MOD = @as(c_int, 0x90);
pub const BPF_XOR = @as(c_int, 0xa0);
pub const BPF_JA = @as(c_int, 0x00);
pub const BPF_JEQ = @as(c_int, 0x10);
pub const BPF_JGT = @as(c_int, 0x20);
pub const BPF_JGE = @as(c_int, 0x30);
pub const BPF_JSET = @as(c_int, 0x40);
pub inline fn BPF_SRC(code: anytype) @TypeOf(code & @as(c_int, 0x08)) {
    _ = &code;
    return code & @as(c_int, 0x08);
}
pub const BPF_K = @as(c_int, 0x00);
pub const BPF_X = @as(c_int, 0x08);
pub const BPF_MAXINSNS = @as(c_int, 4096);
pub const BPF_JMP32 = @as(c_int, 0x06);
pub const BPF_ALU64 = @as(c_int, 0x07);
pub const BPF_DW = @as(c_int, 0x18);
pub const BPF_MEMSX = @as(c_int, 0x80);
pub const BPF_ATOMIC = @as(c_int, 0xc0);
pub const BPF_XADD = @as(c_int, 0xc0);
pub const BPF_MOV = @as(c_int, 0xb0);
pub const BPF_ARSH = @as(c_int, 0xc0);
pub const BPF_END = @as(c_int, 0xd0);
pub const BPF_TO_LE = @as(c_int, 0x00);
pub const BPF_TO_BE = @as(c_int, 0x08);
pub const BPF_FROM_LE = BPF_TO_LE;
pub const BPF_FROM_BE = BPF_TO_BE;
pub const BPF_JNE = @as(c_int, 0x50);
pub const BPF_JLT = @as(c_int, 0xa0);
pub const BPF_JLE = @as(c_int, 0xb0);
pub const BPF_JSGT = @as(c_int, 0x60);
pub const BPF_JSGE = @as(c_int, 0x70);
pub const BPF_JSLT = @as(c_int, 0xc0);
pub const BPF_JSLE = @as(c_int, 0xd0);
pub const BPF_JCOND = @as(c_int, 0xe0);
pub const BPF_CALL = @as(c_int, 0x80);
pub const BPF_EXIT = @as(c_int, 0x90);
pub const BPF_FETCH = @as(c_int, 0x01);
pub const BPF_XCHG = @as(c_int, 0xe0) | BPF_FETCH;
pub const BPF_CMPXCHG = @as(c_int, 0xf0) | BPF_FETCH;
pub const MAX_BPF_REG = __MAX_BPF_REG;
pub const MAX_BPF_ATTACH_TYPE = __MAX_BPF_ATTACH_TYPE;
pub const MAX_BPF_LINK_TYPE = __MAX_BPF_LINK_TYPE;
pub const BPF_F_ALLOW_OVERRIDE = @as(c_uint, 1) << @as(c_int, 0);
pub const BPF_F_ALLOW_MULTI = @as(c_uint, 1) << @as(c_int, 1);
pub const BPF_F_REPLACE = @as(c_uint, 1) << @as(c_int, 2);
pub const BPF_F_BEFORE = @as(c_uint, 1) << @as(c_int, 3);
pub const BPF_F_AFTER = @as(c_uint, 1) << @as(c_int, 4);
pub const BPF_F_ID = @as(c_uint, 1) << @as(c_int, 5);
pub const BPF_F_STRICT_ALIGNMENT = @as(c_uint, 1) << @as(c_int, 0);
pub const BPF_F_ANY_ALIGNMENT = @as(c_uint, 1) << @as(c_int, 1);
pub const BPF_F_TEST_RND_HI32 = @as(c_uint, 1) << @as(c_int, 2);
pub const BPF_F_TEST_STATE_FREQ = @as(c_uint, 1) << @as(c_int, 3);
pub const BPF_F_SLEEPABLE = @as(c_uint, 1) << @as(c_int, 4);
pub const BPF_F_XDP_HAS_FRAGS = @as(c_uint, 1) << @as(c_int, 5);
pub const BPF_F_XDP_DEV_BOUND_ONLY = @as(c_uint, 1) << @as(c_int, 6);
pub const BPF_F_TEST_REG_INVARIANTS = @as(c_uint, 1) << @as(c_int, 7);
pub const BPF_F_NETFILTER_IP_DEFRAG = @as(c_uint, 1) << @as(c_int, 0);
pub const BPF_PSEUDO_MAP_FD = @as(c_int, 1);
pub const BPF_PSEUDO_MAP_IDX = @as(c_int, 5);
pub const BPF_PSEUDO_MAP_VALUE = @as(c_int, 2);
pub const BPF_PSEUDO_MAP_IDX_VALUE = @as(c_int, 6);
pub const BPF_PSEUDO_BTF_ID = @as(c_int, 3);
pub const BPF_PSEUDO_FUNC = @as(c_int, 4);
pub const BPF_PSEUDO_CALL = @as(c_int, 1);
pub const BPF_PSEUDO_KFUNC_CALL = @as(c_int, 2);
pub const BPF_F_QUERY_EFFECTIVE = @as(c_uint, 1) << @as(c_int, 0);
pub const BPF_F_TEST_RUN_ON_CPU = @as(c_uint, 1) << @as(c_int, 0);
pub const BPF_F_TEST_XDP_LIVE_FRAMES = @as(c_uint, 1) << @as(c_int, 1);
pub const BPF_BUILD_ID_SIZE = @as(c_int, 20);
pub const BPF_OBJ_NAME_LEN = @as(c_uint, 16);
pub const ___BPF_FUNC_MAPPER = @compileError("unable to translate C expr: expected ')' instead got '...'");
// /usr/include/linux/bpf.h:5794:9
pub const __BPF_FUNC_MAPPER_APPLY = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/linux/bpf.h:6012:9
pub inline fn __BPF_FUNC_MAPPER(FN: anytype) @TypeOf(___BPF_FUNC_MAPPER(__BPF_FUNC_MAPPER_APPLY, FN)) {
    _ = &FN;
    return ___BPF_FUNC_MAPPER(__BPF_FUNC_MAPPER_APPLY, FN);
}
pub const __BPF_ENUM_FN = @compileError("unable to translate macro: undefined identifier `BPF_FUNC_`");
// /usr/include/linux/bpf.h:6018:9
pub inline fn BPF_F_ADJ_ROOM_ENCAP_L2(len: anytype) @TypeOf((@import("std").zig.c_translation.cast(__u64, len) & BPF_ADJ_ROOM_ENCAP_L2_MASK) << BPF_ADJ_ROOM_ENCAP_L2_SHIFT) {
    _ = &len;
    return (@import("std").zig.c_translation.cast(__u64, len) & BPF_ADJ_ROOM_ENCAP_L2_MASK) << BPF_ADJ_ROOM_ENCAP_L2_SHIFT;
}
pub const __bpf_md_ptr = @compileError("unable to translate macro: undefined identifier `aligned`");
// /usr/include/linux/bpf.h:6204:9
pub const XDP_PACKET_HEADROOM = @as(c_int, 256);
pub const BPF_TAG_SIZE = @as(c_int, 8);
pub inline fn BPF_LINE_INFO_LINE_NUM(line_col: anytype) @TypeOf(line_col >> @as(c_int, 10)) {
    _ = &line_col;
    return line_col >> @as(c_int, 10);
}
pub inline fn BPF_LINE_INFO_LINE_COL(line_col: anytype) @TypeOf(line_col & @as(c_int, 0x3ff)) {
    _ = &line_col;
    return line_col & @as(c_int, 0x3ff);
}
pub const LF = @import("std").zig.c_translation.cast(u_char, '\n');
pub const CR = @import("std").zig.c_translation.cast(u_char, '\r');
pub const CRLF = "\r\n";
pub inline fn ngx_abs(value: anytype) @TypeOf(if (value >= @as(c_int, 0)) value else -value) {
    _ = &value;
    return if (value >= @as(c_int, 0)) value else -value;
}
pub inline fn ngx_max(val1: anytype, val2: anytype) @TypeOf(if (val1 < val2) val2 else val1) {
    _ = &val1;
    _ = &val2;
    return if (val1 < val2) val2 else val1;
}
pub inline fn ngx_min(val1: anytype, val2: anytype) @TypeOf(if (val1 > val2) val2 else val1) {
    _ = &val1;
    _ = &val2;
    return if (val1 > val2) val2 else val1;
}
pub const NGX_DISABLE_SYMLINKS_OFF = @as(c_int, 0);
pub const NGX_DISABLE_SYMLINKS_ON = @as(c_int, 1);
pub const NGX_DISABLE_SYMLINKS_NOTOWNER = @as(c_int, 2);
pub const _NGX_HTTP_VARIABLES_H_INCLUDED_ = "";
pub const ngx_http_variable = @compileError("unable to translate C expr: unexpected token '{'");
// src/http/ngx_http_variables.h:19:9
pub const NGX_HTTP_VAR_CHANGEABLE = @as(c_int, 1);
pub const NGX_HTTP_VAR_NOCACHEABLE = @as(c_int, 2);
pub const NGX_HTTP_VAR_INDEXED = @as(c_int, 4);
pub const NGX_HTTP_VAR_NOHASH = @as(c_int, 8);
pub const NGX_HTTP_VAR_WEAK = @as(c_int, 16);
pub const NGX_HTTP_VAR_PREFIX = @as(c_int, 32);
pub const ngx_http_null_variable = @compileError("unable to translate C expr: unexpected token '{'");
// src/http/ngx_http_variables.h:46:9
pub const _NGX_HTTP_CONFIG_H_INCLUDED_ = "";
pub const NGX_HTTP_MODULE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x50545448, .hex);
pub const NGX_HTTP_MAIN_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const NGX_HTTP_SRV_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x04000000, .hex);
pub const NGX_HTTP_LOC_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x08000000, .hex);
pub const NGX_HTTP_UPS_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000000, .hex);
pub const NGX_HTTP_SIF_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const NGX_HTTP_LIF_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const NGX_HTTP_LMT_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const NGX_HTTP_MAIN_CONF_OFFSET = @compileError("unable to translate macro: undefined identifier `main_conf`");
// src/http/ngx_http_config.h:50:9
pub const NGX_HTTP_SRV_CONF_OFFSET = @compileError("unable to translate macro: undefined identifier `srv_conf`");
// src/http/ngx_http_config.h:51:9
pub const NGX_HTTP_LOC_CONF_OFFSET = @compileError("unable to translate macro: undefined identifier `loc_conf`");
// src/http/ngx_http_config.h:52:9
pub inline fn ngx_http_get_module_main_conf(r: anytype, module: anytype) @TypeOf(r.*.main_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &r;
    _ = &module;
    return r.*.main_conf[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_http_get_module_srv_conf(r: anytype, module: anytype) @TypeOf(r.*.srv_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &r;
    _ = &module;
    return r.*.srv_conf[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_http_get_module_loc_conf(r: anytype, module: anytype) @TypeOf(r.*.loc_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &r;
    _ = &module;
    return r.*.loc_conf[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_http_conf_get_module_main_conf(cf: anytype, module: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cf.*.ctx).*.main_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &cf;
    _ = &module;
    return @import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cf.*.ctx).*.main_conf[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_http_conf_get_module_srv_conf(cf: anytype, module: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cf.*.ctx).*.srv_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &cf;
    _ = &module;
    return @import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cf.*.ctx).*.srv_conf[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_http_conf_get_module_loc_conf(cf: anytype, module: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cf.*.ctx).*.loc_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &cf;
    _ = &module;
    return @import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cf.*.ctx).*.loc_conf[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_http_cycle_get_module_main_conf(cycle: anytype, module: anytype) @TypeOf(if (cycle.*.conf_ctx[@as(usize, @intCast(ngx_http_module.index))]) @import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cycle.*.conf_ctx[@as(usize, @intCast(ngx_http_module.index))]).*.main_conf[@as(usize, @intCast(module.ctx_index))] else NULL) {
    _ = &cycle;
    _ = &module;
    return if (cycle.*.conf_ctx[@as(usize, @intCast(ngx_http_module.index))]) @import("std").zig.c_translation.cast([*c]ngx_http_conf_ctx_t, cycle.*.conf_ctx[@as(usize, @intCast(ngx_http_module.index))]).*.main_conf[@as(usize, @intCast(module.ctx_index))] else NULL;
}
pub const _NGX_HTTP_REQUEST_H_INCLUDED_ = "";
pub const NGX_HTTP_MAX_URI_CHANGES = @as(c_int, 10);
pub const NGX_HTTP_MAX_SUBREQUESTS = @as(c_int, 50);
pub const NGX_HTTP_LC_HEADER_LEN = @as(c_int, 32);
pub const NGX_HTTP_DISCARD_BUFFER_SIZE = @as(c_int, 4096);
pub const NGX_HTTP_LINGERING_BUFFER_SIZE = @as(c_int, 4096);
pub const NGX_HTTP_VERSION_9 = @as(c_int, 9);
pub const NGX_HTTP_VERSION_10 = @as(c_int, 1000);
pub const NGX_HTTP_VERSION_11 = @as(c_int, 1001);
pub const NGX_HTTP_VERSION_20 = @as(c_int, 2000);
pub const NGX_HTTP_VERSION_30 = @as(c_int, 3000);
pub const NGX_HTTP_UNKNOWN = @as(c_int, 0x00000001);
pub const NGX_HTTP_GET = @as(c_int, 0x00000002);
pub const NGX_HTTP_HEAD = @as(c_int, 0x00000004);
pub const NGX_HTTP_POST = @as(c_int, 0x00000008);
pub const NGX_HTTP_PUT = @as(c_int, 0x00000010);
pub const NGX_HTTP_DELETE = @as(c_int, 0x00000020);
pub const NGX_HTTP_MKCOL = @as(c_int, 0x00000040);
pub const NGX_HTTP_COPY = @as(c_int, 0x00000080);
pub const NGX_HTTP_MOVE = @as(c_int, 0x00000100);
pub const NGX_HTTP_OPTIONS = @as(c_int, 0x00000200);
pub const NGX_HTTP_PROPFIND = @as(c_int, 0x00000400);
pub const NGX_HTTP_PROPPATCH = @as(c_int, 0x00000800);
pub const NGX_HTTP_LOCK = @as(c_int, 0x00001000);
pub const NGX_HTTP_UNLOCK = @as(c_int, 0x00002000);
pub const NGX_HTTP_PATCH = @as(c_int, 0x00004000);
pub const NGX_HTTP_TRACE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00008000, .hex);
pub const NGX_HTTP_CONNECT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hex);
pub const NGX_HTTP_CONNECTION_CLOSE = @as(c_int, 1);
pub const NGX_HTTP_CONNECTION_KEEP_ALIVE = @as(c_int, 2);
pub const NGX_NONE = @as(c_int, 1);
pub const NGX_HTTP_PARSE_HEADER_DONE = @as(c_int, 1);
pub const NGX_HTTP_CLIENT_ERROR = @as(c_int, 10);
pub const NGX_HTTP_PARSE_INVALID_METHOD = @as(c_int, 10);
pub const NGX_HTTP_PARSE_INVALID_REQUEST = @as(c_int, 11);
pub const NGX_HTTP_PARSE_INVALID_VERSION = @as(c_int, 12);
pub const NGX_HTTP_PARSE_INVALID_09_METHOD = @as(c_int, 13);
pub const NGX_HTTP_PARSE_INVALID_HEADER = @as(c_int, 14);
pub const NGX_HTTP_SUBREQUEST_IN_MEMORY = @as(c_int, 2);
pub const NGX_HTTP_SUBREQUEST_WAITED = @as(c_int, 4);
pub const NGX_HTTP_SUBREQUEST_CLONE = @as(c_int, 8);
pub const NGX_HTTP_SUBREQUEST_BACKGROUND = @as(c_int, 16);
pub const NGX_HTTP_LOG_UNSAFE = @as(c_int, 1);
pub const NGX_HTTP_CONTINUE = @as(c_int, 100);
pub const NGX_HTTP_SWITCHING_PROTOCOLS = @as(c_int, 101);
pub const NGX_HTTP_PROCESSING = @as(c_int, 102);
pub const NGX_HTTP_OK = @as(c_int, 200);
pub const NGX_HTTP_CREATED = @as(c_int, 201);
pub const NGX_HTTP_ACCEPTED = @as(c_int, 202);
pub const NGX_HTTP_NO_CONTENT = @as(c_int, 204);
pub const NGX_HTTP_PARTIAL_CONTENT = @as(c_int, 206);
pub const NGX_HTTP_SPECIAL_RESPONSE = @as(c_int, 300);
pub const NGX_HTTP_MOVED_PERMANENTLY = @as(c_int, 301);
pub const NGX_HTTP_MOVED_TEMPORARILY = @as(c_int, 302);
pub const NGX_HTTP_SEE_OTHER = @as(c_int, 303);
pub const NGX_HTTP_NOT_MODIFIED = @as(c_int, 304);
pub const NGX_HTTP_TEMPORARY_REDIRECT = @as(c_int, 307);
pub const NGX_HTTP_PERMANENT_REDIRECT = @as(c_int, 308);
pub const NGX_HTTP_BAD_REQUEST = @as(c_int, 400);
pub const NGX_HTTP_UNAUTHORIZED = @as(c_int, 401);
pub const NGX_HTTP_FORBIDDEN = @as(c_int, 403);
pub const NGX_HTTP_NOT_FOUND = @as(c_int, 404);
pub const NGX_HTTP_NOT_ALLOWED = @as(c_int, 405);
pub const NGX_HTTP_REQUEST_TIME_OUT = @as(c_int, 408);
pub const NGX_HTTP_CONFLICT = @as(c_int, 409);
pub const NGX_HTTP_LENGTH_REQUIRED = @as(c_int, 411);
pub const NGX_HTTP_PRECONDITION_FAILED = @as(c_int, 412);
pub const NGX_HTTP_REQUEST_ENTITY_TOO_LARGE = @as(c_int, 413);
pub const NGX_HTTP_REQUEST_URI_TOO_LARGE = @as(c_int, 414);
pub const NGX_HTTP_UNSUPPORTED_MEDIA_TYPE = @as(c_int, 415);
pub const NGX_HTTP_RANGE_NOT_SATISFIABLE = @as(c_int, 416);
pub const NGX_HTTP_MISDIRECTED_REQUEST = @as(c_int, 421);
pub const NGX_HTTP_TOO_MANY_REQUESTS = @as(c_int, 429);
pub const NGX_HTTP_CLOSE = @as(c_int, 444);
pub const NGX_HTTP_NGINX_CODES = @as(c_int, 494);
pub const NGX_HTTP_REQUEST_HEADER_TOO_LARGE = @as(c_int, 494);
pub const NGX_HTTPS_CERT_ERROR = @as(c_int, 495);
pub const NGX_HTTPS_NO_CERT = @as(c_int, 496);
pub const NGX_HTTP_TO_HTTPS = @as(c_int, 497);
pub const NGX_HTTP_CLIENT_CLOSED_REQUEST = @as(c_int, 499);
pub const NGX_HTTP_INTERNAL_SERVER_ERROR = @as(c_int, 500);
pub const NGX_HTTP_NOT_IMPLEMENTED = @as(c_int, 501);
pub const NGX_HTTP_BAD_GATEWAY = @as(c_int, 502);
pub const NGX_HTTP_SERVICE_UNAVAILABLE = @as(c_int, 503);
pub const NGX_HTTP_GATEWAY_TIME_OUT = @as(c_int, 504);
pub const NGX_HTTP_VERSION_NOT_SUPPORTED = @as(c_int, 505);
pub const NGX_HTTP_INSUFFICIENT_STORAGE = @as(c_int, 507);
pub const NGX_HTTP_LOWLEVEL_BUFFERED = @as(c_int, 0xf0);
pub const NGX_HTTP_WRITE_BUFFERED = @as(c_int, 0x10);
pub const NGX_HTTP_GZIP_BUFFERED = @as(c_int, 0x20);
pub const NGX_HTTP_SSI_BUFFERED = @as(c_int, 0x01);
pub const NGX_HTTP_SUB_BUFFERED = @as(c_int, 0x02);
pub const NGX_HTTP_COPY_BUFFERED = @as(c_int, 0x04);
pub inline fn ngx_http_ephemeral(r: anytype) ?*anyopaque {
    _ = &r;
    return @import("std").zig.c_translation.cast(?*anyopaque, &r.*.uri_start);
}
pub const ngx_http_set_log_request = @compileError("unable to translate C expr: unexpected token '='");
// src/http/ngx_http_request.h:619:9
pub const _NGX_HTTP_SCRIPT_H_INCLUDED_ = "";
pub const _NGX_HTTP_UPSTREAM_H_INCLUDED_ = "";
pub const _NGX_EVENT_H_INCLUDED_ = "";
pub const NGX_INVALID_INDEX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xd0d0d0d0, .hex);
pub const NGX_USE_LEVEL_EVENT = @as(c_int, 0x00000001);
pub const NGX_USE_ONESHOT_EVENT = @as(c_int, 0x00000002);
pub const NGX_USE_CLEAR_EVENT = @as(c_int, 0x00000004);
pub const NGX_USE_KQUEUE_EVENT = @as(c_int, 0x00000008);
pub const NGX_USE_LOWAT_EVENT = @as(c_int, 0x00000010);
pub const NGX_USE_GREEDY_EVENT = @as(c_int, 0x00000020);
pub const NGX_USE_EPOLL_EVENT = @as(c_int, 0x00000040);
pub const NGX_USE_RTSIG_EVENT = @as(c_int, 0x00000080);
pub const NGX_USE_AIO_EVENT = @as(c_int, 0x00000100);
pub const NGX_USE_IOCP_EVENT = @as(c_int, 0x00000200);
pub const NGX_USE_FD_EVENT = @as(c_int, 0x00000400);
pub const NGX_USE_TIMER_EVENT = @as(c_int, 0x00000800);
pub const NGX_USE_EVENTPORT_EVENT = @as(c_int, 0x00001000);
pub const NGX_USE_VNODE_EVENT = @as(c_int, 0x00002000);
pub const NGX_CLOSE_EVENT = @as(c_int, 1);
pub const NGX_DISABLE_EVENT = @as(c_int, 2);
pub const NGX_FLUSH_EVENT = @as(c_int, 4);
pub const NGX_LOWAT_EVENT = @as(c_int, 0);
pub const NGX_VNODE_EVENT = @as(c_int, 0);
pub const NGX_READ_EVENT = EPOLLIN | EPOLLRDHUP;
pub const NGX_WRITE_EVENT = EPOLLOUT;
pub const NGX_LEVEL_EVENT = @as(c_int, 0);
pub const NGX_CLEAR_EVENT = EPOLLET;
pub const NGX_ONESHOT_EVENT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x70000000, .hex);
pub const NGX_EXCLUSIVE_EVENT = EPOLLEXCLUSIVE;
pub inline fn ngx_process_events(arg_234: [*c]ngx_cycle_t, arg_235: ngx_msec_t, arg_236: ngx_uint_t) ngx_int_t {
    return ngx_event_actions.process_events.?(arg_234, arg_235, arg_236);
}
pub inline fn ngx_done_events(arg_237: [*c]ngx_cycle_t) void {
    return ngx_event_actions.done.?(arg_237);
}
pub inline fn ngx_add_event(arg_238: [*c]ngx_event_t, arg_239: ngx_int_t, arg_240: ngx_uint_t) ngx_int_t {
    return ngx_event_actions.add.?(arg_238, arg_239, arg_240);
}
pub inline fn ngx_del_event(arg_241: [*c]ngx_event_t, arg_242: ngx_int_t, arg_243: ngx_uint_t) ngx_int_t {
    return ngx_event_actions.del.?(arg_241, arg_242, arg_243);
}
pub inline fn ngx_add_conn(arg_244: [*c]ngx_connection_t) ngx_int_t {
    return ngx_event_actions.add_conn.?(arg_244);
}
pub inline fn ngx_del_conn(arg_245: [*c]ngx_connection_t, arg_246: ngx_uint_t) ngx_int_t {
    return ngx_event_actions.del_conn.?(arg_245, arg_246);
}
pub inline fn ngx_notify(arg_247: ngx_event_handler_pt) ngx_int_t {
    return ngx_event_actions.notify.?(arg_247);
}
pub const ngx_add_timer = @compileError("unable to translate macro: undefined identifier `ngx_event_add_timer`");
// src/event/ngx_event.h:410:9
pub const ngx_del_timer = ngx_event_del_timer;
pub inline fn ngx_recv(arg_248: [*c]ngx_connection_t, arg_249: [*c]u_char, arg_250: usize) isize {
    return ngx_io.recv.?(arg_248, arg_249, arg_250);
}
pub inline fn ngx_recv_chain(arg_251: [*c]ngx_connection_t, arg_252: [*c]ngx_chain_t, arg_253: off_t) isize {
    return ngx_io.recv_chain.?(arg_251, arg_252, arg_253);
}
pub inline fn ngx_udp_recv(arg_254: [*c]ngx_connection_t, arg_255: [*c]u_char, arg_256: usize) isize {
    return ngx_io.udp_recv.?(arg_254, arg_255, arg_256);
}
pub inline fn ngx_send(arg_257: [*c]ngx_connection_t, arg_258: [*c]u_char, arg_259: usize) isize {
    return ngx_io.send.?(arg_257, arg_258, arg_259);
}
pub inline fn ngx_send_chain(arg_260: [*c]ngx_connection_t, arg_261: [*c]ngx_chain_t, arg_262: off_t) [*c]ngx_chain_t {
    return ngx_io.send_chain.?(arg_260, arg_261, arg_262);
}
pub inline fn ngx_udp_send(arg_263: [*c]ngx_connection_t, arg_264: [*c]u_char, arg_265: usize) isize {
    return ngx_io.udp_send.?(arg_263, arg_264, arg_265);
}
pub inline fn ngx_udp_send_chain(arg_266: [*c]ngx_connection_t, arg_267: [*c]ngx_chain_t, arg_268: off_t) [*c]ngx_chain_t {
    return ngx_io.udp_send_chain.?(arg_266, arg_267, arg_268);
}
pub const NGX_EVENT_MODULE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x544E5645, .hex);
pub const NGX_EVENT_CONF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hex);
pub const NGX_UPDATE_TIME = @as(c_int, 1);
pub const NGX_POST_EVENTS = @as(c_int, 2);
pub inline fn ngx_event_get_conf(conf_ctx: anytype, module: anytype) @TypeOf(ngx_get_conf(conf_ctx, ngx_events_module).*[@as(usize, @intCast(module.ctx_index))]) {
    _ = &conf_ctx;
    _ = &module;
    return ngx_get_conf(conf_ctx, ngx_events_module).*[@as(usize, @intCast(module.ctx_index))];
}
pub inline fn ngx_event_ident(p: anytype) @TypeOf(@import("std").zig.c_translation.cast([*c]ngx_connection_t, p).*.fd) {
    _ = &p;
    return @import("std").zig.c_translation.cast([*c]ngx_connection_t, p).*.fd;
}
pub const _NGX_EVENT_TIMER_H_INCLUDED_ = "";
pub const NGX_TIMER_INFINITE = @import("std").zig.c_translation.cast(ngx_msec_t, -@as(c_int, 1));
pub const NGX_TIMER_LAZY_DELAY = @as(c_int, 300);
pub const _NGX_EVENT_POSTED_H_INCLUDED_ = "";
pub const ngx_post_event = @compileError("unable to translate C expr: unexpected token 'if'");
// src/event/ngx_event_posted.h:17:9
pub const ngx_delete_posted_event = @compileError("unable to translate C expr: unexpected token '='");
// src/event/ngx_event_posted.h:31:9
pub const _NGX_EVENT_UDP_H_INCLUDED_ = "";
pub const NGX_HAVE_ADDRINFO_CMSG = @as(c_int, 1);
pub const _NGX_EVENT_CONNECT_H_INCLUDED_ = "";
pub const NGX_PEER_KEEPALIVE = @as(c_int, 1);
pub const NGX_PEER_NEXT = @as(c_int, 2);
pub const NGX_PEER_FAILED = @as(c_int, 4);
pub const _NGX_EVENT_PIPE_H_INCLUDED_ = "";
pub const NGX_HTTP_UPSTREAM_FT_ERROR = @as(c_int, 0x00000002);
pub const NGX_HTTP_UPSTREAM_FT_TIMEOUT = @as(c_int, 0x00000004);
pub const NGX_HTTP_UPSTREAM_FT_INVALID_HEADER = @as(c_int, 0x00000008);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_500 = @as(c_int, 0x00000010);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_502 = @as(c_int, 0x00000020);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_503 = @as(c_int, 0x00000040);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_504 = @as(c_int, 0x00000080);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_403 = @as(c_int, 0x00000100);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_404 = @as(c_int, 0x00000200);
pub const NGX_HTTP_UPSTREAM_FT_HTTP_429 = @as(c_int, 0x00000400);
pub const NGX_HTTP_UPSTREAM_FT_UPDATING = @as(c_int, 0x00000800);
pub const NGX_HTTP_UPSTREAM_FT_BUSY_LOCK = @as(c_int, 0x00001000);
pub const NGX_HTTP_UPSTREAM_FT_MAX_WAITING = @as(c_int, 0x00002000);
pub const NGX_HTTP_UPSTREAM_FT_NON_IDEMPOTENT = @as(c_int, 0x00004000);
pub const NGX_HTTP_UPSTREAM_FT_NOLIVE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const NGX_HTTP_UPSTREAM_FT_OFF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub const NGX_HTTP_UPSTREAM_FT_STATUS = (((((NGX_HTTP_UPSTREAM_FT_HTTP_500 | NGX_HTTP_UPSTREAM_FT_HTTP_502) | NGX_HTTP_UPSTREAM_FT_HTTP_503) | NGX_HTTP_UPSTREAM_FT_HTTP_504) | NGX_HTTP_UPSTREAM_FT_HTTP_403) | NGX_HTTP_UPSTREAM_FT_HTTP_404) | NGX_HTTP_UPSTREAM_FT_HTTP_429;
pub const NGX_HTTP_UPSTREAM_INVALID_HEADER = @as(c_int, 40);
pub const NGX_HTTP_UPSTREAM_IGN_XA_REDIRECT = @as(c_int, 0x00000002);
pub const NGX_HTTP_UPSTREAM_IGN_XA_EXPIRES = @as(c_int, 0x00000004);
pub const NGX_HTTP_UPSTREAM_IGN_EXPIRES = @as(c_int, 0x00000008);
pub const NGX_HTTP_UPSTREAM_IGN_CACHE_CONTROL = @as(c_int, 0x00000010);
pub const NGX_HTTP_UPSTREAM_IGN_SET_COOKIE = @as(c_int, 0x00000020);
pub const NGX_HTTP_UPSTREAM_IGN_XA_LIMIT_RATE = @as(c_int, 0x00000040);
pub const NGX_HTTP_UPSTREAM_IGN_XA_BUFFERING = @as(c_int, 0x00000080);
pub const NGX_HTTP_UPSTREAM_IGN_XA_CHARSET = @as(c_int, 0x00000100);
pub const NGX_HTTP_UPSTREAM_IGN_VARY = @as(c_int, 0x00000200);
pub const NGX_HTTP_UPSTREAM_CREATE = @as(c_int, 0x0001);
pub const NGX_HTTP_UPSTREAM_WEIGHT = @as(c_int, 0x0002);
pub const NGX_HTTP_UPSTREAM_MAX_FAILS = @as(c_int, 0x0004);
pub const NGX_HTTP_UPSTREAM_FAIL_TIMEOUT = @as(c_int, 0x0008);
pub const NGX_HTTP_UPSTREAM_DOWN = @as(c_int, 0x0010);
pub const NGX_HTTP_UPSTREAM_BACKUP = @as(c_int, 0x0020);
pub const NGX_HTTP_UPSTREAM_MODIFY = @as(c_int, 0x0040);
pub const NGX_HTTP_UPSTREAM_MAX_CONNS = @as(c_int, 0x0100);
pub inline fn ngx_http_conf_upstream_srv_conf(uscf: anytype, module: anytype) @TypeOf(uscf.*.srv_conf[@as(usize, @intCast(module.ctx_index))]) {
    _ = &uscf;
    _ = &module;
    return uscf.*.srv_conf[@as(usize, @intCast(module.ctx_index))];
}
pub const _NGX_HTTP_UPSTREAM_ROUND_ROBIN_H_INCLUDED_ = "";
pub const ngx_http_upstream_rr_peers_rlock = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_upstream_round_robin.h:107:9
pub const ngx_http_upstream_rr_peers_wlock = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_upstream_round_robin.h:113:9
pub const ngx_http_upstream_rr_peers_unlock = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_upstream_round_robin.h:119:9
pub const ngx_http_upstream_rr_peer_lock = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_upstream_round_robin.h:126:9
pub const ngx_http_upstream_rr_peer_unlock = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_upstream_round_robin.h:132:9
pub const ngx_http_upstream_rr_peer_ref = @compileError("TODO postfix inc/dec expr");
// src/http/ngx_http_upstream_round_robin.h:139:9
pub const _NGX_HTTP_CORE_H_INCLUDED_ = "";
pub const NGX_HTTP_GZIP_PROXIED_OFF = @as(c_int, 0x0002);
pub const NGX_HTTP_GZIP_PROXIED_EXPIRED = @as(c_int, 0x0004);
pub const NGX_HTTP_GZIP_PROXIED_NO_CACHE = @as(c_int, 0x0008);
pub const NGX_HTTP_GZIP_PROXIED_NO_STORE = @as(c_int, 0x0010);
pub const NGX_HTTP_GZIP_PROXIED_PRIVATE = @as(c_int, 0x0020);
pub const NGX_HTTP_GZIP_PROXIED_NO_LM = @as(c_int, 0x0040);
pub const NGX_HTTP_GZIP_PROXIED_NO_ETAG = @as(c_int, 0x0080);
pub const NGX_HTTP_GZIP_PROXIED_AUTH = @as(c_int, 0x0100);
pub const NGX_HTTP_GZIP_PROXIED_ANY = @as(c_int, 0x0200);
pub const NGX_HTTP_AIO_OFF = @as(c_int, 0);
pub const NGX_HTTP_AIO_ON = @as(c_int, 1);
pub const NGX_HTTP_AIO_THREADS = @as(c_int, 2);
pub const NGX_HTTP_SATISFY_ALL = @as(c_int, 0);
pub const NGX_HTTP_SATISFY_ANY = @as(c_int, 1);
pub const NGX_HTTP_LINGERING_OFF = @as(c_int, 0);
pub const NGX_HTTP_LINGERING_ON = @as(c_int, 1);
pub const NGX_HTTP_LINGERING_ALWAYS = @as(c_int, 2);
pub const NGX_HTTP_IMS_OFF = @as(c_int, 0);
pub const NGX_HTTP_IMS_EXACT = @as(c_int, 1);
pub const NGX_HTTP_IMS_BEFORE = @as(c_int, 2);
pub const NGX_HTTP_KEEPALIVE_DISABLE_NONE = @as(c_int, 0x0002);
pub const NGX_HTTP_KEEPALIVE_DISABLE_MSIE6 = @as(c_int, 0x0004);
pub const NGX_HTTP_KEEPALIVE_DISABLE_SAFARI = @as(c_int, 0x0008);
pub const NGX_HTTP_SERVER_TOKENS_OFF = @as(c_int, 0);
pub const NGX_HTTP_SERVER_TOKENS_ON = @as(c_int, 1);
pub const NGX_HTTP_SERVER_TOKENS_BUILD = @as(c_int, 2);
pub const ngx_http_clear_content_length = @compileError("unable to translate C expr: unexpected token '='");
// src/http/ngx_http_core_module.h:553:9
pub const ngx_http_clear_accept_ranges = @compileError("unable to translate C expr: unexpected token '='");
// src/http/ngx_http_core_module.h:561:9
pub const ngx_http_clear_last_modified = @compileError("unable to translate C expr: unexpected token '='");
// src/http/ngx_http_core_module.h:569:9
pub const ngx_http_clear_location = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_core_module.h:577:9
pub const ngx_http_clear_etag = @compileError("unable to translate C expr: unexpected token 'if'");
// src/http/ngx_http_core_module.h:584:9
pub const _NGX_HTTP_CACHE_H_INCLUDED_ = "";
pub const NGX_HTTP_CACHE_MISS = @as(c_int, 1);
pub const NGX_HTTP_CACHE_BYPASS = @as(c_int, 2);
pub const NGX_HTTP_CACHE_EXPIRED = @as(c_int, 3);
pub const NGX_HTTP_CACHE_STALE = @as(c_int, 4);
pub const NGX_HTTP_CACHE_UPDATING = @as(c_int, 5);
pub const NGX_HTTP_CACHE_REVALIDATED = @as(c_int, 6);
pub const NGX_HTTP_CACHE_HIT = @as(c_int, 7);
pub const NGX_HTTP_CACHE_SCARCE = @as(c_int, 8);
pub const NGX_HTTP_CACHE_KEY_LEN = @as(c_int, 16);
pub const NGX_HTTP_CACHE_ETAG_LEN = @as(c_int, 128);
pub const NGX_HTTP_CACHE_VARY_LEN = @as(c_int, 128);
pub const NGX_HTTP_CACHE_VERSION = @as(c_int, 5);
pub const _NGX_HTTP_SSI_FILTER_H_INCLUDED_ = "";
pub const NGX_HTTP_SSI_MAX_PARAMS = @as(c_int, 16);
pub const NGX_HTTP_SSI_COMMAND_LEN = @as(c_int, 32);
pub const NGX_HTTP_SSI_PARAM_LEN = @as(c_int, 32);
pub const NGX_HTTP_SSI_PARAMS_N = @as(c_int, 4);
pub const NGX_HTTP_SSI_COND_IF = @as(c_int, 1);
pub const NGX_HTTP_SSI_COND_ELSE = @as(c_int, 2);
pub const NGX_HTTP_SSI_NO_ENCODING = @as(c_int, 0);
pub const NGX_HTTP_SSI_URL_ENCODING = @as(c_int, 1);
pub const NGX_HTTP_SSI_ENTITY_ENCODING = @as(c_int, 2);
pub inline fn ngx_http_get_module_ctx(r: anytype, module: anytype) @TypeOf(r.*.ctx[@as(usize, @intCast(module.ctx_index))]) {
    _ = &r;
    _ = &module;
    return r.*.ctx[@as(usize, @intCast(module.ctx_index))];
}
pub const ngx_http_set_ctx = @compileError("unable to translate C expr: unexpected token '='");
// src/http/ngx_http.h:81:9
pub const NGX_HTTP_LAST = @as(c_int, 1);
pub const NGX_HTTP_FLUSH = @as(c_int, 2);
pub const timeval = struct_timeval;
pub const timespec = struct_timespec;
pub const __pthread_internal_list = struct___pthread_internal_list;
pub const __pthread_internal_slist = struct___pthread_internal_slist;
pub const __pthread_mutex_s = struct___pthread_mutex_s;
pub const __pthread_rwlock_arch_t = struct___pthread_rwlock_arch_t;
pub const __pthread_cond_s = struct___pthread_cond_s;
pub const __itimer_which = enum___itimer_which;
pub const itimerval = struct_itimerval;
pub const _G_fpos_t = struct__G_fpos_t;
pub const _G_fpos64_t = struct__G_fpos64_t;
pub const _IO_marker = struct__IO_marker;
pub const _IO_codecvt = struct__IO_codecvt;
pub const _IO_wide_data = struct__IO_wide_data;
pub const _IO_FILE = struct__IO_FILE;
pub const _IO_cookie_io_functions_t = struct__IO_cookie_io_functions_t;
pub const obstack = struct_obstack;
pub const __locale_struct = struct___locale_struct;
pub const random_data = struct_random_data;
pub const drand48_data = struct_drand48_data;
pub const sigval = union_sigval;
pub const sigevent = struct_sigevent;
pub const _fpx_sw_bytes = struct__fpx_sw_bytes;
pub const _fpreg = struct__fpreg;
pub const _fpxreg = struct__fpxreg;
pub const _xmmreg = struct__xmmreg;
pub const _fpstate = struct__fpstate;
pub const sigcontext = struct_sigcontext;
pub const _xsave_hdr = struct__xsave_hdr;
pub const _ymmh_state = struct__ymmh_state;
pub const _xstate = struct__xstate;
pub const _libc_fpxreg = struct__libc_fpxreg;
pub const _libc_xmmreg = struct__libc_xmmreg;
pub const _libc_fpstate = struct__libc_fpstate;
pub const passwd = struct_passwd;
pub const group = struct_group;
pub const dirent = struct_dirent;
pub const dirent64 = struct_dirent64;
pub const __dirstream = struct___dirstream;
pub const iovec = struct_iovec;
pub const statx_timestamp = struct_statx_timestamp;
pub const flock = struct_flock;
pub const flock64 = struct_flock64;
pub const __pid_type = enum___pid_type;
pub const f_owner_ex = struct_f_owner_ex;
pub const file_handle = struct_file_handle;
pub const rusage = struct_rusage;
pub const __rlimit_resource = enum___rlimit_resource;
pub const rlimit = struct_rlimit;
pub const rlimit64 = struct_rlimit64;
pub const __rusage_who = enum___rusage_who;
pub const __priority_which = enum___priority_which;
pub const sched_param = struct_sched_param;
pub const __socket_type = enum___socket_type;
pub const sockaddr = struct_sockaddr;
pub const sockaddr_storage = struct_sockaddr_storage;
pub const msghdr = struct_msghdr;
pub const cmsghdr = struct_cmsghdr;
pub const ucred = struct_ucred;
pub const linger = struct_linger;
pub const osockaddr = struct_osockaddr;
pub const in_addr = struct_in_addr;
pub const sockaddr_in = struct_sockaddr_in;
pub const in6_addr = struct_in6_addr;
pub const sockaddr_in6 = struct_sockaddr_in6;
pub const sockaddr_un = struct_sockaddr_un;
pub const mmsghdr = struct_mmsghdr;
pub const ip_opts = struct_ip_opts;
pub const in_pktinfo = struct_in_pktinfo;
pub const ip_mreq = struct_ip_mreq;
pub const ip_mreqn = struct_ip_mreqn;
pub const ip_mreq_source = struct_ip_mreq_source;
pub const ipv6_mreq = struct_ipv6_mreq;
pub const group_req = struct_group_req;
pub const group_source_req = struct_group_source_req;
pub const ip_msfilter = struct_ip_msfilter;
pub const group_filter = struct_group_filter;
pub const in6_pktinfo = struct_in6_pktinfo;
pub const ip6_mtuinfo = struct_ip6_mtuinfo;
pub const tcphdr = struct_tcphdr;
pub const tcp_ca_state = enum_tcp_ca_state;
pub const tcp_info = struct_tcp_info;
pub const tcp_md5sig = struct_tcp_md5sig;
pub const tcp_repair_opt = struct_tcp_repair_opt;
pub const tcp_cookie_transactions = struct_tcp_cookie_transactions;
pub const tcp_repair_window = struct_tcp_repair_window;
pub const tcp_zerocopy_receive = struct_tcp_zerocopy_receive;
pub const rpcent = struct_rpcent;
pub const netent = struct_netent;
pub const hostent = struct_hostent;
pub const servent = struct_servent;
pub const protoent = struct_protoent;
pub const addrinfo = struct_addrinfo;
pub const gaicb = struct_gaicb;
pub const timex = struct_timex;
pub const tm = struct_tm;
pub const itimerspec = struct_itimerspec;
pub const winsize = struct_winsize;
pub const termio = struct_termio;
pub const crypt_data = struct_crypt_data;
pub const utsname = struct_utsname;
pub const dl_find_object = struct_dl_find_object;
pub const prctl_mm_map = struct_prctl_mm_map;
pub const EPOLL_EVENTS = enum_EPOLL_EVENTS;
pub const epoll_data = union_epoll_data;
pub const epoll_event = struct_epoll_event;
pub const epoll_params = struct_epoll_params;
pub const __user_cap_header_struct = struct___user_cap_header_struct;
pub const __user_cap_data_struct = struct___user_cap_data_struct;
pub const vfs_cap_data = struct_vfs_cap_data;
pub const vfs_ns_cap_data = struct_vfs_ns_cap_data;
pub const udphdr = struct_udphdr;
pub const ngx_open_file_s = struct_ngx_open_file_s;
pub const ngx_log_s = struct_ngx_log_s;
pub const ngx_file_s = struct_ngx_file_s;
pub const ngx_buf_s = struct_ngx_buf_s;
pub const ngx_chain_s = struct_ngx_chain_s;
pub const ngx_pool_large_s = struct_ngx_pool_large_s;
pub const ngx_pool_cleanup_s = struct_ngx_pool_cleanup_s;
pub const ngx_pool_s = struct_ngx_pool_s;
pub const ngx_rbtree_node_s = struct_ngx_rbtree_node_s;
pub const ngx_queue_s = struct_ngx_queue_s;
pub const ngx_event_s = struct_ngx_event_s;
pub const ngx_rbtree_s = struct_ngx_rbtree_s;
pub const ngx_listening_s = struct_ngx_listening_s;
pub const ngx_proxy_protocol_s = struct_ngx_proxy_protocol_s;
pub const ngx_udp_connection_s = struct_ngx_udp_connection_s;
pub const ngx_connection_s = struct_ngx_connection_s;
pub const ngx_cycle_s = struct_ngx_cycle_s;
pub const ngx_conf_s = struct_ngx_conf_s;
pub const ngx_command_s = struct_ngx_command_s;
pub const ngx_module_s = struct_ngx_module_s;
pub const ngx_event_aio_s = struct_ngx_event_aio_s;
pub const ngx_thread_task_s = struct_ngx_thread_task_s;
pub const ngx_ssl_s = struct_ngx_ssl_s;
pub const ngx_quic_stream_s = struct_ngx_quic_stream_s;
pub const ngx_ssl_connection_s = struct_ngx_ssl_connection_s;
pub const ngx_output_chain_ctx_s = struct_ngx_output_chain_ctx_s;
pub const ngx_list_part_s = struct_ngx_list_part_s;
pub const ngx_table_elt_s = struct_ngx_table_elt_s;
pub const ngx_tree_ctx_s = struct_ngx_tree_ctx_s;
pub const pcre2_real_general_context_8 = struct_pcre2_real_general_context_8;
pub const pcre2_real_compile_context_8 = struct_pcre2_real_compile_context_8;
pub const pcre2_real_match_context_8 = struct_pcre2_real_match_context_8;
pub const pcre2_real_convert_context_8 = struct_pcre2_real_convert_context_8;
pub const pcre2_real_code_8 = struct_pcre2_real_code_8;
pub const pcre2_real_match_data_8 = struct_pcre2_real_match_data_8;
pub const pcre2_real_jit_stack_8 = struct_pcre2_real_jit_stack_8;
pub const pcre2_real_general_context_16 = struct_pcre2_real_general_context_16;
pub const pcre2_real_compile_context_16 = struct_pcre2_real_compile_context_16;
pub const pcre2_real_match_context_16 = struct_pcre2_real_match_context_16;
pub const pcre2_real_convert_context_16 = struct_pcre2_real_convert_context_16;
pub const pcre2_real_code_16 = struct_pcre2_real_code_16;
pub const pcre2_real_match_data_16 = struct_pcre2_real_match_data_16;
pub const pcre2_real_jit_stack_16 = struct_pcre2_real_jit_stack_16;
pub const pcre2_real_general_context_32 = struct_pcre2_real_general_context_32;
pub const pcre2_real_compile_context_32 = struct_pcre2_real_compile_context_32;
pub const pcre2_real_match_context_32 = struct_pcre2_real_match_context_32;
pub const pcre2_real_convert_context_32 = struct_pcre2_real_convert_context_32;
pub const pcre2_real_code_32 = struct_pcre2_real_code_32;
pub const pcre2_real_match_data_32 = struct_pcre2_real_match_data_32;
pub const pcre2_real_jit_stack_32 = struct_pcre2_real_jit_stack_32;
pub const ngx_radix_node_s = struct_ngx_radix_node_s;
pub const ngx_slab_page_s = struct_ngx_slab_page_s;
pub const ngx_shm_zone_s = struct_ngx_shm_zone_s;
pub const ngx_resolver_s = struct_ngx_resolver_s;
pub const ngx_resolver_ctx_s = struct_ngx_resolver_ctx_s;
pub const ngx_cached_open_file_s = struct_ngx_cached_open_file_s;
pub const bpf_cond_pseudo_jmp = enum_bpf_cond_pseudo_jmp;
pub const bpf_insn = struct_bpf_insn;
pub const bpf_lpm_trie_key = struct_bpf_lpm_trie_key;
pub const bpf_lpm_trie_key_hdr = struct_bpf_lpm_trie_key_hdr;
pub const bpf_lpm_trie_key_u8 = struct_bpf_lpm_trie_key_u8;
pub const bpf_cgroup_storage_key = struct_bpf_cgroup_storage_key;
pub const bpf_cgroup_iter_order = enum_bpf_cgroup_iter_order;
pub const bpf_iter_link_info = union_bpf_iter_link_info;
pub const bpf_cmd = enum_bpf_cmd;
pub const bpf_map_type = enum_bpf_map_type;
pub const bpf_prog_type = enum_bpf_prog_type;
pub const bpf_attach_type = enum_bpf_attach_type;
pub const bpf_link_type = enum_bpf_link_type;
pub const bpf_perf_event_type = enum_bpf_perf_event_type;
pub const bpf_addr_space_cast = enum_bpf_addr_space_cast;
pub const bpf_stats_type = enum_bpf_stats_type;
pub const bpf_stack_build_id_status = enum_bpf_stack_build_id_status;
pub const bpf_stack_build_id = struct_bpf_stack_build_id;
pub const bpf_attr = union_bpf_attr;
pub const bpf_func_id = enum_bpf_func_id;
pub const bpf_adj_room_mode = enum_bpf_adj_room_mode;
pub const bpf_hdr_start_off = enum_bpf_hdr_start_off;
pub const bpf_lwt_encap_mode = enum_bpf_lwt_encap_mode;
pub const bpf_flow_keys = struct_bpf_flow_keys;
pub const bpf_sock = struct_bpf_sock;
pub const __sk_buff = struct___sk_buff;
pub const bpf_tunnel_key = struct_bpf_tunnel_key;
pub const bpf_xfrm_state = struct_bpf_xfrm_state;
pub const bpf_ret_code = enum_bpf_ret_code;
pub const bpf_tcp_sock = struct_bpf_tcp_sock;
pub const bpf_sock_tuple = struct_bpf_sock_tuple;
pub const tcx_action_base = enum_tcx_action_base;
pub const bpf_xdp_sock = struct_bpf_xdp_sock;
pub const xdp_action = enum_xdp_action;
pub const xdp_md = struct_xdp_md;
pub const bpf_devmap_val = struct_bpf_devmap_val;
pub const bpf_cpumap_val = struct_bpf_cpumap_val;
pub const sk_action = enum_sk_action;
pub const sk_msg_md = struct_sk_msg_md;
pub const sk_reuseport_md = struct_sk_reuseport_md;
pub const bpf_prog_info = struct_bpf_prog_info;
pub const bpf_map_info = struct_bpf_map_info;
pub const bpf_btf_info = struct_bpf_btf_info;
pub const bpf_link_info = struct_bpf_link_info;
pub const bpf_sock_addr = struct_bpf_sock_addr;
pub const bpf_sock_ops = struct_bpf_sock_ops;
pub const bpf_perf_event_value = struct_bpf_perf_event_value;
pub const bpf_cgroup_dev_ctx = struct_bpf_cgroup_dev_ctx;
pub const bpf_raw_tracepoint_args = struct_bpf_raw_tracepoint_args;
pub const bpf_fib_lookup = struct_bpf_fib_lookup;
pub const bpf_redir_neigh = struct_bpf_redir_neigh;
pub const bpf_check_mtu_flags = enum_bpf_check_mtu_flags;
pub const bpf_check_mtu_ret = enum_bpf_check_mtu_ret;
pub const bpf_task_fd_type = enum_bpf_task_fd_type;
pub const bpf_func_info = struct_bpf_func_info;
pub const bpf_line_info = struct_bpf_line_info;
pub const bpf_spin_lock = struct_bpf_spin_lock;
pub const bpf_timer = struct_bpf_timer;
pub const bpf_wq = struct_bpf_wq;
pub const bpf_dynptr = struct_bpf_dynptr;
pub const bpf_list_head = struct_bpf_list_head;
pub const bpf_list_node = struct_bpf_list_node;
pub const bpf_rb_root = struct_bpf_rb_root;
pub const bpf_rb_node = struct_bpf_rb_node;
pub const bpf_refcount = struct_bpf_refcount;
pub const bpf_sysctl = struct_bpf_sysctl;
pub const bpf_sockopt = struct_bpf_sockopt;
pub const bpf_pidns_info = struct_bpf_pidns_info;
pub const bpf_sk_lookup = struct_bpf_sk_lookup;
pub const btf_ptr = struct_btf_ptr;
pub const bpf_core_relo_kind = enum_bpf_core_relo_kind;
pub const bpf_core_relo = struct_bpf_core_relo;
pub const bpf_iter_num = struct_bpf_iter_num;
pub const ngx_http_file_cache_s = struct_ngx_http_file_cache_s;
pub const ngx_http_cache_s = struct_ngx_http_cache_s;
pub const ngx_peer_connection_s = struct_ngx_peer_connection_s;
pub const ngx_event_pipe_s = struct_ngx_event_pipe_s;
pub const ngx_http_upstream_srv_conf_s = struct_ngx_http_upstream_srv_conf_s;
pub const ngx_http_upstream_s = struct_ngx_http_upstream_s;
pub const ngx_http_postponed_request_s = struct_ngx_http_postponed_request_s;
pub const ngx_http_posted_request_s = struct_ngx_http_posted_request_s;
pub const ngx_http_v2_stream_s = struct_ngx_http_v2_stream_s;
pub const ngx_http_v3_parse_s = struct_ngx_http_v3_parse_s;
pub const ngx_http_cleanup_s = struct_ngx_http_cleanup_s;
pub const ngx_http_request_s = struct_ngx_http_request_s;
pub const ngx_http_log_ctx_s = struct_ngx_http_log_ctx_s;
pub const ngx_http_chunked_s = struct_ngx_http_chunked_s;
pub const ngx_http_v3_session_s = struct_ngx_http_v3_session_s;
pub const ngx_http_variable_s = struct_ngx_http_variable_s;
pub const ngx_http_addr_conf_s = struct_ngx_http_addr_conf_s;
pub const ngx_http_upstream_rr_peer_s = struct_ngx_http_upstream_rr_peer_s;
pub const ngx_http_upstream_rr_peers_s = struct_ngx_http_upstream_rr_peers_s;
pub const ngx_http_core_loc_conf_s = struct_ngx_http_core_loc_conf_s;
pub const ngx_http_location_tree_node_s = struct_ngx_http_location_tree_node_s;
pub const ngx_http_phase_handler_s = struct_ngx_http_phase_handler_s;
