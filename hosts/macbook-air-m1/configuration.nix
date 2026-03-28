{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../options/user.nix
    ../../modules/shell/zsh.nix
    ../../modules/home/homeManager.nix
    ../../modules/theme/catppuccin-macchiato.nix
    ../../modules/nix/flakes.nix
  ];

  # Define the hostname
  networking.hostName = "macbook-air-m1";

  # Define user configuration
  my.user.name = "eugen";
  my.user.config = import ./home.nix;

  # Define the user account
  users.users.eugen = {
    home = "/Users/eugen";
  };

  # Used for backwards compatibility, please read the changelog before changing:
  # $ darwin-rebuild changelog
  system.stateVersion = 6; # Did you read the comment?

}
