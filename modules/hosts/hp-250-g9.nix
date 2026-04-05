{ den, ... }: {

  den.aspects.hp-250-g9 = {

    includes = [

      # Customise login environment
      den.aspects.theme._.stylix

      # Configure remote access
      den.aspects.remote._.vscodeserver

    ];

    # Import legacy configuration
    os.imports = [

      # Include custom option definitions
      ../../options/user.nix

      # Basic system configuration
      ../../legacy/system/time/europe/london.nix
      ../../legacy/system/locale/english/british.nix

      # Customise login environment
      ../../legacy/system/shell/zsh.nix
      ../../legacy/system/nix/flakes.nix

    ];

    # Define user configuration
    os.my.user.name = "nixos";

    # Enable support for running NixOS as a WSL distribution
    wsl.enable = true;

  };

}
