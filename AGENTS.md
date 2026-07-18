# Agent Instructions

## Development environment

This project uses Nix to manage the development environment.

- Run `cat shell.nix` to see the available tools.
- Run `nix develop -c make help` to see the available targets.
- Use `nix develop -c make <target>` for standard operations.
- When invoking a managed tool directly and no target exists, use `nix develop -c <command> [args]` rather than invoking the tool by its bare name.
