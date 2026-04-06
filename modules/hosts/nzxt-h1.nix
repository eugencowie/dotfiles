{ den, ... }: {

  # Define user accounts
  den.hosts.x86_64-linux.nzxt-h1.users.echo = {};

  # Define legacy options
  den.aspects.nzxt-h1.os.my.user.name = "echo";

  # Include host aspects
  den.aspects.nzxt-h1.includes = [

    # Customise login environment
    den.aspects.theme._.stylix

    # Configure remote access
    den.aspects.remote._.vscodeserver

  ];

  # Import legacy configuration
  den.aspects.nzxt-h1.os.imports = [

    # Include the results of the hardware scan
    ../../hardware/nzxt-h1/hardware-configuration.nix

    # Include custom option definitions
    ../../options/user.nix

    # Basic system configuration
    ../../legacy/system/boot/grub.nix
    ../../legacy/system/kernel/latest.nix
    ../../legacy/system/network/networkManager.nix
    ../../legacy/system/time/europe/london.nix
    ../../legacy/system/locale/english/british.nix

    # Customise login environment
    ../../legacy/system/shell/zsh.nix
    ../../legacy/system/nix/flakes.nix

    # Configure desktop environment
    ../../legacy/system/gpu/nvidia.nix
    ../../legacy/system/desktop/gnome.nix
    ../../legacy/system/sound/pipewire.nix
    ../../legacy/system/streaming/sunshine.nix

  ];

}
