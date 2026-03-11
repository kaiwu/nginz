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
    /* ngx_core structs */
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

    /* ngx_http structs */
    PRINT_SIZEOF(ngx_http_file_cache_node_t);
    PRINT_SIZEOF(ngx_http_cache_t);
    PRINT_SIZEOF(ngx_http_listen_opt_t);
    PRINT_SIZEOF(ngx_http_core_srv_conf_t);
    PRINT_SIZEOF(ngx_http_addr_conf_t);
    PRINT_SIZEOF(ngx_http_conf_addr_t);
    PRINT_SIZEOF(ngx_http_core_loc_conf_t);
    PRINT_SIZEOF(ngx_http_headers_in_t);
    PRINT_SIZEOF(ngx_http_request_body_t);
    PRINT_SIZEOF(ngx_http_connection_t);
    PRINT_SIZEOF(ngx_http_header_out_t);
    PRINT_SIZEOF(ngx_http_request_t);
    PRINT_SIZEOF(ngx_http_script_engine_t);
    PRINT_SIZEOF(ngx_http_script_compile_t);
    PRINT_SIZEOF(ngx_http_compile_complex_value_t);
    PRINT_SIZEOF(ngx_http_script_regex_code_t);
    PRINT_SIZEOF(ngx_http_script_regex_end_code_t);
    PRINT_SIZEOF(ngx_http_upstream_server_t);
    PRINT_SIZEOF(ngx_http_upstream_conf_t);
    PRINT_SIZEOF(ngx_http_upstream_headers_in_t);
    PRINT_SIZEOF(ngx_http_upstream_t);
    PRINT_SIZEOF(ngx_http_upstream_rr_peer_t);
    PRINT_SIZEOF(ngx_http_upstream_rr_peers_t);
    PRINT_SIZEOF(ngx_ssl_connection_t);
    PRINT_SIZEOF(ngx_ssl_ticket_key_t);
    PRINT_SIZEOF(ngx_http_module_t);

    /* key offsets for ngx_http_request_t */
    PRINT_OFFSETOF(ngx_http_request_t, connection);
    PRINT_OFFSETOF(ngx_http_request_t, cleanup);
    PRINT_OFFSETOF(ngx_http_request_t, state);

    return 0;
}
