{ den, ... }: {

  den.aspects.macbook-air-m1 = {

    includes = [

      # Customise login environment
      den.aspects.theme._.stylix

    ];

    # Import legacy configuration
    os.imports = [

      # Include custom option definitions
      ../../options/user.nix

      # Customise login environment
      ../../legacy/system/shell/zsh.nix
      ../../legacy/system/nix/flakes.nix

    ];

    # Define user configuration
    os.my.user.name = "eugen";

  };

}
