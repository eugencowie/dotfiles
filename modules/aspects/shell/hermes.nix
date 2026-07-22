{ den, lib, ... }: {

  den.aspects.shell.provides.hermes = {

    # Zsh is required for profile configuration
    includes = with den.aspects; [ shell._.zsh ];

    # Ensure Hermes Agent commands are available in the login environment
    homeManager.programs.zsh.profileExtra = lib.mkOrder 1200 ''
      export PATH="$HOME/.local/bin:$PATH"
    '';

  };

}
