{ den, ... }: {

  den.aspects.remote.provides.sunshine = { user, ... }: {

    os = { lib, ... }: {

      services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
      };

      hardware.uinput.enable = true;
      users.users.${user.userName}.extraGroups = lib.mkAfter [ "uinput" ];

      services.displayManager.autoLogin = {
        enable = true;
        user = user.userName;
      };

      services.openssh.enable = true;

    };

  };

}
