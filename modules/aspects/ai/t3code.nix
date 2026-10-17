{ den, ... }: {

  den.aspects.ai.provides.t3code = { user, ... }: let
    t3code-nightly = pkgs: pkgs.callPackage ../../../packages/t3code-nightly.nix { };
  in {

    includes = with den.aspects; [ remote._.tailscale ];

    homeManager = { pkgs, ... }: {

      # Enable T3 Code
      programs.t3code = {
        enable = true;
        package = t3code-nightly pkgs;
      };

    };

    os = { config, pkgs, ... }: {

      # Allow the service user to configure Tailscale Serve, which T3 Code does
      # itself when started with --tailscale-serve
      services.tailscale.extraSetFlags = [ "--operator=${user.userName}" ];

      # Start the T3 Code server automatically at boot
      systemd.services.t3code = {
        description = "T3 Code server";
        after = [ "tailscaled.service" "tailscaled-set.service" ];
        wantedBy = [ "multi-user.target" ];
        path = [ config.services.tailscale.package ];
        serviceConfig = {
          User = user.userName;
          WorkingDirectory = "~";
          # T3 Code only warns if Tailscale Serve setup fails, so wait for the
          # Tailscale backend to leave NoState first.
          ExecStartPre = "${config.services.tailscale.package}/bin/tailscale wait --timeout=30s";
          # Serve HTTPS on this machine's tailnet name, which T3 Code advertises
          # to paired clients as a route. Serve forwards to the server on
          # loopback, where it listens by default.
          ExecStart = "${t3code-nightly pkgs}/bin/t3 serve --tailscale-serve";
          Restart = "always";
          RestartSec = 5;
        };
      };

    };

  };

}
