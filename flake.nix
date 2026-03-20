{
  inputs = {
    # Nix packages collection
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations = {
      # Configuration for NZXT H1
      nzxt-h1 = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/nzxt-h1/configuration.nix ];
      };
    };
  };
}
