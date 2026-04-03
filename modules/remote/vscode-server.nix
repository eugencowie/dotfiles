{ ... }: {

  den.aspects.vscode-server = {

    # Required for VS Code Server
    os.programs.nix-ld.enable = true;

  };

}
