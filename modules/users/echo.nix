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
    den.aspects.ai._.opencode

    # Configure desktop environment
    den.aspects.desktop._.gnome
    den.aspects.browser._.zen

  ];

}
