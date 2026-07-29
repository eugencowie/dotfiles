{ inputs, ... }: {

  # Nix packages for AI coding agents
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.codex = {

    # Use binary cache (input must not follow system nixpkgs for this to work)
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
          personality = "pragmatic";
          sandbox_mode = "workspace-write";
          sandbox_workspace_write = {
            network_access = true;
          };
          desktop = {
            preventSleepWhileRunning = true;
            show-context-window-usage = true;
            followUpQueueMode = "steer";
            reviewDelivery = "detached";
            open-in-target-preferences = {
              global = "zed";
            };
          };
        };
        context = ''
          # Global Instructions
          - Always ask before using subagents, unless the user explicitly requests them.
        '';
      };

      # https://medium.com/@kibotu/your-ai-coding-agent-uses-your-terminals-tools-give-it-better-ones-bdcfb6737ac9
      programs.ripgrep.enable = true;
      programs.fd.enable = true;
      programs.jq.enable = true;
      home.packages = with pkgs; [ tree ];
      programs.bat.enable = true;
      programs.fzf.enable = true;

    };

  };

}
