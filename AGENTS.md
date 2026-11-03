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

- Design for a first-time external user who has not read our chat, specs, or code. Use familiar terms and controls; do not assume internal context.
- Make the main task, current state, and next action obvious through layout, hierarchy, and clear labels. Fix confusing flows before adding explanatory copy.
- Keep visible text to what helps users decide, act, or recover. Remove redundant headings, introductions, helper text, and feature explanations. Say each thing once; avoid paragraphs explaining obvious controls.
- Use concise, specific action labels and consistent user-facing terms. Keep implementation details, internal jargon, and developer commentary out of the interface unless they affect the user's decision.
- Use sensible defaults and reveal advanced options or secondary explanations when needed. Keep essential requirements and consequences visible before the user acts.
- Preserve accessible labels, meaningful status feedback, and actionable errors. Brevity must not create vague buttons, unexplained icons, or instructions available only in placeholders or tooltips.
- Before finishing UI work, walk the primary flow as a new user. Check that they can tell what this is, what to do next, and what happened without a walkthrough. Remove text that adds no decision value and fix interactions that still need narration.

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
