{ den, inputs, ... }: {

  den.aspects.ai.provides.codex = {

    includes = with den.aspects; [ ai._.llm-agents ];

    homeManager = { agentSkills, lib, pkgs, ... }: {

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

      # Make config file writable so Codex can write trusted paths
      home.file.".codex/config.toml".force = true;
      home.activation.makeCodexConfigWritable = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
        target="$HOME/.codex/config.toml"
        if [[ -L "$target" ]]; then
          source="$(readlink -f "$target")"
          run rm -f "$target"
          run install -Dm600 "$source" "$target"
        fi
      '';

    };

  };

}
