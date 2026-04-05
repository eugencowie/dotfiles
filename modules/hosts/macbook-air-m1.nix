{ den, ... }: {

  # Define user accounts
  den.hosts.aarch64-darwin.macbook-air-m1.users.eugen = {};

  # Define legacy options
  den.aspects.macbook-air-m1.os.my.user.name = "eugen";

  # Include host aspects
  den.aspects.macbook-air-m1.includes = [

    # Customise login environment
    den.aspects.theme._.stylix

  ];

  # Import legacy configuration
  den.aspects.macbook-air-m1.os.imports = [

    # Include custom option definitions
    ../../options/user.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/nix/flakes.nix

  ];

}
