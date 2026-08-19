# T3 Code built from a nightly release instead of the version in nixpkgs.
#
# There is no top-level `t3code-unwrapped` attribute, so the nightly is built by
# overriding the unwrapped package reached through the wrapper's passthru, then
# re-wrapping it.
#
{ t3code, pnpm_11, fetchFromGitHub, fetchPnpmDeps }: let

  # Update these three together when bumping to a newer nightly
  version = "0.0.34-nightly.20260819.1133";
  srcHash = "sha256-uv/kD71zDPfaVyQ8EhxxwbKYaOq66T5tLeeFJmvEKrE=";
  pnpmDepsHash = "sha256-AW7M/GU1AQJO8qcbv+aIGhxkCya28kp0TOwfBKlg2rQ=";

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
