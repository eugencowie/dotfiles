{ den, ... }: {

  den.aspects.hp-250-g9 = {

    includes = [

      # Configure remote access
      den.aspects.vscode-server

    ];

    # Import legacy configuration
    os.imports = [ ../../hosts/hp-250-g9/configuration.nix ];

  };

}
