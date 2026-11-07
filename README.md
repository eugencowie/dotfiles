# Dotfiles

Nix configurations for my machines, using [den](https://den.oeiuwq.com).

## Flake Inputs

The `flake.nix` file is **auto-generated** by [flake-file](https://github.com/vic/flake-file) and should not be edited directly. Flakes inputs are declared as module options (`flake-file.inputs.*`) alongside the aspects that use them, rather than in a single central list.

This file is regenerated automatically when required during standard `mise` development tasks. If you need to regenerate it manually for some reason:

```
mise run codegen
```
