import { spawn, spawnSync } from "bun";
import { mkdirSync, rmSync, existsSync } from "fs";
import { join, dirname } from "path";

let nginzProcess = null;
const NGINZ_BIN = "./zig-out/bin/nginz";
const TEST_PORT = 8888;

// Build nginz before running tests
export function ensureBuild() {
  console.log("Building nginz...");
  const result = spawnSync(["zig", "build"], {
    stdout: "inherit",
    stderr: "inherit",
  });
  if (result.exitCode !== 0) {
    throw new Error("zig build failed");
  }
  console.log("Build successful");
}

// Create isolated runtime directory for a module
function createRuntimeDir(moduleName) {
  const runtimeDir = join(process.cwd(), "tests", moduleName, "runtime");
  if (existsSync(runtimeDir)) {
    rmSync(runtimeDir, { recursive: true });
  }
  mkdirSync(runtimeDir, { recursive: true });
  mkdirSync(join(runtimeDir, "logs"), { recursive: true });
  return runtimeDir;
}

// Start nginz with given config
export async function startNginz(configPath, moduleName) {
  const runtimeDir = createRuntimeDir(moduleName);
  const absConfig = join(process.cwd(), configPath);
  
  nginzProcess = spawn([NGINZ_BIN, "-c", absConfig, "-p", runtimeDir], {
    stdout: "inherit",
    stderr: "inherit",
    cwd: process.cwd(),
  });
  
  await waitForPort(TEST_PORT);
  return runtimeDir;
}

// Stop nginz gracefully
export async function stopNginz() {
  if (nginzProcess) {
    nginzProcess.kill("SIGQUIT");
    await nginzProcess.exited;
    nginzProcess = null;
  }
}

// Wait for port to be available
async function waitForPort(port, timeout = 5000) {
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

// Clean up runtime directory
export function cleanupRuntime(moduleName) {
  const runtimeDir = join(process.cwd(), "tests", moduleName, "runtime");
  if (existsSync(runtimeDir)) {
    rmSync(runtimeDir, { recursive: true });
  }
}

export const TEST_PORT_NUM = TEST_PORT;
export const TEST_URL = `http://localhost:${TEST_PORT}`;
