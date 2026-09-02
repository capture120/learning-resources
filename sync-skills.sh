#!/usr/bin/env bash
# Sync skills from this repo into the personal skill directories for Claude Code
# and Codex.
#
# Rules:
# - A folder is a skill only if it contains a SKILL.md file. Folders at any
#   depth count (for example, books/design/refactoring-ui-skill-textbook).
# - Real folders in the target dirs (for example, Yuzu work skills) are never touched.
# - Dangling links to a learning-resources repo are removed. Unrelated dangling
#   links are preserved.
# - Symlinks that point to a live location outside this repo are left alone
#   and reported as conflicts.
#
# Run this script after you add, rename, remove a skill folder, or move this repo.
# Edits to files inside an existing skill need no sync. Symlinks are live.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PHYSICAL_REPO_DIR="$(cd "$REPO_DIR" && pwd -P)"
TARGET_DIRS=("$HOME/.claude/skills" "$HOME/.agents/skills")
SOURCE_DIRS=("$REPO_DIR/books" "$REPO_DIR/skills")

# Codex previously loaded personal skills from ~/.codex/skills. Remove only the
# old symlinks that this repository managed. Keep real folders and links to
# other locations.
legacy_codex_dir="$HOME/.codex/skills"
if [ -d "$legacy_codex_dir" ]; then
  echo "== $legacy_codex_dir (legacy cleanup) =="
  for link in "$legacy_codex_dir"/*; do
    [ -L "$link" ] || continue

    destination="$(readlink "$link")"
    resolved_destination="$destination"
    if [[ "$resolved_destination" != /* ]]; then
      resolved_destination="$(dirname "$link")/$resolved_destination"
    fi

    if [ -e "$link" ]; then
      resolved_destination="$(cd "$(dirname "$resolved_destination")" && pwd -P)/$(basename "$resolved_destination")"
    fi

    if [[ "$resolved_destination" == "$PHYSICAL_REPO_DIR"/* ]] ||
      [[ "$resolved_destination" == "$REPO_DIR"/* ]] ||
      { [ ! -e "$link" ] && [[ "$destination" == */learning-resources/* ]]; }; then
      rm "$link"
      echo "removed: $(basename "$link") (legacy repository link)"
    fi
  done
fi

# Start with an empty sentinel because macOS Bash 3.2 treats an empty array as
# unset when `set -u` is active.
processed_target_paths=("")

for target_dir in "${TARGET_DIRS[@]}"; do
  echo "== $target_dir =="
  mkdir -p "$target_dir"

  # A user can share the full skills directory between tools with a symlink.
  # Process the physical directory once when both paths resolve to one place.
  physical_target_dir="$(cd "$target_dir" && pwd -P)"
  already_processed=false
  for processed_target_path in "${processed_target_paths[@]}"; do
    if [ "$physical_target_dir" = "$processed_target_path" ]; then
      already_processed=true
      break
    fi
  done
  if [ "$already_processed" = true ]; then
    echo "shared:  $physical_target_dir (already synchronized)"
    continue
  fi
  processed_target_paths+=("$physical_target_dir")

  # Remove dangling links from an old location of this repository. Keep
  # unrelated dangling links because another tool or user can still own them.
  for link in "$target_dir"/*; do
    [ -L "$link" ] || continue
    if [ ! -e "$link" ]; then
      dest="$(readlink "$link")"
      if [[ "$dest" == "$REPO_DIR"/* ]] || [[ "$dest" == */learning-resources/* ]]; then
        rm "$link"
        echo "removed: $(basename "$link") (dangling repository link, pointed to $dest)"
      else
        echo "CONFLICT: $(basename "$link") is an unrelated dangling link to $dest — skipped"
      fi
    fi
  done

  # Create a symlink for each valid skill folder, at any depth.
  for source_dir in "${SOURCE_DIRS[@]}"; do
    [ -d "$source_dir" ] || continue
    while IFS= read -r -d '' skill_md; do
      skill_dir="$(dirname "$skill_md")"
      name="$(basename "$skill_dir")"

      link="$target_dir/$name"
      if [ -L "$link" ]; then
        current="$(readlink "$link")"
        if [ "$current" = "$skill_dir" ]; then
          echo "ok:      $name"
        else
          echo "CONFLICT: $name already links to $current — skipped"
        fi
      elif [ -e "$link" ]; then
        echo "CONFLICT: $name exists as a real folder in $target_dir — skipped"
      else
        ln -s "$skill_dir" "$link"
        echo "linked:  $name -> $skill_dir"
      fi
    done < <(find "$source_dir" -name SKILL.md -print0)
  done
done
