{ inputs, lib, ... }: {

  flake-file.inputs = {

    # Generate flake.nix from module options
    flake-file.url = "github:vic/flake-file";

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

  # Use flake-file for dendritic modules
  imports = [ (inputs.flake-file.flakeModules.dendritic or { }) ];

}
