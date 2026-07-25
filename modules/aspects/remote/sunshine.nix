{ den, ... }: {

  den.aspects.remote.provides.sunshine = { user, ... }: {

    os = { lib, ... }: {

      # Enable streaming with Sunshine
      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
        applications = {
          env.PATH = "$(PATH):$(HOME)/.local/bin";
          apps = [
            {
              name = "Desktop";
              image-path = "desktop.png";
            }
            {
              name = "Low Res Desktop";
              image-path = "desktop.png";
              prep-cmd = [{
                do = "xrandr --output HDMI-1 --mode 1920x1080";
                undo = "xrandr --output HDMI-1 --mode 1920x1200";
              }];
            }
            {
              name = "Steam Big Picture";
              detached = [
                "setsid steam steam://open/bigpicture"
              ];
              prep-cmd = [{
                do = "";
                undo = "setsid steam steam://close/bigpicture";
              }];
              image-path = "steam.png";
            }
          ];
        };
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
