{ config, pkgs, inputs, ... }: {

  imports = [

    # Configure terminal environment
    ../../legacy/user/shell/zsh.nix
    ../../legacy/user/shell/direnv.nix
    ../../legacy/user/prompts/starship.nix
    ../../legacy/user/multiplex/zellij.nix
    ../../legacy/user/term/ghostty.nix

    # Configure development environment
    ../../legacy/user/vcs/git.nix
    ../../legacy/user/vcs/jujutsu.nix
    ../../legacy/user/diff/meld.nix
    ../../legacy/user/editor/lazyvim.nix
    ../../legacy/user/editor/zed.nix
    ../../legacy/user/ai/opencode.nix

    # Configure desktop environment
    ../../legacy/user/desktop/gnome.nix
    ../../legacy/user/browser/zen.nix

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
