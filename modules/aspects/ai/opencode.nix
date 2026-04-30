{ den, lib, ... }: {

  den.aspects.ai.provides.opencode.homeManager = {

    programs.opencode = {
      enable = true;
      settings = {
        permission.bash = "ask";
      };
    };

  };

  den.aspects.ai.provides.opencode.os = {
    networking.firewall.allowedTCPPorts = lib.mkAfter [ 4096 ];
  };

}
