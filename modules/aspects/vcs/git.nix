{ den, ... }: {

  den.aspects.vcs.provides.git = { name, email }: {

    # Enable Git
    homeManager.programs.git = {
      enable = true;
      settings.user = {
        inherit name email;
      };
    };

  };

}
