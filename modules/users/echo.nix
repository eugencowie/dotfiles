{ den, ... }: {

  # Include user aspects
  den.aspects.echo.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure system utilities
    monitoring._.ncdu
    network._.dnsutils

    # Configure remote access
    remote._.tailscale
    remote._.sunshine

    # Configure terminal environment
    shell._.zsh
    prompts._.starship
    multiplex._.zellij
    term._.ghostty

    # Configure development environment
    env._.mise
    (vcs._.git {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
    })
    vcs._.github
    vcs._.jujutsu
    diff._.meld
    editor._.lazyvim
    editor._.zed
    editor._.code-server
    ai._.opencode
    ai._.codex
    ai._.claude
    ai._.ccusage
    ai._.t3code

    # Configure desktop environment
    browser._.helium

  ];

}
