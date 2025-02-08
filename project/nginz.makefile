.PHONY: copy clean all

all: ./submodules/nginx/objs/nginz.c

./submodules/nginx/objs/ngx_modules.c:
	cd submodules/nginx && ./auto/configure --with-http_ssl_module --with-debug

copy: ./submodules/nginx/src/core/nginx.c ./submodules/nginx/objs/ngx_modules.c
	cp ./submodules/nginx/src/core/nginx.c ./submodules/nginx/objs/nginz.c
	cp ./submodules/cjson/cJSON.c ./submodules/nginx/objs/cJSON.c
	cp ./submodules/cjson/cJSON.h ./submodules/nginx/objs/cJSON.h

./submodules/nginx/objs/nginz.c: copy
	patch ./submodules/nginx/objs/nginz.c < project/nginz.patch
	patch ./submodules/nginx/objs/cJSON.c < project/cjson.patch
	patch ./submodules/nginx/objs/cJSON.h < project/cjson.h.patch

clean:
	rm -f ./submodules/nginx/objs/ngx_modules.c ./submodules/nginx/objs/nginz.c ./submodules/nginx/objs/cJSON.c
