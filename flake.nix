{
  inputs = {

    # Pure Nix flake utility functions
    flake-utils.url = "github:numtide/flake-utils";

    # Import all Nix files in a directory tree
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
    darwin.follows = "nix-darwin";

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

  outputs = inputs@{ flake-utils, import-tree, nixpkgs, ... }: (nixpkgs.lib.evalModules {

    # Import all modules
    modules = [ (import-tree ./modules) ];
    specialArgs = { inherit inputs; };

  }).config.flake // flake-utils.lib.eachDefaultSystem (system: {

    # Development shell for this project
    devShells.default = import ./shell.nix {
      pkgs = nixpkgs.legacyPackages.${system};
    };

  });
}
