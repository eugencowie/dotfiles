{ den, lib, ... }: {

  den.aspects.ai.provides.codex.homeManager = { pkgs, ... }: {

    # Enable Codex
    programs.codex.enable = true;

    # Enable ripgrep
    programs.ripgrep.enable = true;

  };

}
