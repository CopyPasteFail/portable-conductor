#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--all|--agents|--claude] [--force]

Creates symlinks to this repository's single canonical skill directory.

Targets:
  --all      Link for Codex, Copilot CLI, and Claude Code. Default.
  --agents   Link only ~/.agents/skills/portable-conductor for Codex and Copilot CLI.
  --claude   Link only ~/.claude/skills/portable-conductor for Claude Code.
  --force    Replace an existing symlink. Refuse to replace a real directory.
USAGE
}

target="all"
force=0

while (($#)); do
  case "$1" in
    --all) target="all" ;;
    --agents) target="agents" ;;
    --claude) target="claude" ;;
    --force) force=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
skill_source="$repo_root/skill"

if [[ ! -f "$skill_source/SKILL.md" ]]; then
  echo "ERROR: Canonical skill not found at $skill_source/SKILL.md" >&2
  exit 1
fi

link_skill() {
  local destination="$1"
  local parent
  parent="$(dirname "$destination")"
  mkdir -p "$parent"

  if [[ -e "$destination" || -L "$destination" ]]; then
    if [[ -L "$destination" ]]; then
      if [[ "$force" -ne 1 && "$(readlink "$destination")" != "$skill_source" ]]; then
        echo "ERROR: $destination already points elsewhere. Re-run with --force to replace it." >&2
        exit 1
      fi
      rm "$destination"
    else
      echo "ERROR: $destination exists and is not a symlink. It was not changed." >&2
      exit 1
    fi
  fi

  ln -s "$skill_source" "$destination"
  echo "Linked $destination -> $skill_source"
}

case "$target" in
  all|agents) link_skill "$HOME/.agents/skills/portable-conductor" ;;
esac
case "$target" in
  all|claude) link_skill "$HOME/.claude/skills/portable-conductor" ;;
esac

echo "Done. Restart an agent if it does not discover the skill in the current session."
