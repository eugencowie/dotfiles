# Agent Instructions

## Development Environment

This project uses mise as its task runner. Tools come from the flake's pinned nixpkgs via `nix run --inputs-from . nixpkgs#<package>`, not from mise.

- Run `mise tasks` to see the available tasks.
- Use `mise run <task>` for standard operations.

## Nix Guidelines

- Check requires files to be tracked by Git, use `git add --intent-to-add <file>` to add untracked files without staging.
