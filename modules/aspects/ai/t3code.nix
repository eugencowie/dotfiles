{ den, ... }: {

  den.aspects.ai.provides.t3code = { user, ... }: {

    includes = with den.aspects; [ remote._.tailscale ];

    # Enable T3 Code
    homeManager.programs.t3code.enable = true;

    os = { config, pkgs, ... }: let
      home = config.users.users.${user.userName}.home;
    in {

      # Start the T3 Code server automatically at boot
      systemd.services.t3code = {
        description = "T3 Code server";
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        environment.HOME = home;
        serviceConfig = {
          User = user.userName;
          Group = config.users.users.${user.userName}.group;
          WorkingDirectory = home;
          # Bind to all interfaces, as binding only to localhost enables local-only mode, which prevents linking other devices.
          ExecStart = "${pkgs.t3code}/bin/t3 serve --host 0.0.0.0 --port 3773";
          Restart = "always";
          RestartSec = 5;
        };
      };

      # Expose T3 Code as a named Tailscale Service over HTTPS
      services.tailscale.serve = {
        enableWithHttps = true;
        services.t3code.endpoints."tcp:443" = "http://127.0.0.1:3773";
      };

    };

  };

}
