{ den, ... }: {

  den.aspects.macbook-air-m1 = {

    # Import legacy configuration
    os.imports = [ ../../hosts/macbook-air-m1/configuration.nix ];

  };

}
