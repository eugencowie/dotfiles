{ den, lib, ... }: {

  den.aspects.ai.provides.opencode.homeManager = {

    # Enable OpenCode
    programs.opencode = {
      enable = true;
      settings = {
        permission.bash = "ask";
      };
    };

  };

  den.aspects.ai.provides.opencode.os = {

    # Allow OpenCode Web to be accessed from the local network
    networking.firewall.allowedTCPPorts = lib.mkAfter [ 4096 ];

  };

}
