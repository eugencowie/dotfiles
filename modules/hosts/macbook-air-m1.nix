{ den, ... }: {

  # Include host aspects
  den.aspects.macbook-air-m1.includes = with den.aspects; [

    # Basic system configuration
    nix._.flakes

    # Customise login environment
    theme._.stylix

  ];

  # Define user accounts
  den.hosts.aarch64-darwin.macbook-air-m1.users = {
    eugen = {};
  };

}
