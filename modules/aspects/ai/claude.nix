{ inputs, ... }: {

  # Nix packages for AI coding agents
  # No nixpkgs follows: it would break numtide's binary cache (cache.numtide.com)
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.claude = {

    os.nixpkgs.config.allowUnfree = true;

    homeManager = { pkgs, ... }: {

      # Enable Claude Code
      programs.claude-code = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
        settings = {
          theme = "dark";
          model = "opus";
          effortLevel = "medium";
          attribution = {
            commit = "";
            pr = "";
            sessionUrl = false;
          };
          # Disable system prompt bloat: https://www.youtube.com/shorts/oLx4yCbeklQ
          permissions.deny = [
            "EnterPlanMode"
            "ExitPlanMode"
            "DesignSync"
            "NotebookEdit"
            "SendMessage"
            "PushNotification"
            "RemoteTrigger"
            "ReportFindings"
            "ScheduleWakeup"
            "AskUserQuestion"
            "CronCreate"
            "CronDelete"
            "CronList"
          ];
          disableBundledSkills = true;
          disableWorkflows = true;
          disableRemoteControl = true;
          disableClaudeAiConnectors = true;
          disableArtifact = true;
        };
      };

      # Enable ripgrep
      programs.ripgrep.enable = true;

    };

  };

}
