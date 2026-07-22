{ den, ... }: {

  den.aspects.vcs.provides.github = {

    # Enable the GitHub CLI
    homeManager.programs.gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };

  };

}
