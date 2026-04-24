# pgrest ROADMAP

This roadmap audits the current `pgrest` nginx module against the PostgREST API reference under `postgrest-docs/docs/references/api` and turns the gaps into an implementation backlog.

The goal is not to list every internal cleanup task. The goal is to get `pgrest` closer to actual PostgREST behavior, with work grouped by feature area and ordered from easy to hard inside each category.

## Status Legend

- **Implemented**: behavior is present and close enough to PostgREST parity to not need roadmap work.
- **Partial**: behavior exists, but semantics, coverage, or execution-path consistency still differ from PostgREST.
- **Missing**: feature is absent.

## Current Snapshot

### Already present

- Basic table CRUD routing through HTTP methods
- Basic query shaping: `select`, `order`, `limit`, `offset`
- Basic operators: `eq`, `neq`, `gt`, `gte`, `lt`, `lte`, `like`, `ilike`, `is`, `in`
- Schema profile headers: `Accept-Profile`, `Content-Profile`
- RPC GET/POST calls with JSON bodies and JSON array parameters
- `Prefer: params=single-object`
- JSON, CSV, plain text, and XML response formatting in the blocking path
- `application/vnd.pgrst.object+json` and `nulls=stripped` in the blocking path
- JWT signature validation, JWT passthrough, and role switching
- A non-blocking / pooled execution path

### Important parity caveats

- Several features are only **partial parity**, not full PostgREST behavior.
- The blocking and pooled execution paths do **not** currently behave the same.
- Some README claims are ahead of actual behavior, especially around binary/media handling.

---

## 1. Tables, Views, and URL Grammar

**Status:** Partial

Current module support is centered on single-resource CRUD plus a limited subset of PostgREST URL grammar.

### Action points (easy → hard)

- **[Easy]** Add integration tests for currently parsed but under-tested operators: `neq`, `gte`, `lte`, `like`, `ilike`.
- **[Easy]** Align reserved-parameter handling so feature keys like `select`, `order`, `limit`, and `offset` are cleanly separated from filters in all cases.
- **[Medium]** Add PostgREST logical operators: `or`, `and`, and `not`.
- **[Medium]** Add operator modifiers: `any` and `all`.
- **[Medium]** Add advanced PostgREST operators: `match`, `imatch`, full-text search variants (`fts`, `plfts`, `phfts`, `wfts`), and range/array operators (`cs`, `cd`, `ov`, `sl`, `sr`, `nxr`, `nxl`, `adj`, `isdistinct`).
- **[Medium]** Support PostgREST-style URL grammar escaping for reserved characters, quoted values, unicode names, and identifiers with spaces/dots.
- **[Medium]** Support column aliasing and casting in `select` (`alias:col`, `col::type`).
- **[Medium]** Support JSON/composite/array path operators in both `select` and filtering.
- **[Medium]** Support richer ordering semantics, including `nullsfirst`, `nullslast`, and ordering on JSON/composite paths.
- **[Hard]** Add limited update/delete parity with `limit` + required unique ordering.
- **[Hard]** Verify and align behavior for views, not just tables, including write semantics where PostgREST allows them.
- **[Hard]** Add upsert semantics: `Prefer: resolution=merge-duplicates`, `Prefer: resolution=ignore-duplicates`, `on_conflict`, and `PUT` single-row upsert behavior.
- **[Hard]** Add bulk write support for JSON arrays, CSV insert payloads, `columns=...`, and `missing=default` behavior.

---

## 2. Resource Representation and Media Types

**Status:** Partial

The blocking path supports multiple formats, but representation semantics are still short of PostgREST parity.

### Action points (easy → hard)

- **[Easy]** Fix singular-object semantics so `application/vnd.pgrst.object+json` returns PostgREST-style errors when zero or multiple rows are returned, instead of silently returning `{}` or the first row.
- **[Easy]** Return proper unsupported-media behavior for unknown `Accept` values instead of silently defaulting to JSON.
- **[Easy]** Reconcile README claims with actual binary/media behavior.
- **[Medium]** Implement real `application/octet-stream` response handling for bytea-like responses instead of JSON fallback.
- **[Medium]** Add request-body media type parity where applicable: `application/x-www-form-urlencoded`, `text/csv`, `application/octet-stream`, `text/plain`, `text/xml`.
- **[Medium]** Support PostgREST-style vendor media handling beyond current JSON variants where practical.
- **[Hard]** Add custom media type handler parity, or clearly define the subset intentionally unsupported.
- **[Hard]** Make representation/media behavior identical across blocking and pooled execution paths.

---

## 3. Stored Procedures / RPC

**Status:** Partial

RPC is one of the stronger areas today, but it still trails PostgREST in method semantics, body types, and parity with table endpoints.

### Action points (easy → hard)

- **[Easy]** Expand integration coverage for RPC response formats beyond current JSON-focused tests.
- **[Easy]** Verify GET/HEAD allowances based on function volatility and fail correctly when semantics do not permit a method.
- **[Medium]** Support single unnamed parameter flows for `json/jsonb`, `text`, `xml`, and `bytea`.
- **[Medium]** Support repeated parameters / variadic function calling semantics.
- **[Medium]** Support PostgREST-style array input parity for both GET and POST variants.
- **[Medium]** Align scalar vs table-valued response shaping more closely with PostgREST semantics.
- **[Hard]** Support table-valued function parity with the same filtering, ordering, pagination, and embedding model as table endpoints.
- **[Hard]** Carry profile headers, preferences, and representation features consistently across RPC in both execution paths.

---

## 4. Pagination, Count, and HTTP Semantics

**Status:** Missing / Partial

Query-param `limit` and `offset` exist, but PostgREST’s HTTP-level pagination contract is mostly missing.

### Action points (easy → hard)

- **[Easy]** Add `HEAD` parity for read endpoints.
- **[Easy]** Return stable status codes and response metadata for read/write operations where current behavior is too generic.
- **[Medium]** Add `Range-Unit`, `Range`, and `Content-Range` header handling.
- **[Medium]** Emit partial-content responses where PostgREST would use them.
- **[Medium]** Add `Prefer: count=exact|planned|estimated` parsing and response behavior.
- **[Hard]** Extend pagination/count semantics to table-valued functions and other supported endpoint types.
- **[Hard]** Keep range/count behavior consistent across blocking and pooled execution paths.

---

## 5. Prefer Header Parity

**Status:** Partial

`Prefer: params=single-object` exists, but PostgREST uses `Prefer` as a much broader API contract.

### Action points (easy → hard)

- **[Easy]** Introduce a central Prefer parser instead of handling individual cases ad hoc.
- **[Easy]** Add `Preference-Applied` headers where behavior is honored.
- **[Medium]** Add `Prefer: return=minimal|headers-only|representation` for writes.
- **[Medium]** Add `Prefer: handling=strict|lenient` and strict invalid-preference errors.
- **[Medium]** Add `Prefer: missing=default` for bulk/default-value insert flows.
- **[Medium]** Add `Prefer: max-affected` enforcement for write/RPC flows where applicable.
- **[Hard]** Add `Prefer: tx=commit|rollback` support if it fits the module’s execution model.
- **[Hard]** Ensure Prefer behavior is consistent across table, RPC, blocking, and pooled paths.

---

## 6. Schemas and Profile Handling

**Status:** Partial

Profile headers exist, but PostgREST schema governance is broader than raw schema qualification.

### Action points (easy → hard)

- **[Easy]** Add tests for schema/profile behavior across all supported methods and both execution paths.
- **[Medium]** Enforce an explicit schema allowlist model similar to PostgREST `db-schemas` instead of accepting arbitrary profile values.
- **[Medium]** Return PostgREST-style errors for disallowed or invalid profile headers.
- **[Medium]** Add default-schema selection rules that match PostgREST’s multi-schema behavior.
- **[Hard]** Ensure pooled execution uses the same schema qualification behavior as the blocking path.
- **[Hard]** Consider whether dynamic schema reloading/configuration belongs in scope; if yes, design it explicitly instead of letting it emerge accidentally.

---

## 7. Resource Embedding and Relationship Features

**Status:** Missing

This is one of the biggest parity gaps versus real PostgREST.

### Action points (easy → hard)

- **[Medium]** Define the minimum supported relationship model before implementation begins: foreign-key introspection only, or also computed relationships.
- **[Medium]** Add one-level many-to-one and one-to-many embedding through `select=...,related(...)`.
- **[Hard]** Add many-to-many embedding through join-table inference.
- **[Hard]** Add nested embedding.
- **[Hard]** Add embedded filtering, ordering, limit, and offset.
- **[Hard]** Add top-level filtering via `!inner`, null-based embedding filters, and empty embeds.
- **[Hard]** Add disambiguation syntax like `!fk` where multiple foreign-key relationships exist.
- **[Hard]** Add spread embedding (`...rel(...)`) and mutation-time embedding where practical.
- **[Hard]** Add support for computed relationships, recursive relationships, view relationships, and table-valued-function relationships if these remain in scope.

---

## 8. Aggregate Functions and Computed Fields

**Status:** Missing

PostgREST exposes aggregate and computed-field features through the same request grammar; current pgrest does not.

### Action points (easy → hard)

- **[Medium]** Extend `select` parsing to recognize aggregate expressions like `sum()`, `avg()`, `min()`, `max()`, and `count()`.
- **[Medium]** Support grouped aggregate queries through PostgREST-style `select` combinations.
- **[Medium]** Support renaming and casting of aggregate outputs.
- **[Medium]** Support computed fields in `select`, filtering, and ordering.
- **[Hard]** Support aggregate interaction with JSON paths and casts.
- **[Hard]** Support aggregate/computed-field interaction with embedding and spread semantics.

---

## 9. OPTIONS, CORS, and OpenAPI Surface

**Status:** Missing

PostgREST’s browser-facing API surface is broader than plain CRUD responses.

### Action points (easy → hard)

- **[Easy]** Add `OPTIONS` responses that advertise allowed methods per endpoint kind.
- **[Easy]** Add basic CORS headers for simple requests.
- **[Medium]** Add CORS preflight handling, including `Access-Control-Allow-*` and `Access-Control-Max-Age` behavior.
- **[Medium]** Decide and document whether CORS is always permissive by default or explicitly configured.
- **[Hard]** Add a root endpoint that can serve OpenAPI JSON.
- **[Hard]** Generate endpoint/method metadata for tables, views, and RPC routes closely enough to be useful.
- **[Hard]** Decide whether full PostgREST-style OpenAPI override/customization is in scope, and if not, document the reduced contract.

---

## 10. Execution-Path Parity and Correctness Hardening

**Status:** Partial

This is the main cross-cutting category that can quietly break every feature above if left behind.

### Action points (easy → hard)

- **[Easy]** Add a parity checklist so every newly added feature is tested in both blocking and pooled modes.
- **[Easy]** Add explicit tests for `pgrest_pooling`, `pgrest_server`, and `pgrest_keepalive`.
- **[Medium]** Unify schema/profile behavior across blocking and pooled paths.
- **[Medium]** Unify content negotiation and JSON variants across blocking and pooled paths.
- **[Medium]** Unify error formatting and status code behavior across both paths.
- **[Medium]** Enforce JWT expiration and other basic token validation semantics that are currently absent.
- **[Hard]** Replace manual SQL string construction with parameterized query execution where feasible.
- **[Hard]** Revisit global pooled-state design so upstream configuration is not silently shared in the wrong places.
- **[Hard]** Add failure-mode coverage for connection errors, malformed payloads, and SQL/runtime errors.

---

## 11. Documentation and Coverage Alignment

**Status:** Partial

The roadmap is primarily about feature parity, but documentation drift will slow that work down if left unresolved.

### Action points (easy → hard)

- **[Easy]** Keep `README.md` aligned with actual behavior, especially for binary/media claims.
- **[Easy]** Document all exported `pgrest_*` directives in one directive reference section.
- **[Easy]** Add a parity matrix section to the README once the roadmap starts landing.
- **[Medium]** Expand Bun integration tests category by category as roadmap items are implemented.
- **[Medium]** Use failing integration tests as the entry point for each roadmap item wherever possible.

---

## Batch 1: Foundation Parity and HTTP Contract

This is the first implementation batch because it is the smallest self-contained slice that improves correctness without expanding the query grammar or relationship model.

### Batch 1 goals

- Make the blocking and pooled execution paths behave closer to each other.
- Lock down HTTP semantics that later batches will rely on.
- Improve observable protocol correctness before adding new feature surface.

### Included in Batch 1

- **Execution-path parity tests** for features that already exist in blocking mode and need pooled-mode coverage.
- **Directive coverage** for `pgrest_pooling`, `pgrest_server`, and `pgrest_keepalive`.
- **Singular object correctness** for `application/vnd.pgrst.object+json`.
- **Unsupported Accept handling** so invalid media requests do not silently fall back to JSON.
- **HEAD support** for read endpoints.
- **Range header foundation**: `Range-Unit`, `Range`, and `Content-Range` basics.
- **Central Prefer parsing** for currently supported behavior.
- **Preference-Applied headers** when behavior is actually honored.
- **Error/status parity** between blocking and pooled paths for the features covered by this batch.

### Explicitly excluded from Batch 1

These stay out of the first batch because they enlarge the parser, require introspection, or create cross-feature coupling:

- URL grammar expansion (`or`, `and`, `not`, advanced operators, quoting/escaping work)
- Embedding and relationship features
- Aggregate functions and computed fields
- Schema allowlist governance and dynamic schema behavior
- Full RPC expansion beyond current surface
- Bulk writes, upsert, and `missing=default`
- CORS/OpenAPI work
- Parameterized query redesign

### Why Batch 1 is self-contained

- It works mostly at the **HTTP contract** and **execution-path parity** layer.
- It does **not** require schema introspection.
- It does **not** require new SQL grammar features.
- It reduces regression risk for later batches by making existing behavior more testable and more consistent first.

### Batch 1 acceptance criteria

- Every feature touched in this batch has integration coverage in both blocking and pooled modes where applicable.
- `application/vnd.pgrst.object+json` no longer silently returns `{}` for zero rows or silently picks the first row from multiple rows.
- Unknown `Accept` values fail with an explicit unsupported-media response instead of defaulting to JSON.
- `HEAD` on supported read endpoints returns headers without a response body.
- Read endpoints can emit the basic range headers needed for later pagination/count work.
- `Prefer: params=single-object` is parsed centrally and emits `Preference-Applied` when honored.
- Equivalent success and failure cases return aligned status codes and response structure across blocking and pooled paths.

### Batch boundaries

Batch 1 should land as a protocol/correctness batch only. It should not quietly introduce new query features while fixing these semantics. That boundary keeps future batches independent: URL grammar can expand later, schema governance can tighten later, and embedding/aggregates can be designed later without needing to revisit the first batch.

---

## Full Batch Plan

These batches are intended to fully cover the roadmap while keeping the highest-risk coupling points separated: HTTP contract, representation, parser expansion, schema governance, introspection-heavy relationship work, and final hardening.

### Global batching rules

- Every batch must ship its own **tests** and **documentation deltas** alongside code changes.
- Every batch must state what is **explicitly out of scope** so it does not silently absorb later work.
- Any feature that exists in both blocking and pooled execution paths must be tested in both paths before a batch is considered done.
- Parser-expansion batches must not quietly redesign execution-path or schema-governance behavior.
- Introspection-heavy work must stay behind schema/profile stabilization.

### Upstream-module and performance guardrails

This module is not a standalone PostgREST server. It is an nginx upstream module between the client and PostgreSQL, so roadmap execution should stay focused on features that fit that architecture and preserve performance.

- Prefer features that keep the request path **simple, cacheable, and low-allocation**.
- Do not add runtime schema/relationship introspection to the hot path unless it is explicitly cached or otherwise bounded.
- Keep **blocking** and **pooled** paths aligned; a feature that only works in one path is not done.
- Avoid parity work that forces expensive buffering or architectural churn unless it delivers clear user value in this upstream shape.
- Treat advanced PostgREST features as **subset/guarded scope** when full parity would materially hurt throughput or operational simplicity.
- Every batch should verify that the new work does not regress the pooled path, because that is the most performance-relevant execution mode.
- Documentation for each batch should clearly say when pgrest intentionally supports a narrower contract than PostgREST for upstream/performance reasons.

### Batch 2: Media Types and Representation Completeness

**Theme:** Finish content negotiation and response-format correctness without changing query grammar.

**Includes**
- Real `application/octet-stream` handling instead of JSON fallback
- Request-body media type support where already listed in the roadmap (`application/x-www-form-urlencoded`, `text/csv`, `application/octet-stream`, `text/plain`, `text/xml`) when applicable
- Representation parity across blocking and pooled paths for already supported formats
- README cleanup for media-type claims

**Excludes**
- Custom media type handlers
- URL grammar expansion
- Embedding and aggregates

**Why it is self-contained**
- Works at the formatting and body-parsing layer
- Builds on Batch 1’s Accept/error semantics without requiring parser or introspection changes

**Unlocks**
- Stable representation behavior for later RPC, aggregate, and embedding work

### Batch 3: Prefer Header Completeness and Write Contract

**Theme:** Expand the Prefer contract and write-response semantics before larger query features land.

**Includes**
- `Prefer: return=minimal|headers-only|representation`
- `Prefer: handling=strict|lenient`
- `Prefer: max-affected`
- `Preference-Applied` consistency for newly supported Prefer behaviors
- Write-side status/response semantics that depend on Prefer handling

**Excludes**
- Upsert and bulk-write semantics that require broader SQL/write-shape changes
- `Prefer: tx=commit|rollback`
- URL grammar expansion

**Why it is self-contained**
- Reuses the central Prefer parser from Batch 1
- Focuses on response contract rather than parser or introspection breadth

**Unlocks**
- Predictable write behavior for later bulk-write and upsert work

### Batch 4: URL Grammar Expansion

**Theme:** Expand the request grammar in a controlled way.

**Includes**
- Logical operators: `or`, `and`, `not`
- Operator modifiers: `any`, `all`
- Advanced operators: `match`, `imatch`, `fts`, `plfts`, `phfts`, `wfts`, `cs`, `cd`, `ov`, `sl`, `sr`, `nxr`, `nxl`, `adj`, `isdistinct`
- URL escaping for reserved characters, quoted values, unicode names, and identifiers with spaces/dots
- Richer ordering semantics such as `nullsfirst` and `nullslast`

**Gated subphases inside Batch 4**
- **4A:** operators, logic, escaping, ordering
- **4B:** aliasing/casting and JSON/composite/array path grammar

**Excludes**
- Embedding grammar
- Aggregate grammar
- Bulk writes and upsert

**Why it is self-contained**
- Keeps grammar work together without mixing in schema introspection or relationship logic

**Unlocks**
- Richer filtering for later RPC/table-valued function parity and embedding

### Batch 5: Schema Governance, Profiles, and View Semantics

**Theme:** Stabilize schema selection rules before relationship-aware work begins.

**Includes**
- Schema allowlist behavior similar to PostgREST `db-schemas`
- Invalid/disallowed profile error semantics
- Default-schema selection rules for multi-schema behavior
- Pooled-path schema/profile parity
- View support review and implementation where PostgREST semantics are meant to apply

**Excludes**
- Relationship introspection
- Dynamic schema reloading unless explicitly chosen

**Why it is self-contained**
- It is configuration/governance work, not query-grammar or relationship expansion

**Unlocks**
- Safer foundation for embedding and cross-schema behavior

### Batch 6: Bulk Writes and Upsert Semantics

**Theme:** Finish advanced table write behavior after Prefer and schema rules are stable.

**Includes**
- Bulk JSON-array inserts
- CSV insert payloads
- `columns=...`
- `missing=default`
- Upsert semantics: `Prefer: resolution=merge-duplicates`, `Prefer: resolution=ignore-duplicates`, `on_conflict`, and `PUT` single-row upsert behavior
- Limited update/delete parity with `limit` plus required ordering if still considered table-write scope rather than pure grammar scope

**Excludes**
- Embedding-on-write
- Aggregate and relationship features

**Why it is self-contained**
- Concentrates risky write-path SQL behavior into one batch after Prefer and schema groundwork are done

**Unlocks**
- Complete write-side table contract before advanced RPC/embedding layers build on it

### Batch 7: RPC Parity Expansion

**Theme:** Bring RPC behavior closer to table-endpoint parity without relationship introspection yet.

**Includes**
- GET/HEAD method rules based on function volatility
- Single unnamed parameter flows for `json/jsonb`, `text`, `xml`, and `bytea`
- Repeated parameters and variadic function semantics
- Array input parity across GET and POST variants
- Scalar vs table-valued response shaping improvements
- Table-valued function parity for filtering, ordering, pagination, and profile/preference behavior where it does not depend on embedding

**Excludes**
- RPC embedding
- Aggregate/embedding interactions

**Why it is self-contained**
- Builds on Batch 4 grammar and Batch 5/6 contract work without needing relationship introspection yet

**Unlocks**
- A credible PostgREST-like RPC layer before the relationship model arrives

### Batch 8: Pagination and Count Completeness

**Theme:** Finish the HTTP pagination/count contract cleanly, separate from discovery surface.

**Includes**
- Full `Range-Unit`, `Range`, and `Content-Range` behavior
- Partial-content status semantics where applicable
- `Prefer: count=exact|planned|estimated`
- Count/pagination parity across blocking and pooled paths
- Extension of count/pagination semantics to supported RPC/table-valued-function flows

**Excludes**
- OPTIONS/CORS/OpenAPI
- Embedding

**Why it is self-contained**
- Strictly HTTP response semantics, building on Batch 1 foundation and later query support

**Unlocks**
- Stable count-aware clients and correct response metadata for later advanced features

### Batch 9: Aggregate Functions and Computed Fields

**Theme:** Add computed query features without mixing in relationships yet.

**Includes**
- Aggregate expressions in `select`: `sum()`, `avg()`, `min()`, `max()`, `count()`
- Grouped aggregate queries
- Renaming and casting of aggregate outputs
- Computed fields in `select`, filtering, and ordering
- Aggregate interaction with JSON paths and casts

**Excludes**
- Aggregate behavior inside embedding/spread semantics

**Why it is self-contained**
- Uses the stabilized grammar layer from Batch 4 without requiring relationship introspection

**Unlocks**
- Analytics/reporting use cases and computed-field parity before embedding complexity arrives

### Batch 10: Resource Embedding and Relationships — Phase 1

**Theme:** Introduce the smallest relationship model that is still useful.

**Includes**
- Relationship model decision (at minimum FK introspection scope)
- One-level many-to-one and one-to-many embedding
- Basic disambiguation using `!fk`
- Basic embedded filtering, ordering, limit, and offset where they fit the phase-1 model

**Excludes**
- Many-to-many join-table inference
- Nested embedding
- Spread syntax
- Recursive/view/computed/table-valued-function relationships

**Why it is self-contained**
- Keeps the first introspection-heavy relationship step intentionally narrow

**Unlocks**
- A usable but limited embedding model for common parent/child and to-one cases

### Batch 11: Resource Embedding and Relationships — Phase 2

**Theme:** Finish the advanced relationship model after phase 1 is stable.

**Includes**
- Many-to-many embedding via join-table inference
- Nested embedding

**Gated subphases inside Batch 11**
- **11A:** many-to-many and nested embedding
- **11B:** advanced embed filters, spread syntax, recursive/view/computed/table-valued-function relationships, mutation-time embedding where still in scope

**Also includes interface/discovery surface**
- `OPTIONS` responses
- CORS simple + preflight handling
- OpenAPI root/discovery surface and route/method metadata generation

**Excludes**
- Final hardening-only work

**Why it is self-contained**
- Collects the remaining API-surface and advanced relationship features after the underlying semantics are already stable

**Unlocks**
- Near-complete public interface parity for advanced consumers

### Batch 12: Execution-Path Parity Gap Closure and Hardening

**Theme:** Final parity closure, safety, and proof that the roadmap is fully covered.

**Includes**
- Remaining blocking vs pooled path gap closure
- JWT expiration and related token-validation hardening
- Parameterized query execution where feasible
- Global pooled-state design cleanup where necessary
- Failure-mode coverage for connection errors, malformed payloads, and SQL/runtime errors
- Final docs/coverage sweep that maps every roadmap category to tests and documentation

**Excludes**
- New feature-surface expansion

**Why it is self-contained**
- It is a hardening batch only; by this point feature breadth should already be in place

**Unlocks**
- A more production-safe module and a clear proof that the roadmap has actually been covered

---

## Compact Execution Table

This table is meant to make the batches implementation-ready. The file list is intentionally conservative and names the files we already know are central today.

| Batch | Primary Goal | Likely Files | Main Tests | Main Blockers | Exit Criteria |
|---|---|---|---|---|---|
| 1 | HTTP contract + path parity baseline | `src/modules/pgrest-nginx-module/ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `tests/pgrest/nginx.conf`, `src/modules/pgrest-nginx-module/README.md` | singular object errors, unsupported `Accept`, `HEAD`, range foundation, pooled-vs-blocking parity, directive coverage | current blocking/pooled divergence | existing semantics are aligned across both paths for covered features and documented |
| 2 | Finish media/body format correctness | same files as Batch 1 | binary response behavior, request-body media handling, representation parity by Accept type | binary handling and pooled-path formatting gaps | supported media/body formats behave consistently and README claims match reality |
| 3 | Complete Prefer response contract | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | `Preference-Applied`, strict/lenient handling, `return=*`, `max-affected` | central parser extension without breaking existing behavior | Prefer behavior is centralized, tested, and stable for current write paths |
| 4 | Expand URL grammar safely | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | operator matrix, escaping/quoted values, ordering semantics, alias/cast/path grammar | parser breadth and SQL builder complexity | grammar additions pass without changing unrelated execution semantics |
| 5 | Stabilize schema/profile rules and views | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `tests/pgrest/nginx.conf`, `README.md` | allowlist/default-schema behavior, invalid profile errors, pooled schema parity, view coverage | schema policy design and pooled-path parity | profile behavior is explicit, bounded, and stable before introspection-heavy work |
| 6 | Finish advanced table writes | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | bulk JSON/CSV writes, `columns`, `missing=default`, upsert cases, limited update/delete cases | write-path SQL complexity and correctness | bulk/upsert/write semantics are complete for the chosen scope and do not regress existing CRUD |
| 7 | Raise RPC to table-endpoint parity | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `tests/pgrest/nginx.conf`, `README.md` | volatility-based methods, unnamed params, variadics, arrays, TVF filtering/order/pagination | keeping RPC semantics aligned with table semantics | RPC surface is coherent, documented, and tested without requiring embedding |
| 8 | Finish pagination/count contract | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | `Range`/`Content-Range`, partial content, `Prefer: count=*`, TVF count cases | header/status correctness across both paths | count/pagination metadata is stable and reusable by later features |
| 9 | Add aggregates and computed fields | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | aggregate select cases, grouped output, computed field select/filter/order, cast/path interactions | select grammar and result-shaping complexity | aggregate/computed-field support works on the stabilized grammar layer without relationship coupling |
| 10 | Embedding phase 1 | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | one-level to-one/to-many embedding, basic `!fk`, embedded filters/order/limit | relationship model choice and bounded introspection | a narrow relationship model works reliably and stays within upstream/performance guardrails |
| 11 | Embedding phase 2 + interface surface | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `tests/pgrest/nginx.conf`, `README.md` | many-to-many, nested embed, advanced embed filters, spread, OPTIONS, CORS, OpenAPI/root metadata | highest feature coupling and public-surface breadth | advanced relationship/API-surface work lands without reopening earlier contract decisions |
| 12 | Final parity closure and hardening | `ngx_http_pgrest.zig`, `tests/pgrest/pgrest.test.js`, `README.md` | pooled-vs-blocking gap sweep, JWT expiry, error-path coverage, SQL/runtime failure coverage, final docs/tests audit | hardening without accidental new features | remaining parity gaps are closed or intentionally documented as out of scope for upstream/performance reasons |

---

## Batch-to-Roadmap Coverage Map

- **URL grammar** → Batch 4
- **Representation/media** → Batches 1-2
- **RPC** → Batch 7
- **Pagination/count** → Batches 1 and 8
- **Prefer** → Batches 1 and 3
- **Schemas/profile** → Batch 5
- **Bulk write/upsert table semantics** → Batch 6
- **Embedding/relationships** → Batches 10-11
- **Aggregates/computed fields** → Batch 9
- **OPTIONS/CORS/OpenAPI** → Batch 11
- **Execution-path parity** → Batches 1 and 12
- **Documentation/coverage** → Every batch, with final closure in Batch 12

---

## Suggested Delivery Order Across Categories

If we want steady wins without painting ourselves into a corner, the most practical order is:

1. **Batch 1: foundation parity and HTTP contract**
2. **Batch 2: media types and representation completeness**
3. **Batch 3: Prefer header completeness and write contract**
4. **Batch 4: URL grammar expansion**
5. **Batch 5: schema governance, profiles, and view semantics**
6. **Batch 6: bulk writes and upsert semantics**
7. **Batch 7: RPC parity expansion**
8. **Batch 8: pagination and count completeness**
9. **Batch 9: aggregate functions and computed fields**
10. **Batch 10: embedding phase 1**
11. **Batch 11: embedding phase 2 plus interface/discovery surface**
12. **Batch 12: execution-path parity gap closure and hardening**

That order keeps foundational protocol behavior and path consistency ahead of parser growth, then delays introspection-heavy relationship work until after schema and query semantics are stable, and leaves final parity-proof hardening to the end.
