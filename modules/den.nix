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

  # Manage user environments
  den.schema.user.classes = lib.mkDefault [ "homeManager" ];

  # This option defines the first version of NixOS you have installed on this
  # particular machine, and is used to maintain compatibility with application
  # data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any
  # reason, even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are
  # pulled from, so changing it will NOT upgrade your system - see
  # https://nixos.org/manual/nixos/stable/#sec-upgrading for how to actually do
  # that.
  #
  # This value being lower than the current NixOS release does NOT mean your
  # system is out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes
  # it would make to your configuration, and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or
  # https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  den.default.nixos.system.stateVersion = "25.11";
  den.default.darwin.system.stateVersion = 6;

}
