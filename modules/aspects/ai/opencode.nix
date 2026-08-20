{ den, ... }: {

  den.aspects.ai.provides.opencode = {

    includes = with den.aspects; [ ai._.agent-skills ];

    homeManager = { agentSkills, pkgs, ... }: {

      # Enable OpenCode
      programs.opencode = {
        enable = true;
        skills = agentSkills;
        settings = {
          permission.bash = "ask";
          plugin = ["@simonwjackson/opencode-direnv"];
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
