## Wechatpay

`wechatpay` is a nginx proxy module to the upstream [wechat pay][1] gateway. It provides **3** major functionalies

1. A upstream proxy which signs the request as `wechatpay` requires, meanwhile it verifies the signature in the upstream response.
2. In the nginx `access` phase, it verifies the signature from the request initiated by `wechatpay` gateway, such as `notification` request.
   Optionally it decrypts the `AES-GCM-256` ciphertxt which might present in the request body on the fly.
3. Provides content handlers which either encrypt or decrypt messages found in request body using **RSA** algorithm specified by `wechatpay` 


### Synopsis

```nginx

    server {
        listen 80;
        resolver 223.5.5.5;

        wechatpay_apiclient_key_file prvkey.pem;
        wechatpay_public_key_file pubkey.pem;
        wechatpay_apiclient_serial 0000000000;
        wechatpay_serial FFFFFFFFFF;
        wechatpay_mch_id 1234567890;

        location / {
            wechatpay_proxy_pass https://api.mch.weixin.qq.com;
        }

        # might put this in another server block with SSL port
        location /notify {
            wechatpay_access aes_secret;
            #proxy_pass to upstream;
        }

        location /encrypt {
            wechatpay_oaep_encrypt on;
        }

        location /decrypt {
            wechatpay_oaep_decrypt on;
        }

```

### Deployment

`ngx_http_wechatpay_module.o` provides **2** nginx modules, a content/access handler module and a 
filter module, and they can be added in the `objs/ngx_modules.c` as following. Since `wechatpay` requires
the request body as part of signature verification, the filter module holds both header and body until
the signature is verified for downstream. A failed verification will be indicated from the response
status line to the downstream.

```c

  extern ngx_module_t ngx_core_module;
  /*...*/
  extern ngx_module_t ngx_http_wechatpay_module;
  extern ngx_module_t ngx_http_wechatpay_filter_module;

  ngx_module_t *ngx_modules[] = {
      &ngx_core_module,
      &ngx_errlog_module,
      /*...*/
      &ngx_http_wechatpay_module,
      /*...*/
      /*...*/
      &ngx_http_wechatpay_filter_module,
      /*...*/
      &ngx_http_not_modified_filter_module,
      NULL
  };

  char* ngx_module_names[] = {
      "ngx_core_module",
      "ngx_errlog_module",
      /*...*/
      "ngx_http_wechatpay_module",
      /*...*/
      /*...*/
      "ngx_http_wechatpay_filter_module",
      /*...*/
      "ngx_http_not_modified_filter_module",
      NULL
  };

```

### Versions

`wechatpay` is tested with following `nginx` releases

- 1.27.4
- 1.27.3

### Directives

#### wechatpay_proxy_pass

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_apiclient_key_file

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_apiclient_serial

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_public_key_file

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_serial

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_mch_id

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_oaep_encrypt

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_oaep_decrypt

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |

#### wechatpay_access

|         |         |
| ------- |  -----: |
| syntax  |         |
| default |         |
| context |         |
| phase   |         |




[1]: https://pay.weixin.qq.com/ "wechatpay"
