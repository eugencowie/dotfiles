{ den, ... }: {

  den.aspects.remote.provides.tailscale = {

    os = { config, lib, ... }: let
      cfg = config.services.tailscale.serve.https;
      endpoints = lib.flatten (lib.mapAttrsToList (serviceName: service:
        lib.mapAttrsToList (endpoint: target: let
          match = builtins.match "tcp:([0-9]+)" endpoint;
        in {
          inherit endpoint serviceName target;
          port = if match == null then null else builtins.head match;
        }) service.endpoints
      ) cfg.services);
      validEndpoints = builtins.filter (endpoint: endpoint.port != null) endpoints;
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

        assertions = lib.optionals cfg.enable (
          [{
            assertion = cfg.services != {};
            message = "services.tailscale.serve.https requires at least one service";
          }]
          ++ map (endpoint: {
            assertion = endpoint.port != null;
            message = "services.tailscale.serve.https endpoint '${endpoint.endpoint}' must use the tcp:<port> format";
          }) endpoints
        );

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
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
          script = lib.concatStringsSep "\n" (map (endpoint: ''
            tailscale serve --yes --service=${lib.escapeShellArg "svc:${endpoint.serviceName}"} --http=${endpoint.port} off || true
            tailscale serve --yes --service=${lib.escapeShellArg "svc:${endpoint.serviceName}"} --https=${endpoint.port} ${lib.escapeShellArg endpoint.target}
          '') validEndpoints);
        };

      };

    };

  };

}
