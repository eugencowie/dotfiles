{ den, ... }: {

  den.aspects.shell.provides.direnv.homeManager = {

    # Enable direnv
    programs.direnv.enable = true;

  };

}
