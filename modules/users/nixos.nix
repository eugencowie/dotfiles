{ den, ... }: {

  # Include user aspects
  den.aspects.nixos.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure remote access
    remote._.vscode

    # Configure terminal environment
    shell._.zsh
    prompts._.starship
    term._.ghostty

    # Configure development environment
    env._.mise
    (vcs._.git {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
    })
    vcs._.jujutsu
    diff._.meld
    editor._.lazyvim

  ];

}
