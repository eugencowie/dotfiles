{ lib, ... }: {

  options.my.user = {

    name = lib.mkOption {
      type = lib.types.str;
      description = "Primary user for host-specific defaults.";
    };

    config = lib.mkOption {
      type = lib.types.raw;
      description = "Home Manager module for the primary user.";
    };

  };

}
