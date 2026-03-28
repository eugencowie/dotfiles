{ config, ... }: {

  # Enable Jujutsu
  programs.jujutsu = {
    enable = true;
    settings = {
      user = config.programs.git.settings.user;
      templates = {
        new_description = ''
          if(parents.len() == 2 && parents.get(0).bookmarks() && parents.get(1).bookmarks(),
            "Merge branch '" ++ parents.get(1).bookmarks() ++ "' into " ++ parents.get(0).bookmarks()
          )
        '';
      };
    };
  };

}
