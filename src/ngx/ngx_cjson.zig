const std = @import("std");
const ngx = @import("ngx.zig");
const cjson = @import("cjson.zig");
const core = @import("ngx_core.zig");
const string = @import("ngx_string.zig");
const expectEqual = std.testing.expectEqual;

const ngx_str_t = string.ngx_str_t;
const ngx_string = string.ngx_string;

const cJSON = cjson.cJSON;
const Allocator = cjson.Allocator;
const cJSON_Parse = cjson.cJSON_Parse;
const cJSON_ParseWithLength = cjson.cJSON_ParseWithLength;
const cJSON_ParseWithOpts = cjson.cJSON_ParseWithOpts;
const cJSON_ParseWithLengthOpts = cjson.cJSON_ParseWithLengthOpts;
const cJSON_Print = cjson.cJSON_Print;
const cJSON_PrintUnformatted = cjson.cJSON_PrintUnformatted;
const cJSON_PrintBuffered = cjson.cJSON_PrintBuffered;
const cJSON_PrintPreallocated = cjson.cJSON_PrintPreallocated;
const cJSON_Delete = cjson.cJSON_Delete;
const cJSON_GetArraySize = cjson.cJSON_GetArraySize;
const cJSON_GetArrayItem = cjson.cJSON_GetArrayItem;
const cJSON_GetObjectItem = cjson.cJSON_GetObjectItem;
const cJSON_GetObjectItemCaseSensit = cjson.cJSON_GetObjectItemCaseSensit;
const cJSON_HasObjectItem = cjson.cJSON_HasObjectItem;
const cJSON_GetErrorPtr = cjson.cJSON_GetErrorPtr;
const cJSON_GetStringValue = cjson.cJSON_GetStringValue;
const cJSON_GetNumberValue = cjson.cJSON_GetNumberValue;
const cJSON_IsInvalid = cjson.cJSON_IsInvalid;
const cJSON_IsFalse = cjson.cJSON_IsFalse;
const cJSON_IsTrue = cjson.cJSON_IsTrue;
const cJSON_IsBool = cjson.cJSON_IsBool;
const cJSON_IsNull = cjson.cJSON_IsNull;
const cJSON_IsNumber = cjson.cJSON_IsNumber;
const cJSON_IsString = cjson.cJSON_IsString;
const cJSON_IsArray = cjson.cJSON_IsArray;
const cJSON_IsObject = cjson.cJSON_IsObject;
const cJSON_IsRaw = cjson.cJSON_IsRaw;
const cJSON_CreateNull = cjson.cJSON_CreateNull;
const cJSON_CreateTrue = cjson.cJSON_CreateTrue;
const cJSON_CreateFalse = cjson.cJSON_CreateFalse;
const cJSON_CreateBool = cjson.cJSON_CreateBool;
const cJSON_CreateNumber = cjson.cJSON_CreateNumber;
const cJSON_CreateString = cjson.cJSON_CreateString;
const cJSON_CreateRaw = cjson.cJSON_CreateRaw;
const cJSON_CreateArray = cjson.cJSON_CreateArray;
const cJSON_CreateObject = cjson.cJSON_CreateObject;
const cJSON_CreateStringReference = cjson.cJSON_CreateStringReference;
const cJSON_CreateObjectReference = cjson.cJSON_CreateObjectReference;
const cJSON_CreateArrayReference = cjson.cJSON_CreateArrayReference;
const cJSON_CreateIntArray = cjson.cJSON_CreateIntArray;
const cJSON_CreateFloatArray = cjson.cJSON_CreateFloatArray;
const cJSON_CreateDoubleArray = cjson.cJSON_CreateDoubleArray;
const cJSON_CreateStringArray = cjson.cJSON_CreateStringArray;
const cJSON_AddItemToArray = cjson.cJSON_AddItemToArray;
const cJSON_AddItemToObject = cjson.cJSON_AddItemToObject;
const cJSON_AddItemToObjectCS = cjson.cJSON_AddItemToObjectCS;
const cJSON_AddItemReferenceToArray = cjson.cJSON_AddItemReferenceToArray;
const cJSON_AddItemReferenceToObjec = cjson.cJSON_AddItemReferenceToObjec;
const cJSON_DetachItemViaPointer = cjson.cJSON_DetachItemViaPointer;
const cJSON_DetachItemFromArray = cjson.cJSON_DetachItemFromArray;
const cJSON_DeleteItemFromArray = cjson.cJSON_DeleteItemFromArray;
const cJSON_DetachItemFromObject = cjson.cJSON_DetachItemFromObject;
const cJSON_DetachItemFromObjectCas = cjson.cJSON_DetachItemFromObjectCas;
const cJSON_DeleteItemFromObject = cjson.cJSON_DeleteItemFromObject;
const cJSON_DeleteItemFromObjectCas = cjson.cJSON_DeleteItemFromObjectCas;
const cJSON_InsertItemInArray = cjson.cJSON_InsertItemInArray;
const cJSON_ReplaceItemViaPointer = cjson.cJSON_ReplaceItemViaPointer;
const cJSON_ReplaceItemInArray = cjson.cJSON_ReplaceItemInArray;
const cJSON_ReplaceItemInObject = cjson.cJSON_ReplaceItemInObject;
const cJSON_ReplaceItemInObjectCase = cjson.cJSON_ReplaceItemInObjectCase;
const cJSON_Duplicate = cjson.cJSON_Duplicate;
const cJSON_Compare = cjson.cJSON_Compare;
const cJSON_Minify = cjson.cJSON_Minify;
const cJSON_AddNullToObject = cjson.cJSON_AddNullToObject;
const cJSON_AddTrueToObject = cjson.cJSON_AddTrueToObject;
const cJSON_AddFalseToObject = cjson.cJSON_AddFalseToObject;
const cJSON_AddBoolToObject = cjson.cJSON_AddBoolToObject;
const cJSON_AddNumberToObject = cjson.cJSON_AddNumberToObject;
const cJSON_AddStringToObject = cjson.cJSON_AddStringToObject;
const cJSON_AddRawToObject = cjson.cJSON_AddRawToObject;
const cJSON_AddObjectToObject = cjson.cJSON_AddObjectToObject;
const cJSON_AddArrayToObject = cjson.cJSON_AddArrayToObject;
const cJSON_SetNumberHelper = cjson.cJSON_SetNumberHelper;
const cJSON_SetValuestring = cjson.cJSON_SetValuestring;
const cJSON_malloc = cjson.cJSON_malloc;
const cJSON_free = cjson.cJSON_free;

fn cjson_palloc(size: usize, ctx: ?*anyopaque) callconv(.C) ?*anyopaque {
    if (core.castPtr(core.ngx_pool_t, ctx)) |p| {
        return core.ngx_pcalloc(p, size);
    }
    return null;
}

fn cjson_pfree(p: ?*anyopaque) callconv(.C) void {
    _ = p;
}

pub const CJSON = extern struct {
    const Self = @This();
    const CJSON_BUFFER_LENTH = 512;

    alloc: Allocator,

    pub fn init(pool: [*c]core.ngx_pool_t) Self {
        return Self{
            .alloc = Allocator{
                .ctx = pool,
                .allocate = cjson_palloc,
                .deallocate = cjson_pfree,
                .reallocate = null,
            },
        };
    }

    pub fn decode(self: *Self, str: ngx_str_t) [*c]cJSON {
        return cJSON_ParseWithLength(str.data, str.len, &self.alloc);
    }

    pub fn encode(self: *Self, j: [*c]cJSON) !ngx_str_t {
        if (core.castPtr(core.ngx_pool_t, self.alloc.ctx)) |pool| {
            var size: usize = CJSON_BUFFER_LENTH;
            var len: usize = 0;
            while (core.castPtr(u8, core.ngx_pnalloc(pool, size))) |p| {
                const b = cJSON_PrintPreallocated(j, p, @as(c_int, @intCast(size)), 0, &len);
                if (b == 1) {
                    return ngx_str_t{ .len = len, .data = p };
                } else {
                    size *= 2;
                }
            }
        }
        return core.NError.OOM;
    }

    pub fn free(self: *Self, p: ?*anyopaque) void {
        cJSON_free(p, &self.alloc);
    }
};

const ngx_log_init = ngx.ngx_log_init;
const ngx_create_pool = ngx.ngx_create_pool;
const ngx_destroy_pool = ngx.ngx_destroy_pool;
test "cjson" {
    const log = ngx_log_init(core.c_str(""), core.c_str(""));
    const pool = ngx_create_pool(1024, log);
    defer ngx_destroy_pool(pool);

    const json =
        \\{
        \\"a": "hello nginz",
        \\"b": [0,1,2],
        \\"c": {"x": 1, "y": 42}
        \\}
    ;
    var cj = CJSON.init(pool);
    const parsed = cj.decode(ngx_string(json));
    try expectEqual(cJSON_IsObject(parsed), 1);
    try expectEqual(cJSON_GetArraySize(cJSON_GetObjectItem(parsed, "b")), 3);

    const j = try cj.encode(parsed);
    try expectEqual(j.len, 50);
    // std.debug.print("{s}", .{core.slicify(u8, j.data, j.len)});

    cj.free(parsed);
}
