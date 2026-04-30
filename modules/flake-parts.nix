{ den, ... }: {

  # Flake basics described using the module system
  flake-file.inputs.flake-parts.url = "github:hercules-ci/flake-parts";
  flake-file.inputs.flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

  # Generate a flake output for each system defined in den.hosts
  systems = builtins.attrNames den.hosts;

  # Development shell for this project
  perSystem = { pkgs, ... }: {
    devShells.default = import ../shell.nix { inherit pkgs; };
  };

}
