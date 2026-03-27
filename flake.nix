{
  inputs = {

    # Nix packages collection and NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Modules for running NixOS on Windows Subsystem for Linux
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    # Modules for managing macOS using Nix
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # System for managing user environments using Nix
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Theming framework for NixOS, Home Manager, and nix-darwin
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # Module for managing LazyVim in Home Manager
    lazyvim-nix.url = "github:pfassina/lazyvim-nix";
    lazyvim-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Flake providing Zen Browser packages
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nixos-wsl, home-manager, stylix, ... }: {

    # Configuration for NZXT H1
    nixosConfigurations.nzxt-h1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ./hosts/nzxt-h1/configuration.nix
      ];
    };

    # Configuration for HP 250 G9
    nixosConfigurations.hp-250-g9 = nixpkgs.lib.nixosSystem {
      modules = [
        nixos-wsl.nixosModules.default
        home-manager.nixosModules.home-manager
        stylix.nixosModules.stylix
        ./hosts/hp-250-g9/configuration.nix
      ];
    };

    # Configuration for MacBook Air M1
    darwinConfigurations.macbook-air-m1 = nix-darwin.lib.darwinSystem {
      modules = [
        home-manager.darwinModules.home-manager
        stylix.darwinModules.stylix
        ./hosts/macbook-air-m1/configuration.nix
      ];
    };

  };
}
