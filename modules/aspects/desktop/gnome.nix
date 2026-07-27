{

  den.aspects.desktop.provides.gnome.os = {

    services = {

      # Enable the GNOME Desktop Environment
      xserver.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;

      # Seed default preferences. These override the schema defaults rather
      # than the user's settings, so they still apply on a fresh install but
      # remain changeable at runtime. Overrides are checked against the
      # schemas at build time, so a renamed key fails the build.
      desktopManager.gnome.extraGSettingsOverrides = ''
        [org.gnome.desktop.peripherals.mouse]
        accel-profile='flat'
      '';
    };

  };

}
