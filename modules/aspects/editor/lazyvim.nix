{ inputs, ... }: {

  # Module for managing LazyVim in Home Manager
  flake-file.inputs.lazyvim-nix = {
    url = "github:pfassina/lazyvim-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.editor.provides.lazyvim.homeManager = {

    imports = [ inputs.lazyvim-nix.homeManagerModules.default ];

    # Enable LazyVim
    programs.lazyvim = {
      enable = true;
      extras.ai.copilot.enable = true;
    };

    # Set Neovim as the default editor
    programs.neovim.defaultEditor = true;

  };

}
