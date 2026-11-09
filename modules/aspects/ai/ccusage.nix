{

  # Enable ccusage
  den.aspects.ai.provides.ccusage.homeManager = { pkgs, ... }: {
    home.packages = [
      # TODO: drop once nixpkgs adds zstd to ccusage's buildInputs; zstd-sys
      # fails to find libzstd via pkg-config without it.
      (pkgs.ccusage.overrideAttrs (old: {
        buildInputs = (old.buildInputs or [ ]) ++ [ pkgs.zstd ];
      }))
    ];
  };

}
