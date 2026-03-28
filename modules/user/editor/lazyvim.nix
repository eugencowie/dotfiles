{ inputs, ... }: {

  imports = [
    inputs.lazyvim-nix.homeManagerModules.default
  ];

  # Enable LazyVim
  programs.lazyvim.enable = true;
  programs.neovim.defaultEditor = true;

}
