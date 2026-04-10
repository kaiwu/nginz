const ngx = @import("ngx.zig");
const core = @import("ngx_core.zig");

pub const ngx_shm_zone_t = core.ngx_shm_zone_t;
pub const ngx_slab_pool_t = core.ngx_slab_pool_t;
pub const ngx_shmtx_t = ngx.ngx_shmtx_t;
pub const ngx_shmtx_sh_t = ngx.ngx_shmtx_sh_t;

pub const ngx_shared_memory_add = ngx.ngx_shared_memory_add;
pub const ngx_slab_init = ngx.ngx_slab_init;
pub const ngx_slab_calloc = ngx.ngx_slab_calloc;
pub const ngx_slab_alloc_locked = ngx.ngx_slab_alloc_locked;
pub const ngx_slab_calloc_locked = ngx.ngx_slab_calloc_locked;
pub const ngx_slab_free_locked = ngx.ngx_slab_free_locked;
pub const ngx_shmtx_lock = ngx.ngx_shmtx_lock;
pub const ngx_shmtx_unlock = ngx.ngx_shmtx_unlock;
