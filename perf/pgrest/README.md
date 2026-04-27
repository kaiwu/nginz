# pgrest performance tooling

This directory contains pgrest-specific benchmark runners, configs, fixtures, and notes.

Shared perf helpers live under `perf/common/`.

## Contents

- `nginx.conf` - benchmark-specific nginz config for pgrest
- `benchmark/` - pgrest vs PostgREST benchmark runner, fixtures, scenarios, and validation logic

## Artifact layout

Each benchmark run now writes a dedicated run directory under `perf/pgrest/benchmark/output/`:

```text
output/<run-id>/
  manifest.json
  benchmark.json
  environment.json
  command.json
  profiling/
    summary.json
    perf-stat.txt        # optional
  logs/
  runtime/              # preserved only with --keep-runtime
```

## Usage

```bash
bun perf/pgrest/benchmark/run.js --help

# default matrix, both pgrest and postgrest
bun perf/pgrest/benchmark/run.js

# narrower run
bun perf/pgrest/benchmark/run.js --scenario=small-page --concurrency=1,8 --requests=200 --warmup=20

# enable optional perf stat capture when available
bun perf/pgrest/benchmark/run.js --profile=perf-stat --scenario=small-page --service=pgrest
```

Default profiling mode is `snapshot`. When `perf` is installed and the user asks for `--profile=perf-stat`, the runner adds system-counter capture without requiring module instrumentation.

Results are written to `perf/pgrest/benchmark/output/`.

## Schema cache note

PostgREST has a persistent startup-loaded schema cache that can be reloaded.

The current `pgrest` module does **not** have that same kind of persistent schema cache. It performs targeted runtime introspection for specific features such as relationship and RPC metadata, but there is no resident cached metadata layer equivalent to PostgREST's `SchemaCache`.
