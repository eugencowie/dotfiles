{ den, lib, ... }: {

  den.aspects.remote.provides.code-server = { user, ... }: {

    os = { config, ... }: {

      services.code-server = {
        enable = true;
        user = user.userName;
        group = config.users.users.${user.userName}.group;
        host = "127.0.0.1";
        auth = "none";
        disableTelemetry = true;
        disableUpdateCheck = true;
      };

      # Expose code-server as a named Tailscale Service over HTTPS
      services.tailscale.serve = {
        enable = true;
        services.code-server.endpoints."tcp:443" = "http://127.0.0.1:4444";
      };

      # Work around tailscale serve set-config creating an HTTP listener on port 443
      systemd.services.tailscale-serve.serviceConfig.ExecStartPost = lib.mkAfter [
        "-${config.services.tailscale.package}/bin/tailscale serve --yes --service=svc:code-server --http=443 off"
        "${config.services.tailscale.package}/bin/tailscale serve --yes --service=svc:code-server --https=443 127.0.0.1:4444"
      ];

    };

  };

}
