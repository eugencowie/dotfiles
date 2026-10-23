{ den, lib, ... }: {

  den.aspects.env.provides.hermes = {

    # Zsh is required for profile configuration
    includes = with den.aspects; [ shell._.zsh ];

    # Ensure Hermes Agent commands are available in the login environment
    homeManager.programs.zsh.profileExtra = lib.mkOrder 1200 ''
      export PATH="$HOME/.local/bin:$PATH"
    '';

    # The Hermes installer also requires this in .zshrc, which home-manager makes read-only
    homeManager.programs.zsh.initContent = ''
      case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
    '';

  };

}
