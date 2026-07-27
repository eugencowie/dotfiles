{ ... }: {

  den.aspects.remote.provides.vscode.os = {

    # Required by the VS Code Remote server, which ships prebuilt binaries
    # expecting an FHS-style loader. This enables nix-ld rather than installing
    # VS Code, as the editor itself runs on the connecting machine.
    programs.nix-ld.enable = true;

  };

}
