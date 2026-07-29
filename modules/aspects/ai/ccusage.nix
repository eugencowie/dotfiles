{

  # Enable ccusage
  den.aspects.ai.provides.ccusage.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [ ccusage ];
  };

}
