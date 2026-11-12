{ den, ... }: {

  # Enable support for running NixOS as a WSL distribution
  den.hosts.x86_64-linux.inspiron-16.wsl.enable = true;
  den.aspects.inspiron-16.wsl.enable = true;

  den.aspects.inspiron-16.os = { lib, ... }: {

    # WSL has no real VT. Its tty1 gets hung up when other distros (e.g.
    # docker-desktop) start, so the getty crash-loops into start-limit-hit
    # and fails switch-to-configuration. Stop getty.target pulling it in.
    systemd.targets.getty.wants = lib.mkForce [ ];

    # Work around microsoft/WSL#40593: when distros start at the same time,
    # the user manager can fail with EBUSY. Retry instead of staying dead.
    systemd.services."user@".serviceConfig = {
      Restart = "on-failure";
      RestartSec = "2s";
    };

    # Enable Docker Desktop WSL integration
    wsl.docker-desktop.enable = true;
    wsl.interop.register = true;

  };

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
