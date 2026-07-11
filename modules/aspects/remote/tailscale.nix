{ den, ... }: {

  den.aspects.remote.provides.tailscale.os = {

    # Enable the Tailscale mesh VPN
    services.tailscale.enable = true;

  };

}
