{ den, lib, ... }: {

  den.aspects.shell.provides.dotnet = {

    # Zsh is required for profile configuration
    includes = with den.aspects; [ shell._.zsh ];

    # Add .NET Core SDK tools to the login environment
    homeManager.programs.zsh.profileExtra = lib.mkOrder 1000 ''
      export PATH="$PATH:$HOME/.dotnet/tools"
    '';

  };

}
