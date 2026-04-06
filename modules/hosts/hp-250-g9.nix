{ den, ... }: {

  # Enable support for running NixOS as a WSL distribution
  den.hosts.x86_64-linux.hp-250-g9.wsl.enable = true;
  den.aspects.hp-250-g9.wsl.enable = true;

  # Define user accounts
  den.hosts.x86_64-linux.hp-250-g9.users.nixos = {};

  # Include host aspects
  den.aspects.hp-250-g9.includes = [

    # Basic system configuration
    den.aspects.time._.london
    den.aspects.locale._.british
    den.aspects.nix._.flakes

    # Customise login environment
    den.aspects.theme._.stylix

    # Configure remote access
    den.aspects.remote._.vscodeserver

  ];

}
