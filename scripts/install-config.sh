#!/bin/sh
set -eu

repo=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
mkdir -p "${1:?Pass the home directory to install into}"
config_root=$(CDPATH= cd "$1" && pwd)
canonical="$config_root/.agents/AGENTS.md"
suffix="backup.$(date -u +%Y%m%dT%H%M%SZ).$$"

backup() {
    if [ -e "$1" ] || [ -L "$1" ]; then
        mv "$1" "$1.$suffix"
        printf 'Backed up %s\n' "$1"
    fi
}

mkdir -p "$(dirname "$canonical")"
if ! cmp -s "$repo/AGENTS.md" "$canonical"; then
    backup "$canonical"
    cp "$repo/AGENTS.md" "$canonical"
fi

for relative in .codex/AGENTS.md .claude/CLAUDE.md .gemini/GEMINI.md .config/opencode/AGENTS.md; do
    target="$config_root/$relative"
    if [ "$target" -ef "$canonical" ]; then
        continue
    fi
    mkdir -p "$(dirname "$target")"
    backup "$target"
    ln -s "$canonical" "$target"
done

printf 'Installed shared instructions at %s\n' "$canonical"
