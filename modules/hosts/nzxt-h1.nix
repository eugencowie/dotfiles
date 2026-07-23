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

    # Configure desktop environment
    gpu._.nvidia
    desktop._.gnome
    sound._.pipewire

    # Configure remote access
    (remote._.tailscale {
      httpsServices = {
        code-server = "http://127.0.0.1:4444";
        t3code = "http://127.0.0.1:3773";
      };
    })
    remote._.code-server

  ];

  # Define user accounts
  den.hosts.x86_64-linux.nzxt-h1.users = {
    echo = {};
  };

}
