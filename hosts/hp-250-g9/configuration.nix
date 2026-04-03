{ config, lib, pkgs, ... }: {

  imports = [

    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Basic system configuration
    ../../legacy/system/boot/wsl.nix
    ../../legacy/system/time/europe/london.nix
    ../../legacy/system/locale/english/british.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/home/homeManager.nix
    ../../legacy/system/theme/stylix.nix
    ../../legacy/system/nix/flakes.nix

  ];

  # Define the hostname
  networking.hostName = "hp-250-g9";

  # Define user configuration
  my.user.name = "nixos";
  my.user.config = import ./home.nix;

  # Required for VS Code Server
  programs.nix-ld.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}
