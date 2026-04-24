// r.subrequest
async function subrequest_echo(r) {
    let reply = await r.subrequest('/sub/echo', `msg=${r.args.msg || 'hello'}`);
    r.return(reply.status, reply.responseText);
}

async function subrequest_join(r) {
    let [a, b] = await Promise.all([
        r.subrequest('/sub/echo', 'msg=foo'),
        r.subrequest('/sub/echo', 'msg=bar'),
    ]);
    r.return(200, JSON.stringify([a.responseText, b.responseText]));
}

async function subrequest_status(r) {
    let reply = await r.subrequest('/sub/noContent');
    r.return(200, String(reply.status));
}

// ngx.fetch
async function fetch_get(r) {
    let resp = await ngx.fetch(`http://127.0.0.1:${r.args.port}/data`);
    r.return(resp.status, await resp.text());
}

async function fetch_json(r) {
    let resp = await ngx.fetch(`http://127.0.0.1:${r.args.port}/json`);
    let data = await resp.json();
    r.return(200, JSON.stringify({ status: resp.status, value: data.value }));
}

async function fetch_post(r) {
    let resp = await ngx.fetch(`http://127.0.0.1:${r.args.port}/echo`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: r.requestText,
    });
    r.return(resp.status, await resp.text());
}

async function fetch_headers(r) {
    let resp = await ngx.fetch(`http://127.0.0.1:${r.args.port}/headers-check`, {
        headers: { 'X-Token': 'secret' },
    });
    r.return(resp.status, await resp.text());
}

// shared dict
function dict_set(r) {
    ngx.shared.kv.set(r.args.key, r.args.val);
    r.return(200, 'ok');
}

function dict_get(r) {
    let val = ngx.shared.kv.get(r.args.key);
    r.return(200, val === undefined ? '' : val);
}

function dict_delete(r) {
    ngx.shared.kv.delete(r.args.key);
    r.return(200, 'ok');
}

function dict_incr(r) {
    let key = r.args.key || 'counter';
    let n = Number(ngx.shared.kv.get(key) || 0) + 1;
    ngx.shared.kv.set(key, String(n));
    r.return(200, String(n));
}

export default {
    subrequest_echo,
    subrequest_join,
    subrequest_status,
    fetch_get,
    fetch_json,
    fetch_post,
    fetch_headers,
    dict_set,
    dict_get,
    dict_delete,
    dict_incr,
};
