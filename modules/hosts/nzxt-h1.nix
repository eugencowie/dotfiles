{ den, ... }: {

  # Include the results of the hardware scan
  den.aspects.nzxt-h1.os.imports = [ ../../hardware/nzxt-h1/hardware-configuration.nix ];

  # Define user accounts
  den.hosts.x86_64-linux.nzxt-h1.users.echo = {};

  # Include host aspects
  den.aspects.nzxt-h1.includes = [

    # Basic system configuration
    den.aspects.boot._.grub
    den.aspects.kernel._.latest
    den.aspects.network._.networkmanager
    den.aspects.time._.london
    den.aspects.locale._.british
    den.aspects.nix._.flakes

    # Configure desktop environment
    den.aspects.gpu._.nvidia
    den.aspects.desktop._.gnome
    den.aspects.sound._.pipewire

    # Configure remote access
    den.aspects.remote._.vscodeserver

  ];

}
