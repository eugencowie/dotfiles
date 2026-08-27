{ den, inputs, ... }: {

  # Nix packages for AI coding agents
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.codex = {

    includes = with den.aspects; [ ai._.agent-skills ai._.agent-tools ];

    # Use binary cache (input must not follow system nixpkgs for this to work)
    os.nix.settings.extra-substituters = [ "https://cache.numtide.com" ];
    os.nix.settings.extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];

    homeManager = { agentSkills, pkgs, ... }: {

      # Enable Codex
      programs.codex = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
        skills = agentSkills;
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
      };

    };

  };

}
