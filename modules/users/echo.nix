{ den, ... }: {

  # Include user aspects
  den.aspects.echo.includes = [

    # Mark as primary user
    den.provides.primary-user

    # Customise login environment
    (den.provides.user-shell "zsh")

    # Configure remote access
    den.aspects.remote._.sunshine

    # Configure terminal environment
    den.aspects.shell._.zsh
    den.aspects.shell._.direnv
    den.aspects.prompts._.starship
    den.aspects.multiplex._.zellij
    den.aspects.term._.ghostty

    # Configure development environment
    den.aspects.vcs._.git
    den.aspects.vcs._.jujutsu
    den.aspects.diff._.meld
    den.aspects.editor._.lazyvim
    den.aspects.editor._.zed

  ];

  # Import legacy configuration
  den.aspects.echo.homeManager.imports = [

    # Configure development environment
    ../../legacy/user/ai/opencode.nix

    # Configure desktop environment
    ../../legacy/user/desktop/gnome.nix
    ../../legacy/user/browser/zen.nix

  ];

}
