{ den, ... }: {

  den.aspects.remote.provides.code-server = { user, ... }: {

    os = { config, ... }: {

      services.code-server = {
        enable = true;
        user = user.userName;
        group = config.users.users.${user.userName}.group;
        host = "0.0.0.0";
        auth = "none";
        disableTelemetry = true;
        disableUpdateCheck = true;
      };

      networking.firewall.allowedTCPPorts = [ 4444 ];

    };

  };

}
