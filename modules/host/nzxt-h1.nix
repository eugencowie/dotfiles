{ den, ... }: {

  den.aspects.nzxt-h1 = {

    includes = [

      # Customise login environment
      den.aspects.stylix

      # Configure remote access
      den.aspects.vscode-server

    ];

    # Import legacy configuration
    os.imports = [ ../../hosts/nzxt-h1/configuration.nix ];

  };

}
