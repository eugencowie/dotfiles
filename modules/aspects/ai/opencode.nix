{ den, lib, ... }: {

  den.aspects.ai.provides.opencode.homeManager = {

    # Enable OpenCode
    programs.opencode = {
      enable = true;
      settings = {
        permission.bash = "ask";
        plugin = ["@simonwjackson/opencode-direnv"];
      };
    };

    # Enable ripgrep
    programs.ripgrep.enable = true;

  };

}
