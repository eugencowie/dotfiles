{ den, lib, ... }: {

  den.aspects.ai.provides.claude = {

    os.nixpkgs.config.allowUnfree = true;

    homeManager = {

      # Enable Claude Code
      programs.claude-code = {
        enable = true;
        settings = {
          theme = "dark";
          model = "opus";
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
