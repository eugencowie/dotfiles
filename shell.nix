{ pkgs ? import <nixpkgs> {} }: pkgs.mkShellNoCC {

  packages = with pkgs; [
    gnumake
    skills
    nixd
  ];

}
