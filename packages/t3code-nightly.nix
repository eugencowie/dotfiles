# T3 Code built from a nightly release instead of the version in nixpkgs.
#
# There is no top-level `t3code-unwrapped` attribute, so the nightly is built by
# overriding the unwrapped package reached through the wrapper's passthru, then
# re-wrapping it. Upstream derives `src` and `pnpmDeps` from `finalAttrs`, so
# only the version and fixed-output hashes need replacing.
#
{
  t3code,
}: let

  # Update these three together when bumping to a newer nightly
  version = "0.1.6-nightly.20261029.3892";
  srcHash = "sha256-FFPC549L0Q1N0YSHK4BdSVQL1/mu0nGTqBhGtplSgxI=";
  pnpmDepsHash = "sha256-uj7IxNMdubCtIqkv1M/vg5dRTeUaysC+1l/7ag+D7/4=";

  unwrapped = t3code.unwrapped.overrideAttrs (previousAttrs: {

    inherit version;

    src = previousAttrs.src.override { hash = srcHash; };

    # The web app is a development dependency of the server, so the inherited
    # transitive workspace filters do not include its patched dependencies.
    pnpmWorkspaces = previousAttrs.pnpmWorkspaces ++ [ "@t3tools/web..." ];

    pnpmDeps = previousAttrs.pnpmDeps.override { hash = pnpmDepsHash; };

  });

in t3code.override {
  t3code-unwrapped = unwrapped;
}
