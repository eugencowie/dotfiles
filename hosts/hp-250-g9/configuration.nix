{ config, lib, pkgs, ... }: {

  imports = [

    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Basic system configuration
    ../../legacy/system/time/europe/london.nix
    ../../legacy/system/locale/english/british.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/home/homeManager.nix
    ../../legacy/system/theme/stylix.nix
    ../../legacy/system/nix/flakes.nix

  ];

  # Define user configuration
  my.user.name = "nixos";
  my.user.config = import ./home.nix;

}
