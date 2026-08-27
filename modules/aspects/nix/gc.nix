{

  den.aspects.nix.provides.gc.os = { host, ... }: {

    # Clean system and root profile generations
    nix.gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    } // (
      if host.class == "darwin" then {
        interval = [{
          Weekday = 7;
          Hour = 3;
          Minute = 15;
        }];
      } else {
        dates = "weekly";
      }
    );

    # Clean each user's profile generations
    home-manager.sharedModules = [{
      nix.gc = {
        automatic = true;
        options = "--delete-older-than 30d";
        dates = "weekly";
      };
    }];

  };

}
