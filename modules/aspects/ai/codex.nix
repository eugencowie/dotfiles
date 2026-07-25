{ inputs, ... }: {

  # Nix packages for AI coding agents
  # No nixpkgs follows: it would break numtide's binary cache (cache.numtide.com)
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
