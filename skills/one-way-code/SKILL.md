---
name: one-way-code
description: >-
  Apply whenever writing, modifying, debugging, refactoring, or reviewing code.
  Keep code readable and organized, with one owner per responsibility, reuse,
  typed boundaries, and correctly scoped services. Excludes non-coding tasks.
---

# One way to do one thing

Write code a human can follow quickly. Use one implementation per responsibility
and one shared service instance per valid scope. Preserve useful behavior.
Readability wins over fewer lines or files, including Ponytail's brevity rules.

## Before changing code

Read project instructions and relevant docs. Trace the affected flow and search
for existing helpers, clients, schemas, configuration, and callers. Reuse or
extend their owner before adding another implementation. Follow existing
framework conventions; prefer native features and installed dependencies.

## Rules

- **Reuse behavior.** Centralize repeated rules, identifiers, configuration,
  schemas, and cache keys. Migrate affected callers and remove superseded paths.
  Keep legitimate compatibility paths only while actual consumers need them.
- **Scope singletons.** Construct reusable clients, pools, and services once per
  process/configuration at the existing composition or DI boundary. Inject them
  or reuse module exports. No per-handler construction or silent fallback
  instances. Use sharing only where the library is concurrency-safe.
- **Isolate mutable state.** Sessions, user/tenant identity, transactions,
  cancellation, and SSR caches belong to their request or operation. Never put
  them in unkeyed globals. Account-specific configuration needs its own scope.
  Close resources when their owner ends. A process singleton is not a distributed
  lock. Pure functions need one definition, not singleton objects.
- **Use typed boundaries.** Call the existing named domain/client methods;
  centralize compatible transport policy and validate external data at its
  boundary. No scattered HTTP/auth setup, copied DTOs, unchecked casts, or `any`
  escape hatches. Keep server credentials out of browser code. Preserve dedicated
  upload/stream adapters when their transport requirements differ.
- **Make the flow obvious.** Use descriptive names, guard clauses, and ordinary
  branches and loops. Name intermediate values when they clarify intent. Avoid
  nested ternaries, dense expressions, redundant annotations, and clever
  one-liners. Keep comments that explain non-obvious reasons or constraints;
  remove narration of what the code already says.
- **Keep files cohesive.** Follow the existing layout. Keep code that changes
  together near each other, with local helpers beside their callers. Export only
  what other modules need. Split when responsibilities differ or a file becomes
  hard to navigate, not to meet a line limit. Avoid miscellaneous utility files,
  tiny forwarding files, and new folder hierarchies for one feature.
- **Earn each abstraction.** Prefer existing functions and UI components. Add a
  helper or layer only when it hides meaningful complexity, enforces a real
  boundary, or serves actual shared behavior. Share meaning, not similar syntax.
  Avoid speculative factories, registries, base classes, and flag-heavy helpers.
  Collapse pass-through layers within scope when they serve no contract.
- **Keep data and state simple.** Use a collection or explicit variant when it
  makes repeated branching or invalid flag combinations unnecessary. Prefer
  local values and derived state over mutable fields and synchronized copies.
  A reader should easily find where a value comes from and what can change it.
- **Preserve contracts.** Keep authorization, isolation, idempotency, ordering,
  retries, cancellation, errors, cleanup, and accessibility intact. Do not hide
  failures or confuse absent, null, empty, and zero values. Avoid stacked retries.
- **Finish the cleanup.** Remove dead code, imports, debug artifacts, and unused
  dependencies. Update existing docs when behavior, ownership, or setup changes.
  Keep edits within the task; do not expand a feature into a broad rewrite or
  remove useful functionality just to make the implementation smaller.

## Verify or review

Run focused behavioral checks and required project checks. Test isolation and
concurrency when changing lifetimes; test failures and retries when changing
transport. Keep expected outcomes independent of implementation. Inspect the
final diff for duplicate paths and unintended behavior changes. In review-only
work, report concrete findings and fixes without modifying files. Report actual
verification and remaining limits; do not claim unperformed live tests.

Read only the relevant section of [examples.md](references/examples.md) when an
ownership decision or before/after example would help. Do not load it routinely.
