{ den, ... }: {

  den.aspects.ai.provides.opencode = {

    includes = with den.aspects; [ ai._.agent-skills ai._.agent-tools ];

    homeManager = { agentSkills, ... }: {

      # Enable OpenCode
      programs.opencode = {
        enable = true;
        skills = agentSkills;
        settings = {
          permission.bash = "ask";
          plugin = ["@simonwjackson/opencode-direnv"];
        };
      };

    };

  };

}
