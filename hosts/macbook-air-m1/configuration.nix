{ config, lib, pkgs, ... }: {

  imports = [

    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/home/homeManager.nix
    ../../legacy/system/nix/flakes.nix

  ];

  # Define user configuration
  my.user.name = "eugen";
  my.user.config = import ./home.nix;

}
