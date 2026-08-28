{ den, ... }: {

  # Include the results of the hardware scan
  den.aspects.nzxt-h1.os.imports = [
    ../../hardware/nzxt-h1/hardware-configuration.nix
  ];

  # Include host aspects
  den.aspects.nzxt-h1.includes = with den.aspects; [

    # Basic system configuration
    boot._.grub
    kernel._.latest
    network._.networkmanager
    time._.london
    locale._.british
    nix._.flakes
    nix._.gc

    # Configure desktop environment
    gpu._.nvidia
    desktop._.gnome
    sound._.pipewire

  ];

  # Define user accounts
  den.hosts.x86_64-linux.nzxt-h1.users = {
    echo = {};
  };

  # Work around a GNOME Shell autologin crash caused when these GPU HDMI/DP
  # audio devices briefly expose PipeWire ports without any profiles. They are
  # unused here, so keep them out of PipeWire while retaining onboard audio.
  den.aspects.nzxt-h1.os.services.pipewire.wireplumber.extraConfig."51-disable-gpu-audio" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          { "device.name" = "alsa_card.pci-0000_01_00.1"; }
          { "device.name" = "alsa_card.pci-0000_0c_00.1"; }
        ];
        actions.update-props."device.disabled" = true;
      }
    ];
  };

}
