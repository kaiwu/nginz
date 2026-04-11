import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";
import { spawnSync } from "node:child_process";
import { existsSync, mkdtempSync, rmSync, writeFileSync } from "fs";
import { tmpdir } from "os";
import { join } from "path";

const MODULE = "waf";
const RULES_FILE = `${process.cwd()}/tests/waf/native-subset.rules`;
const LIBINJECTION_RULES_FILE = `${process.cwd()}/tests/waf/libinjection.rules`;
const BAN_RULES_FILE = `${process.cwd()}/tests/waf/ban.rules`;
const SCORE_RULES_FILE = `${process.cwd()}/tests/waf/ban.rules`;
const ACTION_RULES_FILE = `${process.cwd()}/tests/waf/action.rules`;
const UNSUPPORTED_RULES_FILE = `${process.cwd()}/tests/waf/unsupported.rules`;
const TRANSFORM_RULES_FILE = `${process.cwd()}/tests/waf/transform.rules`;
const OPERATORS_RULES_FILE = `${process.cwd()}/tests/waf/operators.rules`;
const COLLECTIONS_RULES_FILE = `${process.cwd()}/tests/waf/collections.rules`;
const BODY_RULES_FILE = `${process.cwd()}/tests/waf/body.rules`;
const RESPONSE_RULES_FILE = `${process.cwd()}/tests/waf/response.rules`;
const GENERATED_CONFIG = `tests/${MODULE}/nginx.generated.conf`;
const ERROR_LOG = `${process.cwd()}/tests/${MODULE}/runtime/logs/error.log`;

async function waitForLogContains(needle, attempts = 10) {
  for (let i = 0; i < attempts; i++) {
    const text = await Bun.file(ERROR_LOG).text().catch(() => "");
    if (text.includes(needle)) return text;
    await Bun.sleep(50);
  }
  return Bun.file(ERROR_LOG).text().catch(() => "");
}

async function fetchNoKeepAlive(url, init = {}) {
  const headers = new Headers(init.headers ?? {});
  headers.set("Connection", "close");
  return fetch(url, { ...init, headers });
}

async function waitForStatus(url, expectedStatus, attempts = 24, delayMs = 500) {
  let lastRes;
  for (let i = 0; i < attempts; i++) {
    lastRes = await fetchNoKeepAlive(url);
    if (lastRes.status === expectedStatus) return lastRes;
    await Bun.sleep(delayMs);
  }
  return lastRes;
}

function testConfigFailure(rulesFile) {
  const runtimeDir = mkdtempSync(join(tmpdir(), "nginz-waf-invalid-"));
  const confPath = join(runtimeDir, "nginx.conf");

  const config = `daemon off;\nerror_log stderr notice;\npid logs/nginx.pid;\n\nevents {\n    worker_connections 16;\n}\n\nhttp {\n    server {\n        listen 8899;\n\n        location / {\n            waf on;\n            waf_mode block;\n            waf_sqli off;\n            waf_xss off;\n            waf_rules_file ${rulesFile};\n            echozn \"invalid config response\";\n        }\n    }\n}\n`;

  writeFileSync(confPath, config);

  try {
    return spawnSync("./zig-out/bin/nginz", ["-t", "-p", runtimeDir, "-c", confPath], {
      cwd: process.cwd(),
      encoding: "utf8",
    });
  } finally {
    rmSync(runtimeDir, { recursive: true, force: true });
  }
}

describe("waf module", () => {
  beforeAll(async () => {
    const template = await Bun.file(`tests/${MODULE}/nginx.conf`).text();
    await Bun.write(
      GENERATED_CONFIG,
      template
        .replaceAll("__WAF_RULES_FILE__", RULES_FILE)
        .replaceAll("__WAF_LIBINJECTION_RULES_FILE__", LIBINJECTION_RULES_FILE)
        .replaceAll("__WAF_ACTION_RULES_FILE__", ACTION_RULES_FILE)
        .replaceAll("__WAF_BAN_RULES_FILE__", BAN_RULES_FILE)
        .replaceAll("__WAF_SCORE_RULES_FILE__", SCORE_RULES_FILE)
        .replaceAll("__WAF_TRANSFORM_RULES_FILE__", TRANSFORM_RULES_FILE)
        .replaceAll("__WAF_OPERATORS_RULES_FILE__", OPERATORS_RULES_FILE)
        .replaceAll("__WAF_COLLECTIONS_RULES_FILE__", COLLECTIONS_RULES_FILE)
        .replaceAll("__WAF_BODY_RULES_FILE__", BODY_RULES_FILE)
        .replaceAll("__WAF_RESPONSE_RULES_FILE__", RESPONSE_RULES_FILE)
    );
    await startNginz(GENERATED_CONFIG, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    if (existsSync(GENERATED_CONFIG)) {
      rmSync(GENERATED_CONFIG);
    }
    cleanupRuntime(MODULE);
  });

  // Clean requests should pass
  describe("clean requests", () => {
    test("normal request passes", async () => {
      const res = await fetch(`${TEST_URL}/api?name=john&age=25`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("api response");
    });

    test("request to clean endpoint passes", async () => {
      const res = await fetch(`${TEST_URL}/clean`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("clean response");
    });
  });

  // SQL Injection tests
  describe("SQL injection detection", () => {
    test("blocks SQLi in query string - OR 1=1", async () => {
      const res = await fetch(`${TEST_URL}/api?id=1' OR '1'='1`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });

    test("blocks URL-encoded SQLi", async () => {
      const res = await fetch(`${TEST_URL}/api?id=%27%20OR%20%271%27=%271`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });

    test("blocks union select attack", async () => {
      const res = await fetch(`${TEST_URL}/api?q=1 UNION SELECT * FROM users`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });

    test("blocks comment-based attack", async () => {
      const res = await fetch(`${TEST_URL}/api?user=admin'--`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });

    test("blocks SQL keywords with space", async () => {
      const res = await fetch(`${TEST_URL}/api?q=SELECT * FROM users`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });

    test("blocks sleep-based attack", async () => {
      const res = await fetch(`${TEST_URL}/api?id=1; SLEEP(5)`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });
  });

  // XSS tests
  describe("XSS detection", () => {
    test("blocks script tag", async () => {
      const res = await fetch(`${TEST_URL}/api?q=<script>alert(1)</script>`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("blocks URL-encoded script tag", async () => {
      const res = await fetch(`${TEST_URL}/api?q=%3Cscript%3Ealert(1)%3C/script%3E`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("blocks onerror event handler", async () => {
      const res = await fetch(`${TEST_URL}/api?img=<img src=x onerror=alert(1)>`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("blocks javascript protocol", async () => {
      const res = await fetch(`${TEST_URL}/api?url=javascript:alert(1)`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("blocks document.cookie access", async () => {
      const res = await fetch(`${TEST_URL}/api?code=document.cookie`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("blocks eval function", async () => {
      const res = await fetch(`${TEST_URL}/api?code=eval(x)`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("blocks entity-obfuscated javascript protocol", async () => {
      const res = await fetch(`${TEST_URL}/api?url=javas%26%23x09%3Bcript%3Aalert(1)`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("xss");
    });
  });

  // Detect mode tests
  describe("detect mode", () => {
    test("SQLi passes in detect mode", async () => {
      const res = await fetch(`${TEST_URL}/detect?id=1' OR '1'='1`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("detect response");
    });

    test("XSS passes in detect mode", async () => {
      const res = await fetch(`${TEST_URL}/detect?q=<script>alert(1)</script>`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("detect response");
    });

    test("nested child location inherits detect mode", async () => {
      const res = await fetch(`${TEST_URL}/detect-parent/child?q=<script>alert(1)</script>`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("detect child response");
    });
  });

  // WAF disabled tests
  describe("WAF disabled", () => {
    test("SQLi passes when WAF disabled", async () => {
      const res = await fetch(`${TEST_URL}/disabled?id=1' OR '1'='1`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("disabled response");
    });

    test("XSS passes when WAF disabled", async () => {
      const res = await fetch(`${TEST_URL}/disabled?q=<script>alert(1)</script>`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("disabled response");
    });
  });

  // Selective detection tests
  describe("selective detection", () => {
    test("SQLi-only blocks SQLi", async () => {
      const res = await fetch(`${TEST_URL}/sqli-only?id=1' OR '1'='1`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("sqli");
    });

    test("SQLi-only allows XSS", async () => {
      const res = await fetch(`${TEST_URL}/sqli-only?q=<script>alert(1)</script>`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("sqli-only response");
    });

    test("XSS-only blocks XSS", async () => {
      const res = await fetch(`${TEST_URL}/xss-only?q=<script>alert(1)</script>`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("xss");
    });

    test("XSS-only allows SQLi", async () => {
      const res = await fetch(`${TEST_URL}/xss-only?id=1' OR '1'='1`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("xss-only response");
    });
  });

  // Body checking tests
  describe("body checking", () => {
    test("blocks SQLi in POST body", async () => {
      const res = await fetch(`${TEST_URL}/body`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "username=admin' OR '1'='1",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("sqli");
    });

    test("blocks XSS in POST body", async () => {
      const res = await fetch(`${TEST_URL}/body`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "comment=<script>alert(1)</script>",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("xss");
    });

    test("clean POST body passes", async () => {
      const res = await fetch(`${TEST_URL}/body`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "username=john&email=john@example.com",
      });
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("body response");
    });

    test("blocks SQLi in PUT body", async () => {
      const res = await fetchNoKeepAlive(`${TEST_URL}/body`, {
        method: "PUT",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "data=1; DROP TABLE users",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("sqli");
    });

    test("blocks XSS in PATCH body", async () => {
      const res = await fetch(`${TEST_URL}/body`, {
        method: "PATCH",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "bio=<svg onload=alert(1)>",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("xss");
    });
  });

  // Case insensitivity tests
  describe("case insensitivity", () => {
    test("blocks uppercase SQLi", async () => {
      const res = await fetch(`${TEST_URL}/api?q=UNION SELECT * FROM users`);
      expect(res.status).toBe(403);
    });

    test("blocks mixed case SQLi", async () => {
      const res = await fetch(`${TEST_URL}/api?q=UnIoN sElEcT * FROM users`);
      expect(res.status).toBe(403);
    });

    test("blocks uppercase XSS", async () => {
      const res = await fetch(`${TEST_URL}/api?q=<SCRIPT>alert(1)</SCRIPT>`);
      expect(res.status).toBe(403);
    });

    test("blocks mixed case XSS", async () => {
      const res = await fetch(`${TEST_URL}/api?q=<ScRiPt>alert(1)</ScRiPt>`);
      expect(res.status).toBe(403);
    });

    test("blocks concat-style SQLi missed by simple keyword rules", async () => {
      const res = await fetch(`${TEST_URL}/api?id=1'%20%7C%7C%201%20--`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("sqli");
    });
  });

  describe("native rule-file subset", () => {
    test("blocks based on ARGS rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules?token=native-subset-needle`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.error).toBe("waf_blocked");
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_URI rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules/blocked-path`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_BODY rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-body`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "comment=native-body-needle",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("rule-file matches respect detect mode", async () => {
      const res = await fetch(`${TEST_URL}/rules-detect?token=native-subset-needle`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("rules detect response");
    });

    test("blocks based on REQUEST_HEADERS rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-headers`, {
        headers: { "X-Native-Header": "blocked-header-value" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_COOKIES rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-cookies`, {
        headers: { Cookie: "waf_cookie=native-cookie-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_METHOD rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-method`, {
        method: "DELETE",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REMOTE_ADDR rule from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-ip`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on @rx operator from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-regex/regex-path-12345`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on equals-style operator from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-equals`, {
        method: "PATCH",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_HEADERS selector rule", async () => {
      const res = await fetch(`${TEST_URL}/rules-header-selector`, {
        headers: { "X-Scoped-Header": "scoped-header-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_COOKIES selector rule", async () => {
      const res = await fetch(`${TEST_URL}/rules-cookie-selector`, {
        headers: { Cookie: "scoped_cookie=scoped-cookie-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on ARGS selector rule", async () => {
      const res = await fetch(`${TEST_URL}/rules-arg-selector?scoped_arg=scoped-arg-hit&other=ok`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("uses per-rule status action when blocking", async () => {
      const res = await fetch(`${TEST_URL}/rules-status/status-path`);
      expect(res.status).toBe(406);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on @beginsWith operator from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-begins-with/rules-prefix-hit/path`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on @endsWith operator from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-ends-with/path/suffix-hit`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on QUERY_STRING collection from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-query-string?query-string-hit=1`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_LINE collection from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-request-line/request-line-hit`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on @pm operator from file", async () => {
      const res = await fetch(`${TEST_URL}/rules-pm`, {
        headers: { "X-PM-Header": "phrase-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_BODY selector rule for form bodies", async () => {
      const res = await fetch(`${TEST_URL}/rules-body-selector-form`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "comment=scoped-body-hit&other=ok",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on REQUEST_BODY selector rule for JSON bodies", async () => {
      const res = await fetch(`${TEST_URL}/rules-body-selector-json`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ comment: "json-body-hit", other: "ok" }),
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("per-rule deny overrides detect mode", async () => {
      const res = await fetch(`${TEST_URL}/rules-deny/deny-path`);
      expect(res.status).toBe(418);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("per-rule pass overrides block mode", async () => {
      const res = await fetch(`${TEST_URL}/rules-pass/pass-path`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("rules pass response");

      const logText = await waitForLogContains("logdata=pass-path-observed");
      expect(logText).toContain("tag=monitor");
      expect(logText).toContain("logdata=pass-path-observed");
    });

    test("blocks based on explicit @libinjection_sqli operator", async () => {
      const res = await fetch(`${TEST_URL}/rules-libinjection?id=1'%20%7C%7C%201%20--`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("blocks based on explicit @libinjection_xss operator in request body", async () => {
      const res = await fetch(`${TEST_URL}/rules-libinjection-body`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "payload=<svg onload=alert(1)>",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("temporarily bans IP once reputation score threshold is reached and decays after quiet period", async () => {
      const first = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=score-subset-needle`);
      expect(first.status).toBe(200);
      expect(await first.text()).toContain("rules score response");

      const second = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=score-subset-needle`);
      expect(second.status).toBe(200);
      expect(await second.text()).toContain("rules score response");

      const banned = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=clean`);
      expect(banned.status).toBe(403);
      const bannedBody = await banned.json();
      expect(bannedBody.rule).toBe("ban");

      await Bun.sleep(4200);

      const recovered = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=clean`);
      expect(recovered.status).toBe(200);
      expect(await recovered.text()).toContain("rules score response");

      const spacedFirst = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=score-subset-needle`);
      expect(spacedFirst.status).toBe(200);
      expect(await spacedFirst.text()).toContain("rules score response");

      await Bun.sleep(3200);

      const spacedSecond = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=score-subset-needle`);
      expect(spacedSecond.status).toBe(200);
      expect(await spacedSecond.text()).toContain("rules score response");

      const notBanned = await fetchNoKeepAlive(`${TEST_URL}/rules-score?token=clean`);
      expect(notBanned.status).toBe(200);
      expect(await notBanned.text()).toContain("rules score response");
    }, 15000);

    test("temporarily bans IP after repeated rule hits and escalates repeat offenders", async () => {
      await Bun.sleep(4200);

      const preflight = await fetchNoKeepAlive(`${TEST_URL}/rules-ban?token=clean`);
      expect(preflight.status).toBe(200);
      expect(await preflight.text()).toContain("rules ban response");

      for (let i = 0; i < 2; i++) {
        const res = await fetchNoKeepAlive(`${TEST_URL}/rules-ban?token=native-subset-needle`);
        expect(res.status).toBe(200);
        const text = await res.text();
        expect(text).toContain("rules ban response");
      }

      const banned = await fetchNoKeepAlive(`${TEST_URL}/rules-ban?token=clean`);
      expect(banned.status).toBe(403);
      const bannedBody = await banned.json();
      expect(bannedBody.rule).toBe("ban");

      const firstRecoveryStart = Date.now();
      const recovered = await waitForStatus(`${TEST_URL}/rules-ban?token=clean`, 200);
      const firstRecoveryMs = Date.now() - firstRecoveryStart;
      expect(recovered.status).toBe(200);
      const recoveredText = await recovered.text();
      expect(recoveredText).toContain("rules ban response");

      const secondHit = await fetchNoKeepAlive(`${TEST_URL}/rules-ban?token=native-subset-needle`);
      expect(secondHit.status).toBe(200);
      const secondHitText = await secondHit.text();
      expect(secondHitText).toContain("rules ban response");

      const secondBan = await fetchNoKeepAlive(`${TEST_URL}/rules-ban?token=native-subset-needle`);
      expect([200, 403]).toContain(secondBan.status);
      if (secondBan.status === 200) {
        const secondBanText = await secondBan.text();
        expect(secondBanText).toContain("rules ban response");
      } else {
        const secondBanBody = await secondBan.json();
        expect(secondBanBody.rule).toBe("ban");
      }

      const secondRecoveryStart = Date.now();
      const secondRecovery = await waitForStatus(`${TEST_URL}/rules-ban?token=clean`, 200);
      const secondRecoveryMs = Date.now() - secondRecoveryStart;
      expect(secondRecovery.status).toBe(200);
      const secondRecoveryText = await secondRecovery.text();
      expect(secondRecoveryText).toContain("rules ban response");
      expect(secondRecoveryMs).toBeGreaterThan(firstRecoveryMs);
    }, 15000);
  });

  describe("configuration validation", () => {
    test("reports line-specific unsupported rule syntax", () => {
      const result = testConfigFailure(UNSUPPORTED_RULES_FILE);
      expect(result.stderr).toContain("line 2: unsupported rule operator");
      expect(result.stderr).toContain("configuration file");
      expect(result.stderr).toContain("test failed");
    });
  });

  describe("transform compatibility subset", () => {
    test("t:lowercase applies per-rule normalization", async () => {
      const res = await fetch(`${TEST_URL}/rules-transform/TrAnSfOrM-HiT`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("accepts t:urlDecode rules and matches decoded query strings", async () => {
      const res = await fetch(`${TEST_URL}/rules-transform-query?q=url%20decoded`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("t:urlDecodeUni applies per-rule decoding", async () => {
      const res = await fetch(`${TEST_URL}/rules-transform-query?q=unicode%20path`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("t:none disables the legacy normalization path for that rule", async () => {
      const res = await fetch(`${TEST_URL}/rules-transform-none/CaseSensitive-Hit`);
      expect(res.status).toBe(200);
      const body = await res.text();
      expect(body).toContain("rules transform none response");
    });
  });

  describe("dedicated operator fixtures", () => {
    test("keeps regex coverage concrete in operators.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-operators-regex/operators-regex-123`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps beginsWith coverage concrete in operators.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-operators-prefix/rules-operators-prefix-hit/path`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps endsWith coverage concrete in operators.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-operators-suffix/path/operators-suffix-hit`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps pm coverage concrete in operators.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-operators-pm`, {
        headers: { "X-Operators-Header": "phrase-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps equals coverage concrete in operators.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-operators-equals`, { method: "PATCH" });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });
  });

  describe("dedicated collection fixtures", () => {
    test("keeps query string coverage concrete in collections.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-collections-query?collections-query-hit=1`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps request line coverage concrete in collections.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-collections-line/collections-line-hit`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps header selector coverage concrete in collections.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-collections-header`, {
        headers: { "X-Collections-Header": "collections-header-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps cookie selector coverage concrete in collections.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-collections-cookie`, {
        headers: { Cookie: "collections_cookie=collections-cookie-hit" },
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps arg selector coverage concrete in collections.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-collections-arg?collections_arg=collections-arg-hit`);
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("keeps body selector coverage concrete in collections.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-collections-body`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "comment=collections-body-hit",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });
  });

  describe("broader body processors", () => {
    test("keeps form body selector coverage concrete in body.rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-body-form`, {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "comment=body-form-hit",
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("supports nested JSON selector paths in request bodies", async () => {
      const res = await fetch(`${TEST_URL}/rules-body-json-nested`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ profile: { comment: "nested-json-hit" } }),
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });

    test("supports multipart form field selectors in request bodies", async () => {
      const form = new FormData();
      form.append("comment", "multipart-hit");
      const res = await fetch(`${TEST_URL}/rules-body-multipart`, {
        method: "POST",
        body: form,
      });
      expect(res.status).toBe(403);
      const body = await res.json();
      expect(body.rule).toBe("rule");
    });
  });

  describe("response-phase inspection", () => {
    test("blocks based on RESPONSE_STATUS rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-response-status`);
      expect(res.status).toBe(451);
    });

    test("blocks based on RESPONSE_HEADERS rules", async () => {
      const res = await fetch(`${TEST_URL}/rules-response-header`);
      expect(res.status).toBe(452);
    });
  });
});
