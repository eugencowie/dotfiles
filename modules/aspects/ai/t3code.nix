{ den, lib, ... }: {

  den.aspects.ai.provides.t3code = {

    # Enable T3 Code
    homeManager.programs.t3code.enable = true;

    # Allow T3 Code to be accessed from the local network
    os.networking.firewall.allowedTCPPorts = lib.mkAfter [ 3773 ];

  };

}
