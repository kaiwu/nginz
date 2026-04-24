import qs from 'querystring';
import fs from 'fs';
import xml from 'xml';

const TMP = '/tmp/nginz-njs-stdlib-test.txt';

// querystring
function qs_stringify(r) {
    r.return(200, qs.stringify(JSON.parse(r.requestText)));
}

function qs_parse(r) {
    r.return(200, JSON.stringify(qs.parse(r.variables.args || '')));
}

function qs_roundtrip(r) {
    let obj = { a: 'hello world', b: '42', c: 'foo&bar' };
    let str = qs.stringify(obj);
    let parsed = qs.parse(str);
    r.return(200, JSON.stringify({ ok: parsed.a === obj.a && parsed.b === obj.b && parsed.c === obj.c }));
}

// fs
function fs_write(r) {
    fs.writeFileSync(TMP, r.requestText);
    r.return(200, 'ok');
}

function fs_read(r) {
    try {
        r.return(200, fs.readFileSync(TMP, 'utf8'));
    } catch (e) {
        r.return(404, 'not found');
    }
}

function fs_append(r) {
    fs.appendFileSync(TMP, r.requestText);
    r.return(200, 'ok');
}

function fs_unlink(r) {
    try { fs.unlinkSync(TMP); } catch (e) {}
    r.return(200, 'ok');
}

// xml
function xml_root_name(r) {
    let doc = xml.parse('<catalog><book id="1"><title>NJS</title></book></catalog>');
    r.return(200, doc.$root.$name);
}

function xml_child_text(r) {
    let doc = xml.parse('<root><item>hello njs</item></root>');
    r.return(200, doc.$root.$tag$item.$text);
}

function xml_attribute(r) {
    let doc = xml.parse('<root><book id="42" lang="en">text</book></root>');
    let book = doc.$root.$tag$book;
    r.return(200, JSON.stringify({ id: book.$attr$id, lang: book.$attr$lang }));
}

function xml_multiple_tags(r) {
    let doc = xml.parse('<list><item>a</item><item>b</item><item>c</item></list>');
    let items = doc.$root.$tags$item;
    r.return(200, JSON.stringify(items.map(n => n.$text)));
}

function xml_nested(r) {
    let doc = xml.parse('<root><section><title>T1</title><body>B1</body></section></root>');
    let section = doc.$root.$tag$section;
    r.return(200, JSON.stringify({
        title: section.$tag$title.$text,
        body: section.$tag$body.$text,
    }));
}

function xml_serialize(r) {
    let doc = xml.parse('<note><to>Alice</to><from>Bob</from></note>');
    let out = xml.serializeToString(doc.$root, null, false);
    r.return(200, out);
}

export default {
    qs_stringify,
    qs_parse,
    qs_roundtrip,
    fs_write,
    fs_read,
    fs_append,
    fs_unlink,
    xml_root_name,
    xml_child_text,
    xml_attribute,
    xml_multiple_tags,
    xml_nested,
    xml_serialize,
};
