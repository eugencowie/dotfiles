{ den, ... }: {

  den.aspects.kernel.provides.latest.os = { pkgs, ... }: {

    # Use the latest kernel
    boot.kernelPackages = pkgs.linuxPackages_latest;

  };

}
