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
  version = "0.1.1-nightly.20261020.3411";
  srcHash = "sha256-2VTtUgGHv90noh5YtdqIPip0XgP87cjr9SVJbBAVD90=";
  pnpmDepsHash = "sha256-witoens1UicKE+SIQCrRk9YtbAVIW5x+2MqDrFh4F0s=";

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
