{ den, ... }: {

  # Define user accounts
  den.hosts.aarch64-darwin.macbook-air-m1.users.eugen = {};

  # Include host aspects
  den.aspects.macbook-air-m1.includes = [

    # Basic system configuration
    den.aspects.nix._.flakes

    # Customise login environment
    den.aspects.theme._.stylix

  ];

}
