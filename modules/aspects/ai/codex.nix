{ den, inputs, ... }: {

  den.aspects.ai.provides.codex = {

    includes = with den.aspects; [ ai._.llm-agents ];

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
