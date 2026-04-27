import { existsSync, readFileSync, writeFileSync } from "fs";
import { join } from "path";
import { spawn } from "bun";
import os from "os";
import { commandExists } from "./system.js";

function readFileMaybe(path) {
  try {
    return readFileSync(path, "utf8");
  } catch {
    return "";
  }
}

function snapshotPid(pid) {
  if (!pid || !existsSync(`/proc/${pid}`)) return null;
  const status = readFileMaybe(`/proc/${pid}/status`);
  const stat = readFileMaybe(`/proc/${pid}/stat`);
  const limits = readFileMaybe(`/proc/${pid}/limits`);
  const cmdline = readFileMaybe(`/proc/${pid}/cmdline`).replaceAll("\u0000", " ").trim();
  return {
    pid,
    cmdline,
    status,
    stat,
    limits,
  };
}

function snapshotSystem() {
  return {
    generated_at: new Date().toISOString(),
    loadavg: os.loadavg(),
    uptime: readFileMaybe("/proc/uptime").trim(),
    meminfo: readFileMaybe("/proc/meminfo"),
  };
}

export function normalizeProfileMode(requestedMode) {
  if (!requestedMode || requestedMode === "snapshot") return { requested: requestedMode || "snapshot", effective: "snapshot", reason: null };
  if (requestedMode === "none") return { requested: "none", effective: "none", reason: null };
  if (requestedMode === "perf-stat") {
    if (!commandExists("perf")) {
      return { requested: "perf-stat", effective: "snapshot", reason: "perf not found; fell back to snapshot" };
    }
    return { requested: "perf-stat", effective: "perf-stat", reason: null };
  }
  return { requested: requestedMode, effective: "snapshot", reason: `unknown profiling mode '${requestedMode}', fell back to snapshot` };
}

export function captureSnapshotSummary({ mode, pids, reason = null }) {
  const normalized = normalizeProfileMode(mode);
  return {
    requested_mode: normalized.requested,
    effective_mode: normalized.effective === "perf-stat" ? "snapshot" : normalized.effective,
    fallback_reason: normalized.effective === "perf-stat"
      ? "perf-stat capture not started; recorded snapshot only"
      : normalized.reason,
    reason,
    started_at: new Date().toISOString(),
    finished_at: new Date().toISOString(),
    pids: pids.filter(Boolean),
    before: {
      system: snapshotSystem(),
      processes: pids.map(snapshotPid).filter(Boolean),
    },
    after: {
      system: snapshotSystem(),
      processes: pids.map(snapshotPid).filter(Boolean),
    },
    perf_stat_path: null,
  };
}

export function writeSnapshotSummary(profilingDir, summary) {
  const summaryPath = join(profilingDir, "summary.json");
  writeFileSync(summaryPath, JSON.stringify(summary, null, 2));
  return summaryPath;
}

export async function startProfiling({ mode, pids, profilingDir }) {
  const normalized = normalizeProfileMode(mode);
  const session = {
    requested_mode: normalized.requested,
    effective_mode: normalized.effective,
    fallback_reason: normalized.reason,
    pids: pids.filter(Boolean),
    started_at: new Date().toISOString(),
    before: {
      system: snapshotSystem(),
      processes: pids.map(snapshotPid).filter(Boolean),
    },
    perfStatPath: join(profilingDir, "perf-stat.txt"),
    processRef: null,
  };

  if (normalized.effective === "perf-stat" && session.pids.length > 0) {
    session.processRef = spawn([
      "perf",
      "stat",
      "-x,",
      "-e",
      "task-clock,cycles,instructions,branches,branch-misses,cache-references,cache-misses,context-switches,cpu-migrations,page-faults",
      "-p",
      session.pids.join(","),
      "-o",
      session.perfStatPath,
      "sleep",
      "1000000",
    ], {
      stdout: "ignore",
      stderr: "ignore",
      cwd: process.cwd(),
      env: process.env,
    });
  }

  return session;
}

export async function stopProfiling(session, profilingDir) {
  if (session.processRef) {
    session.processRef.kill("SIGINT");
    try {
      await session.processRef.exited;
    } catch {
      // ignore
    }
  }

  const summary = {
    requested_mode: session.requested_mode,
    effective_mode: session.effective_mode,
    fallback_reason: session.fallback_reason,
    started_at: session.started_at,
    finished_at: new Date().toISOString(),
    pids: session.pids,
    before: session.before,
    after: {
      system: snapshotSystem(),
      processes: session.pids.map(snapshotPid).filter(Boolean),
    },
    perf_stat_path: session.effective_mode === "perf-stat" ? "perf-stat.txt" : null,
  };

  const summaryPath = join(profilingDir, "summary.json");
  writeFileSync(summaryPath, JSON.stringify(summary, null, 2));
  return summary;
}
