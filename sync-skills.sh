#!/usr/bin/env bash
# Sync skills from this repo into ~/.claude/skills as symlinks.
#
# Rules:
# - A folder is a skill only if it contains a SKILL.md file. Folders at any
#   depth count (for example, books/design/refactoring-ui-skill-textbook).
# - Only symlinks that point into this repo are managed.
# - Real folders in ~/.claude/skills (for example, Yuzu work skills) are never touched.
# - Dangling symlinks that point into this repo are removed.
#
# Run this script after you add, rename, or remove a skill folder.
# Edits to files inside an existing skill need no sync. Symlinks are live.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.claude/skills"
SOURCE_DIRS=("$REPO_DIR/books" "$REPO_DIR/skills")

mkdir -p "$TARGET_DIR"

# Remove dangling symlinks that point into this repo.
for link in "$TARGET_DIR"/*; do
  [ -L "$link" ] || continue
  dest="$(readlink "$link")"
  case "$dest" in
    "$REPO_DIR"/*)
      if [ ! -f "$link/SKILL.md" ]; then
        rm "$link"
        echo "removed: $(basename "$link") (source is gone or has no SKILL.md)"
      fi
      ;;
  esac
done

# Create a symlink for each valid skill folder, at any depth.
for source_dir in "${SOURCE_DIRS[@]}"; do
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
