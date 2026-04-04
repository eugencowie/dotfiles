{ config, pkgs, ... }: {

  # Enable Zsh
  programs.zsh.enable = true;

  # Set the login shell for the primary user
  users.users.${config.my.user.name}.shell = pkgs.zsh;

}
