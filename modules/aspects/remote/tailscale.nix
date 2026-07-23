{ den, ... }: {

  den.aspects.remote.provides.tailscale = {

    os = { config, lib, ... }: let
      httpsServices = config.services.tailscale.httpsServices;
    in {

      options.services.tailscale.httpsServices = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = "Named Tailscale Services exposed over HTTPS and their local HTTP backends";
      };

      config = {

        # Enable the Tailscale mesh VPN
        services.tailscale.enable = true;

        # Configure HTTPS services directly until the Tailscale Serve config format
        # can preserve the protocol used by the frontend listener.
        systemd.services.tailscale-serve = lib.mkIf (httpsServices != {}) {
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
          script = lib.concatStringsSep "\n" (lib.mapAttrsToList (name: target: ''
            tailscale serve --yes --service=${lib.escapeShellArg "svc:${name}"} --http=443 off || true
            tailscale serve --yes --service=${lib.escapeShellArg "svc:${name}"} --https=443 ${lib.escapeShellArg target}
          '') httpsServices);
        };

      };

    };

  };

}
