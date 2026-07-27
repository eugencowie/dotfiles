{ den, ... }: {

  den.aspects.remote.provides.tailscale = {

    os = { config, lib, ... }: let
      cfg = config.services.tailscale.serve;
      endpointPort = endpoint: let
        match = builtins.match "tcp:([0-9]+)" endpoint;
      in
        if match == null then null else builtins.head match;
      mkEndpoint = serviceName: endpoint: target: let
        port = endpointPort endpoint;
      in
        lib.optionalString (port != null) ''
          tailscale serve --yes --service=${lib.escapeShellArg "svc:${serviceName}"} --http=${port} off || true
          tailscale serve --yes --service=${lib.escapeShellArg "svc:${serviceName}"} --https=${port} ${lib.escapeShellArg target}
        '';
      mkService = serviceName: service:
        lib.concatMapAttrsStringSep "\n" (mkEndpoint serviceName) service.endpoints;
      badEndpoints = lib.concatLists (lib.mapAttrsToList (_: service:
        lib.filter (endpoint: endpointPort endpoint == null)
          (builtins.attrNames service.endpoints)
      ) cfg.services);
      undrainable = builtins.attrNames
        (lib.filterAttrs (_: service: service.advertised == false) cfg.services);
    in {

      # Renders services.tailscale.serve.services with an HTTPS frontend listener.
      # Mutually exclusive with services.tailscale.serve.enable, which renders the
      # same services via `serve set-config`; see the assertions below.
      options.services.tailscale.serve.enableWithHttps =
        lib.mkEnableOption "HTTPS termination for named Tailscale Services";

      config = {

        # Enable the Tailscale mesh VPN
        services.tailscale.enable = true;

        assertions = [
          {
            assertion = cfg.services == {} || (cfg.enable != cfg.enableWithHttps);
            message = ''
              services.tailscale.serve.services is rendered by exactly one of
              services.tailscale.serve.enable or services.tailscale.serve.enableWithHttps.
              Set one of them, not both and not neither.
            '';
          }
          {
            assertion = !cfg.enableWithHttps || cfg.configFile == null;
            message = ''
              services.tailscale.serve.configFile is ignored when
              services.tailscale.serve.enableWithHttps is set, as the Serve config
              format cannot express an HTTPS frontend listener.
            '';
          }
          {
            assertion = !cfg.enableWithHttps || undrainable == [];
            message = ''
              services.tailscale.serve.enableWithHttps cannot unadvertise a service,
              but advertised = false is set on: ${lib.concatStringsSep ", " undrainable}.
              Supporting this would require running `tailscale serve drain`.
            '';
          }
          {
            assertion = !cfg.enableWithHttps || badEndpoints == [];
            message = ''
              services.tailscale.serve.enableWithHttps only supports endpoints in the
              tcp:<port> format, but found: ${lib.concatStringsSep ", " badEndpoints}.
              Port ranges are not supported, as `tailscale serve --https` takes a
              single port.
            '';
          }
        ];

        # Configure HTTPS services imperatively. The Tailscale Services config
        # format (version 0.0.1) accepts tcp:<port> ingress keys whose values name
        # the *backend* protocol, and has no field for the protocol of the frontend
        # listener, so `serve set-config` cannot terminate HTTPS. This is a
        # limitation of the config format itself rather than of the nixpkgs module,
        # so a nixpkgs bump will not lift it; recheck the format for a
        # frontend-protocol field before removing this.
        systemd.services.tailscale-serve = lib.mkIf cfg.enableWithHttps {
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
