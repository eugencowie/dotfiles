{ ... }: {

  den.aspects.remote.provides.t3code-wsl.os = {

    # Required by T3 Code's built-in WSL backend, which runs prebuilt binaries
    # inside the distro expecting an FHS-style loader. This enables nix-ld
    # rather than installing T3 Code, as the app itself runs on the Windows host.
    programs.nix-ld.enable = true;

  };

}
