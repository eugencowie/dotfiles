{ lib, pkgs, ... }: {

  # Enable Ghostty
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      font-family = "IosevkaTerm NF";
      font-size = 14;
    };
  };

  # Enable font support for Ghostty fonts
  fonts.fontconfig.enable = true;

  # Install Iosevka Term font
  home.packages = lib.mkAfter [
    pkgs.nerd-fonts.iosevka-term
  ];

}
