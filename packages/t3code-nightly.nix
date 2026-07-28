# T3 Code built from a nightly release instead of the version in nixpkgs.
#
# There is no top-level `t3code-unwrapped` attribute, so the nightly is built by
# overriding the unwrapped package reached through the wrapper's passthru, then
# re-wrapping it.
#
# Currently unreferenced and therefore not covered by `nix flake check`, kept as
# a reference for switching back to nightlies. To do so, point the helper in
# modules/aspects/ai/t3code.nix back at this file via `pkgs.callPackage`.
#
# Beware when bumping past the version pinned below: t3code replaced
# `process.env.HOST?.trim()` with `explicitHost` in apps/web/vite.config.ts in
# releases after 2026-07-26, which makes the `postPatch` inherited from nixpkgs
# fail its `--replace-fail`. Newer nightlies additionally need that substitution
# updated, as done in https://github.com/NixOS/nixpkgs/pull/546533.

{ t3code, pnpm_11, fetchFromGitHub, fetchPnpmDeps }: let

  # Update these three together when bumping to a newer nightly
  version = "0.0.29-nightly.20260725.899";
  srcHash = "sha256-hlXyQiLeJfhMv8XQ/+B0lADZbDSzku6Bj95tIeoscjQ=";
  pnpmDepsHash = "sha256-QNVBRvXVUOKZEdIqKY2dfjvmivMTaJJSh2cexvtdJ6k=";

  # The nightly uses pnpm 11, while the pinned stable recipe still uses pnpm 10.
  unwrapped = (t3code.unwrapped.override {
    pnpm_10 = pnpm_11;
  }).overrideAttrs (finalAttrs: previousAttrs: {

    inherit version;

    # Avoid pnpm 11 checking and installing dependencies for filtered-out workspaces.
    env = (previousAttrs.env or { }) // {
      pnpm_config_verify_deps_before_run = "false";
    };

    src = fetchFromGitHub {
      owner = "pingdotgg";
      repo = "t3code";
      tag = "v${version}";
      hash = srcHash;
    };

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
