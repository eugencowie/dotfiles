{ den, ... }: {

  den.aspects.vcs.provides.git.homeManager = {

    programs.git = {
      enable = true;
      settings.user = {
        name = "Eugén Cowie";
        email = "eugencowie@users.noreply.github.com";
      };
    };

  };

}
