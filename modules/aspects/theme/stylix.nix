{ inputs, ... }: {

  # Theming framework for NixOS, Home Manager, and nix-darwin
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.theme.provides.stylix = { host, ... }: {

    os = { pkgs, ... }: {

      imports = [ inputs.stylix."${host.class}Modules".stylix ];

      # Enable Stylix
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
        polarity = "dark";
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.iosevka-term;
            name = "IosevkaTerm Nerd Font";
          };
        };
      };

    };

    homeManager = {

      # Disable KDE Stylix target (not needed on GNOME/non-KDE hosts)
      stylix.targets.kde.enable = false;

    };

  };

}
