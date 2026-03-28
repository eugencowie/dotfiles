{ ... }: {

  # Use the GRUB EFI boot loader
  boot.loader.grub = {
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };

  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };

}
