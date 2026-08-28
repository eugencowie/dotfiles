{ den, ... }: {

  den.aspects.term.provides.ghostty = {

    # Zsh is required for Zsh integration
    includes = with den.aspects; [ shell._.zsh ];

    homeManager = { pkgs, ... }: {

      # Enable Ghostty
      programs.ghostty = {
        enable = true;
        enableZshIntegration = true;
        package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
        settings.font-family = "IosevkaTerm Nerd Font";
      };

      # Enable font support for Ghostty fonts
      fonts.fontconfig.enable = true;
      home.packages = [ pkgs.nerd-fonts.iosevka-term ];

    };

  };

}
