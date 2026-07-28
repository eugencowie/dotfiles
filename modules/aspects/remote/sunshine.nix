{

  den.aspects.remote.provides.sunshine = { user, ... }: {

    os = { lib, pkgs, ... }: {

      # Enable streaming with Sunshine
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        settings.csrf_allowed_origins = "https://192.168.0.10:47990";
        applications.apps = [
          {
            name = "Desktop";
            image-path = "desktop.png";
          }
          {
            name = "Low Res Desktop";
            image-path = "desktop-alt.png";
            prep-cmd = [{
              do = "${lib.getExe pkgs.gnome-randr} modify --mode 1680x1050@59.954 DP-2";
              undo = "${lib.getExe pkgs.gnome-randr} modify --mode 2560x1440@165.080 DP-2";
            }];
          }
        ];
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

    homeManager = { lib, ... }: {

      # Keep the session awake so remote capture keeps working. Suspend stays
      # remote-controlled through wake-on-lan and the sudo rule above, so the
      # idle timer must never suspend the host on its own. These are enforced
      # rather than seeded, as a stray change in Settings would break streaming.
      dconf.settings = {
        "org/gnome/desktop/screensaver".lock-enabled = false;
        "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 0;
        "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
      };

    };

  };

}
