{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../options/user.nix
    ../../modules/system/boot/grub.nix
    ../../modules/system/kernel/latest.nix
    ../../modules/system/network/networkManager.nix
    ../../modules/system/time/europe/london.nix
    ../../modules/system/locale/english/british.nix
    ../../modules/system/gpu/nvidia.nix
    ../../modules/system/desktop/gnome.nix
    ../../modules/system/sound/pipewire.nix
    ../../modules/system/streaming/sunshine.nix
    ../../modules/system/shell/zsh.nix
    ../../modules/system/home/homeManager.nix
    ../../modules/system/theme/stylix.nix
    ../../modules/system/nix/flakes.nix
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
