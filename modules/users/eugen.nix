{ den, ... }: {

  # Include user aspects
  den.aspects.eugen.includes = [

    # Mark as primary user
    den.provides.primary-user

    # Customise login environment
    (den.provides.user-shell "zsh")

    # Configure terminal environment
    den.aspects.shell._.zsh
    den.aspects.shell._.direnv
    den.aspects.prompts._.starship
    den.aspects.term._.ghostty

    # Configure development environment
    den.aspects.vcs._.git

  ];

  # Import legacy configuration
  den.aspects.eugen.homeManager.imports = [

    # Configure development environment
    ../../legacy/user/vcs/jujutsu.nix

  ];

}
