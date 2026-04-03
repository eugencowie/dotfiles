{ den, ... }: {

  den.hosts = {

    # Configuration for NZXT H1
    x86_64-linux.nzxt-h1 = {
      users.echo = {};
    };

    # Configuration for HP 250 G9
    x86_64-linux.hp-250-g9 = {
      users.nixos = {};
      wsl.enable = true;
    };

    # Configuration for MacBook Air M1
    aarch64-darwin.macbook-air-m1 = {
      users.eugen = {};
    };

  };

}
