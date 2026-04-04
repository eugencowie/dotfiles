{ den, ... }: {

  # Define user accounts
  den.hosts.aarch64-darwin.macbook-air-m1.users.eugen = {};

  # Include host aspects
  den.aspects.macbook-air-m1.includes = [

    # Customise login environment
    den.aspects.theme._.stylix

  ];

  # Import legacy configuration
  den.aspects.macbook-air-m1.os.imports = [

    # Customise login environment
    ../../legacy/system/nix/flakes.nix

  ];

}
