## Echoz

`echoz` is a simplified replica of [echo][1] module. It implements many of its directives in `Zig`. The main drive is
to demo how to implement nginx content handler module as well as filter module, taking advantages of the language features.
On the other hand, `echoz` does not intend to deal with a long history of nginx releases and changes. It only addresses to
the recent nginx releases and their exposed calibers, so that a learner might find the implementations cleaner.

A full and much better documentation can be found at the original [echo][1] module. This doc also references the original work
as much as it can.

### Synopsis

```nginx

```

### Deployment

Instead of providing standard nginx building routines, the project artifacts are module object files, with which one shall
build into a target `nginx` binary. `ngx_http_echoz_module.o` provides **2** nginx modules, a content handler module and a 
filter module, and they can be added in the `objs/ngx_modules.c` as following.

```c

  extern ngx_module_t ngx_core_module;
  /*...*/
  extern ngx_module_t ngx_http_echoz_module;
  extern ngx_module_t ngx_http_echoz_filter_module;

  ngx_module_t *ngx_modules[] = {
      &ngx_core_module,
      &ngx_errlog_module,
      /*...*/
      &ngx_http_echoz_module,
      /*...*/
      /*...*/
      &ngx_http_echoz_filter_module,
      /*...*/
      &ngx_http_not_modified_filter_module,
      NULL
  };

  char* ngx_module_names[] = {
      "ngx_core_module",
      "ngx_errlog_module",
      /*...*/
      "ngx_http_echoz_module",
      /*...*/
      /*...*/
      "ngx_http_echoz_filter_module",
      /*...*/
      "ngx_http_not_modified_filter_module",
      NULL
  };

```

### Versions

`echoz` is tested with following `nginx` releases

- 1.27.4
- 1.27.3

### Directives

#### echoz

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echozn

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_duplicate

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_flush

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_sleep

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_location_async

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_request_body

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_read_request_body

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_exec

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_before_body

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_after_body

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_status

 syntax           
 default          
 context          
 phase            

```nginx

```

#### echoz_header

 syntax           
 default          
 context          
 phase            

```nginx

```




[1]: https://github.com/openresty/echo-nginx-module "echo"



