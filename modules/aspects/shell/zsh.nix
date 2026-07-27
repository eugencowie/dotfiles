{

  den.aspects.shell.provides.zsh.homeManager = {

    # Enable Zsh
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

  };

}
