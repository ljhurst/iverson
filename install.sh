#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

main() {
  local targets target skill
  targets="$(parse_targets "$@")"
  for target in $targets; do
    for skill in "$repo_dir"/skills/*/; do
      link_skill "${skill%/}" "$(skills_dir_for "$target")"
    done
  done
}

parse_targets() {
  local arg
  if (($# == 0)); then
    detect_targets
    return
  fi
  for arg in "$@"; do
    case "$arg" in
    claude | cursor) echo "$arg" ;;
    *)
      echo "error: unknown target '$arg'" >&2
      usage
      return 1
      ;;
    esac
  done
}

detect_targets() {
  local tool found=0
  for tool in claude cursor; do
    if [[ -d "$HOME/.$tool" ]]; then
      echo "$tool"
      found=1
    fi
  done
  if ((found == 0)); then
    echo "error: neither ~/.claude nor ~/.cursor exists; name a target" >&2
    usage
    return 1
  fi
}

skills_dir_for() {
  echo "$HOME/.$1/skills"
}

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

usage() {
  cat >&2 <<'EOF'
usage: install.sh [claude] [cursor]

With no targets, installs for each tool whose home directory exists.
EOF
}

main "$@"
