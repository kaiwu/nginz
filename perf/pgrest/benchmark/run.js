import { existsSync, readFileSync, rmSync, writeFileSync } from "fs";
import { join } from "path";
import { spawn } from "bun";
import { parseBenchmarkArgs, printBenchmarkHelp } from "../../common/benchmark_cli.js";
import { ensureBuild, startNginz, stopNginz } from "../../common/nginz.js";
import { summarizeSamples, printSummary } from "../../common/report.js";
import { run, runResult, ensureDockerContainerRunning, ensureHostPortOpen, waitForHttp } from "../../common/system.js";
import { captureCommandArtifact, captureEnvironmentArtifact, copyRuntimeLogs, createRunArtifacts, writeJsonArtifact, writeManifest } from "../../common/artifacts.js";
import { startProfiling, stopProfiling } from "../../common/profiling.js";
import { SCENARIOS, getScenario } from "./scenarios.js";
import { validateScenarioPair } from "./validate.js";

const MODULE = "pgrest";
const PG_CONTAINER = "pg18";
const PG_USER = "nginz_test";
const PG_PASSWORD = "nginz_test_pass";
const PG_DB = process.env.PGREST_BENCH_DB || "nginz_bench";
const PGREST_BASE_URL = "http://127.0.0.1:8888/api";
const POSTGREST_PORT = Number(process.env.POSTGREST_PORT || 3000);
const POSTGREST_BASE_URL = `http://127.0.0.1:${POSTGREST_PORT}`;
const PERF_DIR = join(process.cwd(), "perf", "pgrest");
const BENCH_DIR = join(PERF_DIR, "benchmark");
const OUTPUT_DIR = join(BENCH_DIR, "output");
const FIXTURES_SQL = readFileSync(join(BENCH_DIR, "fixtures.sql"), "utf8");

function psqlAdmin(sql) {
  run(["sudo", "docker", "exec", "-i", PG_CONTAINER, "psql", "-U", "postgres"], Buffer.from(sql));
}

function psqlDb(sql) {
  run(["sudo", "docker", "exec", "-i", PG_CONTAINER, "psql", "-U", PG_USER, "-d", PG_DB], Buffer.from(sql));
}

function ensureBenchmarkDatabase() {
  psqlAdmin(`DO $$ BEGIN IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '${PG_USER}') THEN CREATE USER ${PG_USER} WITH PASSWORD '${PG_PASSWORD}'; END IF; END $$;`);
  run(["sudo", "docker", "exec", PG_CONTAINER, "dropdb", "-U", "postgres", "--if-exists", PG_DB]);
  run(["sudo", "docker", "exec", PG_CONTAINER, "createdb", "-U", "postgres", `--owner=${PG_USER}`, PG_DB]);
  psqlDb(FIXTURES_SQL);
}

function cleanupBenchmarkDatabase() {
  if (process.env.PGREST_BENCH_KEEP_DB) return;
  try {
    run(["sudo", "docker", "exec", PG_CONTAINER, "dropdb", "-U", "postgres", "--if-exists", PG_DB]);
  } catch {
    // ignore cleanup failure
  }
}

function resolvePostgrestBin() {
  return process.env.POSTGREST_BIN || "postgrest";
}

function buildPostgrestConfig() {
  const configPath = join(activeArtifacts.runtimeDir, "postgrest.conf");
  const config = [
    `db-uri = "postgresql://${PG_USER}:${PG_PASSWORD}@127.0.0.1:5432/${PG_DB}"`,
    `db-schemas = "public"`,
    `db-anon-role = "${PG_USER}"`,
    `server-host = "127.0.0.1"`,
    `server-port = ${POSTGREST_PORT}`,
    `admin-server-port = ${POSTGREST_PORT + 1}`,
    `log-level = "warn"`,
  ].join("\n");
  writeFileSync(configPath, `${config}\n`);
  return configPath;
}

let activeArtifacts = null;

async function startPostgrest() {
  const bin = resolvePostgrestBin();
  const preflight = runResult([bin, "--help"]);
  if (preflight.exitCode !== 0) {
    throw new Error(`PostgREST executable is not runnable: ${bin}\n${preflight.stdout}${preflight.stderr}`.trim());
  }

  const configPath = buildPostgrestConfig();
  const processRef = spawn([bin, configPath], {
    stdout: "inherit",
    stderr: "inherit",
    cwd: process.cwd(),
    env: process.env,
  });
  await waitForHttp(`${POSTGREST_BASE_URL}/`);
  return processRef;
}

async function stopProcess(processRef) {
  if (!processRef) return;
  processRef.kill("SIGTERM");
  try {
    await processRef.exited;
  } catch {
    // ignore
  }
}

function serviceBaseUrl(service) {
  return service === "pgrest" ? PGREST_BASE_URL : POSTGREST_BASE_URL;
}

function buildScenarioUrl(service, scenario) {
  return `${serviceBaseUrl(service)}${scenario.path}`;
}

async function fetchScenario(service, scenario) {
  const url = buildScenarioUrl(service, scenario);
  const started = performance.now();
  const response = await fetch(url, { headers: scenario.headers });
  const text = await response.text();
  const latencyMs = performance.now() - started;
  let json;
  try {
    json = text.length === 0 ? null : JSON.parse(text);
  } catch (error) {
    throw new Error(`Failed to parse JSON for ${service} ${scenario.name}: ${error.message}\n${text.slice(0, 200)}`);
  }
  return {
    status: response.status,
    text,
    json,
    payloadBytes: Buffer.byteLength(text),
    latencyMs,
  };
}

async function warmupService(service, scenario, warmupCount) {
  for (let i = 0; i < warmupCount; i += 1) {
    const result = await fetchScenario(service, scenario);
    if (result.status !== 200) {
      throw new Error(`Warmup failed for ${service} ${scenario.name}: HTTP ${result.status}`);
    }
  }
}

async function benchmarkScenario(service, scenario, requests, concurrency) {
  let nextIndex = 0;
  const samples = [];

  const started = performance.now();
  async function worker() {
    while (true) {
      const current = nextIndex;
      nextIndex += 1;
      if (current >= requests) return;
      const result = await fetchScenario(service, scenario);
      samples.push({
        status: result.status,
        latencyMs: result.latencyMs,
        payloadBytes: result.payloadBytes,
      });
    }
  }

  await Promise.all(Array.from({ length: concurrency }, () => worker()));
  const wallTimeMs = performance.now() - started;
  return {
    summary: summarizeSamples(samples, wallTimeMs),
    wallTimeMs,
  };
}

async function validateScenario(scenario, enabledServices) {
  if (enabledServices.length < 2) return;
  const [leftService, rightService] = enabledServices;
  const left = await fetchScenario(leftService, scenario);
  const right = await fetchScenario(rightService, scenario);
  validateScenarioPair(scenario, left, right);
}

async function main() {
  const options = parseBenchmarkArgs(process.argv.slice(2));
  if (options.help) {
    printBenchmarkHelp("perf/pgrest/benchmark/run.js");
    return;
  }

  const scenarios = options.scenario ? [getScenario(options.scenario)] : SCENARIOS;
  if (scenarios.some((scenario) => scenario == null)) {
    throw new Error(`Unknown scenario: ${options.scenario}`);
  }
  if (!["both", "pgrest", "postgrest"].includes(options.service)) {
    throw new Error(`Unsupported --service value: ${options.service}`);
  }

  const enabledServices = options.service === "both" ? ["pgrest", "postgrest"] : [options.service];
  const optimizeMode = process.env.ZIG_OPTIMIZE || "ReleaseSmall";

  ensureDockerContainerRunning(PG_CONTAINER);
  ensureHostPortOpen("127.0.0.1", 5432);
  ensureBuild();
  activeArtifacts = createRunArtifacts(OUTPUT_DIR, MODULE, optimizeMode, options.artifactTag);
  writeJsonArtifact(activeArtifacts.environmentPath, captureEnvironmentArtifact(MODULE, { optimizeMode }));
  writeJsonArtifact(activeArtifacts.commandPath, captureCommandArtifact("perf/pgrest/benchmark/run.js", options));
  writeManifest(activeArtifacts, {
    module: MODULE,
    profiling_mode: options.profile,
  });
  ensureBenchmarkDatabase();

  let postgrestProcess = null;
  let nginzRuntime = null;
  try {
    nginzRuntime = await startNginz("perf/pgrest/nginx.conf", activeArtifacts.runtimeDir);
    if (enabledServices.includes("postgrest")) {
      postgrestProcess = await startPostgrest();
    }

    for (const scenario of scenarios) {
      await validateScenario(scenario, enabledServices);
      for (const service of enabledServices) {
        await warmupService(service, scenario, options.warmup);
      }
    }

    const profilingSession = await startProfiling({
      mode: options.profile,
      pids: [nginzRuntime?.pid, postgrestProcess?.pid],
      profilingDir: activeArtifacts.profilingDir,
    });

    const results = [];
    try {
      for (const scenario of scenarios) {
        for (const concurrency of options.concurrency) {
          for (const service of enabledServices) {
            const runResultData = await benchmarkScenario(service, scenario, options.requests, concurrency);
            results.push({
              service,
              scenario: scenario.name,
              description: scenario.description,
              query: scenario.path,
              concurrency,
              duration_ms: runResultData.wallTimeMs,
              summary: runResultData.summary,
            });
          }
        }
      }
    } finally {
      await stopProfiling(profilingSession, activeArtifacts.profilingDir);
    }

    writeJsonArtifact(activeArtifacts.benchmarkPath, {
      generated_at: new Date().toISOString(),
      module: MODULE,
      database: PG_DB,
      services: enabledServices,
      requests: options.requests,
      warmup: options.warmup,
      concurrency: options.concurrency,
      results,
    });

    console.log(`Benchmark results written to ${activeArtifacts.runDir}`);
    printSummary(results);
  } finally {
    await stopProcess(postgrestProcess);
    copyRuntimeLogs(activeArtifacts.runtimeDir, activeArtifacts.logsDir);
    await stopNginz();
    if (!options.keepRuntime && existsSync(activeArtifacts.runtimeDir)) {
      rmSync(activeArtifacts.runtimeDir, { recursive: true, force: true });
    }
    cleanupBenchmarkDatabase();
  }
}

main().catch((error) => {
  console.error(error instanceof Error ? error.message : error);
  process.exit(1);
});
