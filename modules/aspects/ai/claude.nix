{ den, inputs, ... }: {

  # Nix packages for AI coding agents
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";

  den.aspects.ai.provides.claude = {

    includes = with den.aspects; [ ai._.agent-skills ];

    # Use binary cache (input must not follow system nixpkgs for this to work)
    os.nix.settings.extra-substituters = [ "https://cache.numtide.com" ];
    os.nix.settings.extra-trusted-public-keys = [ "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g=" ];

    # Allow unfree packages
    os.nixpkgs.config.allowUnfree = true;

    homeManager = { agentSkills, pkgs, ... }: {

      # Enable Claude Code
      programs.claude-code = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
        skills = agentSkills;
        context = ''
          # Global Instructions
          - Use the unslop skill, apply it to your own output.
        '';
        settings = {
          theme = "dark";
          model = "fable";
          effortLevel = "high";
          outputStyle = "Concise";
          attribution = {
            commit = "";
            pr = "";
            sessionUrl = false;
          };
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
