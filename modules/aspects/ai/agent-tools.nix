{

  # Terminal tools for AI coding agents
  den.aspects.ai.provides.agent-tools.homeManager = { pkgs, ... }: {

    # https://medium.com/@kibotu/your-ai-coding-agent-uses-your-terminals-tools-give-it-better-ones-bdcfb6737ac9
    programs.ripgrep.enable = true;
    programs.fd.enable = true;
    programs.jq.enable = true;
    home.packages = with pkgs; [ tree python3 ];
    programs.bat.enable = true;
    programs.fzf.enable = true;

  };

}
