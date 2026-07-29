{ den, ... }: {

  # Include user aspects
  den.aspects.eugen.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure remote access
    remote._.wakeonlan

    # Configure terminal environment
    shell._.zsh
    prompts._.starship
    term._.ghostty

    # Configure development environment
    env._.mise
    env._.homebrew
    env._.dotnet
    env._.hermes
    (vcs._.git {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
    })
    vcs._.github
    vcs._.jujutsu
    ai._.codex
    ai._.claude
    ai._.ccusage

  ];

}
