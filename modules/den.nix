{ inputs, den, lib, ... }: {

  imports = [ inputs.den.flakeModule ];

  den.hosts.x86_64-linux.nzxt-h1.users.echo = {};
  den.aspects.nzxt-h1.nixos = { ... }: {
    imports = [ ../hosts/nzxt-h1/configuration.nix ];
  };

  den.hosts.x86_64-linux.hp-250-g9.users.nixos = {};
  den.aspects.hp-250-g9.nixos = { ... }: {
    imports = [ ../hosts/hp-250-g9/configuration.nix ];
  };

  den.hosts.aarch64-darwin.macbook-air-m1.users.eugen = {};
  den.aspects.macbook-air-m1.darwin = { ... }: {
    imports = [ ../hosts/macbook-air-m1/configuration.nix ];
  };

}
