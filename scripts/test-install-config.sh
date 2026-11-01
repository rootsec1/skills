#!/bin/sh
set -eu

repo=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
temporary=$(mktemp -d)
trap 'rm -rf "$temporary"' EXIT HUP INT TERM
target="$temporary/home with spaces"

sh "$repo/scripts/install-config.sh" "$target"
cmp "$repo/AGENTS.md" "$target/.agents/AGENTS.md"
for relative in .codex/AGENTS.md .claude/CLAUDE.md .gemini/GEMINI.md .config/opencode/AGENTS.md; do
    test -L "$target/$relative"
    test "$target/$relative" -ef "$target/.agents/AGENTS.md"
done

sh "$repo/scripts/install-config.sh" "$target"
test -z "$(find "$target" -name '*.backup.*' -print)"

printf 'existing instructions\n' > "$target/.agents/AGENTS.md"
rm "$target/.claude/CLAUDE.md" "$target/.gemini/GEMINI.md"
printf 'existing Claude instructions\n' > "$target/.claude/CLAUDE.md"
ln -s "$temporary/missing" "$target/.gemini/GEMINI.md"
sh "$repo/scripts/install-config.sh" "$target"
cmp "$repo/AGENTS.md" "$target/.agents/AGENTS.md"
test "$(cat "$target/.agents/AGENTS.md".backup.*)" = 'existing instructions'
test "$(cat "$target/.claude/CLAUDE.md".backup.*)" = 'existing Claude instructions'
test -L "$target/.gemini/GEMINI.md".backup.*
test "$target/.claude/CLAUDE.md" -ef "$target/.agents/AGENTS.md"
test "$target/.gemini/GEMINI.md" -ef "$target/.agents/AGENTS.md"
printf 'PASS: fresh install, repeat install, backups, broken links, and paths with spaces.\n'
