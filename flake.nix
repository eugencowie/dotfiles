{
  inputs = {
    # Nix packages collection
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Module for managing user environments
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      # Configuration for NZXT H1
      nzxt-h1 = nixpkgs.lib.nixosSystem {
        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/nzxt-h1/configuration.nix
        ];
      };
    };
  };
}
