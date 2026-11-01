# Skills

My custom coding skills, plus commands to install the upstream skills I use.
The goal is simple, readable code and evidence that changes work.

## Install

Requires Git, Make, and Node.js 22.20 or later with npm/npx. On Windows, use WSL.

```sh
git clone https://github.com/rootsec1/skills.git
cd skills
make install
```

The installer uses the [skills CLI](https://github.com/vercel-labs/skills), pinned
to version 1.7.4. It installs globally into `~/.agents/skills` and creates links
for other supported coding assistants in their own skill directories. It uses
`--agent '*'`, so installation is not limited to the currently detected assistant.
The CLI may report unsupported global installs for project-only assistants such
as Eve and PromptScript; those require project-local setup. See the
[supported agents and paths](https://github.com/vercel-labs/skills/blob/main/docs/agents.md).

```sh
make install-custom    # Only the custom skills in this checkout
make install-upstream  # Only the selected upstream skills below
```

Rerunning a target replaces installed skills with the same names. Custom skills
come from this checkout; upstream skills come from their current repository
versions. The CLI version is pinned, but upstream content is not. Pull this repo
and rerun `make install` to refresh both. Restart your assistant if it caches
its skill list.

## Custom skills

| Skill | Purpose |
| --- | --- |
| [one-way-code](skills/one-way-code/SKILL.md) | Readable code, cohesive files, reuse, clear ownership, and correctly scoped state. |
| [prove-it](skills/prove-it/SKILL.md) | Test assumptions, check downstream effects, verify fixes, and measure performance honestly. |

Edit these under `skills/`, then run `make install-custom`. The installed copies
are separate from the checkout. Each skill uses the portable `SKILL.md` format;
the optional `agents/openai.yaml` files provide Codex UI metadata only.

To make the intended usage explicit in an assistant's instructions:

```text
Apply one-way-code when writing or reviewing code. Readability takes priority
over fewer lines or files. Apply prove-it for debugging, performance measurements,
changes to shared contracts or state, and recurring defects. Keep checks
proportionate to the change.
```

The installer does not replace your existing agent instructions.

## Upstream skills

These are the nine upstream skills installed when this repo was created. Some
are vendor-maintained; others are community projects. Their code stays upstream.
The Makefile selects individual skills, not entire collections.

| Skill | Source |
| --- | --- |
| agent-browser | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) |
| find-skills | [vercel-labs/skills](https://github.com/vercel-labs/skills) |
| impeccable | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) |
| ponytail | [dietrichgebert/ponytail](https://github.com/dietrichgebert/ponytail) |
| shadcn | [shadcn-ui/ui](https://github.com/shadcn-ui/ui) |
| turborepo | [vercel/turborepo](https://github.com/vercel/turborepo) |
| unslop | [cursor/plugins](https://github.com/cursor/plugins/tree/main/pstack/skills/unslop) |
| use-railway | [railwayapp/railway-skills](https://github.com/railwayapp/railway-skills) |
| vercel-react-best-practices | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) |

Previously removed skills and app-bundled plugins are not included. Installing a
skill supplies instructions; tools, accounts, and credentials it uses still need
their own setup.
