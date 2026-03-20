{
  inputs = {
    # Nix packages collection
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      # NOTE: 'nixos' is the default hostname
      nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/nixos/configuration.nix ];
      };
    };
  };
}
