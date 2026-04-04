{ ... }: {

  # Configure GNOME
  dconf = {
    enable = true;
    settings = {
      "org/gnome/mutter" = {
        experimental-features = [
          "scale-monitor-framebuffer" # fractional scaling
        ];
      };
    };
  };

  # Disable KDE Stylix target on GNOME host
  stylix.targets.kde.enable = false;

}
