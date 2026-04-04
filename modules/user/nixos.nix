{ den, ... }: {

  den.aspects.nixos = {

    # Mark as primary user
    includes = [ den.provides.primary-user ];

    # Import legacy configuration
    homeManager = import ../../hosts/hp-250-g9/home.nix;

  };

}
