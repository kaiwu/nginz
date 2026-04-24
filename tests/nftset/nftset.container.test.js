import { describe, test, expect, beforeAll, afterAll } from "bun:test";
const IMAGE = "nginz-nftset-test:local";
const CONTAINER = `nginz-nftset-${Date.now()}`;
const NGINX_CONF = "/workdir/tests/nftset/nginx.container.conf";
const NFT_CONF = "/workdir/tests/nftset/nftables.conf";
const NGINX_RUNTIME = "/tmp/nginz-runtime";

function hostZigRoot() {
  const out = run(["zig", "env"]).stdout;
  const match = out.match(/\.lib_dir = "([^"]+)"/);
  if (!match) {
    throw new Error(`Unable to determine Zig lib_dir from: ${out}`);
  }
  return match[1].replace(/\/lib\/?$/, "");
}

const ZIG_ROOT = hostZigRoot();

function run(command, options = {}) {
  const result = Bun.spawnSync(command, {
    stdout: options.capture === false ? "inherit" : "pipe",
    stderr: options.capture === false ? "inherit" : "pipe",
    cwd: process.cwd(),
    env: process.env,
  });

  if (result.exitCode !== 0) {
    const stderr = result.stderr ? Buffer.from(result.stderr).toString() : "";
    const stdout = result.stdout ? Buffer.from(result.stdout).toString() : "";
    throw new Error(`${command.join(" ")} failed\n${stdout}${stderr}`.trim());
  }

  return {
    stdout: result.stdout ? Buffer.from(result.stdout).toString() : "",
    stderr: result.stderr ? Buffer.from(result.stderr).toString() : "",
  };
}

function createRuntimeDir() {
  // Container runtime stays inside the container filesystem.
}

function cleanupRuntime() {
  // Remove root-owned cache entries left by the in-container zig build.
  try {
    console.log("Cleaning root-owned .zig-cache artifacts left by the nftset container build...");
    run(["sudo", "find", ".zig-cache", "-user", "root", "-delete"]);
  } catch {
    // best-effort; non-fatal if nothing to remove
  }
}

function docker(...args) {
  return run(["sudo", "docker", ...args]);
}

function dockerStreaming(...args) {
  return run(["sudo", "docker", ...args], { capture: false });
}

function dockerExec(command) {
  return docker("exec", CONTAINER, "bash", "-lc", command);
}

function ensureImage() {
  if (!process.env.NFTSET_DOCKER_REBUILD) {
    const inspect = Bun.spawnSync(["sudo", "docker", "image", "inspect", IMAGE], {
      stdout: "ignore",
      stderr: "ignore",
      cwd: process.cwd(),
      env: process.env,
    });

    if (inspect.exitCode === 0) {
      return;
    }
  }

  dockerStreaming("build", "-t", IMAGE, "-f", "tests/nftset/Dockerfile", "tests/nftset");
}

function startContainer() {
  docker(
    "run",
    "--rm",
    "-d",
    "--name",
    CONTAINER,
    "--cap-add",
    "NET_ADMIN",
    "--cap-add",
    "NET_RAW",
    "-v",
    `${process.cwd()}:/workdir`,
    "-v",
    `${ZIG_ROOT}:/opt/zig:ro`,
    "-w",
    "/workdir",
    IMAGE,
  );
}

function stopContainer() {
  try {
    docker("rm", "-f", CONTAINER);
  } catch {
    // container may already be gone
  }
}

function startNginzInContainer() {
  dockerExec(`mkdir -p ${NGINX_RUNTIME}/logs && nohup ./zig-out/bin/nginz -c ${NGINX_CONF} -p ${NGINX_RUNTIME} > ${NGINX_RUNTIME}/logs/stdout.log 2>&1 < /dev/null &`);
}

function buildNginzInContainer() {
  dockerExec("/opt/zig/zig build");
}

function stopNginzInContainer() {
  try {
    dockerExec(`if [ -f ${NGINX_RUNTIME}/logs/nginx.pid ]; then kill -QUIT "$(cat ${NGINX_RUNTIME}/logs/nginx.pid)" || true; fi`);
  } catch {
    // container teardown is the final fallback
  }
}

async function waitForReady(timeout = 10000) {
  const start = Date.now();
  while (Date.now() - start < timeout) {
    try {
      const res = dockerExec(`curl -sS -i http://127.0.0.1:8888/ready`);
      if (res.stdout.includes("200 OK") && res.stdout.includes("ready ok")) {
        return;
      }
    } catch {
      // still starting
    }
    await Bun.sleep(100);
  }
  throw new Error("Timeout waiting for containerized nginz");
}

function applyNftRules() {
  dockerExec(`nft -f ${NFT_CONF}`);
}

function request(path) {
  const res = dockerExec(`curl -sS -i http://127.0.0.1:8888${path}`);
  const raw = res.stdout.replace(/\r/g, "");
  const [headerBlock, body = ""] = raw.split("\n\n", 2);
  const headerLines = headerBlock.split("\n");
  const statusLine = headerLines[0] ?? "";
  const status = Number(statusLine.split(" ")[1]);
  const headers = new Map();
  for (const line of headerLines.slice(1)) {
    const idx = line.indexOf(":");
    if (idx > 0) {
      headers.set(line.slice(0, idx).trim().toLowerCase(), line.slice(idx + 1).trim());
    }
  }
  return { status, headers, body };
}

function requestIpv6(path) {
  const res = dockerExec(`curl -g -6 -sS -i http://[::1]:8888${path}`);
  const raw = res.stdout.replace(/\r/g, "");
  const [headerBlock, body = ""] = raw.split("\n\n", 2);
  const headerLines = headerBlock.split("\n");
  const statusLine = headerLines[0] ?? "";
  const status = Number(statusLine.split(" ")[1]);
  const headers = new Map();
  for (const line of headerLines.slice(1)) {
    const idx = line.indexOf(":");
    if (idx > 0) {
      headers.set(line.slice(0, idx).trim().toLowerCase(), line.slice(idx + 1).trim());
    }
  }
  return { status, headers, body };
}

function requestBurst(path, count) {
  const res = dockerExec(`statuses=""; i=0; while [ "$i" -lt ${count} ]; do code=$(curl -sS -o /dev/null -w '%{http_code}' http://127.0.0.1:8888${path}); statuses="$statuses $code"; i=$((i + 1)); done; printf '%s\n' "$statuses"`);
  return res.stdout.trim().split(/\s+/).filter(Boolean).map(Number);
}

function requestConcurrent(path, count) {
  const res = dockerExec(`seq 1 ${count} | xargs -n1 -P${count} -I{} bash -lc "curl -sS -o /dev/null -w '%{http_code}\n' http://127.0.0.1:8888${path}"`);
  return res.stdout.trim().split(/\s+/).filter(Boolean).map(Number);
}

function nft(command) {
  return dockerExec(`nft ${command}`);
}

ensureImage();

describe("nftset-nginx-module container integration", () => {
  beforeAll(async () => {
    createRuntimeDir();
    startContainer();
    buildNginzInContainer();
    applyNftRules();
    startNginzInContainer();
    await waitForReady();
  }, 300000);

  afterAll(async () => {
    stopNginzInContainer();
    stopContainer();
    cleanupRuntime();
  }, 30000);

  test("blocklist denies when client IP is present in the set", () => {
    const res = request("/block-hit");
    expect(res.status).toBe(403);
  });

  test("blocklist passes when client IP is absent from the set", () => {
    const res = request("/block-miss");
    expect(res.status).toBe(200);
    expect(res.body).toContain("block-miss ok");
  });

  test("allowlist passes when client IP is present in the trusted set", () => {
    const res = request("/allow-hit");
    expect(res.status).toBe(200);
    expect(res.body).toContain("allow-hit ok");
  });

  test("allowlist denies when client IP is absent from the trusted set", () => {
    const res = request("/allow-miss");
    expect(res.status).toBe(403);
  });

  test("custom status is used for a real membership hit", () => {
    const res = request("/status-hit");
    expect(res.status).toBe(429);
  });

  test("$nftset_result is deny on a real blocking decision", () => {
    const res = request("/variable-block-hit");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("deny");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:blocklist");
  });

  test("$nftset_result is allow on a real allowlist hit", () => {
    const res = request("/variable-allow-hit");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:trusted");
  });

  test("dryrun reports dryrun on a real membership hit without blocking", () => {
    const res = request("/dryrun-hit");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("dryrun");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:blocklist");
    expect(res.body).toContain("dryrun-hit ok");
  });

  test("cache TTL keeps a positive hit sticky until expiry", async () => {
    const first = request("/cache-positive");
    expect(first.status).toBe(403);
    expect(first.headers.get("x-nftset-result")).toBe("deny");

    nft("delete element ip nginz_test cachepositive { 127.0.0.1 }");

    const cached = request("/cache-positive");
    expect(cached.status).toBe(403);
    expect(cached.headers.get("x-nftset-result")).toBe("deny");

    await Bun.sleep(1400);

    const afterExpiry = request("/cache-positive");
    expect(afterExpiry.status).toBe(200);
    expect(afterExpiry.headers.get("x-nftset-result")).toBe("allow");
    expect(afterExpiry.body).toContain("cache-positive ok");
  });

  test("cache TTL keeps a negative miss sticky until expiry", async () => {
    const first = request("/cache-negative");
    expect(first.status).toBe(200);
    expect(first.headers.get("x-nftset-result")).toBe("allow");

    nft("add element ip nginz_test cachenegative { 127.0.0.1 }");

    const cached = request("/cache-negative");
    expect(cached.status).toBe(200);
    expect(cached.headers.get("x-nftset-result")).toBe("allow");

    await Bun.sleep(1400);

    const afterExpiry = request("/cache-negative");
    expect(afterExpiry.status).toBe(403);
    expect(afterExpiry.headers.get("x-nftset-result")).toBe("deny");
  });

  test("cache_ttl 0 disables caching so live nft changes apply immediately", () => {
    const first = request("/cache-disabled");
    expect(first.status).toBe(200);
    expect(first.headers.get("x-nftset-result")).toBe("allow");

    nft("add element ip nginz_test cachedisabled { 127.0.0.1 }");

    const second = request("/cache-disabled");
    expect(second.status).toBe(403);
    expect(second.headers.get("x-nftset-result")).toBe("deny");
  });

  test("autoadd inserts the client IP into the target set without blocking", () => {
    const before = dockerExec("nft list set ip nginz_test honeypot").stdout;
    expect(before).not.toContain("127.0.0.1");

    const res = request("/autoadd-basic");
    expect(res.status).toBe(200);
    expect(res.body).toContain("autoadd-basic ok");

    const after = dockerExec("nft list set ip nginz_test honeypot").stdout;
    expect(after).toContain("127.0.0.1");
  });

  test("autoadd timeout inserts an expiring element into a timeout-capable set", async () => {
    const res = request("/autoadd-timeout");
    expect(res.status).toBe(200);
    expect(res.body).toContain("autoadd-timeout ok");

    const afterAdd = dockerExec("nft list set ip nginz_test honeypot_timeout").stdout;
    expect(afterAdd).toContain("127.0.0.1 timeout");
    expect(afterAdd).toContain("expires");

    await Bun.sleep(1600);

    const afterExpiry = dockerExec("nft list set ip nginz_test honeypot_timeout").stdout;
    expect(afterExpiry).not.toContain("127.0.0.1");
  });

  test("autoadd updates shared lookup cache so a follow-up request sees the new membership", () => {
    const first = request("/autoadd-lookup-shared");
    expect(first.status).toBe(200);
    expect(first.headers.get("x-nftset-result")).toBe("allow");

    const second = request("/autoadd-lookup-shared");
    expect(second.status).toBe(403);
    expect(second.headers.get("x-nftset-result")).toBe("deny");
    expect(second.headers.get("x-nftset-matched-set")).toBe("nginz_test:autoaddshared");

    const listed = dockerExec("nft list set ip nginz_test autoaddshared").stdout;
    expect(listed).toContain("127.0.0.1");
  });

  test("shared cache generation clears stale worker-local misses after autoadd", () => {
    const warm = requestConcurrent("/shared-cache-probe", 8);
    expect(warm.every((status) => status === 200)).toBe(true);

    const write = request("/shared-cache-autoadd");
    expect(write.status).toBe(200);
    expect(write.body).toContain("shared-cache-autoadd ok");

    const afterWrite = requestConcurrent("/shared-cache-probe", 8);
    expect(afterWrite.every((status) => status === 403)).toBe(true);

    const listed = dockerExec("nft list set ip nginz_test sharedcoherent").stdout;
    expect(listed).toContain("127.0.0.1");
  });

  test("autoadd write errors do not poison lookup cache", () => {
    const first = request("/autoadd-error-no-refresh");
    expect(first.status).toBe(200);
    expect(first.headers.get("x-nftset-result")).toBe("allow");
    expect(first.headers.get("x-nftset-matched-set")).toBeUndefined();

    const second = request("/autoadd-error-no-refresh");
    expect(second.status).toBe(200);
    expect(second.headers.get("x-nftset-result")).toBe("allow");
    expect(second.headers.get("x-nftset-matched-set")).toBeUndefined();
    expect(second.body).toContain("autoadd-error-no-refresh ok");
  });

  test("autoadd family mismatch is logged but does not fail the request", () => {
    const res = request("/autoadd-family-mismatch");
    expect(res.status).toBe(200);
    expect(res.body).toContain("autoadd-family-mismatch ok");
  });

  test("ratelimit returns 429 after the configured fixed-window budget is exhausted", async () => {
    await Bun.sleep(1100);

    const statuses = requestBurst("/ratelimit-plain", 4);

    expect(statuses).toEqual([200, 200, 200, 429]);
  });

  test("ratelimit burst allows burst requests before returning 429", async () => {
    await Bun.sleep(1100);

    const statuses = requestBurst("/ratelimit-burst", 4);

    expect(statuses).toEqual([200, 200, 200, 429]);
  });

  test("ratelimit shared memory enforces a single budget across multiple workers", async () => {
    await Bun.sleep(1100);

    const statuses = requestConcurrent("/ratelimit-plain", 4);

    expect(statuses.filter((s) => s === 200).length).toBe(3);
    expect(statuses.filter((s) => s === 429).length).toBe(1);
  });

  test("child zero-burst overrides inherited burst allowance", async () => {
    await Bun.sleep(1100);

    const statuses = requestBurst("/ratelimit-parent/child-zero-burst", 3);

    expect(statuses).toEqual([200, 200, 429]);
  });

  test("ratelimit autoban inserts into the configured set and subsequent lookup blocks immediately", async () => {
    await Bun.sleep(1100);

    const before = dockerExec("nft list set ip nginz_test ratelimit_banned").stdout;
    expect(before).not.toContain("127.0.0.1");

    const statuses = requestBurst("/ratelimit-autoban", 2);
    expect(statuses).toEqual([200, 429]);

    const after = dockerExec("nft list set ip nginz_test ratelimit_banned").stdout;
    expect(after).toContain("127.0.0.1 timeout");

    const third = request("/ratelimit-autoban");
    expect(third.status).toBe(403);
    expect(third.headers.get("x-nftset-result")).toBe("deny");
    expect(third.headers.get("x-nftset-matched-set")).toBe("nginz_test:ratelimit_banned");

    const concurrent = requestConcurrent("/ratelimit-autoban", 4);
    expect(concurrent.every((status) => status === 403)).toBe(true);

    await Bun.sleep(1400);

    const afterExpiry = dockerExec("nft list set ip nginz_test ratelimit_banned").stdout;
    expect(afterExpiry).not.toContain("127.0.0.1");
  });

  test("missing set is treated as lookup error and fails closed by default", () => {
    const res = request("/missing-set-fail-closed");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("error");
  });

  test("missing set still reports lookup error when fail_open allows the request", () => {
    const res = request("/missing-set-fail-open");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("error");
    expect(res.body).toContain("missing-set-fail-open ok");
  });

  test("configured family mismatch is treated as lookup error and fails closed", () => {
    const res = request("/family-mismatch");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("error");
  });

  test("configured family mismatch respects fail_open", () => {
    const res = request("/family-mismatch-fail-open");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("error");
    expect(res.body).toContain("family-mismatch-fail-open ok");
  });

  test("native IPv6 blocklist hit is denied against an ip6 set", () => {
    const res = requestIpv6("/ip6-hit");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("deny");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:blocklist6");
  });

  test("native IPv6 blocklist miss passes against an ip6 set", () => {
    const res = requestIpv6("/ip6-miss");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
    expect(res.headers.get("x-nftset-matched-set")).toBeUndefined();
    expect(res.body).toContain("ip6-miss ok");
  });

  test("multi-set blocklist stops at the first matching set", () => {
    const res = request("/multi-block-hit");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("deny");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:blocklist");
  });

  test("multi-set blocklist passes when no set matches", () => {
    const res = request("/multi-block-miss");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
    expect(res.headers.get("x-nftset-matched-set")).toBeUndefined();
    expect(res.body).toContain("multi-block-miss ok");
  });

  test("multi-set allowlist passes when any set matches", () => {
    const res = request("/multi-allow-hit");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:trusted");
    expect(res.body).toContain("multi-allow-hit ok");
  });

  test("multi-set allowlist denies when all sets miss", () => {
    const res = request("/multi-allow-miss");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("deny");
    expect(res.headers.get("x-nftset-matched-set")).toBeUndefined();
  });

  test("CIDR interval set denies when the client IP falls inside the prefix", () => {
    const res = request("/cidr-hit");
    expect(res.status).toBe(403);
    expect(res.headers.get("x-nftset-result")).toBe("deny");
    expect(res.headers.get("x-nftset-matched-set")).toBe("nginz_test:cidrblock");
  });

  test("CIDR interval set passes when the client IP falls outside the prefix", () => {
    const res = request("/cidr-miss");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
    expect(res.headers.get("x-nftset-matched-set")).toBeUndefined();
    expect(res.body).toContain("cidr-miss ok");
  });

  test("container nftables state contains the expected sets and elements", () => {
    const listedIp = dockerExec("nft list table ip nginz_test").stdout;
    const listedIp6 = dockerExec("nft list table ip6 nginz_test").stdout;
    expect(listedIp).toContain("set blocklist");
    expect(listedIp).toContain("127.0.0.1");
    expect(listedIp).toContain("set trusted");
    expect(listedIp).toContain("set cachepositive");
    expect(listedIp).toContain("set honeypot");
    expect(listedIp).toContain("set honeypot_timeout");
    expect(listedIp).toContain("set autoaddshared");
    expect(listedIp).toContain("set sharedcoherent");
    expect(listedIp).toContain("set autoaddguard");
    expect(listedIp).toContain("set ratelimit_banned");
    expect(listedIp).toContain("set cidrblock");
    expect(listedIp6).toContain("set blocklist6");
    expect(listedIp6).toContain("::1");
  });
});
