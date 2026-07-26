# dotfiles

Nix configurations for my machines, using [den](https://den.oeiuwq.com).

## Structure

- `hardware/` - Auto-generated hardware configs per machine
- `modules/aspects/` - Reusable feature aspects (what each feature configures)
- `modules/hosts/` - Machine definitions (what exists on each host)
- `modules/users/` - User definitions (what each user includes)

## Flake Inputs

The `flake.nix` file is **auto-generated** by [flake-file](https://github.com/vic/flake-file) and should not be edited directly. Flakes inputs are declared as module options (`flake-file.inputs.*`) alongside the aspects that use them, rather than in a single central list.

After changing any `flake-file.inputs.*` option, regenerate `flake.nix`:

```
mise run codegen
```

This is done automatically by `mise run update` and `mise run apply`.

## Commands

- `mise run init` - Initialise development environment
- `mise run check` - Verify flake evaluates
- `mise run codegen` - Regenerate flake file
- `mise run update` - Update lock file
- `mise run hardware` - Regenerate hardware configuration for this machine
- `mise run apply` - Activate system configuration

## Without mise

Mise is an optional task runner and project-local development-tool manager. It is not required to build or apply the configuration.

```
nix run .#write-flake                                   # codegen
nix flake update                                        # update
nix flake check                                         # check
sudo nixos-rebuild switch --flake .                     # apply on NixOS
sudo darwin-rebuild switch --flake .                    # apply on macOS

nixos-generate-config --show-hardware-config \
  > hardware/$(hostname)/hardware-configuration.nix     # hardware
```
