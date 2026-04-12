{ den, ... }: {

  den.aspects.vcs.provides.gitbutler.homeManager = { lib, pkgs, ... }: {

    # Enable GitButler
    nixpkgs.config.allowUnfree = true;
    home.packages = lib.mkAfter [ pkgs.gitbutler ];

  };

}
