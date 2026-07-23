{ den, ... }: {

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

    };

  };

}
