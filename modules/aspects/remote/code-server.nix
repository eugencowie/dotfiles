{ den, ... }: {

  den.aspects.remote.provides.code-server = { user, ... }: {

    includes = with den.aspects; [ remote._.tailscale ];

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
      services.tailscale.httpsServices.code-server = "http://127.0.0.1:4444";

    };

  };

}
