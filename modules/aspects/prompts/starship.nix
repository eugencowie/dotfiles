{ den, ... }: {

  den.aspects.prompts.provides.starship = {

    # Zsh is required for Zsh integration
    includes = with den.aspects; [ shell._.zsh ];

    # Enable Starship
    homeManager.programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };

  };

}
