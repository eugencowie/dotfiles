{ den, ... }: {

  # Define user accounts
  den.hosts.x86_64-linux.nzxt-h1.users.echo = {};

  # Include host aspects
  den.aspects.nzxt-h1.includes = [

    # Basic system configuration
    den.aspects.boot._.grub
    den.aspects.kernel._.latest
    den.aspects.network._.networkmanager
    den.aspects.time._.london

    # Customise login environment
    den.aspects.theme._.stylix

    # Configure remote access
    den.aspects.remote._.vscodeserver

  ];

  # Import legacy configuration
  den.aspects.nzxt-h1.os.imports = [

    # Include the results of the hardware scan
    ../../hardware/nzxt-h1/hardware-configuration.nix

    # Basic system configuration
    ../../legacy/system/locale/english/british.nix

    # Customise login environment
    ../../legacy/system/nix/flakes.nix

    # Configure desktop environment
    ../../legacy/system/gpu/nvidia.nix
    ../../legacy/system/desktop/gnome.nix
    ../../legacy/system/sound/pipewire.nix

  ];

}
