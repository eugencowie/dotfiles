{ inputs, ... }: {

  # Prebuilt Rex release binaries. Only the preview channel exists until Rex
  # tags a stable release.
  flake-file.inputs.rex = {
    url = "https://pkgs.superlogical.com/rex/nix/preview.tar.gz";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.multiplex.provides.rex = { user, ... }: {

    homeManager = {
      imports = [ inputs.rex.homeManagerModules.default ];

      # Install the rex command and its xterm-rex terminfo
      programs.rex.enable = true;

      # Run a personal Rex server as a systemd user service
      services.rex.enable = true;

      # Skip the ssh guard, which rewrites TERM=xterm-rex for outgoing ssh.
      # This machine is only an ssh destination, and it has xterm-rex itself.
      programs.rex.sshGuard = false;
    };

    # Keep the user service, and so every session, alive after logging out
    os.users.users.${user.userName}.linger = true;

  };

}
