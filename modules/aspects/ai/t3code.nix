{ den, inputs, ... }: {

  # T3 Code 0.0.29 from an unmerged nixpkgs pull request, as the pinned nixpkgs
  # is still on 0.0.28. Deliberately not following nixpkgs: this input is itself
  # a nixpkgs, pinned to the pull request head.
  #
  # Once https://github.com/NixOS/nixpkgs/pull/546533 is merged, drop this input
  # and the t3code-pr helper below, and use `pkgs.t3code` directly.
  flake-file.inputs.nixpkgs-t3code.url = "github:NixOS/nixpkgs/refs/pull/546533/head";

  den.aspects.ai.provides.t3code = { user, ... }: let
    t3code-pr = pkgs: inputs.nixpkgs-t3code.legacyPackages.${pkgs.stdenv.hostPlatform.system}.t3code;
  in {

    includes = with den.aspects; [ remote._.tailscale ];

    homeManager = { pkgs, ... }: {

      # Enable T3 Code
      programs.t3code = {
        enable = true;
        package = t3code-pr pkgs;
      };

    };

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
          ExecStart = "${t3code-pr pkgs}/bin/t3 serve --host 0.0.0.0 --port 3773";
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
