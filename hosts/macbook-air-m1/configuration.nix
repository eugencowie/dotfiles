{ config, lib, pkgs, ... }: {

  imports = [

    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Customise login environment
    ../../modules/system/shell/zsh.nix
    ../../modules/system/home/homeManager.nix
    ../../modules/system/theme/stylix.nix
    ../../modules/system/nix/flakes.nix

  ];

  # Define the hostname
  networking.hostName = "macbook-air-m1";

  # Define user configuration
  my.user.name = "eugen";
  my.user.config = import ./home.nix;

  # Define the user account
  users.users.eugen.home = "/Users/eugen";

  # Used for backwards compatibility, please read the changelog before changing:
  # $ darwin-rebuild changelog
  system.stateVersion = 6; # Did you read the comment?

}
