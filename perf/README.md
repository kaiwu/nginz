# Performance Handbook

This directory is the project-level home for performance work in `nginz`.

`tests/` is for correctness and integration testing. `perf/` is for repeatable measurement, benchmark fixtures, perf notes, generated perf output, and optional instrumentation support.

The goal is that every serious native module can plug into the same performance workflow instead of inventing a one-off benchmark story.

## Goals

- make performance work repeatable across modules
- standardize how baselines are collected, recorded, and compared
- keep shared tooling in one place
- let module-specific benchmark logic live close to the module that owns it
- make regressions visible early instead of treating perf as an afterthought

## Non-goals

- `perf/` does not replace correctness tests
- this handbook does not claim instrumentation or metrics the repo does not currently expose
- this handbook does not require every module to ship deep native instrumentation on day one

## Directory contract

```text
perf/
  README.md                 # this handbook
  common/                   # shared perf tooling
    artifacts.js            # shared artifact capture
    profiling.js            # non-intrusive profiling helpers
  <module>/                 # module-specific perf assets
```

### Shared vs module-owned responsibilities

| Location | Owns | Must not own |
|---|---|---|
| `perf/common/` | generic CLI parsing, nginz lifecycle helpers, result summarization, process/docker/port helpers, shared conventions | module-specific fixtures, module-specific nginx configs, module-specific validators, one-off benchmark logic |
| `perf/<module>/` | benchmark runner, scenarios, fixtures, validators, module benchmark config, outputs, notes, module caveats | repo-wide generic helpers that should be reused by multiple modules |

### Default module layout

```text
perf/<module>/
  README.md
  nginx.conf
  benchmark/
    run.js
    scenarios.js
    validate.js
    fixtures.*
    output/      # generated
    runtime/     # generated
  notes/         # optional, recommended for iteration logs
```

Modules may omit pieces they do not need, but this is the default target layout.

## Available tools today

### Shared Bun utilities in `perf/common/`

- `benchmark_cli.js`
  - common benchmark CLI parsing
  - standardizes `--scenario`, `--requests`, `--warmup`, `--concurrency`, `--service`, `--keep-runtime`
- `nginz.js`
  - builds nginz and manages nginz runtime lifecycle for perf runs
  - handles isolated runtime directories and port readiness
- `report.js`
  - computes throughput and latency summaries
  - emits `p50`, `p95`, `p99`, mean, max, and payload-size summaries
- `system.js`
  - shared process helpers
  - Docker/container checks
  - port readiness and HTTP wait helpers
- `artifacts.js`
  - creates per-run artifact directories
  - writes manifest, environment, and command metadata
  - copies logs into the run artifact tree
- `profiling.js`
  - shared non-intrusive profiling helpers
  - supports low-overhead process/system snapshots today
  - optionally captures `perf stat` counters when available

### Module-specific runner example

- `perf/pgrest/benchmark/run.js`
  - current reference implementation for a real benchmark runner
  - validates response equivalence before trusting numbers
  - warms up, runs timed samples, writes JSON output, and prints a summary table

### Optional repo observability surfaces

- `prometheus-nginx-module`
  - current built-in production metrics surface
  - exposes request counters, status-class counters, and request-duration histograms
- nginx logs
  - benchmark and integration configs already use `access_log` and `error_log`
  - many test configs use `error_log logs/error.log debug;` for troubleshooting

### Timing APIs available to native modules

When deeper native instrumentation is needed, modules can build on nginx timing primitives already available through the Zig bindings, such as:

- `ngx_current_msec`
- `ngx_time()`
- `ngx_timeofday()`
- event timers via the nginx event layer

That means a future shared Zig instrumentation layer is possible, but it is not a current framework requirement.

### Non-intrusive system profiling

The framework now supports a distinct non-intrusive profiling layer in addition to request-level benchmarking.

Current profiling modes:

- `none`
- `snapshot` - default; captures process/system snapshots around the timed section
- `perf-stat` - optional; uses Linux `perf stat` when available and falls back to `snapshot` when it is not

This layer is intentionally shared and module-agnostic. It should be preferred before adding native instrumentation.

## Common metrics to capture

The framework should distinguish between metrics that are available **today** and metrics that are only available if a benchmark explicitly wires them in.

### Metrics available from the current benchmark framework

These come directly from the current benchmark runner/reporting model and should be treated as the minimum standard baseline set:

- throughput: `throughput_rps`
- latency: `latency_p50_ms`, `latency_p95_ms`, `latency_p99_ms`, `latency_mean_ms`, `latency_max_ms`
- payload size: `payload_bytes_min`, `payload_bytes_mean`, `payload_bytes_max`
- result quality: `requests_total`, `success_total`, `status_counts`

### Metrics available from the current profiling layer

When the runner uses the shared profiling layer, each run can also capture:

- target process identity and command lines
- before/after process snapshots from `/proc`
- before/after host snapshots such as load average and memory summary
- optional `perf stat` counters including task clock, cycles, instructions, cache misses, branches, branch misses, context switches, CPU migrations, and page faults when the host allows it

### Common nginx metrics to capture when available

These should be part of the standard procedure whenever the benchmark setup makes them available:

- HTTP status distribution from access logs or benchmark status counts
- request duration histograms via the Prometheus module when the benchmark setup includes it
- request totals and request rate from Prometheus counters when wired in
- error-log anomalies, upstream connection failures, and timeout patterns from `logs/error.log`

### Prometheus metrics currently available in-repo

If a module benchmark includes the Prometheus module, the current repo already supports a standard nginx metrics surface:

- `nginx_up`
- `nginx_http_requests_total`
- `nginx_http_requests_by_status{status="1xx"|"2xx"|...}`
- `nginx_http_request_duration_seconds` histogram

The current histogram buckets are the built-in request-duration buckets from the Prometheus module implementation. If a benchmark uses those metrics, note that choice in the module notes so later runs stay comparable.

## Standard performance procedure

This is the default measurement loop for any module.

1. **Prove correctness first**
   - run the module’s integration tests before doing any perf work
   - do not trust faster results from a correctness-regressed build

2. **Choose the build mode deliberately**
   - record whether you used the default debug build or an optimized build
   - when using an optimized build, record the exact `ZIG_OPTIMIZE` value
   - for perf runs in this repo, the default standard is **`ReleaseSmall`**
   - `ReleaseSmall` is preferred over `ReleaseFast` as the baseline perf mode because it is already the repo-recommended release-grade build and keeps safety checks on

3. **Prepare dependencies and fixtures**
   - start required containers or external services
   - seed deterministic fixtures
   - keep fixture setup under `perf/<module>/benchmark/fixtures.*`

4. **Start the benchmark-specific runtime**
   - use a dedicated benchmark config under `perf/<module>/nginx.conf`
   - do not overload integration-test configs for performance work unless that is the explicit scenario under test

5. **Validate scenario semantics before timing**
   - use a validator like `validate.js` to confirm the measured endpoint still returns the expected semantic result
   - for comparison runs, confirm the baseline service and comparison service return equivalent top-level shapes and stable row counts

6. **Warm up**
   - exclude warmup from reported metrics
   - warm both services when doing a comparison benchmark

7. **Run timed samples**
   - keep scenario set, concurrency set, request count, and warmup count fixed within a comparison
   - record the exact command used

8. **Persist structured output**
   - write the run into a dedicated artifact directory under `perf/<module>/benchmark/output/`
   - never rely on console output alone

9. **Record iteration notes immediately**
   - write down the hypothesis, change, command, artifact path, and observed delta before starting the next change

10. **Only then make the next change**
   - one hypothesis per iteration is the default rule

## Baseline collection

A baseline is only valid if all of the following stay fixed or are explicitly recorded:

- commit SHA
- module name
- benchmark scenario names
- concurrency set
- request count
- warmup count
- build mode
- config file used
- dependency/container versions where relevant
- machine/OS summary

For each baseline, record at least:

- date/time
- command run
- output artifact path
- summary metrics
- any observed anomalies in logs

The standard run artifact layout is:

```text
perf/<module>/benchmark/output/<run-id>/
  manifest.json
  benchmark.json
  environment.json
  command.json
  profiling/
    summary.json
    perf-stat.txt        # optional
  logs/
  runtime/              # kept only when requested
```

If the baseline is a comparison against another implementation, the exact comparison target must also be recorded.

## Iteration note-taking standard

Every optimization attempt should produce a short note. Store it under `perf/<module>/notes/` or append it to the module perf README if the history is still small.

Each note should capture:

- **hypothesis** - what you think is slow and why
- **change** - what code/config changed
- **command** - exact benchmark command run
- **scenario** - which scenario(s) were used
- **environment** - build mode, container/runtime assumptions
- **artifact** - JSON output file path
- **correctness check** - pass/fail and how it was checked
- **delta** - throughput and latency changes, plus payload/status drift if any
- **decision** - keep, revert, or investigate further

If a change makes the benchmark faster but changes response semantics, the note must call that out as a regression, not an improvement.

## TDD-oriented perf workflow

Performance work in this repo should follow the same discipline as correctness work:

1. define the scenario
2. define the correctness invariants
3. implement validation first
4. collect a baseline
5. make one change
6. rerun the same scenario matrix
7. compare against the saved artifact, not memory

The current `perf/pgrest/benchmark/validate.js` pattern is the reference example for “measure only after semantic validation.”

## Interpreting results

Use these rules by default:

- compare only runs with the same scenario, load, and build mode
- reject runs with correctness failures even if they are faster
- treat `p95` and `p99` as first-class, not optional extras
- watch for payload-size drift and status-count drift
- investigate suspiciously large wins before celebrating them
- when comparing two services, always label the direction explicitly, for example `pgrest : PostgREST`

## Module responsibilities

When a module adopts perf tooling, it owns:

- benchmark-specific nginx config
- scenario definitions
- fixtures and seed data
- correctness validation for the benchmarked responses
- module-specific setup/teardown rules
- interpretation notes and caveats

It should avoid:

- inventing a custom CLI shape when `perf/common/benchmark_cli.js` already fits
- putting one-off fixtures or validators into `perf/common/`
- storing generated output outside its own module subtree

## Shared-tooling responsibilities

`perf/common/` should contain only proven shared pieces, such as:

- generic CLI parsing
- nginz lifecycle helpers
- process/docker/wait helpers
- non-intrusive profiling helpers
- artifact directory creation and metadata capture
- result summarization and console reporting
- future shared result schemas or optional Zig instrumentation helpers once they are used by multiple modules

It should not contain:

- module-specific SQL fixtures
- module-specific request scenarios
- service-specific correctness validators
- module-specific benchmark configs

## Adding performance coverage for a new module

Use this checklist:

1. create `perf/<module>/`
2. add a dedicated `nginx.conf` for perf runs
3. define representative scenarios
4. define deterministic fixtures or mocks
5. implement validation before benchmarking
6. choose a profiling mode (`snapshot` by default, `perf-stat` when appropriate)
7. reuse `perf/common/` helpers wherever possible
8. collect one initial baseline before optimization work starts
9. record every iteration in notes

## Current repo-specific guidance

- prefer `tests/` for correctness and `perf/` for measurement; do not mix them
- many existing nginx configs use `error_log logs/error.log debug;` and `access_log logs/access.log;`, which is useful for local diagnosis and should be preserved when it helps explain anomalies
- `KEEP_LOGS=1` is useful when you need to preserve runtime artifacts for debugging
- `ZIG_OPTIMIZE` should always be recorded in perf notes because it materially changes the run
- perf runners should default to `ZIG_OPTIMIZE=ReleaseSmall` unless the benchmark is explicitly studying a different optimization mode
- the Prometheus module is the current in-repo standard for production metrics collection when a benchmark wants nginx-native counters and histograms

## Maintenance expectation

- `perf/README.md` is the project-wide handbook
- `perf/common/README.md` documents the shared utilities only
- `perf/<module>/README.md` documents module-specific setup, caveats, and benchmark entrypoints

When shared conventions change, update this handbook in the same batch.
