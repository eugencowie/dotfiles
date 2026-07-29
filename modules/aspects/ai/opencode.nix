{

  den.aspects.ai.provides.opencode.homeManager = { pkgs, ... }: {

    # Enable OpenCode
    programs.opencode = {
      enable = true;
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

}
