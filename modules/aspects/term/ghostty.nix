{ den, ... }: {

  den.aspects.term.provides.ghostty.homeManager = { pkgs, ... }: {

    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    };

    fonts.fontconfig.enable = true;

  };

}
