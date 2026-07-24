{ den, ... }: {

  # Include user aspects
  den.aspects.echo.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure remote access
    remote._.sunshine
    multiplex._.zellij

    # Configure terminal environment
    shell._.zsh
    shell._.direnv
    shell._.mise
    prompts._.starship
    term._.ghostty

    # Configure development environment
    (vcs._.git {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
    })
    vcs._.github
    vcs._.jujutsu
    diff._.meld
    editor._.lazyvim
    editor._.zed
    ai._.codex
    ai._.claude
    ai._.ccusage
    ai._.t3code

    # Configure desktop environment
    browser._.helium
    browser._.zen

  ];

}
