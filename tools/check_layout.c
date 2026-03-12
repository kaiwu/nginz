#include <stdio.h>
#include <stddef.h>

#include <ngx_config.h>
#include <ngx_core.h>
#include <ngx_http.h>
#include <ngx_http_upstream_round_robin.h>

#define PRINT_SIZEOF(type) \
    printf("sizeof " #type " %zu\n", sizeof(type))

#define PRINT_OFFSETOF(type, field) \
    printf("offsetof " #type " " #field " %zu\n", offsetof(type, field))

int main(void) {
    /* === Core structs === */
    PRINT_SIZEOF(ngx_str_t);
    PRINT_SIZEOF(ngx_keyval_t);
    PRINT_SIZEOF(ngx_dir_t);
    PRINT_SIZEOF(ngx_process_t);
    PRINT_SIZEOF(ngx_pool_t);
    PRINT_SIZEOF(ngx_cycle_t);
    PRINT_SIZEOF(ngx_output_chain_ctx_t);
    PRINT_SIZEOF(ngx_listening_t);
    PRINT_SIZEOF(ngx_connection_t);
    PRINT_SIZEOF(ngx_ext_rename_file_t);
    PRINT_SIZEOF(ngx_url_t);
    PRINT_SIZEOF(ngx_open_file_info_t);
    PRINT_SIZEOF(ngx_cached_open_file_t);
    PRINT_SIZEOF(ngx_resolver_node_t);
    PRINT_SIZEOF(ngx_resolver_t);
    PRINT_SIZEOF(ngx_resolver_ctx_t);
    PRINT_SIZEOF(ngx_slab_pool_t);
    PRINT_SIZEOF(ngx_variable_value_t);
    PRINT_SIZEOF(ngx_syslog_peer_t);
    PRINT_SIZEOF(ngx_event_t);
    PRINT_SIZEOF(ngx_peer_connection_t);
    PRINT_SIZEOF(ngx_event_pipe_t);

    /* === Buf / Chain structs === */
    PRINT_SIZEOF(ngx_buf_t);
    PRINT_SIZEOF(ngx_chain_t);
    PRINT_SIZEOF(ngx_chain_writer_ctx_t);

    /* === Log / File structs === */
    PRINT_SIZEOF(ngx_log_t);
    PRINT_SIZEOF(ngx_file_t);
    PRINT_SIZEOF(ngx_temp_file_t);

    /* === Config / Module structs === */
    PRINT_SIZEOF(ngx_conf_t);
    PRINT_SIZEOF(ngx_command_t);
    PRINT_SIZEOF(ngx_module_t);

    /* === Container structs === */
    PRINT_SIZEOF(ngx_array_t);
    PRINT_SIZEOF(ngx_list_t);
    PRINT_SIZEOF(ngx_queue_t);
    PRINT_SIZEOF(ngx_hash_t);
    PRINT_SIZEOF(ngx_hash_init_t);
    PRINT_SIZEOF(ngx_table_elt_t);
    PRINT_SIZEOF(ngx_rbtree_t);
    PRINT_SIZEOF(ngx_rbtree_node_t);

    /* === HTTP core structs === */
    PRINT_SIZEOF(ngx_http_module_t);
    PRINT_SIZEOF(ngx_http_request_t);
    PRINT_SIZEOF(ngx_http_request_body_t);
    PRINT_SIZEOF(ngx_http_headers_in_t);
    PRINT_SIZEOF(ngx_http_header_out_t);
    PRINT_SIZEOF(ngx_http_connection_t);
    PRINT_SIZEOF(ngx_http_cleanup_t);
    PRINT_SIZEOF(ngx_http_log_ctx_t);
    PRINT_SIZEOF(ngx_http_posted_request_t);
    PRINT_SIZEOF(ngx_http_post_subrequest_t);
    PRINT_SIZEOF(ngx_http_status_t);
    PRINT_SIZEOF(ngx_http_variable_t);
    PRINT_SIZEOF(ngx_http_variable_value_t);

    /* === HTTP config structs === */
    PRINT_SIZEOF(ngx_http_listen_opt_t);
    PRINT_SIZEOF(ngx_http_core_main_conf_t);
    PRINT_SIZEOF(ngx_http_core_srv_conf_t);
    PRINT_SIZEOF(ngx_http_core_loc_conf_t);
    PRINT_SIZEOF(ngx_http_addr_conf_t);
    PRINT_SIZEOF(ngx_http_conf_addr_t);

    /* === HTTP cache structs === */
    PRINT_SIZEOF(ngx_http_file_cache_node_t);
    PRINT_SIZEOF(ngx_http_cache_t);

    /* === HTTP script structs === */
    PRINT_SIZEOF(ngx_http_script_engine_t);
    PRINT_SIZEOF(ngx_http_script_compile_t);
    PRINT_SIZEOF(ngx_http_compile_complex_value_t);
    PRINT_SIZEOF(ngx_http_script_regex_code_t);
    PRINT_SIZEOF(ngx_http_script_regex_end_code_t);

    /* === HTTP upstream structs === */
    PRINT_SIZEOF(ngx_http_upstream_t);
    PRINT_SIZEOF(ngx_http_upstream_conf_t);
    PRINT_SIZEOF(ngx_http_upstream_server_t);
    PRINT_SIZEOF(ngx_http_upstream_srv_conf_t);
    PRINT_SIZEOF(ngx_http_upstream_main_conf_t);
    PRINT_SIZEOF(ngx_http_upstream_local_t);
    PRINT_SIZEOF(ngx_http_upstream_resolved_t);
    PRINT_SIZEOF(ngx_http_upstream_state_t);
    PRINT_SIZEOF(ngx_http_upstream_headers_in_t);
    PRINT_SIZEOF(ngx_http_upstream_header_t);
    PRINT_SIZEOF(ngx_http_upstream_rr_peer_t);
    PRINT_SIZEOF(ngx_http_upstream_rr_peers_t);

    /* === SSL structs === */
    PRINT_SIZEOF(ngx_ssl_connection_t);
    PRINT_SIZEOF(ngx_ssl_ticket_key_t);

    /* === Key offsets: ngx_http_request_t === */
    PRINT_OFFSETOF(ngx_http_request_t, connection);
    PRINT_OFFSETOF(ngx_http_request_t, upstream);
    PRINT_OFFSETOF(ngx_http_request_t, pool);
    PRINT_OFFSETOF(ngx_http_request_t, header_in);
    PRINT_OFFSETOF(ngx_http_request_t, headers_in);
    PRINT_OFFSETOF(ngx_http_request_t, headers_out);
    PRINT_OFFSETOF(ngx_http_request_t, cleanup);
    PRINT_OFFSETOF(ngx_http_request_t, state);

    /* === Key offsets: ngx_http_upstream_t === */
    PRINT_OFFSETOF(ngx_http_upstream_t, conf);
    PRINT_OFFSETOF(ngx_http_upstream_t, upstream);
    PRINT_OFFSETOF(ngx_http_upstream_t, headers_in);
    PRINT_OFFSETOF(ngx_http_upstream_t, resolved);
    PRINT_OFFSETOF(ngx_http_upstream_t, create_request);
    PRINT_OFFSETOF(ngx_http_upstream_t, process_header);
    PRINT_OFFSETOF(ngx_http_upstream_t, finalize_request);
    PRINT_OFFSETOF(ngx_http_upstream_t, cleanup);

    /* === Key offsets: ngx_connection_t === */
    PRINT_OFFSETOF(ngx_connection_t, ssl);
    PRINT_OFFSETOF(ngx_connection_t, fd);
    PRINT_OFFSETOF(ngx_connection_t, log);
    PRINT_OFFSETOF(ngx_connection_t, read);
    PRINT_OFFSETOF(ngx_connection_t, write);

    /* === Key offsets: ngx_peer_connection_t === */
    PRINT_OFFSETOF(ngx_peer_connection_t, connection);
    PRINT_OFFSETOF(ngx_peer_connection_t, local);
    PRINT_OFFSETOF(ngx_peer_connection_t, log);

    /* === Key offsets: ngx_event_t === */
    PRINT_OFFSETOF(ngx_event_t, data);
    PRINT_OFFSETOF(ngx_event_t, handler);

    /* === Key offsets: ngx_cycle_t === */
    PRINT_OFFSETOF(ngx_cycle_t, conf_ctx);
    PRINT_OFFSETOF(ngx_cycle_t, pool);
    PRINT_OFFSETOF(ngx_cycle_t, log);
    PRINT_OFFSETOF(ngx_cycle_t, modules);

    /* === Key offsets: ngx_http_upstream_conf_t === */
    PRINT_OFFSETOF(ngx_http_upstream_conf_t, upstream);

    return 0;
}
