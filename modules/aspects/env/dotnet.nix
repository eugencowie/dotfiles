{ den, lib, ... }: {

  den.aspects.env.provides.dotnet = { host, ... }: {

    # Zsh is required for profile configuration
    includes = with den.aspects; [ shell._.zsh ];

    # Add .NET Core SDK tools to the login environment
    homeManager.programs.zsh.profileExtra = lib.mkOrder 1000 ''
      export PATH="$PATH:$HOME/.dotnet/tools"
    '';

    # ICU is required by the dynamically linked .NET runtime on NixOS
    os = { pkgs, ... }: lib.optionalAttrs (host.class == "nixos") {
      programs.nix-ld = {
        enable = true;
        libraries = [ pkgs.icu ];
      };
    };

  };

}
