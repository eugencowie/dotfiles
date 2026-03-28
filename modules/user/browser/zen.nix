{ inputs, lib, pkgs, ... }: {

  home.packages = lib.mkAfter [
    inputs.zen-browser.packages.${pkgs.system}.zen-browser
  ];

}
