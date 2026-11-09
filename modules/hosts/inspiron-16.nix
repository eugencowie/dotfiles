{ den, ... }: {

  # Enable support for running NixOS as a WSL distribution
  den.hosts.x86_64-linux.inspiron-16.wsl.enable = true;
  den.aspects.inspiron-16.wsl.enable = true;

  # Include host aspects
  den.aspects.inspiron-16.includes = with den.aspects; [

    # Basic system configuration
    time._.london
    locale._.british
    nix._.flakes
    nix._.gc

  ];

  # Define user accounts
  den.hosts.x86_64-linux.inspiron-16.users = {
    nixos = {};
  };

}
