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

}
