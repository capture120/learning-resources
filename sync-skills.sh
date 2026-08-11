#!/usr/bin/env bash
# Sync skills from this repo into ~/.claude/skills as symlinks.
#
# Rules:
# - A folder is a skill only if it contains a SKILL.md file. Folders at any
#   depth count (for example, books/design/refactoring-ui-skill-textbook).
# - Real folders in ~/.claude/skills (for example, Yuzu work skills) are never touched.
# - Dangling symlinks (destination no longer exists) are removed — this makes
#   the script self-healing when this repo moves: stale links from the old
#   location are pruned and fresh ones created, no matter where the repo lives.
# - Symlinks that point to a live location outside this repo are left alone
#   and reported as conflicts.
#
# Run this script after you add, rename, remove a skill folder, or move this repo.
# Edits to files inside an existing skill need no sync. Symlinks are live.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.claude/skills"
SOURCE_DIRS=("$REPO_DIR/books" "$REPO_DIR/skills")

mkdir -p "$TARGET_DIR"

# Remove dangling symlinks. A symlink whose destination is gone is broken
# regardless of where it pointed, so this is safe and survives repo moves.
for link in "$TARGET_DIR"/*; do
  [ -L "$link" ] || continue
  if [ ! -e "$link" ]; then
    dest="$(readlink "$link")"
    rm "$link"
    echo "removed: $(basename "$link") (dangling, pointed to $dest)"
  fi
done

# Create a symlink for each valid skill folder, at any depth.
for source_dir in "${SOURCE_DIRS[@]}"; do
  [ -d "$source_dir" ] || continue
  while IFS= read -r skill_md; do
    skill_dir="$(dirname "$skill_md")"
    name="$(basename "$skill_dir")"

    link="$TARGET_DIR/$name"
    if [ -L "$link" ]; then
      current="$(readlink "$link")"
      if [ "$current" = "$skill_dir" ]; then
        echo "ok:      $name"
      else
        echo "CONFLICT: $name already links to $current — skipped"
      fi
    elif [ -e "$link" ]; then
      echo "CONFLICT: $name exists as a real folder in $TARGET_DIR — skipped"
    else
      ln -s "$skill_dir" "$link"
      echo "linked:  $name -> $skill_dir"
    fi
  done < <(find "$source_dir" -name SKILL.md | sort)
done
