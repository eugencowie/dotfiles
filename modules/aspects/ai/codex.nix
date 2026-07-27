{ inputs, ... }: {

  # Nix packages for AI coding agents
  # No nixpkgs follows: it would break numtide's binary cache (cache.numtide.com)
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.codex = {

    # Prebuilt llm-agents packages, avoiding a local build from source
    os.nix.settings.extra-substituters = [ "https://cache.numtide.com" ];
    os.nix.settings.extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];

    homeManager = { pkgs, ... }: {

      # Enable Codex
      programs.codex = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
        settings = {
          model = "gpt-5.6-sol";
          model_reasoning_effort = "high";
          sandbox_mode = "workspace-write";
        };
        context = ''
          # Global Instructions
          - Always ask before using subagents, unless the user explicitly requests them.
        '';
      };

      # Enable ripgrep
      programs.ripgrep.enable = true;

    };

  };

}
