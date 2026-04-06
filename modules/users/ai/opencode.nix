{ den, ... }: {

  den.aspects.ai.provides.opencode.homeManager = {

    # Enable OpenCode
    programs.opencode = {
      enable = true;
      settings = {
        permission.bash = "ask";
      };
    };

  };

}
