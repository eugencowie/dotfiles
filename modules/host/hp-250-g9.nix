{ den, ... }: {

  den.aspects.hp-250-g9 = {

    includes = [

      # Customise login environment
      den.aspects.stylix

      # Configure remote access
      den.aspects.vscode-server

    ];

    # Import legacy configuration
    os.imports = [

      # Include the results of the hardware scan
      ../../hosts/hp-250-g9/hardware-configuration.nix
      
      # Include custom option definitions
      ../../options/user.nix

      # Basic system configuration
      ../../legacy/system/time/europe/london.nix
      ../../legacy/system/locale/english/british.nix

      # Customise login environment
      ../../legacy/system/shell/zsh.nix
      ../../legacy/system/home/homeManager.nix
      ../../legacy/system/nix/flakes.nix

    ];

    # Define user configuration
    os.my.user.name = "nixos";
    os.my.user.config = import ../../hosts/hp-250-g9/home.nix;

    # Enable support for running NixOS as a WSL distribution
    wsl.enable = true;

  };

}
