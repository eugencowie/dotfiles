update:
	nix flake update

install:
	@case "$$(uname -s)" in \
		Darwin) darwin-rebuild switch --flake . ;; \
		*) nixos-rebuild switch --flake . ;; \
	esac

.PHONY: update install
