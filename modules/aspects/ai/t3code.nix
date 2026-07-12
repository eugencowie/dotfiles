{ den, lib, ... }: {

  den.aspects.ai.provides.t3code = { user, ... }: {

    # Enable T3 Code
    homeManager.programs.t3code.enable = true;

    os = { config, pkgs, ... }: let
      home = config.users.users.${user.userName}.home;
    in {

      # Start the T3 Code server automatically at boot
      systemd.services.t3code = {
        description = "T3 Code server";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];

        environment.HOME = home;

        serviceConfig = {
          User = user.userName;
          Group = config.users.users.${user.userName}.group;
          WorkingDirectory = home;
          # Binding only to localhost enables local-only mode, which prevents linking other devices.
          ExecStart = "${pkgs.t3code}/bin/t3 serve --host 0.0.0.0 --port 3773";
          Restart = "always";
          RestartSec = 5;
        };
      };

      # Allow T3 Code to be accessed from the local network
      networking.firewall.allowedTCPPorts = lib.mkAfter [ 3773 ];

    };

  };

}
