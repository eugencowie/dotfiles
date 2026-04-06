{ den, inputs, ... }: {

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
