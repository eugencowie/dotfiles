{ inputs, ... }: {

  # Module for managing Helium Browser in Home Manager
  flake-file.inputs.helium-browser = {
    url = "github:oxcl/nix-flake-helium-browser";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.browser.provides.helium.homeManager = {

    imports = [ inputs.helium-browser.homeModules.default ];

    programs.helium.enable = true;

  };

}
