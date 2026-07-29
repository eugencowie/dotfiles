{ inputs, ... }: {

  # Community-driven Nix flake for the Zen browser
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake/beta";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  # Enable Zen
  den.aspects.browser.provides.zen.homeManager = {
    imports = [ inputs.zen-browser.homeModules.beta ];
    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;
    };
  };

}
