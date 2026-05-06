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

.PHONY: flake.nix
