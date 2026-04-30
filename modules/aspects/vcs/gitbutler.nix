{ den, ... }: {

  den.aspects.vcs.provides.gitbutler.homeManager = { lib, pkgs, ... }: {

    nixpkgs.config.allowUnfree = true;
    home.packages = lib.mkAfter [ pkgs.gitbutler ];

  };

}
