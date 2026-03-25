{ config, pkgs, inputs, ... }: {

  imports = [
    # Module for managing LazyVim in Home Manager
    inputs.lazyvim-nix.homeManagerModules.default
  ];

  # Enable Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Enable Starship
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      git_branch.disabled = true;
      git_status.disabled = true;
      custom.jj = {
        when = "jj-starship detect";
        shell = [ "jj-starship" ];
        format = "$output ";
      };
    };
  };

  # Enable Zellij
  programs.zellij.enable = true;

  # Enable Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "Eugén Cowie";
      user.email = "eugencowie@users.noreply.github.com";
    };
  };

  # Enable Jujutsu
  programs.jujutsu = {
    enable = true;
    settings = {
      user = config.programs.git.settings.user;
      templates = {
        new_description = ''
          if(parents.len() == 2 && parents.get(0).bookmarks() && parents.get(1).bookmarks(),
            "Merge branch '" ++ parents.get(1).bookmarks() ++ "' into " ++ parents.get(0).bookmarks()
          )
        '';
      };
    };
  };

  # Enable LazyVim
  programs.lazyvim.enable = true;
  programs.neovim.defaultEditor = true;

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
    nerd-fonts.iosevka-term
    jj-starship
    opencode
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
