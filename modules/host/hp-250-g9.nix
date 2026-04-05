{ den, ... }: {

  den.aspects.hp-250-g9 = {

    includes = [

      # Customise login environment
      den.aspects.stylix

      # Configure remote access
      den.aspects.vscode-server

    ];

    # Import legacy configuration
    os.imports = [ ../../hosts/hp-250-g9/configuration.nix ];

    # Enable support for running NixOS as a WSL distribution
    wsl.enable = true;

  };

}
