{ config, lib, ... }: {

  # Enable streaming with Sunshine
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  users.users.${config.my.user.name}.extraGroups = lib.mkAfter [ "input" ];

  # Autologin for Sunshine
  services.displayManager.autoLogin = {
    enable = true;
    user = config.my.user.name;
  };

  # Enable the OpenSSH daemon as a backup for Sunshine
  services.openssh.enable = true;

}
