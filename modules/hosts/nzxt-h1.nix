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

  # Work around a GNOME Shell crash that sends GDM autologin back to the
  # greeter. At startup, pipewire-pulse can briefly report a GPU HDMI/DP audio
  # card ("profiles inconsistent") that has ports but no profiles, so libpulse
  # sets pa_card_info.active_profile to NULL. GNOME Shell's bundled libgvc then
  # dereferences it unconditionally in update_card (gvc-mixer-control.c) and
  # segfaults. These devices (NVIDIA 01:00.1, AMD 0c:00.1) are unused here, so
  # keep them out of PipeWire and retain onboard Realtek audio.
  #
  # Remove once PipeWire stops sending cards with no profiles (a regression of
  # pipewire#393, related to MR 541), or once GNOME Shell bundles a libgvc that
  # checks for a null active_profile. Neither had happened as of GNOME Shell
  # 50.4 and PipeWire 1.6.9. If GPU audio is needed sooner, patch gnome-shell's
  # subprojects/gvc to add that check instead. After removing this, reboot
  # several times and check for:
  #   journalctl -b | rg 'profiles inconsistent|segfault.*libgvc'
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
