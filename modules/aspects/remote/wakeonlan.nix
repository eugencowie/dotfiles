{ den, ... }: {

  den.aspects.remote.provides.wakeonlan.homeManager = { pkgs, ... }: {

    # Send Wake-on-LAN magic packets
    home.packages = with pkgs; [ wakeonlan ];

  };

}
