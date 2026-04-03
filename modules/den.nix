{ inputs, ... }: {

  imports = [ inputs.den.flakeModule ];

  den.hosts.x86_64-linux.nzxt-h1.users.echo = {};
  den.hosts.x86_64-linux.hp-250-g9.users.nixos = {};
  den.hosts.aarch64-darwin.macbook-air-m1.users.eugen = {};

}
