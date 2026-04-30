{ den, ... }: {

  den.aspects.prompts.provides.starship.homeManager = { lib, pkgs, ... }: {

    # Enable Starship
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        git_branch.disabled = true;
        git_status.disabled = true;
        custom.jj = {
          when = "jj-starship detect";
          shell = [ "jj-starship" ];
          format = "$output ";
        };
      };
    };

    home.packages = lib.mkAfter [ pkgs.jj-starship ];

  };

}
