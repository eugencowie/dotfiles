{ config, ... }: {

  # Enable support for running NixOS as a WSL distribution
  wsl.enable = true;
  wsl.defaultUser = config.my.user.name;

}
