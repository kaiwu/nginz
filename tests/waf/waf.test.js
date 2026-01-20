import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "waf";

describe("waf module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
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
  });
});
