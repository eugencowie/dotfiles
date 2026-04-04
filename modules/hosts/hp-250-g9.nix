{ den, ... }: {

  # Enable support for running NixOS as a WSL distribution
  den.hosts.x86_64-linux.hp-250-g9.wsl.enable = true;
  den.aspects.hp-250-g9.wsl.enable = true;

  # Define user accounts
  den.hosts.x86_64-linux.hp-250-g9.users.nixos = {};

  # Include host aspects
  den.aspects.hp-250-g9.includes = [

    # Customise login environment
    den.aspects.theme._.stylix

    # Configure remote access
    den.aspects.remote._.vscodeserver

  ];

  # Import legacy configuration
  den.aspects.hp-250-g9.os.imports = [

    # Basic system configuration
    ../../legacy/system/time/europe/london.nix
    ../../legacy/system/locale/english/british.nix

    # Customise login environment
    ../../legacy/system/nix/flakes.nix

  ];

}
