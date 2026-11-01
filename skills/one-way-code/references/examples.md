# Ownership and before/after examples

Read the relevant section when choosing a service lifetime, consolidating clients,
or deciding whether an abstraction removes real duplication. Examples use
TypeScript; apply the same ownership rules in the project's language.

## Resource lifetimes

| Resource | Default ownership | Never do this |
| --- | --- | --- |
| Thread-safe API client with fixed service credentials | One per process and configuration | Recreate it in every handler, or mutate its credentials for another user |
| Database connection pool | One per process/configuration | Share an active transaction or ORM unit of work globally |
| Validated configuration and public catalog service | One per app lifecycle | Reparse env in callers or construct fallback service instances |
| Session, current user, tenant, request headers | Per authenticated request/session | Store a mutable current user on a shared client |
| Transaction, cancellation controller, mutable unit of work | Per operation | Reuse one across concurrent requests |
| SSR query cache | Per request; browser cache follows its app/session lifecycle | Share server query results across users by accident |
| Account-specific client or cache | Explicit account/configuration scope | Use an unkeyed process-global instance or a growing registry without cleanup |

Reuse only resources the underlying library permits sharing. Dispose owned
resources at the end of their lifetime. A process singleton is not unique across
workers, containers, or machines; it cannot provide distributed locking or
cross-process idempotency. Use the existing durable coordination mechanism there.

## Do and don't

| Do | Don't |
| --- | --- |
| Use named domain methods on the existing typed client | Scatter raw HTTP, endpoint strings, auth headers, and JSON parsing across callers |
| Share transport policy; let each client validate its responses | Hide everything behind an unrestricted `request(path, body): any` API |
| Keep transport-specific adapters where needed | Force uploads, streams, sockets, and JSON RPC through an incompatible wrapper |
| Validate untrusted input once at the appropriate boundary and infer internal types where supported | Copy DTOs and schemas, trust external data via casts, or use `any` to suppress errors |
| Centralize common rules with a clear domain owner | Build a giant `utils`, `Manager`, or `BaseService` module with unrelated responsibilities |
| Reuse behavior that has the same meaning and reasons to change | Merge merely similar-looking code whose policies or lifetimes differ |
| Keep a local helper local until real callers need it elsewhere | Build a framework, registry, factory, or plugin system for hypothetical reuse |
| Keep routes and UI components focused on orchestration and presentation | Repeat business validation, credential handling, or I/O setup in every entry point |
| Use existing UI components, variants, and query conventions | Introduce a second component system, parallel cache keys, or per-screen fetch wrappers |
| Use guard clauses, named values, and readable branches | Replace clear code with nested ternaries, dense spreads, flag-heavy helpers, or clever one-liners |
| Handle errors where they can be acted on; preserve actionable context | Swallow failures, invent success values, or wrap every function in redundant try/catch |
| Reuse the configured service in scripts and jobs | Maintain a second implementation just because the caller is a script |

A reusable function should describe an operation, not just move five unrelated
lines into another file. Avoid layers that only rename or forward a call unless
they enforce a boundary, satisfy a framework contract, or isolate an actual
external dependency. Do not duplicate an upstream framework's client, state
machine, router, or agent runtime when its supported API already does the job.

## Before and after

These are abbreviated TypeScript examples of decisions, not required filenames
or a framework to copy. Adapt the ownership and APIs to the project.

### Construct services once

Before: every route gets a separate catalog/cache, and missing injection silently
creates another instance.

```ts
// routes/connections.ts
const catalog = new ConnectionsCatalog();
const activeCatalog = context.catalog ?? new ConnectionsCatalog();
```

After: application composition owns construction; callers and tests receive an
explicit dependency. If the service is optional, report its absence through the
existing configuration-error path instead of constructing a fallback.

```ts
// services.ts, loaded at application startup
export const catalog = new ConnectionsCatalog();

// request context, using the same instance
const context = { catalog, session: await readSession(request) };

// route
return context.catalog.search(input);
```

### Reuse the typed network client

Before: a verification script owns a second copy of authentication, endpoints,
serialization, error handling, and response parsing.

```ts
await fetch(`${url}/workspaces/${projectId}/${threadId}/prompt`, {
  method: "POST",
  headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
  body: JSON.stringify(prompt),
});
```

After: construct the existing client once for this script's lifecycle. Its named
method uses the established transport and response validation.

```ts
const agent = new AgentRuntime(url, token);
await agent.start({ projectId, threadId }, prompt);
```

Keep browser and server authentication boundaries separate. Share compatible
schemas and policy; never import a privileged server client into a browser bundle.

### Centralize environment setup

Before: the runtime, setup script, and verification script independently build
virtualenv paths and process environment settings.

```ts
// Repeated in different callers
const python = join(resolve(import.meta.dir, ".."), ".venv/bin/python");
const path = `${dirname(python)}:${process.env.PATH}`;
```

After: one environment module defines the paths and selection rules. Setup and
runtime consume those exports. Local setup and Docker consume one dependency
manifest when they require the same packages.

```ts
import { agentPython, agentEnvironment } from "./environment";
spawn([agentPython, "task.py"], { env: { ...process.env, ...agentEnvironment } });
```

Use the project's intended environment allowlist when spawning untrusted or
isolated processes; do not copy all parent secrets merely to reuse this example.
Do not add a generic configuration framework for a few shared constants.

### Keep operation state out of shared services

Before: concurrent requests can overwrite each other's identity or cancel each
other's work.

```ts
const service = { currentUser: null, controller: new AbortController() };
service.currentUser = request.user;
```

After: the client is shared, while identity and cancellation belong to the
operation and are passed through its typed API.

```ts
async function handle(request: RequestContext) {
  const controller = new AbortController();
  return service.run({ userId: request.user.id, signal: controller.signal });
}
```

Connect the operation's controller to the existing cancellation lifecycle. If the
framework already supplies the correct request signal, pass that signal directly.

### Flatten construction without changing serialization

Before: nested spreads hide which values are sent.

```ts
const request = {
  ...identity,
  ...(isBox ? { parameters: boxParameters } : {}),
  ...(needsAssertion ? { assertion: { ...key, ...(keyId ? { keyId } : {}) } } : {}),
};
```

After: name the conditions and construct the payload plainly.

```ts
const request = {
  ...identity,
  parameters: isBox ? boxParameters : undefined,
  assertion: needsAssertion ? { ...key, keyId: keyId || undefined } : undefined,
};
```

This is appropriate only when omitted and `undefined` serialize identically and
no intermediate code depends on property presence. Preserve `null`, empty-string,
zero, and omission semantics. Keep branches when they express the contract better.
