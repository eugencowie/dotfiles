# dotfiles

Nix configurations for my machines, using [den](https://den.oeiuwq.com).

## Structure

- `hardware/` - Auto-generated hardware configs per machine
- `modules/aspects/` - Reusable feature aspects (what each feature configures)
- `modules/hosts/` - Machine definitions (what exists on each host)
- `modules/users/` - User definitions (what each user includes)

## Flake Inputs

The `flake.nix` file is **auto-generated** by [flake-file](https://github.com/vic/flake-file) and should not be edited directly. Flakes inputs are declared as module options (`flake-file.inputs.*`) alongside the aspects that use them, rather than in a single central list.

This file is regenerated automatically when required during standard `mise` development tasks. If you need to regenerate it manually for some reason:

```
mise run codegen
```

## Development Tasks

- `mise run check` - Verify flake evaluates and perform checks
- `mise run codegen` - Regenerate flake file
- `mise run update` - Update lock file
- `mise run update:auth` - Update lock file using GitHub token
- `mise run hardware` - Regenerate hardware configuration for this machine
- `mise run apply` - Activate system configuration

### Without Mise

Mise is an optional task runner and project-local development-tool manager. It is not required to build or apply the configuration.

```
nix run .#write-flake                                     # codegen
nix flake update                                          # update
nix flake check                                           # check
nix run nixpkgs#deadnix -- --fail --exclude hardware -- . # lint
sudo nixos-rebuild switch --flake .                       # apply on NixOS
sudo darwin-rebuild switch --flake .                      # apply on macOS

nixos-generate-config --show-hardware-config \
  > hardware/$(hostname)/hardware-configuration.nix       # hardware
```
