{

  den.aspects.boot.provides.grub.os = {

    # Mount the EFI system partition
    boot.loader.efi = {
      efiSysMountPoint = "/boot/efi";
      canTouchEfiVariables = true;
    };

    # Use the GRUB EFI boot loader
    boot.loader.grub = {
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };

  };

}
