#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link_skill() {
  local source="$1" target_dir="$2" target
  target="$target_dir/$(basename "$source")"

  if [[ -e "$target" && ! -L "$target" ]]; then
    echo "error: $target exists and is not a symlink; move it aside and re-run" >&2
    return 1
  fi
  mkdir -p "$target_dir"
  ln -sfn "$source" "$target"
  echo "linked $target"
}

main() {
  local skill
  for skill in "$repo_dir"/skills/*/; do
    skill="${skill%/}"
    link_skill "$skill" "$HOME/.claude/skills"
    if [[ -d "$HOME/.cursor" ]]; then
      link_skill "$skill" "$HOME/.cursor/skills"
    fi
  done
}

main "$@"
