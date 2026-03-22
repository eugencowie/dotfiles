update:
	nix flake update

install:
	nixos-rebuild switch --flake .
