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

  ];

  # Import legacy configuration
  den.aspects.echo.homeManager.imports = [

    # Configure terminal environment
    ../../legacy/user/term/ghostty.nix

    # Configure development environment
    ../../legacy/user/vcs/git.nix
    ../../legacy/user/vcs/jujutsu.nix
    ../../legacy/user/diff/meld.nix
    ../../legacy/user/editor/lazyvim.nix
    ../../legacy/user/editor/zed.nix
    ../../legacy/user/ai/opencode.nix

    # Configure desktop environment
    ../../legacy/user/desktop/gnome.nix
    ../../legacy/user/browser/zen.nix

  ];

}
