{ config, lib, pkgs, inputs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../options/user.nix
    ../../modules/boot/grub.nix
    ../../modules/kernel/latest.nix
    ../../modules/network/networkManager.nix
    ../../modules/time/europe/london.nix
    ../../modules/locale/english/british.nix
    ../../modules/gpu/nvidia.nix
  ];

  # Define the hostname
  networking.hostName = "nzxt-h1";

  # Define user configuration
  my.user.name = "echo";

  # Enable the GNOME Desktop Environment
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable streaming with sunshine
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';
  services.displayManager.autoLogin = {
    enable = true;
    user = "echo";
  };

  # Enable Zsh
  programs.zsh.enable = true;

  # Enable Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    polarity = "dark";
  };

  # Define the user account
  users.users.echo = {
    isNormalUser = true;
    description = "Eugén Cowie";
    shell = pkgs.zsh;
    extraGroups = [
      "input" # needed for sunshine
      "wheel"
    ];
  };

  # Manage user environment
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.echo = import ./home.nix;
  };

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
