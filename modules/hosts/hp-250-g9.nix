{ den, ... }: {

  # Enable support for running NixOS as a WSL distribution
  den.hosts.x86_64-linux.hp-250-g9.wsl.enable = true;
  den.aspects.hp-250-g9.wsl.enable = true;

  # Include host aspects
  den.aspects.hp-250-g9.includes = with den.aspects; [

    # Basic system configuration
    time._.london
    locale._.british
    nix._.flakes

  ];

  # Define user accounts
  den.hosts.x86_64-linux.hp-250-g9.users = {
    nixos = {};
  };

}
