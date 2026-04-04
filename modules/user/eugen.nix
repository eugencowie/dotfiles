{ den, ... }: {

  den.aspects.eugen = {

    # Mark as primary user
    includes = [ den.provides.primary-user ];

    # Import legacy configuration
    homeManager = import ../../hosts/macbook-air-m1/home.nix;

  };

}
