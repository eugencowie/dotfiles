{ den, ... }: {

  # Include user aspects
  den.aspects.eugen.includes = [

    # Mark as primary user
    den.provides.primary-user

    # Customise login environment
    (den.provides.user-shell "zsh")

    # Configure terminal environment
    den.aspects.shell._.zsh

  ];

  # Import legacy configuration
  den.aspects.eugen.homeManager.imports = [

    # Configure terminal environment
    ../../legacy/user/shell/direnv.nix
    ../../legacy/user/prompts/starship.nix
    ../../legacy/user/term/ghostty.nix

    # Configure development environment
    ../../legacy/user/vcs/git.nix
    ../../legacy/user/vcs/jujutsu.nix

  ];

}
