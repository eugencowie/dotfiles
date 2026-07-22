{ den, ... }: {

  den.aspects.ai.provides.ccusage.homeManager = { pkgs, ... }: {

    # Enable ccusage
    home.packages = with pkgs; [
      ccusage
    ];

  };

}
