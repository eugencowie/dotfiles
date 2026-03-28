{ config, pkgs, ... }: {

  imports = [
    ../../modules/user/shell/zsh.nix
  ];

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

  # Enable Git
  programs.git = {
    enable = true;
    settings.user = {
      name = "Eugén Cowie";
      email = "eugencowie@users.noreply.github.com";
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

  # Install user packages
  home.packages = with pkgs; [
    jj-starship
    gnumake
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

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
