{ den, lib, ... }: {

  den.aspects.env.provides.homebrew = {

    # Zsh is required for profile configuration
    includes = with den.aspects; [ shell._.zsh ];

    # Set PATH, MANPATH, and Homebrew environment variables
    homeManager.programs.zsh.profileExtra = lib.mkOrder 1100 ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';

  };

}
