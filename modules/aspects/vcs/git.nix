{ den, ... }: {

  den.aspects.vcs.provides.git = { name, email }: {

    # Meld is configured as the merge tool
    includes = with den.aspects; [ diff._.meld ];

    homeManager = { pkgs, ... }: {

      # Enable Git
      programs.git = {
        enable = true;
        settings = {
          user = {
            inherit name email;
          };
          merge.tool = "meld";
          mergetool.meld.cmd = "meld \"$LOCAL\" \"$BASE\" \"$REMOTE\" --output \"$MERGED\"";
        };
      };

      # Enable git-absorb
      home.packages = with pkgs; [ git-absorb ];

    };

  };

}
