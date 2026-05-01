{ den, ... }: {

  den.aspects.vcs.provides.gitbutler =

    # Git is required
    includes = with den.aspects; [ vcs._.git ];

    homeManager = { lib, pkgs, ... }: {

      # Enable GitButler
      nixpkgs.config.allowUnfree = true;
      home.packages = lib.mkAfter [ pkgs.gitbutler ];

    };

  };

}
