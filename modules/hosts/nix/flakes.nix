{ den, ... }: {

  den.aspects.nix.provides.flakes.os = {

    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

  };

}
