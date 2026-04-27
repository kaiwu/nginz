# perf/common

Shared performance utilities live here.

Current shared pieces:

- `benchmark_cli.js` - common CLI parsing/help for benchmark runners
- `nginz.js` - shared nginz build/start/stop helpers for perf runs
- `report.js` - latency/payload summary and console reporting helpers
- `system.js` - generic process, docker, and wait helpers
- `artifacts.js` - per-run artifact directory, manifest, environment, command, and log-capture helpers
- `profiling.js` - non-intrusive profiling layer with snapshot and optional `perf stat` support

Shared perf helpers should provide the common framework contract for every module:

- standard CLI shape
- standard run artifact layout
- standard low-overhead profiling modes
- standard build/runtime lifecycle management

As more modules adopt perf tooling, shared helpers should move here only when they are proven reusable across modules.
