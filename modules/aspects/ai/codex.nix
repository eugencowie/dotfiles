{ den, flake-file, inputs, lib, ... }: {

  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.codex.homeManager = { pkgs, ... }: {

    # Enable Codex
    programs.codex = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
    };

    # Enable ripgrep
    programs.ripgrep.enable = true;

  };

}
