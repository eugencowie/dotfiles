{ den, ... }: {

  den.aspects.macbook-air-m1 = {

    includes = [

      # Customise login environment
      den.aspects.stylix

    ];

    # Import legacy configuration
    os.imports = [

      # Include the results of the hardware scan
      ../../hosts/macbook-air-m1/hardware-configuration.nix

      # Include custom option definitions
      ../../options/user.nix

      # Customise login environment
      ../../legacy/system/shell/zsh.nix
      ../../legacy/system/home/homeManager.nix
      ../../legacy/system/nix/flakes.nix

    ];

    # Define user configuration
    os.my.user.name = "eugen";
    os.my.user.config = import ../../hosts/macbook-air-m1/home.nix;

  };

}
