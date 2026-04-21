import { describe, test, expect, beforeAll, afterAll } from "bun:test";
import { startNginz, stopNginz, cleanupRuntime, TEST_URL } from "../harness.js";

const MODULE = "nftset";

describe("nftset-nginx-module", () => {
  beforeAll(async () => {
    await startNginz(`tests/${MODULE}/nginx.conf`, MODULE);
  });

  afterAll(async () => {
    await stopNginz();
    cleanupRuntime(MODULE);
  });

  describe("config loading", () => {
    test("nginx starts with all nftset directives (http/server/location context)", async () => {
      const res = await fetch(`${TEST_URL}/unset`);
      expect(res.status).toBe(200);
    });
  });

  describe("fail-open config coverage", () => {
    test("blocklist location passes through when lookup fails and fail_open is inherited", async () => {
      const res = await fetch(`${TEST_URL}/blocklist`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("blocklist ok");
    });

    test("allowlist location fails closed when lookup cannot be completed", async () => {
      const res = await fetch(`${TEST_URL}/allowlist`);
      expect(res.status).toBe(403);
    });

    test("defaults location inherits fail_open from server block and passes through", async () => {
      const res = await fetch(`${TEST_URL}/defaults`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("defaults ok");
    });

    test("ipv6 family location still passes through when fail_open is inherited", async () => {
      const res = await fetch(`${TEST_URL}/ipv6`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("ipv6 ok");
    });
  });

  describe("nftset off", () => {
    test("disabled location is not intercepted", async () => {
      const res = await fetch(`${TEST_URL}/disabled`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("disabled ok");
    });
  });

  describe("location without nftset directive", () => {
    test("unset location is unaffected by module", async () => {
      const res = await fetch(`${TEST_URL}/unset`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("unset ok");
    });
  });

  describe("nftset_status", () => {
    test("custom status location returns configured status when lookup fails closed", async () => {
      const res = await fetch(`${TEST_URL}/status-429`);
      expect(res.status).toBe(429);
    });
  });

  describe("nftset_fail_open", () => {
    test("fail_open location passes through", async () => {
      const res = await fetch(`${TEST_URL}/fail-open`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("fail-open ok");
    });
  });

  describe("nftset_dryrun", () => {
    test("dryrun location always passes through", async () => {
      const res = await fetch(`${TEST_URL}/dryrun`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("dryrun ok");
    });

    test("dryrun location passes through under load", async () => {
      const reqs = Array.from({ length: 5 }, () => fetch(`${TEST_URL}/dryrun`));
      const results = await Promise.all(reqs);
      for (const res of results) {
        expect(res.status).toBe(200);
      }
    });
  });

  describe("nftset_cache_ttl", () => {
    test("custom cache TTL location parses and still passes through via inherited fail_open", async () => {
      const res = await fetch(`${TEST_URL}/cache-ttl`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("cache-ttl ok");
    });
  });

  describe("$nftset_result variable", () => {
    test("result is 'error' when lookup fails but fail_open allows the request", async () => {
      const res = await fetch(`${TEST_URL}/variable`);
      expect(res.status).toBe(200);
      expect(res.headers.get("x-nftset-result")).toBe("error");
      expect(res.headers.get("x-nftset-matched-set")).toBeNull();
    });

    test("result is 'dryrun' when nftset_dryrun is on", async () => {
      const res = await fetch(`${TEST_URL}/variable-dryrun`);
      expect(res.status).toBe(200);
      expect(res.headers.get("x-nftset-result")).toBe("dryrun");
      expect(res.headers.get("x-nftset-matched-set")).toBeNull();
    });
  });

  describe("config inheritance", () => {
    test("child location inherits nftset and fail_open from parent/server and passes through", async () => {
      const res = await fetch(`${TEST_URL}/parent/child`);
      expect(res.status).toBe(200);
      expect(await res.text()).toContain("child ok");
    });

    test("location inherits table/set/family/fail_open from server block", async () => {
      const res = await fetch(`${TEST_URL}/defaults`);
      expect(res.status).toBe(200);
    });
  });

  describe("IP family auto-detection", () => {
    test("auto-detect: no nftset_family configured — nginx starts and serves requests", async () => {
      const res = await fetch(`${TEST_URL}/auto-family`);
      expect(res.status).toBe(200);
      // dryrun is on so result is always "dryrun" regardless of detected family
      expect(res.headers.get("x-nftset-result")).toBe("dryrun");
      expect(await res.text()).toContain("auto-family ok");
    });

    test("explicit nftset_family overrides auto-detect", async () => {
      const res = await fetch(`${TEST_URL}/explicit-family`);
      expect(res.status).toBe(200);
      expect(res.headers.get("x-nftset-result")).toBe("dryrun");
    });

    test("blocklist without nftset_family set still passes through via inherited fail_open", async () => {
      const res = await fetch(`${TEST_URL}/defaults`);
      expect(res.status).toBe(200);
    });
  });

  describe("concurrent requests", () => {
    test("handles concurrent requests across fail-open and dryrun locations", async () => {
      const reqs = [
        ...Array.from({ length: 4 }, () => fetch(`${TEST_URL}/blocklist`)),
        ...Array.from({ length: 4 }, () => fetch(`${TEST_URL}/dryrun`)),
        ...Array.from({ length: 4 }, () => fetch(`${TEST_URL}/variable`)),
      ];
      const results = await Promise.all(reqs);
      for (const res of results) {
        expect(res.status).toBe(200);
      }
    });
  });
});
