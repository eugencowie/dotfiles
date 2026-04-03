{
  inputs = {

    # Pure Nix flake utility functions
    flake-utils.url = "github:numtide/flake-utils";

    # Import all nix files in a directory tree
    import-tree.url = "github:vic/import-tree";

    # Aspect-oriented, context-driven dendritic Nix configurations
    den.url = "github:vic/den";

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

    # Module for managing Zen Browser in Home Manager
    zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";

  };

  outputs = inputs@{ flake-utils, import-tree, nixpkgs, nix-darwin, nixos-wsl, stylix, ... }: let

    den = (nixpkgs.lib.evalModules {
      modules = [ (import-tree ./modules) ];
      specialArgs = { inherit inputs; };
    }).config;

    inherit (den.den.hosts.x86_64-linux) nzxt-h1 hp-250-g9;
    inherit (den.den.hosts.aarch64-darwin) macbook-air-m1;

  in {

    # Configuration for NZXT H1
    nixosConfigurations.nzxt-h1 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        nzxt-h1.mainModule
        stylix.nixosModules.stylix
      ];
    };

    # Configuration for HP 250 G9
    nixosConfigurations.hp-250-g9 = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        hp-250-g9.mainModule
        nixos-wsl.nixosModules.default
        stylix.nixosModules.stylix
      ];
    };

    # Configuration for MacBook Air M1
    darwinConfigurations.macbook-air-m1 = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [
        macbook-air-m1.mainModule
        stylix.darwinModules.stylix
      ];
    };

  } // flake-utils.lib.eachDefaultSystem (system: {

    # Development shell for this project
    devShells.default = import ./shell.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

  });
}
