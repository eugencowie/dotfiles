{ den, ... }: {

  den.aspects.prompts.provides.starship.homeManager = {

    # Enable Starship
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

  };

}
