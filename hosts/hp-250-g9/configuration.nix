{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../options/user.nix
    ../../modules/system/time/europe/london.nix
    ../../modules/system/locale/english/british.nix
    ../../modules/system/shell/zsh.nix
    ../../modules/system/home/homeManager.nix
    ../../modules/system/theme/stylix.nix
    ../../modules/system/nix/flakes.nix
  ];

  # Enable support for running NixOS as a WSL distribution
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # Set the hostname
  networking.hostName = "hp-250-g9";

  # Define user configuration
  my.user.name = "nixos";
  my.user.config = import ./home.nix;

  # Required for VS Code Server
  programs.nix-ld.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
