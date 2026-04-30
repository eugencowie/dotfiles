{ den, ... }: {

  den.aspects.desktop.provides.gnome.os = {

    # Enable the GNOME Desktop Environment
    services = {
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

  };

  den.aspects.desktop.provides.gnome.homeManager = {

    # Disable KDE Stylix target on GNOME host
    stylix.targets.kde.enable = false;

  };

}
