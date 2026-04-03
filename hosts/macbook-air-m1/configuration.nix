{ config, lib, pkgs, ... }: {

  imports = [

    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/home/homeManager.nix
    ../../legacy/system/theme/stylix.nix
    ../../legacy/system/nix/flakes.nix

  ];

  # Define the hostname
  networking.hostName = "macbook-air-m1";

  # Define user configuration
  my.user.name = "eugen";
  my.user.config = import ./home.nix;

  # Define the user account
  users.users.eugen.home = "/Users/eugen";

}
