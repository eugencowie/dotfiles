{

  den.aspects.diff.provides.meld.homeManager = { lib, pkgs, ... }: {

    home.packages = lib.mkAfter [ pkgs.meld ];

  };

}
