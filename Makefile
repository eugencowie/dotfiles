help:
	@printf '%s\n' \
		'Available targets:' \
		'init        Initialise development environment' \
		'flake.nix   Generate flake.nix using flake-file' \
		'flake.lock  Update flake lock file' \
		'hardware/<hostname>/hardware-configuration.nix' \
		'            Update hardware configuration' \
		'install     Rebuild and activate the system configuration (run using sudo)'

init:
	skills experimental_install
	cp -r .agents/. .claude

flake.nix:
	nix run .#write-flake

flake.lock: flake.nix
	nix flake update

hardware/%/hardware-configuration.nix: flake.nix
	mkdir -p $(@D)
	nixos-generate-config --show-hardware-config > $@

install: flake.nix
	@case "$$(uname -s)" in \
		Darwin) darwin-rebuild switch --flake . ;; \
		*) nixos-rebuild switch --flake . ;; \
	esac

.PHONY: help init flake.nix
