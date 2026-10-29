{ den, inputs, ... }: {

  # T3 Code packaged from upstream release binaries, updated hourly
  flake-file.inputs.t3code = {
    url = "github:omarcresp/t3code-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.ai.provides.t3code = { user, ... }: let
    t3code-nightly = pkgs: inputs.t3code.packages.${pkgs.stdenv.hostPlatform.system}.t3-code-nightly;
  in {

    includes = with den.aspects; [ remote._.tailscale ];

    homeManager = { pkgs, ... }: {

      # Enable T3 Code
      programs.t3code = {
        enable = true;
        package = t3code-nightly pkgs;
      };

    };

    os = { config, pkgs, ... }: let
      homeConfig = config.home-manager.users.${user.userName};
    in {

      # Allow the service user to configure Tailscale Serve, which T3 Code does
      # itself when started with --tailscale-serve
      services.tailscale.extraSetFlags = [ "--operator=${user.userName}" ];

      # Start the T3 Code server automatically at boot
      systemd.services.t3code = {
        description = "T3 Code server";
        after = [ "tailscaled.service" "tailscaled-set.service" ];
        wantedBy = [ "multi-user.target" ];
        # The package doesn't wrap the CLIs T3 Code drives (git, gh, coding
        # agents), so give the server the user's packages like their session
        path = [ config.services.tailscale.package homeConfig.home.path ];
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
