{ den, ... }: {

  den.aspects.macbook-air-m1 = {

    includes = [

      # Customise login environment
      den.aspects.stylix

    ];

    # Import legacy configuration
    os.imports = [ ../../hosts/macbook-air-m1/configuration.nix ];

  };

}
