{ config, lib, pkgs, ... }: {

  imports = [

    # Include the results of the hardware scan
    ./hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Basic system configuration
    ../../legacy/system/boot/grub.nix
    ../../legacy/system/kernel/latest.nix
    ../../legacy/system/network/networkManager.nix
    ../../legacy/system/time/europe/london.nix
    ../../legacy/system/locale/english/british.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/home/homeManager.nix
    ../../legacy/system/theme/stylix.nix
    ../../legacy/system/nix/flakes.nix

    # Configure desktop environment
    ../../legacy/system/gpu/nvidia.nix
    ../../legacy/system/desktop/gnome.nix
    ../../legacy/system/sound/pipewire.nix
    ../../legacy/system/streaming/sunshine.nix

  ];

  # Define the hostname
  networking.hostName = "nzxt-h1";

  # Define user configuration
  my.user.name = "echo";
  my.user.config = import ./home.nix;

  # Define the user account
  users.users.echo = {
    isNormalUser = true;
    description = "Eugén Cowie";
    extraGroups = [ "wheel" ];
  };

  # Required for VS Code Server
  programs.nix-ld.enable = true;

}
