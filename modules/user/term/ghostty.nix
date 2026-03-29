{ pkgs, ... }: {

  # Enable Ghostty
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
  };

  # Enable font support for Ghostty fonts
  fonts.fontconfig.enable = true;

}
