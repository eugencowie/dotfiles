{ config, lib, ... }: {

  # Configure network connections interactively with nmcli or nmtui
  networking.networkmanager.enable = true;

  users.users.${config.my.user.name}.extraGroups = lib.mkAfter [ "networkmanager" ];

}
