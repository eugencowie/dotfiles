{ inputs, den, lib, ... }: {

  imports = [ inputs.den.flakeModule ];

  den.hosts.x86_64-linux.nzxt-h1.users.echo = {};
  den.aspects.nzxt-h1.nixos = { ... }: {
    imports = [ ../hosts/nzxt-h1/configuration.nix ];
  };
  den.aspects.echo = {
    includes = [ den.provides.primary-user ];
    user.description = "Eugén Cowie";
  };

  den.hosts.x86_64-linux.hp-250-g9.users.nixos = {};
  den.aspects.hp-250-g9.nixos = { ... }: {
    imports = [ ../hosts/hp-250-g9/configuration.nix ];
  };
  den.aspects.nixos.includes = [ den.provides.primary-user ];

  den.hosts.aarch64-darwin.macbook-air-m1.users.eugen = {};
  den.aspects.macbook-air-m1.darwin = { ... }: {
    imports = [ ../hosts/macbook-air-m1/configuration.nix ];
  };
  den.aspects.eugen.includes = [ den.provides.primary-user ];

  den.default.includes = [

    # Define the hostname
    den.provides.hostname

    # Define the user account
    den.provides.define-user

  ];

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

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  den.default.homeManager.home.stateVersion = "25.11";

}
