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

    # Module for running NixOS on Windows Subsystem for Linux
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

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

  outputs = inputs@{ self, nixpkgs, nix-darwin, nixos-wsl, home-manager, ... }: {

    # Configuration for NZXT H1
    nixosConfigurations.nzxt-h1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        home-manager.nixosModules.home-manager
        ./hosts/nzxt-h1/configuration.nix
      ];
    };

    # Configuration for NixOS-WSL
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        {
          system.stateVersion = "25.11";
          wsl.enable = true;
        }
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
