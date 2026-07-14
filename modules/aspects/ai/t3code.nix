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
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
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

      # Expose T3 Code as a named Tailscale Service over HTTPS
      services.tailscale.serve = {
        enable = true;
        services.t3code.endpoints."tcp:443" = "http://127.0.0.1:3773";
      };

      # Work around tailscale serve set-config creating an HTTP listener on port 443
      systemd.services.tailscale-serve.serviceConfig.ExecStartPost = lib.mkAfter [
        "-${config.services.tailscale.package}/bin/tailscale serve --yes --service=svc:t3code --http=443 off"
        "${config.services.tailscale.package}/bin/tailscale serve --yes --service=svc:t3code --https=443 127.0.0.1:3773"
      ];

    };

  };

}
