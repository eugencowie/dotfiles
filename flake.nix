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

    # Module for managing LazyVim in Home Manager
    lazyvim-nix = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake providing Zen Browser packages
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager, ... }: {

    # Configuration for NZXT H1
    nixosConfigurations.nzxt-h1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/nzxt-h1/configuration.nix
      ];
    };

    # Configuration for MacBook Air M1
    darwinConfigurations.macbook-air-m1 = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        ./hosts/macbook-air-m1/configuration.nix
      ];
    };

  };
}
