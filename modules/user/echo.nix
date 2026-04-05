{ den, ... }: {

  den.aspects.echo = {

    # Mark as primary user
    includes = [ den.provides.primary-user ];
    
  };

}
