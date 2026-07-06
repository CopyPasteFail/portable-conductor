#!/usr/bin/env bash
set -euo pipefail

for destination in "$HOME/.agents/skills/portable-conductor" "$HOME/.claude/skills/portable-conductor"; do
  if [[ -L "$destination" ]]; then
    rm "$destination"
    echo "Removed $destination"
  elif [[ -e "$destination" ]]; then
    echo "Skipped $destination because it is not a symlink." >&2
  fi
done
