{ den, ... }: {

  # Include host aspects
  den.aspects.macbook-air-m1.includes = with den.aspects; [

    # Basic system configuration
    nix._.flakes

  ];

  # Define user accounts
  den.hosts.aarch64-darwin.macbook-air-m1.users = {
    eugen = {};
  };

}
