{ den, lib, pkgs, ... }: {

  den.aspects.vcs.provides.jujutsu.homeManager = { config, ... }: {

    # Enable Jujutsu
    programs.jujutsu = {
      enable = true;
      settings = {
        user = config.programs.git.settings.user;
        ui = {
          default-command = "status";
          merge-editor = "meld";
        };
        aliases = {
          l = [ "log" ];
        };
        templates = {
          new_description = ''
            if(parents.len() == 2 && parents.get(0).bookmarks() && parents.get(1).bookmarks(),
              "Merge branch '" ++ parents.get(1).bookmarks() ++ "' into " ++ parents.get(0).bookmarks()
            )
          '';
        };
      };
    };

    # Show Jujutsu repository status in Starship prompt
    programs.starship = {
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
