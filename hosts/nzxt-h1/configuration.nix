{ config, lib, pkgs, inputs, ... }: {

  # Include the results of the hardware scan
  imports = [ ./hardware-configuration.nix ];

  # Use the GRUB EFI boot loader
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

  # Use latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Define the hostname
  networking.hostName = "nzxt-h1";

  # Configure network connections interactively with nmcli or nmtui
  networking.networkmanager.enable = true;

  # Set the time zone
  time.timeZone = "Europe/London";

  # Select internationalisation properties
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the NVIDIA graphics drivers
  nixpkgs.config.allowUnfree = true;
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = true;
  hardware.nvidia.modesetting.enable = true;

  # Enable the GNOME Desktop Environment
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

  # Define the user account
  users.users.echo = {
    isNormalUser = true;
    description = "Eugén Cowie";
    shell = pkgs.zsh;
    extraGroups = [
      "input" # needed for sunshine
      "networkmanager"
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
