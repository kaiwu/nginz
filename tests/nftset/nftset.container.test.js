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
  // No host cleanup needed because runtime stays inside the container.
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

  test("missing set currently follows ENOENT-as-miss policy in blocklist mode", () => {
    const res = request("/missing-set-fail-closed");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
    expect(res.body).toContain("missing-set-fail-closed ok");
  });

  test("missing set also passes in blocklist mode when fail_open is on", () => {
    const res = request("/missing-set-fail-open");
    expect(res.status).toBe(200);
    expect(res.headers.get("x-nftset-result")).toBe("allow");
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

  test("container nftables state contains the expected sets and elements", () => {
    const listedIp = dockerExec("nft list table ip nginz_test").stdout;
    const listedIp6 = dockerExec("nft list table ip6 nginz_test").stdout;
    expect(listedIp).toContain("set blocklist");
    expect(listedIp).toContain("127.0.0.1");
    expect(listedIp).toContain("set trusted");
    expect(listedIp).toContain("set cachepositive");
    expect(listedIp6).toContain("set blocklist6");
    expect(listedIp6).toContain("::1");
  });
});
