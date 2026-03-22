{ config, lib, pkgs, ... }: {

  # Include the results of the hardware scan
  imports = [ ./hardware-configuration.nix ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
  ];

  # Define the user account
  users.users.eugen = {
    home = "/Users/eugen";
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
