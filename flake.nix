{
  inputs = {

    # Official Nix packages collection
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    # Module for managing macOS system configurations
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Module for managing user environments
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }: {

    # Configuration for NZXT H1
    nixosConfigurations.nzxt-h1 = nixpkgs.lib.nixosSystem {
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/nzxt-h1/configuration.nix
      ];
    };

    # Configuration for MacBook Air M1
    darwinConfigurations.macbook-air-m1 = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self inputs; };
      modules = [
        ./hosts/macbook-air-m1/configuration.nix
      ];
    };

  };
}
