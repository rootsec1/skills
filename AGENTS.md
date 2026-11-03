Optimize for simplicity, correctness, and speed. Use the installed Ponytail skill before writing code.

Before writing, modifying, debugging, refactoring, or reviewing code, apply the installed `one-way-code` skill. Read its `SKILL.md` once per session and load its examples only when needed.

For debugging, performance measurements, changes to shared contracts or state, and recurring code defects, also apply `prove-it`. Keep checks proportionate to the change.

## Working rules

- Use relevant installed skills and existing project patterns before inventing an approach.
- Make the smallest safe change that solves the root cause. Avoid speculative abstractions, broad rewrites, unrelated edits, and case-specific hacks.
- Verify assumptions from the best available source: project docs, code, current behavior, tests, and—when data shape matters—the database schema and real queries.
- Inspect relevant `docs/`, specs, workflows, existing modules, utilities, prompts, and tests before adding behavior. Reuse rather than duplicate.
- Push back when a request is incorrect, unsafe, underspecified, or unnecessarily complex. State uncertainty when it affects the result.

- For design and frontend work, use `impeccable` before and throughout implementation to guide visual direction, layout, typography, interactions, accessibility, and polish.
- Use `stageshow` alongside `impeccable` for mocked product UI, marketing illustrations, and animated demos or cursor walkthroughs.

## Product UI and UX

- Make the UI intuitive for a first-time external user. The next action should be obvious without an explanation.
- Use the right components for the task: tabs, tables, badges, toggles, progress indicators, and other familiar controls instead of walls of text. Follow the existing design system.
- Keep copy short and useful. Preserve clear labels, accessible controls, and actionable errors; cut jargon and repeated explanations.
- Do not add decorative footers, filler sections, or unnecessary explanatory banners.

## Writing on my behalf

- Whenever drafting or replying to people in Slack, email, or any other app, always apply `$unslop` before presenting or sending the message.
- Write in my voice. Use my messages and the conversation context to match my tone and level of formality.
- Keep the language simple, clean, clear, and to the point. Use YC style: lead with the point, use concrete words and short sentences, and cut fluff, jargon, corporate phrasing, and AI tells.
- Keep enough context for the recipient to understand the message and any ask. Do not invent facts, opinions, or commitments on my behalf.

## Implementation and verification

- Follow the project's architecture, naming, tooling, and conventions.
- Prefer modifying existing functions and composing existing utilities over adding new layers.
- Keep responsibilities clear and control flow easy to follow. Split code only when the current structure is genuinely hard to reason about.
- Use `.venv` when present. Run focused tests before broad suites and validate more than the reported example.
- For extraction, matching, ranking, or classification changes: eval, diagnose, fix, then re-run the eval.
- Update documentation only when behavior, workflow, or an important decision changes.

## Safety

- Inspect PostgreSQL schemas and representative data before changing code that depends on their shape. Avoid blind writes.
- Never mutate a remote or shared Kubernetes cluster. If unsure whether a cluster is local, treat it as remote. Read-only inspection is allowed; writes are allowed only on confirmed local clusters such as `kind`, `minikube`, or `docker-desktop`.
- Track and stop processes you start. Do not leave watchers, dev servers, test loops, or other background jobs running.

## Before finishing

- Remove debug code, dead code, unused imports and variables, redundant logic, temporary files, and stale processes.
- Confirm the change is minimal, addresses the underlying failure class, follows existing patterns, and is easy to review and revert.
