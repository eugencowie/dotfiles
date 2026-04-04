{ den, ... }: {

  den.aspects.eugen = {

    # Mark as primary user
    includes = [ den.provides.primary-user ];

    # Import legacy configuration
    homeManager = { config, pkgs, ... }: {

      imports = [

        # Configure terminal environment
        ../../legacy/user/shell/zsh.nix
        ../../legacy/user/shell/direnv.nix
        ../../legacy/user/prompts/starship.nix
        ../../legacy/user/term/ghostty.nix

        # Configure development environment
        ../../legacy/user/vcs/git.nix
        ../../legacy/user/vcs/jujutsu.nix

      ];

    };

  };

}
