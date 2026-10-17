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
        settings = {
          font-family = "IosevkaTerm Nerd Font";
          # Install Ghostty's terminfo on remote hosts when connecting over SSH,
          # falling back to xterm-256color if the install fails
          shell-integration-features = "ssh-env,ssh-terminfo";
        };
      };

      # Enable font support for Ghostty fonts
      fonts.fontconfig.enable = true;
      home.packages = [ pkgs.nerd-fonts.iosevka-term ];

    };

  };

}
