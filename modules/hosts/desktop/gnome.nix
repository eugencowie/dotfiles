{ den, ... }: {

  den.aspects.desktop.provides.gnome.os = {

    # Enable the GNOME Desktop Environment
    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

  };

}
