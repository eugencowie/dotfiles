{ den, lib, ... }: {

  den.aspects.shell.provides.mise = { host, ... }: {

    homeManager = { pkgs, ... }: let
      opensslLib = lib.getLib pkgs.openssl;
      opensslDev = lib.getDev pkgs.openssl;
    in {

      # Enable mise
      programs.mise = {
        enable = true;
        enableZshIntegration = true;
        globalConfig.settings.all_compile = false;
      };

      # Compiler and native-build dependencies for tools managed by mise
      home.packages = with pkgs; lib.mkAfter [
        gcc
        pkg-config
        openssl
        opensslDev
      ];

      # Native build configuration needed on NixOS
      home.sessionVariables = lib.optionalAttrs (host.class == "nixos") {
        PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" [ opensslDev ];
        OPENSSL_INCLUDE_DIR = "${opensslDev}/include";
        OPENSSL_LIB_DIR = "${opensslLib}/lib";
        RUSTFLAGS = "-C link-arg=-Wl,-rpath,${opensslLib}/lib";
      };

    };

    # Run dynamically linked tools installed by mise on NixOS.
    os = { pkgs, ... }: lib.optionalAttrs (host.class == "nixos") {

      programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
          openssl
        ];
      };

    };

  };

}
