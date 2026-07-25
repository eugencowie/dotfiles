{ den, ... }: {

  den.aspects.remote.provides.sunshine = { user, ... }: {

    os = { lib, ... }: {

      # Enable streaming with Sunshine
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        settings.csrf_allowed_origins = "https://192.168.0.10:47990";
        applications.apps = [{
          name = "Desktop";
          image-path = "desktop.png";
        }];
      };

      # Do not start the global user service for the GDM greeter
      systemd.user.services.sunshine.unitConfig.ConditionUser = user.userName;

      # Allow the user to control the virtual input device
      hardware.uinput.enable = true;
      users.users.${user.userName}.extraGroups = lib.mkAfter [ "uinput" ];

      # Autologin to allow streaming without needing to log in first
      services.displayManager.autoLogin = {
        enable = true;
        user = user.userName;
      };

      # Allow remote clients to wake and suspend the streaming host
      networking.interfaces.enp9s0.wakeOnLan.enable = true;
      security.sudo.extraRules = [{
        users = [ user.userName ];
        commands = [{
          command = "/run/current-system/sw/bin/systemctl --no-block suspend";
          options = [ "NOPASSWD" ];
        }];
      }];

      # Enable SSH as a backup in case streaming fails
      services.openssh.enable = true;

    };

    homeManager = {

      # Keep the display active after resuming for remote capture
      dconf.settings."org/gnome/desktop/screensaver".lock-enabled = false;

    };

  };

}
