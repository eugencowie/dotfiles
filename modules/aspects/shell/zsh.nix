{ den, ... }: {

  den.aspects.shell.provides.zsh.homeManager = {

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

  };

}
