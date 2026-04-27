export const SCENARIOS = [
  {
    name: "small-page",
    description: "Small ordered JSON page with common scalar columns",
    path: "/bench_users?select=id,name,email,status&order=id.asc&limit=25",
    headers: {},
  },
  {
    name: "medium-page",
    description: "Medium ordered JSON page with wider scalar payload",
    path: "/bench_users?select=id,org_id,name,email,status,created_at&order=id.asc&limit=250",
    headers: {},
  },
  {
    name: "filtered-read",
    description: "Indexed filtered read with stable ordering",
    path: "/bench_users?select=id,org_id,name,status&status=eq.active&org_id=eq.7&order=id.asc&limit=100",
    headers: {},
  },
  {
    name: "paged-read",
    description: "Filtered, ordered, paginated list endpoint",
    path: "/bench_users?select=id,name,email,status,created_at&status=eq.active&order=created_at.desc,id.desc&limit=100&offset=400",
    headers: {},
  },
  {
    name: "counted-read",
    description: "Read with PostgREST-style count preference",
    path: "/bench_users?select=id,name,status&status=eq.active&order=id.asc&limit=100",
    headers: {
      Prefer: "count=exact",
    },
  },
];

export function getScenario(name) {
  return SCENARIOS.find((scenario) => scenario.name === name) ?? null;
}
