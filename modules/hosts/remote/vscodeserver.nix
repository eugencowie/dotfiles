{ ... }: {

  den.aspects.remote.provides.vscodeserver.os = {

    # Required for VS Code Server
    programs.nix-ld.enable = true;

  };

}
