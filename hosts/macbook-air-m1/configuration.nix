{ config, lib, pkgs, ... }: {

  # Include the results of the hardware scan
  imports = [ ./hardware-configuration.nix ];

  # Define the hostname
  networking.hostName = "macbook-air-m1";

  # Enable Zsh
  programs.zsh.enable = true;

  # Define the user account
  users.users.eugen = {
    home = "/Users/eugen";
    shell = pkgs.zsh;
  };

  # Manage user environment
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.eugen = import ./home.nix;
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Used for backwards compatibility, please read the changelog before changing:
  # $ darwin-rebuild changelog
  system.stateVersion = 6; # Did you read the comment?

}
