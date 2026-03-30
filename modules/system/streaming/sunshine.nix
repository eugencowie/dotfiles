{ config, lib, ... }: {

  # Enable streaming with Sunshine
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  # Allow the primary user to control the virtual input device
  hardware.uinput.enable = true;
  users.users.${config.my.user.name}.extraGroups = lib.mkAfter [ "uinput" ];

  # Autologin to allow streaming without needing to log in first
  services.displayManager.autoLogin = {
    enable = true;
    user = config.my.user.name;
  };

  # Enable SSH as a backup in case streaming fails
  services.openssh.enable = true;

}
