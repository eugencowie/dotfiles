{ den, ... }: {

  den.aspects.shell.provides.direnv.homeManager = {

    programs.direnv.enable = true;

  };

}
