{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../options/user.nix
    ../../modules/boot/grub.nix
    ../../modules/kernel/latest.nix
    ../../modules/network/networkManager.nix
    ../../modules/time/europe/london.nix
    ../../modules/locale/english/british.nix
    ../../modules/gpu/nvidia.nix
    ../../modules/desktop/gnome.nix
    ../../modules/sound/pipewire.nix
    ../../modules/streaming/sunshine.nix
    ../../modules/shell/zsh.nix
    ../../modules/home/homeManager.nix
    ../../modules/theme/catppuccin-macchiato.nix
    ../../modules/nix/flakes.nix
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
