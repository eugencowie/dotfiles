{ den, ... }: {

  den.aspects.desktop.provides.gnome.homeManager = {

    # Disable KDE Stylix target on GNOME host
    stylix.targets.kde.enable = false;

  };

}
