{ inputs, lib, ... }: {

  # Generate flake.nix from module options
  flake-file.inputs.flake-file.url = "github:vic/flake-file";

  # Use flake-file for dendritic modules
  imports = [ (inputs.flake-file.flakeModules.dendritic or { }) ];

}
