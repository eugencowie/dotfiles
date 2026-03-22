{ config, lib, pkgs, ... }: {

  # Include the results of the hardware scan
  imports = [ ./hardware-configuration.nix ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Used for backwards compatibility, please read the changelog before changing:
  # $ darwin-rebuild changelog
  system.stateVersion = 6; # Did you read the comment?

}
