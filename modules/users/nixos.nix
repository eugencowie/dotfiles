{ den, ... }: {

  # Include user aspects
  den.aspects.nixos.includes = [

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
    den.aspects.vcs._.jujutsu
    den.aspects.diff._.meld
    den.aspects.editor._.lazyvim

  ];

  # Import legacy configuration
  den.aspects.nixos.homeManager.imports = [

    # Configure development environment
    ../../legacy/user/ai/opencode.nix

  ];

}
