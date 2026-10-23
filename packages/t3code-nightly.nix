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
  version = "0.1.3-nightly.20261023.3579";
  srcHash = "sha256-Pug8I74Iwne5eY/ovYiO6uH3apMlJhsqu1DSMkJAtt4=";
  pnpmDepsHash = "sha256-xRmOrOZbBljaF1IJr0JFUFzdhkld6+ehLIlpVOg/J3E=";

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
