import { spawnSync } from "bun";
import net from "net";

export function runResult(command, stdin) {
  const result = spawnSync(command, {
    stdout: "pipe",
    stderr: "pipe",
    stdin,
    cwd: process.cwd(),
    env: process.env,
  });
  return {
    exitCode: result.exitCode,
    stdout: result.stdout ? Buffer.from(result.stdout).toString() : "",
    stderr: result.stderr ? Buffer.from(result.stderr).toString() : "",
  };
}

export function run(command, stdin) {
  const result = runResult(command, stdin);
  if (result.exitCode !== 0) {
    throw new Error(`Command failed: ${command.join(" ")}\n${result.stdout}${result.stderr}`.trim());
  }
  return result;
}

export function commandExists(command) {
  const result = runResult(["sh", "-lc", `command -v ${command}`]);
  return result.exitCode === 0 && result.stdout.trim().length > 0;
}

export function ensureDockerContainerRunning(name) {
  const result = runResult(["sudo", "docker", "inspect", "--format", "{{.State.Running}}", name]);
  if (result.exitCode !== 0 || !result.stdout.trim().includes("true")) {
    throw new Error(`Container ${name} is not running.`);
  }
}

export function ensureHostPortOpen(host, port) {
  const result = runResult(["nc", "-z", host, String(port)]);
  if (result.exitCode !== 0) {
    throw new Error(`Port ${port} on ${host} is not reachable.`);
  }
}

export async function waitForHttp(url, timeout = 10000) {
  const start = Date.now();
  while (Date.now() - start < timeout) {
    try {
      const controller = new AbortController();
      const timeoutId = setTimeout(() => controller.abort(), 200);
      await fetch(url, { signal: controller.signal });
      clearTimeout(timeoutId);
      return;
    } catch {
      await Bun.sleep(50);
    }
  }
  throw new Error(`Timeout waiting for ${url}`);
}

export async function getFreePort() {
  return await new Promise((resolve, reject) => {
    const server = net.createServer();
    server.unref();
    server.on("error", reject);
    server.listen(0, "127.0.0.1", () => {
      const address = server.address();
      if (!address || typeof address === "string") {
        server.close(() => reject(new Error("Failed to allocate free port")));
        return;
      }
      const { port } = address;
      server.close((error) => {
        if (error) reject(error);
        else resolve(port);
      });
    });
  });
}
