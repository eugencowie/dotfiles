{ ... }: {

  den.aspects.remote.provides.vscodeserver.os = {

    # Required for VS Code extensions that expect an FHS-style loader
    programs.nix-ld.enable = true;

  };

}
