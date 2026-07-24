{ den, ... }: {

  # Include the results of the hardware scan
  den.aspects.nzxt-h1.os.imports = [
    ../../hardware/nzxt-h1/hardware-configuration.nix
  ];

  # Enable Wake-on-LAN for the wired network interface
  den.aspects.nzxt-h1.os.networking.interfaces.enp9s0.wakeOnLan.enable = true;
  den.aspects.nzxt-h1.os.security.sudo.extraRules = [{
    users = [ "echo" ];
    commands = [{
      command = "/run/current-system/sw/bin/systemctl --no-block suspend";
      options = [ "NOPASSWD" ];
    }];
  }];

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
    remote._.code-server

  ];

  # Define user accounts
  den.hosts.x86_64-linux.nzxt-h1.users = {
    echo = {};
  };

}
