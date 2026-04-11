# ISSUE #4 - ModSecurity-compatible direction for `ngx_http_waf`

## Issue

GitHub issue: `kaiwu/nginz#4`

Original request:

- make `ngx_http_waf` “ModSecurity compatible” so it can be production-usable.

Important discussion from the issue thread:

- one direction is a thin Zig wrapper around the real ModSecurity C library,
- but the issue also points at existing nginx WAF projects that are already production-ready,
- and there is additional interest in smart IP banning / fail2ban-like behavior.

## Reframed question

Because `libmodsecurity` is a heavy dependency, the practical question is not just:

> “Can we wrap ModSecurity?”

It is:

> “Can we make `ngx_http_waf` meaningfully ModSecurity-compatible **without** importing the full ModSecurity engine?”

After checking both local references, the answer is:

- **Yes, but only as a compatibility subset / native rule engine path**, not as full ModSecurity parity.

## What the two local references actually show

## 1. `ModSecurity-nginx`

Path:

- `/home/kaiwu/Documents/github/ModSecurity-nginx`

What it is:

- an nginx **connector** around `libmodsecurity`, not a native WAF engine.

What it teaches us:

- if we want true ModSecurity compatibility, the clean architecture is:
  - create a transaction,
  - feed connection / URI / headers / body into the library,
  - ask for intervention,
  - map intervention back into nginx.

Why it may not fit this issue well right now:

- it requires `libmodsecurity` as a real system dependency,
- it increases build and deployment complexity,
- it makes `ngx_http_waf` largely a wrapper layer rather than a Zig-native module.

## 2. `ngx_waf`

Path:

- `/home/kaiwu/Documents/github/ngx_waf`

What it is:

- a **native nginx WAF implementation** with its own config parser, rule loader, VM, caches, shared memory, and inspection pipeline.

What matters most for us:

- it claims ModSecurity compatibility **without** embedding `libmodsecurity`,
- it relies on:
  - native nginx phase integration,
  - custom rule/config parsing,
  - a VM/execution model for advanced rules,
  - `libinjection` for SQLi/XSS detection,
  - shared-memory/LRU/native data structures for operational features.

That means its compatibility story is closer to:

- **ModSecurity-like rule compatibility**, not **ModSecurity engine embedding**.

## Key takeaway

If we want to avoid a heavy `libmodsecurity` dependency, then issue #4 should be interpreted as:

> make `ngx_http_waf` support a useful ModSecurity-compatible rule/config subset through a native Zig implementation.

That is a different goal from wrapping the real engine.

## Recommendation

### Recommended approach for `nginz`

Do **not** make issue #4 a `libmodsecurity` binding project first.

Instead:

1. keep the current lightweight `ngx_http_waf` request-inspection core,
2. evolve it toward a **native rule engine**,
3. target a **small, explicit ModSecurity-compatible subset** first,
4. borrow structure from `ngx_waf`, not just syntax from ModSecurity,
5. treat smart IP banning / shared-memory enforcement as a later native enhancement.

### Why this is the better fit

- it avoids a heavy external library dependency,
- it preserves the repo’s current “nginx module written in Zig” spirit,
- it gives us room to build production-native features like IP banning,
- it matches how `ngx_waf` appears to achieve compatibility in practice.

## What “compatible” should mean here

It should **not** mean “full ModSecurity parity” at first.

It should mean:

- support a subset of familiar rule concepts and syntax,
- support rule files,
- support common request fields (URI, args, headers, body, IP, UA, cookie, referer),
- support block / detect semantics,
- eventually support enough of common CRS-style rules to be useful.

### Non-goal for the first milestone

Do **not** claim:

- full `libmodsecurity` compatibility,
- full CRS compatibility,
- response-body inspection parity,
- full SecRule action/operator matrix,
- drop-in replacement for `ModSecurity-nginx`.

## How `ngx_waf` suggests we should structure this

From the local codebase, the useful ideas are:

### 1. Separate rule loading from request execution

`ngx_waf` has explicit config/rule loading infrastructure and a VM execution path.

For `nginz`, that suggests:

- parse rule files at config load time,
- compile them into an internal rule representation,
- execute that representation cheaply per request.

### 2. Keep a scheduler / ordered inspection pipeline

`ngx_waf` clearly separates checks like IP, URL, args, cookies, referer, advanced rules, and CC logic.

For `nginz`, that suggests a pipeline like:

1. allowlist / bypass
2. blocklist / IP policy
3. URI
4. query args
5. headers / UA / referer / cookies
6. request body
7. advanced rule engine
8. optional auto-ban / IP reputation

### 3. Use native fast-path detectors where they help

`ngx_waf` uses `libinjection` for SQLi/XSS.

For `nginz`, this is much more attractive than pulling in full ModSecurity first.

That suggests:

- keep current lightweight pattern-based detection as the minimal baseline,
- add `libinjection` for stronger SQLi/XSS confidence,
- let the rule engine call those detectors as operators.

### 4. Shared memory belongs to operational controls, not basic compatibility

`ngx_waf` uses shared memory / caches for things like CC defense and access statistics.

For `nginz`, that suggests:

- first milestone: no shared-memory-heavy compatibility claims,
- later milestone: shared-memory offender tracking for IP bans / rate-like WAF behavior.

## Proposed architecture for `ngx_http_waf`

## A. Keep the current simple directives and engine

Current strengths:

- tiny and easy to test,
- simple detect/block mode,
- already integrated with URI/args/body phases,
- good baseline for Bun guardrails.

Do not throw this away.

## B. Add a native advanced-rule layer

Recommended additions:

- `waf_rule_path <dir-or-file>;`
- `waf_rules_file <file>;` or similar explicit file directive
- `waf_rules '...'` for inline rules later if needed

Implementation shape:

- parse at config time,
- compile into internal rule nodes/opcodes,
- execute in access/body phases using request context.

## C. Compatibility target: a focused rule subset

Start with a documented subset roughly like:

- targets:
  - URI
  - ARGS
  - REQUEST_BODY
  - REQUEST_HEADERS
  - REQUEST_COOKIES
  - REMOTE_ADDR
  - REQUEST_METHOD

- operators:
  - contains / substring
  - regex match
  - equals
  - libinjection_sqli
  - libinjection_xss

- actions:
  - deny
  - pass
  - log
  - status
  - id
  - phase

This is enough to build a credible first compatibility story without pretending to support everything.

## D. Defer full CRS ambition

CRS should be treated as an eventual validation target, not the first milestone.

Why:

- CRS assumes a wide and subtle ModSecurity surface area,
- claiming CRS support too early will create misleading expectations,
- a smaller compatibility slice can still be valuable and honest.

## E. Auto-ban / smart fail2ban as phase 2+

The issue comment asking for smart automatic IP blocking is valid, but it should come after the rule engine basics.

Recommended later model:

- count disruptive matches per IP in shared memory,
- configurable threshold + duration,
- optional temporary denylist,
- explicit directive family, separate from core rule parsing.

This is where `ngx_waf` is especially relevant as a reference.

## Concrete plan

## Phase 0 - scope lock

Goal:

- redefine issue #4 in `nginz` terms as:
  - **native ModSecurity-style compatibility subset**,
  - not `libmodsecurity` wrapping.

Deliverable:

- this plan file.

## Phase 1 - native rule infrastructure

Goal:

- create the minimum config-time rule loading pipeline.

Tasks:

1. define internal rule representation in Zig,
2. add rule-file directive(s),
3. build parser for a small supported rule subset,
4. compile rules at config load time,
5. fail config load on invalid syntax.

Success criteria:

- a simple rule file loads successfully,
- invalid rules fail fast at startup.

## Phase 2 - request execution engine

Goal:

- execute compiled rules against request fields.

Tasks:

1. expose request targets (uri, args, headers, body, cookies, ip, method),
2. implement operators (`contains`, `regex`, `equals`),
3. wire actions (`deny`, `pass`, `log`, `status`),
4. run request-body-dependent rules only when body reading is enabled/needed.

Success criteria:

- file-driven rules can block or log requests end-to-end.

## Phase 3 - detector upgrades

Goal:

- improve real protection quality without importing ModSecurity.

Tasks:

1. integrate `libinjection` for SQLi,
2. integrate `libinjection` for XSS,
3. expose them as operators in the rule engine,
4. keep current simple signatures as a fallback/basic mode.

Success criteria:

- rules can invoke libinjection-backed checks,
- Bun tests show better detection with fewer naive false positives.

## Phase 4 - compatibility/documentation pass

Goal:

- define exactly which ModSecurity-like syntax and semantics are supported.

Tasks:

1. document the supported subset clearly,
2. add compatibility examples,
3. test representative CRS-style snippets that fit the subset,
4. reject unsupported directives/operators explicitly.

Success criteria:

- users can tell what is and is not supported,
- supported examples work consistently.

## Phase 5 - native production features

Goal:

- add the operational features users actually expect from a production WAF.

Candidate tasks:

1. temporary IP ban on repeated rule hits,
2. shared-memory counters,
3. allowlists / blocklists,
4. richer logging / tracing,
5. request ID integration.

## What should be tested

The repo’s established guardrail is Bun integration tests, so the compatibility work should follow that.

Recommended test layers:

### Rule loading

- valid config/rule file loads,
- invalid rule file fails startup,
- inheritance across nested locations works.

### Request behavior

- clean requests pass,
- args rules block/log correctly,
- header/cookie/referer rules work,
- POST/PUT/PATCH body rules work,
- detect vs block mode works.

### Compatibility subset

- supported ModSecurity-like syntax examples,
- unsupported features fail explicitly,
- a few curated CRS-style examples pass if within supported subset.

### Native enhancements later

- auto-ban thresholds,
- ban expiry,
- shared-memory consistency.

## Risks

### 1. “Compatible” can easily become misleading

If we do not document the supported subset clearly, users will assume full ModSecurity parity.

### 2. Parser/VM scope can explode

Trying to support too much rule syntax too early will stall the project.

### 3. Detection quality matters more than syntax alone

Matching rule syntax without strong operators/detectors will disappoint users.

### 4. Auto-ban is operationally tricky

Temporary IP blocking introduces shared memory, eviction, and false-positive risk.

## Recommended decision

For issue #4, the best fit for this repo is:

> evolve `ngx_http_waf` into a native Zig WAF with a documented ModSecurity-compatible subset, borrowing architecture ideas from `ngx_waf`, instead of wrapping the heavy `libmodsecurity` engine first.

## Immediate next actions

1. confirm in the issue/docs that the target is a **native compatibility subset**,
2. define the first supported rule subset,
3. design the internal rule representation and file-loading API,
4. add config-time parsing and a small set of file-driven Bun tests,
5. integrate `libinjection` after the first rule engine milestone.

## Bottom line

If `libmodsecurity` is too heavy, then `nginz` should follow the **`ngx_waf` style of compatibility**:

- native nginx module,
- native rule/config parsing,
- optional accelerator libraries like `libinjection`,
- honest compatibility subset,
- production-native features like auto-ban added later.

That is the most realistic way to tackle issue #4 inside `ngx_http_waf` without turning the module into a thin wrapper around a heavy external engine.

---

## Current implementation status

The first step of this plan has now started in code.

Implemented in `ngx_http_waf`:

- new directive: `waf_rules_file <path>;`
- config-time rule loading from a checked-in test fixture / file
- native rule subset with one `SecRule` per line
- supported targets:
  - `REQUEST_URI`
  - `ARGS`
  - `QUERY_STRING`
  - `REQUEST_LINE`
  - `REQUEST_PROTOCOL`
  - `REQUEST_SCHEME`
  - `REQUEST_BASENAME`
  - `REQUEST_BODY`
  - `REQUEST_HEADERS`
  - `REQUEST_HEADER_NAMES`
  - `REQUEST_COOKIES`
  - `REQUEST_METHOD`
  - `REMOTE_ADDR`
  - `RESPONSE_STATUS`
  - `RESPONSE_HEADERS`
- supported operator:
  - `@contains <needle>`
  - `@pm <space-delimited phrases>`
  - `@within <space-delimited values>`
  - `@beginsWith <value>`
  - `@endsWith <value>`
  - `@streq <value>` / `@eq <value>`
  - `@rx <pattern>`
  - `@libinjection_sqli`
  - `@libinjection_xss`
- supported selectors:
  - `ARGS:<name>`
  - `REQUEST_HEADERS:<name>`
  - `REQUEST_COOKIES:<name>`
  - `RESPONSE_HEADERS:<name>`
- supported action subset also includes:
  - `status:<code>`
- supported action subset:
  - `id:<n>`
  - `phase:1|2|3`
  - `msg:'...'`
  - supported compatibility subset: `deny`, `block`, `pass`, `log`, `nolog`, `tag:'...'`, `logdata:'...'`, `t:none`, `t:lowercase`, `t:urlDecode`, `t:urlDecodeUni`
- request-phase execution for `REQUEST_URI` and `ARGS`
- body-phase execution for `REQUEST_BODY`
- vendored in-tree `libinjection` build/package support
- `libinjection`-backed SQLi/XSS checks in the native detector path before substring fallbacks
- explicit `@libinjection_sqli` / `@libinjection_xss` operators in `waf_rules_file`
- explicit `@rx` and equals-style operators in `waf_rules_file`
- explicit `ARGS:<name>` selectors for more realistic application-field targeting
- explicit scoped header/cookie selectors in `waf_rules_file`
- explicit `REQUEST_BODY:<name>` selectors for form-encoded and top-level JSON request fields
- shared-memory temporary IP banning via threshold/window/duration directives
- per-rule `status:<code>` handling for application-specific block responses
- explicit `deny` / `pass` per-rule action semantics while keeping `waf_mode` as the default policy
- line-specific config-time parser errors for unsupported native subset syntax
- escalating shared-memory repeat-offender bans with short-term strike retention
- explicit `@beginsWith` / `@endsWith` string operators in `waf_rules_file`
- explicit `QUERY_STRING` / `REQUEST_LINE` request metadata collections in `waf_rules_file`
- explicit native `@pm` multi-phrase matching subset in `waf_rules_file`
- richer warning-log output for detect-mode and `pass,log` rule matches
- explicit per-rule transform subset via `t:none`, `t:lowercase`, `t:urlDecode`, and `t:urlDecodeUni`
- broader checked-in WAF fixture coverage split across dedicated files for operators, collections, actions, transforms, bans, libinjection, and parser failures
- metadata-oriented `tag:'...'` / `logdata:'...'` actions for richer non-blocking rule logs
- broader `REQUEST_BODY` selector coverage for form fields, nested JSON selector paths, and multipart form-data fields
- response-phase inspection for `RESPONSE_STATUS` and `RESPONSE_HEADERS`
- lightweight score-based shared-memory banning with decay controls
- verified clean body-phase disruptive handling that no longer leaks preread request-body bytes into later request parsing
- native request header-name collection support via `REQUEST_HEADER_NAMES`
- safe action-slice additions via `block` (deny alias) and `nolog` log suppression
- scoped response-header selectors via `RESPONSE_HEADERS:<name>`
- low-risk `@within` operator support for exact token-set membership
- safe request metadata collection support for `REQUEST_PROTOCOL`
- safe request metadata collection support for `REQUEST_SCHEME`
- safe path-derived request metadata collection support for `REQUEST_BASENAME`
- Bun integration coverage proving file-driven block/detect behavior
- Bun integration coverage proving stronger detection of obfuscated SQLi/XSS payloads

What this means:

- `ngx_http_waf` now has a real native rule-file path,
- but it is still a **small compatibility subset**, not a general ModSecurity parser and not CRS-compatible yet.

## Updated near-term next steps

1. add more checked-in rule fixtures under `tests/waf/` and expand Bun coverage accordingly
2. extend the parser and execution model toward a broader ModSecurity-compatible subset
3. evolve the shared-memory reputation model further toward richer scoring / escalation behavior

## Living gap checklist

This section is the durable implementation checklist. Update it in batches whenever a coherent feature slice lands and is verified.

Covered recently:

- [x] `REQUEST_BODY:<name>` selectors for form-encoded and top-level JSON request fields
- [x] explicit per-rule `deny` / `pass` semantics
- [x] line-specific config-time parser errors for unsupported native subset syntax
- [x] escalating repeat-offender bans with short-term strike retention
- [x] `@beginsWith` / `@endsWith` string operators
- [x] `QUERY_STRING` / `REQUEST_LINE` request metadata collections
- [x] native `@pm` multi-phrase matching subset
- [x] richer warning-log output for detect-mode and `pass,log` matches
- [x] explicit per-rule transform subset via `t:none`, `t:lowercase`, `t:urlDecode`, and `t:urlDecodeUni`
- [x] broader checked-in WAF fixture coverage split across dedicated files instead of one overloaded subset fixture
- [x] metadata-oriented `tag:'...'` / `logdata:'...'` actions for richer non-blocking rule logs
- [x] broader `REQUEST_BODY` selector coverage for form fields, nested JSON selector paths, and multipart form-data fields
- [x] response-phase inspection for `RESPONSE_STATUS` and `RESPONSE_HEADERS`
- [x] score-based shared-memory banning with quiet-period decay controls
- [x] clean body-phase disruptive handling for blocked form, JSON, multipart, and libinjection-backed body matches

Remaining gaps / todos:

- [ ] add more string / set operators that map cleanly to the native engine (for example `@pm`, `@within`, and closely related low-risk subsets)
- [ ] add more request collections beyond the newly covered `QUERY_STRING` / `REQUEST_LINE`, especially header-name collections and other safe request metadata targets
- [ ] continue to reject or very carefully evaluate path-mapped targets like `REQUEST_FILENAME` unless nginx-native resolution semantics can be preserved without misleading access-phase behavior
- [ ] add broader action support beyond `deny` / `pass` / `log` / `status`, starting with the safest native subsets
- [ ] evolve the shared-memory reputation model toward richer scoring, expiry tuning, and stronger escalation controls
- [ ] evaluate safe native integration points for static IP reputation / allowlist-blocklist style policy without duplicating nginx access controls
- [ ] evaluate which high-value ModSecurity-compatible parser slices are worth adding next versus intentionally rejecting with clear startup errors
- [ ] keep README and this issue checklist synchronized whenever a new verified slice lands

## Practical scope note

Static IP allow/deny policy should continue to rely on nginx's built-in access module rather than being duplicated inside `ngx_http_waf`.

That keeps the WAF focused on request inspection, dynamic bans, and rule-driven behavior where it adds unique value.

## Next strongest real-world slices

From a practical WAF deployment angle, the next highest-value follow-ups are:

1. **Broader checked-in rule fixtures**
   - keep expanding representative rule files and Bun coverage so the supported subset stays concrete and reproducible

2. **Broader compatibility subset**
   - keep adding carefully chosen operators, actions, and collections that map cleanly to a native Zig rule engine

3. **Richer shared-memory reputation model**
   - keep pushing beyond basic escalating bans toward scoring, expiry tuning, and stronger operational controls
