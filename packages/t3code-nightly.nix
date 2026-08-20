# T3 Code built from a nightly release instead of the version in nixpkgs.
#
# There is no top-level `t3code-unwrapped` attribute, so the nightly is built by
# overriding the unwrapped package reached through the wrapper's passthru, then
# re-wrapping it.
#
{ t3code, pnpm_11, fetchFromGitHub, fetchPnpmDeps }: let

  # Update these three together when bumping to a newer nightly
  version = "0.0.34-nightly.20260820.1142";
  srcHash = "sha256-7JpauTRvXzmpjA5zV9Cv9XWaLZNSIyqGbHxqvM1SjA8=";
  pnpmDepsHash = "sha256-klkRO8u32eau5AkqRloonJOmh6Ipsgtc+YW/4xP8xmA=";

  unwrapped = t3code.unwrapped.overrideAttrs (finalAttrs: previousAttrs: {

    inherit version;

    src = fetchFromGitHub {
      owner = "pingdotgg";
      repo = "t3code";
      tag = "v${version}";
      hash = srcHash;
    };

    # The web app is a development dependency of the server, so the inherited
    # transitive workspace filters do not include its patched dependencies.
    pnpmWorkspaces = previousAttrs.pnpmWorkspaces ++ [ "@t3tools/web..." ];

    pnpmDeps = fetchPnpmDeps {
      pnpm = pnpm_11;
      inherit (finalAttrs) pname version src pnpmWorkspaces;
      fetcherVersion = 4;
      hash = pnpmDepsHash;
    };

  });

in t3code.override {
  t3code-unwrapped = unwrapped;
}
