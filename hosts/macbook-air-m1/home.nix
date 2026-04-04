{ config, pkgs, ... }: {

  imports = [

    # Configure terminal environment
    ../../legacy/user/shell/zsh.nix
    ../../legacy/user/shell/direnv.nix
    ../../legacy/user/prompts/starship.nix
    ../../legacy/user/term/ghostty.nix

    # Configure development environment
    ../../legacy/user/vcs/git.nix
    ../../legacy/user/vcs/jujutsu.nix

  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "eugen";
  home.homeDirectory = "/Users/eugen";

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
