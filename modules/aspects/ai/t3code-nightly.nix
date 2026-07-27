{ den, ... }: {

  den.aspects.ai.provides.t3code-nightly = {

    includes = with den.aspects; [ ai._.t3code ];

    # Build T3 Code from a nightly release instead of the version in nixpkgs
    os.nixpkgs.overlays = [(_final: prev: {

      t3code = let

        # The nightly uses pnpm 11, while the pinned stable recipe still uses pnpm 10.
        unwrapped = (prev.t3code.unwrapped.override {
          pnpm_10 = prev.pnpm_11;
        }).overrideAttrs (finalAttrs: previousAttrs: {

          version = "0.0.29-nightly.20260725.899";

          # Avoid pnpm 11 checking and installing dependencies for filtered-out workspaces.
          env = (previousAttrs.env or { }) // {
            pnpm_config_verify_deps_before_run = "false";
          };

          src = prev.fetchFromGitHub {
            owner = "pingdotgg";
            repo = "t3code";
            tag = "v${finalAttrs.version}";
            hash = "sha256-hlXyQiLeJfhMv8XQ/+B0lADZbDSzku6Bj95tIeoscjQ=";
          };

          pnpmDeps = prev.fetchPnpmDeps {
            pnpm = prev.pnpm_11;
            inherit (finalAttrs) pname version src pnpmWorkspaces;
            fetcherVersion = 4;
            hash = "sha256-QNVBRvXVUOKZEdIqKY2dfjvmivMTaJJSh2cexvtdJ6k=";
          };

        });

      in prev.t3code.override {
        t3code-unwrapped = unwrapped;
      };

    })];

  };

}
