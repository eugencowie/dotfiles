{ config, pkgs, ... }: {

  # Enable Zsh
  programs.zsh.enable = true;

  # Set the login shell
  users.users.${config.my.user.name}.shell = pkgs.zsh;

}
