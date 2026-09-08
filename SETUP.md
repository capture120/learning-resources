# Set up shared skills and instructions for Claude Code and Codex

Set up my Claude Code and Codex skills and instructions from my learning resources repository.
The Git clone can use any local Mac path.

## Repository details

- The Git clone can live anywhere on the Mac.
- Use `~/.claude/learning-resources` as the stable access path.
- The repository contains the `books/` and `skills/` directories.
- A skill folder must contain a `SKILL.md` file.
- The repository root contains `sync-skills.sh`.
- The script links valid skills into `~/.claude/skills` and `~/.agents/skills`.
- The script preserves real folders and unrelated links.
- Use the committed script. Do not write a replacement script.

## Safety rules

- Do not commit any changes.
- Do not discard any local repository changes.
- Do not delete any real skill folders.
- Do not overwrite an existing instruction file that contains unique instructions.
- Report a conflict when safe automatic setup is not possible.

## Find the repository

1. Find the clone with the Git remote `git@github.com:capture120/learning-resources.git`.
2. Resolve the clone's absolute Git root and save the path as `REPO_DIR`.
3. Quote `REPO_DIR` in every shell command because the path can contain spaces.
4. Create `~/.claude` when the directory does not exist.
5. Inspect `~/.claude/learning-resources` before changing it.
6. Keep the path when it already resolves to `REPO_DIR`.
7. Create a symbolic link to `REPO_DIR` when the stable path does not exist.
8. Do not replace any other file, directory, or symbolic link at the stable path.
9. Report the existing path and stop when the stable path conflicts.

Create the link with quoted paths:

```bash
ln -s "$REPO_DIR" "$HOME/.claude/learning-resources"
```

## Update the repository and skills

1. Inspect the repository status with `git -C ~/.claude/learning-resources status --short --branch`.
2. Pull with `git -C ~/.claude/learning-resources pull --ff-only`.
3. Keep all local changes if Git blocks the pull. Report the blocker and stop.
4. Run `bash ~/.claude/learning-resources/sync-skills.sh`.
5. Show the complete script output.

The sync script also removes old repository links from `~/.codex/skills`.
The sync script does not remove real folders or unrelated links from that directory.

## Set up Claude Code instructions

Update `~/.claude/CLAUDE.md` so its first line is exactly:

```text
@~/.claude/learning-resources/AGENTS.md
```

Apply these rules:

- Create the file with only the import line when the file does not exist.
- Keep all unique existing content below the import line.
- Remove any other import for this repository's `AGENTS.md`.
- Remove only content that duplicates the `<style>` section from the repository's `AGENTS.md`.
- Keep all other content unchanged.

## Set up Codex instructions

Codex reads global instructions from `~/.codex/AGENTS.md`.
Do not rely on the Claude Code import line for Codex.

Configure a direct symbolic link to the shared instruction file:

```text
~/.codex/AGENTS.md -> ~/.claude/learning-resources/AGENTS.md
```

Apply these rules:

- Create `~/.codex` when the directory does not exist.
- Create the symbolic link when `~/.codex/AGENTS.md` does not exist.
- Keep the symbolic link when it already points to the shared instruction file.
- Replace an old link to `~/.claude/CLAUDE.md` only when the target contains no unique instructions.
- Do not replace any other existing file or link.
- Report the existing path, file type, and link target when a conflict exists.
- Report a non-empty `~/.codex/AGENTS.override.md` because Codex loads the override instead.

## Verify the setup

Verify every item:

- `ls -la ~/.claude/skills` shows repository links for Claude Code.
- `ls -la ~/.agents/skills` shows the same repository skills for Codex.
- `head -1 ~/.claude/CLAUDE.md` shows the exact import line.
- `readlink ~/.codex/AGENTS.md` shows the shared repository `AGENTS.md` path.
- No real skill folder changes type or disappears.
- No unrelated symbolic link disappears.

Report every change and every unresolved conflict.
Restart Claude Code and Codex sessions so both products load the current instructions.

## Ongoing workflow on both Macs

Edit skills and instructions through `~/.claude/learning-resources`, then push the changes.
Pull the changes on the other Mac.
Run `sync-skills.sh` after you add, rename, remove, or move a skill folder.
Do not run `sync-skills.sh` after a normal edit inside an existing skill folder.
