{ den, ... }: {

  den.aspects.term.provides.ghostty = {

    # Zsh is required for Zsh integration
    includes = with den.aspects; [ shell._.zsh ];

    homeManager = { pkgs, ... }: {

      # Enable Ghostty
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
      };

      # Enable font support for Ghostty fonts
      fonts.fontconfig.enable = true;

    };

  };

}
