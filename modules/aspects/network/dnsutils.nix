{

  den.aspects.network.provides.dnsutils.homeManager = { pkgs, ... }: {

    # Install DNS lookup utilities (e.g. dig)
    home.packages = with pkgs; [ dnsutils ];

  };

}
