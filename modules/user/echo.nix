{ den, ... }: {

  den.aspects.echo = {

    # Mark as primary user
    includes = [ den.provides.primary-user ];

    # Import legacy configuration
    homeManager = import ../../hosts/nzxt-h1/home.nix;

  };

}
