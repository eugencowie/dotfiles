{

  # Enable ncdu
  den.aspects.monitoring.provides.ncdu.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [ ncdu ];
  };

}
