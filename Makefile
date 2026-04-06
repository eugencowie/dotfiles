write-flake:
	nix run .#write-flake

check: write-flake
	nix flake check

show: write-flake
	nix flake show

update: write-flake
	nix flake update

install: write-flake
	@case "$$(uname -s)" in \
		Darwin) darwin-rebuild switch --flake . ;; \
		*) nixos-rebuild switch --flake . ;; \
	esac

.PHONY: write-flake check show update install
