{ config, pkgs, inputs, ... }: {

  imports = [

    # Configure terminal environment
    ../../modules/user/shell/zsh.nix
    ../../modules/user/shell/direnv.nix
    ../../modules/user/prompts/starship.nix
    ../../modules/user/multiplex/zellij.nix
    ../../modules/user/term/ghostty.nix

    # Configure development environment
    ../../modules/user/make/make.nix # TODO: remove in favour of dev shell
    ../../modules/user/vcs/git.nix
    ../../modules/user/vcs/jujutsu.nix
    ../../modules/user/diff/meld.nix
    ../../modules/user/editor/lazyvim.nix
    ../../modules/user/editor/zed.nix
    ../../modules/user/ai/opencode.nix

    # Configure desktop environment
    ../../modules/user/desktop/gnome.nix
    ../../modules/user/browser/zen.nix

  ];

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
