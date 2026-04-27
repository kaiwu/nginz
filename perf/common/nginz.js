import { mkdirSync, rmSync, existsSync } from "fs";
import { join, isAbsolute } from "path";
import { spawn, spawnSync } from "bun";

let nginzProcess = null;
const NGINZ_BIN = "./zig-out/bin/nginz";
export const DEFAULT_PERF_OPTIMIZE = "ReleaseSmall";

export function ensureBuild() {
  const optimize = process.env.ZIG_OPTIMIZE || DEFAULT_PERF_OPTIMIZE;
  const args = ["zig", "build"];

  args.push(`-Doptimize=${optimize}`);
  console.log(`Building nginz with -Doptimize=${optimize}...`);

  const result = spawnSync(args, {
    stdout: "inherit",
    stderr: "inherit",
  });
  if (result.exitCode !== 0) {
    throw new Error("zig build failed");
  }
  console.log("Build successful");
}

export function resetRuntimeDir(runtimeDir) {
  if (existsSync(runtimeDir)) {
    rmSync(runtimeDir, { recursive: true, force: true });
  }
  mkdirSync(runtimeDir, { recursive: true });
  mkdirSync(join(runtimeDir, "logs"), { recursive: true });
}

async function waitForPort(port, timeout = 10000) {
  const start = Date.now();
  while (Date.now() - start < timeout) {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 100);
      await fetch(`http://localhost:${port}/`, { signal: controller.signal });
      clearTimeout(timeoutId);
      return;
    } catch {
      await Bun.sleep(50);
    }
  }
  throw new Error(`Timeout waiting for port ${port}`);
}

export async function startNginz(configPath, runtimeDir, port, options = {}) {
  if (options.resetRuntime !== false) {
    resetRuntimeDir(runtimeDir);
  }
  const absConfig = isAbsolute(configPath) ? configPath : join(process.cwd(), configPath);

  nginzProcess = spawn([NGINZ_BIN, "-c", absConfig, "-p", runtimeDir], {
    stdout: "inherit",
    stderr: "inherit",
    cwd: process.cwd(),
  });

  const readyPort = port ?? 8888;
  await waitForPort(readyPort);
  return {
    runtimeDir,
    pid: nginzProcess?.pid ?? null,
    port: readyPort,
  };
}

export async function stopNginz() {
  if (nginzProcess) {
    nginzProcess.kill("SIGQUIT");
    await nginzProcess.exited;
    nginzProcess = null;
  }
}

export function getNginzPid() {
  return nginzProcess?.pid ?? null;
}
