{ inputs, ... }: {

  # Nix flake for Helium browser
  flake-file.inputs.helium-browser = {
    url = "github:oxcl/nix-flake-helium-browser";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  # Enable Helium
  den.aspects.browser.provides.helium.homeManager = {
    imports = [ inputs.helium-browser.homeModules.default ];
    programs.helium.enable = true;
  };

}
