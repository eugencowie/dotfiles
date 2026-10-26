{ den, inputs, ... }: {

  den.aspects.ai.provides.claude = {

    includes = with den.aspects; [ ai._.llm-agents ];

    # Allow unfree packages
    os.nixpkgs.config.allowUnfree = true;

    homeManager = { agentSkills, pkgs, ... }: {

      # Enable Claude Code
      programs.claude-code = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
        skills = agentSkills;
        enableMcpIntegration = true;
        settings = {
          theme = "dark";
          model = "opus";
          effortLevel = "high";
          outputStyle = "Concise";
          attribution = {
            commit = "";
            pr = "";
            sessionUrl = false;
          };
          # Run tool commands in bash rather than the login shell
          env.CLAUDE_CODE_SHELL = "${pkgs.bashInteractive}/bin/bash";
          # Disable auto-memory: https://www.youtube.com/shorts/A0scuiiGBC4
          autoMemoryEnabled = false;
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

    };

  };

}
