import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";
import { existsSync, rmSync } from "fs";

const MODULE = "waf";
const RULES_FILE = `${process.cwd()}/tests/waf/native-subset.rules`;
const GENERATED_CONFIG = `tests/${MODULE}/nginx.generated.conf`;

describe("waf module", () => {
  beforeAll(async () => {
    const template = await Bun.file(`tests/${MODULE}/nginx.conf`).text();
    await Bun.write(GENERATED_CONFIG, template.replaceAll("__WAF_RULES_FILE__", RULES_FILE));
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
      const res = await fetch(`${TEST_URL}/body`, {
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
  });
});
