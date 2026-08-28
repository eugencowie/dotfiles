{ den, inputs, ... }: {

  den.aspects.ai.provides.opencode = {

    includes = with den.aspects; [ ai._.llm-agents ];

    homeManager = { agentSkills, pkgs, ... }: {

      # Enable OpenCode
      programs.opencode = {
        enable = true;
        package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
        skills = agentSkills;
      };

    };

  };

}
