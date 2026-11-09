{
  perSystem = { pkgs, ... }: {

    # jactionlint 2.4.0's runner-label test fixtures still list macos-14, which
    # its own rules treat as retired since 2026-11-02, so its test suite fails
    # on any build after that date. Fixed upstream in 2.5.0; drop this override
    # once nixpkgs ships it.
    packages.jactionlint = pkgs.jactionlint.overrideAttrs { doCheck = false; };

  };
}
