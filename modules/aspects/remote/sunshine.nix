{ den, ... }: {

  den.aspects.remote.provides.sunshine = { user, ... }: {

    os = { lib, ... }: {

      # Enable streaming with Sunshine
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        applications.apps = [{
          name = "Desktop";
          image-path = "desktop.png";
        }];
      };

      # Allow the user to control the virtual input device
      hardware.uinput.enable = true;
      users.users.${user.userName}.extraGroups = lib.mkAfter [ "uinput" ];

      # Autologin to allow streaming without needing to log in first
      services.displayManager.autoLogin = {
        enable = true;
        user = user.userName;
      };

      # Enable SSH as a backup in case streaming fails
      services.openssh.enable = true;

    };

  };

}
