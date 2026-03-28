{ lib, ... }: {

  options.my.user = {

    name = lib.mkOption {
      type = lib.types.str;
      description = "Primary user for host-specific defaults.";
    };

  };

}
