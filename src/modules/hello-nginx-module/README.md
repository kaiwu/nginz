## Hello

A minimal nginx module written in Zig that returns a literal "hello" response when the `hello` directive is specified.

### Directive

#### hello

*syntax:* `hello;`  
*context:* `location`

Enables the hello module handler for the current location. When enabled, any request to this location will receive a response containing the literal string "hello".

### Usage

```nginx
location /hello {
    hello;
}
```

Visiting `/hello` will return a response with status code 200 and body containing "hello".
