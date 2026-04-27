import { cpSync, existsSync, mkdirSync, readFileSync, writeFileSync } from "fs";
import { join } from "path";
import os from "os";
import { runResult } from "./system.js";

function sanitizeTag(value) {
  return value.replace(/[^a-zA-Z0-9._-]+/g, "-").replace(/-+/g, "-").replace(/^-|-$/g, "");
}

export function sanitizeArtifactTag(value) {
  return sanitizeTag(value);
}

function readFirstLine(path) {
  try {
    return readFileSync(path, "utf8").split("\n")[0].trim();
  } catch {
    return "";
  }
}

function readCpuModel() {
  try {
    const lines = readFileSync("/proc/cpuinfo", "utf8").split("\n");
    const model = lines.find((line) => line.startsWith("model name"));
    return model ? model.split(":")[1].trim() : os.arch();
  } catch {
    return os.arch();
  }
}

function readMemTotal() {
  try {
    const lines = readFileSync("/proc/meminfo", "utf8").split("\n");
    const mem = lines.find((line) => line.startsWith("MemTotal:"));
    return mem ? mem.replace(/\s+/g, " ").trim() : "";
  } catch {
    return "";
  }
}

export function createRunArtifacts(baseOutputDir, moduleName, optimizeMode, tag = "") {
  mkdirSync(baseOutputDir, { recursive: true });
  const timestamp = new Date().toISOString().replaceAll(":", "-");
  const slugParts = [timestamp, moduleName, sanitizeTag((optimizeMode || "debug").toLowerCase())];
  const cleanedTag = sanitizeTag(tag);
  if (cleanedTag) slugParts.push(cleanedTag);
  const runId = slugParts.join("-");
  const runDir = join(baseOutputDir, runId);
  const profilingDir = join(runDir, "profiling");
  const logsDir = join(runDir, "logs");
  const runtimeDir = join(runDir, "runtime");

  mkdirSync(runDir, { recursive: true });
  mkdirSync(profilingDir, { recursive: true });
  mkdirSync(logsDir, { recursive: true });
  mkdirSync(runtimeDir, { recursive: true });

  return {
    runId,
    runDir,
    profilingDir,
    logsDir,
    runtimeDir,
    benchmarkPath: join(runDir, "benchmark.json"),
    environmentPath: join(runDir, "environment.json"),
    commandPath: join(runDir, "command.json"),
    manifestPath: join(runDir, "manifest.json"),
    failurePath: join(runDir, "failure.json"),
  };
}

export function writeJsonArtifact(filePath, data) {
  writeFileSync(filePath, JSON.stringify(data, null, 2));
}

export function captureEnvironmentArtifact(moduleName, options) {
  const gitSha = runResult(["git", "rev-parse", "HEAD"]).stdout.trim();
  const zigVersion = runResult(["zig", "version"]).stdout.trim();
  return {
    module: moduleName,
    generated_at: new Date().toISOString(),
    git_sha: gitSha || null,
    zig_version: zigVersion || null,
    bun_version: Bun.version,
    optimize_mode: process.env.ZIG_OPTIMIZE || options.optimizeMode || null,
    hostname: os.hostname(),
    platform: os.platform(),
    release: os.release(),
    arch: os.arch(),
    cpu_model: readCpuModel(),
    cpu_count: os.cpus().length,
    mem_total: readMemTotal(),
    loadavg: os.loadavg(),
    proc_uptime: readFirstLine("/proc/uptime"),
  };
}

export function captureCommandArtifact(scriptPath, options) {
  return {
    generated_at: new Date().toISOString(),
    command: `bun ${scriptPath} ${process.argv.slice(2).join(" ")}`.trim(),
    argv: process.argv.slice(2),
    options,
  };
}

export function copyRuntimeLogs(runtimeDir, logsDir) {
  const src = join(runtimeDir, "logs");
  if (!existsSync(src)) return;
  cpSync(src, logsDir, { recursive: true });
}

export function writeManifest(artifacts, metadata = {}) {
  writeJsonArtifact(artifacts.manifestPath, {
    schema_version: 1,
    generated_at: new Date().toISOString(),
    run_id: artifacts.runId,
    status: metadata.status ?? "initialized",
    paths: {
      benchmark: "benchmark.json",
      environment: "environment.json",
      command: "command.json",
      failure: "failure.json",
      profiling: "profiling",
      logs: "logs",
      runtime: "runtime",
    },
    ...metadata,
  });
}

export function updateManifest(artifacts, patch = {}) {
  const current = existsSync(artifacts.manifestPath)
    ? JSON.parse(readFileSync(artifacts.manifestPath, "utf8"))
    : { schema_version: 1, run_id: artifacts.runId, paths: {} };

  writeJsonArtifact(artifacts.manifestPath, {
    ...current,
    ...patch,
    updated_at: new Date().toISOString(),
  });
}
