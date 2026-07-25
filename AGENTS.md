# Agent Instructions

## Development environment

This project uses Nix to manage the development environment.

- Run `nix develop -c make help` to see the available targets.
- Use `nix develop -c make <target>` for standard operations.
- Run `cat shell.nix` to see the managed tools in the development shell.
- When invoking a managed tool directly, use `nix develop -c <command> [args]` rather than invoking the tool by its bare name.
