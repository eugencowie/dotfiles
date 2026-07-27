{ den, ... }: {

  den.aspects.remote.provides.tailscale = {

    os = { config, lib, ... }: let
      cfg = config.services.tailscale.serve.https;
      mkEndpoint = serviceName: endpoint: target: let
        match = builtins.match "tcp:([0-9]+)" endpoint;
        port = builtins.head match;
      in
        assert lib.assertMsg (match != null)
          "services.tailscale.serve.https endpoint '${endpoint}' must use the tcp:<port> format";
        ''
          tailscale serve --yes --service=${lib.escapeShellArg "svc:${serviceName}"} --http=${port} off || true
          tailscale serve --yes --service=${lib.escapeShellArg "svc:${serviceName}"} --https=${port} ${lib.escapeShellArg target}
        '';
      mkService = serviceName: service:
        lib.concatMapAttrsStringSep "\n" (mkEndpoint serviceName) service.endpoints;
    in {

      options.services.tailscale.serve.https = {
        enable = lib.mkEnableOption "HTTPS termination for named Tailscale Services";
        services = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submodule {
            options.endpoints = lib.mkOption {
              type = lib.types.attrsOf lib.types.str;
              description = "TCP frontend endpoints and their local HTTP backends";
            };
          });
          default = {};
          description = "Named Tailscale Services exposed over HTTPS";
        };
      };

      config = {

        # Enable the Tailscale mesh VPN
        services.tailscale.enable = true;

        assertions = lib.optional cfg.enable {
          assertion = cfg.services != {};
          message = "services.tailscale.serve.https requires at least one service";
        };

        # Configure HTTPS services directly until the Tailscale Serve config format
        # can preserve the protocol used by the frontend listener.
        systemd.services.tailscale-serve = lib.mkIf cfg.enable {
          description = "Configure Tailscale HTTPS services";
          after = [
            "tailscaled.service"
            "tailscaled-autoconnect.service"
            "tailscaled-set.service"
          ];
          wants = [ "tailscaled.service" ];
          wantedBy = [ "multi-user.target" ];
          path = [ config.services.tailscale.package ];
          # Ordering after tailscaled.service only waits for the daemon to start,
          # not for its backend to leave NoState, so wait for readiness explicitly.
          preStart = ''
            tailscale wait --timeout=30s
          '';
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
          script = lib.concatMapAttrsStringSep "\n" mkService cfg.services;
        };

      };

    };

  };

}
