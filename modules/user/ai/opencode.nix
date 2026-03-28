{ ... }: {

  # Enable OpenCode
  programs.opencode = {
    enable = true;
    settings = {
      permission.bash = "ask";
    };
  };

}
