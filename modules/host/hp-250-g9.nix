{ den, ... }: {

  den.aspects.hp-250-g9 = {

    # Import legacy configuration
    os.imports = [ ../../hosts/hp-250-g9/configuration.nix ];

  };

}
