# T3 Code built from a nightly release instead of the version in nixpkgs.
#
# There is no top-level `t3code-unwrapped` attribute, so the nightly is built by
# overriding the unwrapped package reached through the wrapper's passthru, then
# re-wrapping it.
#
{
  t3code,
  pnpm_11,
  fetchFromGitHub,
  fetchPnpmDeps,
  lib,
  libsecret,
  pkg-config,
  stdenv,
}: let

  # Update these three together when bumping to a newer nightly
  version = "0.0.39-nightly.20260905.1289";
  srcHash = "sha256-Qd8nMgh8RLbv61ooYAJS6APhs9k19VlZyFA9xka1+iM=";
  pnpmDepsHash = "sha256-xtON4Zds68LiB182QF/IWgSqLLj6hvJOL8Ywz3ME+MU=";

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

    nativeBuildInputs = previousAttrs.nativeBuildInputs
      ++ lib.optionals stdenv.hostPlatform.isLinux [ pkg-config ];

    buildInputs = (previousAttrs.buildInputs or [])
      ++ lib.optionals stdenv.hostPlatform.isLinux [ libsecret ];

    postInstall = (previousAttrs.postInstall or "")
      + lib.optionalString stdenv.hostPlatform.isLinux ''
        mkdir --parents "$out"/libexec/t3code/native/browser-secret
        cp --recursive native/browser-secret/build \
          "$out"/libexec/t3code/native/browser-secret/
      '';

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
