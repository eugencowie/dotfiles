{ den, ... }: {

  den.aspects.editor.provides.zed = {

    # Codex and Claude are required for the ACP agent servers, which inherit
    # their model and effort settings from the CLI configs
    includes = with den.aspects; [ ai._.codex ai._.claude ];

    homeManager = { pkgs, ... }: {

      # Enable Zed editor
      programs.zed-editor = {
        enable = true;
        userSettings = {
          theme = "Ayu Dark";
          icon_theme = "Zed (Default)";
          buffer_font_family = "IosevkaTerm Nerd Font";
          base_keymap = "VSCode";
          telemetry = {
            diagnostics = false;
            metrics = false;
          };
          agent_servers = {
            codex-acp.type = "registry";
            claude-acp.type = "registry";
          };
        };
      };

      # Enable font support for Zed fonts
      fonts.fontconfig.enable = true;
      home.packages = [ pkgs.nerd-fonts.iosevka-term ];

    };

  };

}
