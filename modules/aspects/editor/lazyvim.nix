{ den, inputs, ... }: {

  flake-file.inputs.lazyvim-nix = {
    url = "github:pfassina/lazyvim-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.editor.provides.lazyvim.homeManager = {

    imports = [ inputs.lazyvim-nix.homeManagerModules.default ];

    programs.lazyvim = {
      enable = true;
      extras.ai.copilot.enable = true;
    };

    programs.neovim.defaultEditor = true;

  };

}
