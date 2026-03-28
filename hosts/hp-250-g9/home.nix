{ config, pkgs, ... }: {

  imports = [
    ../../modules/user/shell/zsh.nix
    ../../modules/user/prompts/starship.nix
    ../../modules/user/vcs/git.nix
    ../../modules/user/vcs/jujutsu.nix
  ];

  # Install user packages
  home.packages = with pkgs; [
    gnumake
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

}
