{ config, lib, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../options/user.nix
  ];

  # Define the hostname
  networking.hostName = "macbook-air-m1";

  # Define user configuration
  my.user.name = "eugen";

  # Enable Zsh
  programs.zsh.enable = true;

  # Enable Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  };

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
