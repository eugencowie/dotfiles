{

  den.aspects.vcs.provides.gitlab = {

    homeManager = { lib, pkgs, ... }: {

      # Install the GitLab CLI
      home.packages = lib.mkAfter [ pkgs.glab ];

    };

  };

}
