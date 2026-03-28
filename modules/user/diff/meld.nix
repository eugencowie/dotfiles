{ lib, pkgs, ... }: {

  home.packages = lib.mkAfter [
    pkgs.meld
  ];

  programs.jujutsu.settings.ui.merge-editor = "meld";

}
