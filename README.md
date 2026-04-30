# dotfiles

Nix configurations for my machines, using [den](https://den.oeiuwq.com).

## Structure

- `hardware/` - Auto-generated hardware configs per machine
- `modules/aspects/` - Reusable feature aspects (what each feature configures)
- `modules/hosts/` - Machine definitions (what exists on each host)
- `modules/users/` - User definitions (what each user includes)

## Commands

- `sudo make install` - Apply configuration
- `make flake.lock` - Update all flake inputs
- `make flake.nix` - Regenerate flake.nix
- `make hardware/$(hostname)/hardware-configuration.nix` - Regenerate hardware configuration
