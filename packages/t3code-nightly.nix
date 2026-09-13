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
  version = "0.0.41-nightly.20260913.1646";
  srcHash = "sha256-9GOSiCoCR2Z7xV/DCyFG+uCKmVaa8zYb9WeCodxdXys=";
  pnpmDepsHash = "sha256-EO844JyOlqtUG+mGWOeXlVtQjRpFFgwiXRvTgfEh7ao=";

  # Match the SPDX revision in scripts/lib/third-party-licenses.ts upstream.
  spdxLicenseList = fetchFromGitHub {
    owner = "spdx";
    repo = "license-list-data";
    rev = "c4a7237ec8f4654e867546f9f409749300f1bf4c"; # v3.28.0
    hash = "sha256-FbeeEBAg9ih6DkAsXdU6ruZwkC7A2u2zYBvblpl54q0=";
  };

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

    # Release builds generate license notices; seed their cache for offline builds.
    preBuild = (previousAttrs.preBuild or "") + ''
      mkdir -p .generated/third-party-licenses/spdx
      cp -r ${spdxLicenseList}/json/details .generated/third-party-licenses/spdx/v3.28.0
    '';

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
