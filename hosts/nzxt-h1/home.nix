{ config, pkgs, inputs, ... }: {

  imports = [
    inputs.lazyvim-nix.homeManagerModules.default
    ../../modules/user/shell/zsh.nix
    ../../modules/user/prompts/starship.nix
    ../../modules/user/multiplex/zellij.nix
    ../../modules/user/vcs/git.nix
    ../../modules/user/vcs/jujutsu.nix
    ../../modules/user/diff/meld.nix
  ];

  # Enable LazyVim
  programs.lazyvim.enable = true;
  programs.neovim.defaultEditor = true;

  # Enable OpenCode
  programs.opencode = {
    enable = true;
    settings = {
      permission.bash = "ask";
    };
  };

  # Enable Zed editor
  programs.zed-editor.enable = true;

  # Enable Ghostty
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "IosevkaTerm NF";
    };
  };

  # Enable font support
  fonts.fontconfig.enable = true;

  # Install user packages
  home.packages = with pkgs; [
    inputs.zen-browser.packages.x86_64-linux.zen-browser
    nerd-fonts.iosevka-term
    gnumake
  ];

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

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "echo";
  home.homeDirectory = "/home/echo";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

}
