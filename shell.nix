{ pkgs ? import <nixpkgs> {} }: pkgs.mkShellNoCC {

  packages = with pkgs; [
    gnumake
    nixd
  ];

}
