import crypto from 'crypto';

function hello(r) {
    r.return(200, "Hello from njs!\n");
}

function version(r) {
    r.return(200, njs.version);
}

function echo_method(r) {
    r.return(200, r.method);
}

function echo_uri(r) {
    r.return(200, r.uri);
}

function echo_args(r) {
    r.return(200, JSON.stringify(r.args));
}

function echo_header(r) {
    r.return(200, r.headersIn['X-Test'] || 'none');
}

function set_response_header(r) {
    r.headersOut['X-Powered-By'] = 'njs';
    r.return(200, 'ok');
}

function echo_body(r) {
    r.return(200, r.requestText);
}

function json_echo(r) {
    let body = JSON.parse(r.requestText);
    r.return(200, JSON.stringify({ received: body }));
}

function base64_encode(r) {
    let input = r.args.input || '';
    r.return(200, Buffer.from(input).toString('base64'));
}

function sha256_hash(r) {
    let input = r.args.input || '';
    let hash = crypto.createHash('sha256').update(input).digest('hex');
    r.return(200, hash);
}

function hmac_sha256(r) {
    let h = crypto.createHmac('sha256', 'secret-key');
    h.update(r.args.data || '');
    r.return(200, h.digest('hex'));
}

function dec_foo(r) {
    return decodeURIComponent(r.args.foo || '');
}

export default {
    hello,
    version,
    echo_method,
    echo_uri,
    echo_args,
    echo_header,
    set_response_header,
    echo_body,
    json_echo,
    base64_encode,
    sha256_hash,
    hmac_sha256,
    dec_foo,
};
