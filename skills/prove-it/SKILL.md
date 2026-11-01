---
name: prove-it
description: >-
  Use for debugging, performance measurements, changes to shared contracts or
  state, and recurring code defects. Test assumptions and downstream behavior
  with proportionate evidence before claiming a fix or improvement.
---

# Prove it

Resolve the uncertainty that could make the change wrong. Use the smallest
reliable check and the project's existing tools. Apply only the relevant rules;
routine edits do not need a new investigation, benchmark, or test suite.

- **Observe before fixing.** Reproduce the reported behavior or capture evidence
  that distinguishes likely causes. Choose the next check for what it can rule
  out. If reproduction is blocked, name what is unproven rather than treating a
  plausible explanation as a confirmed cause.
- **Question failed assumptions.** When two attempted fixes rely on the same
  assumption and fail, state and test that assumption before another patch.
  Remove changes motivated by disproven explanations.
- **Check beyond callers.** For shared changes, identify the contract that makes
  them safe. Follow relevant stored data, API payloads, background jobs, lifecycle
  timing, and dependency behavior that a symbol search can miss. Prove the key
  assumption with a focused check against real code and representative data.
  Stay within the authorized environment and scope.
- **Verify the outcome.** Re-run the original failing case and a nearby case
  that could regress. Use the actual app or integration when a unit check cannot
  establish the claim. Keep expected results independent of the implementation.
  Verify meaningful steps before building later work on them. A green build alone
  does not prove a runtime fix.
- **Measure honestly.** For performance claims, compare equivalent workloads
  and settings. Check correct outputs, failures, and that the timed work actually
  ran. Repeat and alternate comparisons enough to distinguish change from noise;
  report variation and run count. Identify the limiting work and check whether
  the gain affects the path users wait on. Label a one-run estimate or an
  inconclusive comparison as such.
- **Prevent demonstrated repeats.** When the same defect recurs, prefer the
  cheapest effective prevention at its owner: remove duplicate state or paths,
  strengthen a type or boundary, or add a focused test or existing lint rule.
  Check that it catches the known failure. Do not create a new framework or a
  broad refactor to enforce one lesson. Reserve prose rules for judgment calls.

Stop when the relevant evidence and required project checks support the claim.
Keep any useful regression check in the existing test setup; remove temporary
instrumentation and stop processes you started unless asked to leave them running.
No mandatory subagents, competing implementations, reports, or new tooling.
Review-only requests stay read-only.

Report the result, the decisive evidence, and material limits briefly. Distinguish
what you observed from what you inferred. Do not claim checks you did not run.
