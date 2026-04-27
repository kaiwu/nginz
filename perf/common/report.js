function percentileFromSorted(values, fraction) {
  if (values.length === 0) return 0;
  const index = Math.min(values.length - 1, Math.max(0, Math.ceil(values.length * fraction) - 1));
  return values[index];
}

export function summarizeSamples(samples, wallTimeMs) {
  const latencies = samples.map((sample) => sample.latencyMs).sort((a, b) => a - b);
  const payloads = samples.map((sample) => sample.payloadBytes).sort((a, b) => a - b);
  const statusCounts = {};

  for (const sample of samples) {
    const key = String(sample.status);
    statusCounts[key] = (statusCounts[key] ?? 0) + 1;
  }

  const successTotal = samples.filter((sample) => sample.status >= 200 && sample.status < 300).length;
  const requestsTotal = samples.length;
  const meanLatency = requestsTotal === 0 ? 0 : latencies.reduce((sum, value) => sum + value, 0) / requestsTotal;
  const meanPayload = requestsTotal === 0 ? 0 : payloads.reduce((sum, value) => sum + value, 0) / requestsTotal;

  return {
    requests_total: requestsTotal,
    success_total: successTotal,
    status_counts: statusCounts,
    throughput_rps: wallTimeMs > 0 ? (requestsTotal * 1000) / wallTimeMs : 0,
    latency_p50_ms: percentileFromSorted(latencies, 0.5),
    latency_p95_ms: percentileFromSorted(latencies, 0.95),
    latency_p99_ms: percentileFromSorted(latencies, 0.99),
    latency_mean_ms: meanLatency,
    latency_max_ms: latencies.at(-1) ?? 0,
    payload_bytes_min: payloads[0] ?? 0,
    payload_bytes_mean: meanPayload,
    payload_bytes_max: payloads.at(-1) ?? 0,
  };
}

export function printSummary(results) {
  const rows = results.map((result) => ({
    service: result.service,
    scenario: result.scenario,
    concurrency: result.concurrency,
    rps: result.summary.throughput_rps.toFixed(2),
    p50_ms: result.summary.latency_p50_ms.toFixed(2),
    p95_ms: result.summary.latency_p95_ms.toFixed(2),
    p99_ms: result.summary.latency_p99_ms.toFixed(2),
    bytes_mean: result.summary.payload_bytes_mean.toFixed(0),
    ok: `${result.summary.success_total}/${result.summary.requests_total}`,
  }));

  console.table(rows);
}
