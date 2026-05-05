{ den, lib, ... }: {

  den.aspects.ai.provides.opencode-web = {

    includes = with den.aspects; [ ai._.opencode ];

    homeManager.programs.opencode.web = {
      enable = true;
      extraArgs = [ "--hostname" "0.0.0.0" ];
    };

    # Allow OpenCode Web to be accessed from the local network
    os.networking.firewall.allowedTCPPorts = lib.mkAfter [ 4096 ];

  };

}
