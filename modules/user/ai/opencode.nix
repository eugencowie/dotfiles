{ pkgs, inputs, ... }: {

  # Enable OpenCode
  programs.opencode = {
    enable = true;
    package = inputs.nixpkgs-latest.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode;
    settings = {
      permission.bash = "ask";
    };
  };

}
