{ den, ... }: {

  # Include user aspects
  den.aspects.nixos.includes = with den.provides; with den.aspects; [

    # Mark as primary user
    primary-user

    # Customise login environment
    (user-shell "zsh")

    # Configure remote access
    remote._.t3code-wsl

    # Configure terminal environment
    shell._.zsh
    prompts._.starship

    # Configure development environment
    env._.mise
    env._.dotnet
    (vcs._.git {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
    })
    vcs._.github
    vcs._.gitlab
    ai._.claude

  ];

  # Use separate Git identity for work repos
  den.aspects.nixos.homeManager.programs.git.includes = [
    { condition = "gitdir:~/Repos/"; path = "~/.config/git/work"; }
  ];

}
