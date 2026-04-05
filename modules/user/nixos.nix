{ den, ... }: {

  den.aspects.nixos = {

    # Mark as primary user
    includes = [ den.provides.primary-user ];
    
  };

}
