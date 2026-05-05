{ den, ... }: {

  # Include user aspects
  den.aspects.eugen.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure terminal environment
    shell._.zsh
    shell._.direnv
    prompts._.starship
    term._.ghostty

    # Configure development environment
    (vcs._.git {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
    })
    vcs._.jujutsu
    ai._.opencode

  ];

}
