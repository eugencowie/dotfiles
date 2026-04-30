{ den, ... }: {

  # Include user aspects
  den.aspects.echo.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure remote access
    remote._.sunshine

    # Configure terminal environment
    shell._.zsh
    shell._.direnv
    prompts._.starship
    multiplex._.zellij
    term._.ghostty

    # Configure development environment
    vcs._.git
    vcs._.gitbutler
    vcs._.jujutsu
    diff._.meld
    editor._.lazyvim
    editor._.zed
    ai._.opencode

    # Configure desktop environment
    browser._.zen

  ];

}
