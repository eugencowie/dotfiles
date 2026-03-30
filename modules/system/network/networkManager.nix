{ config, lib, ... }: {

  # Configure network connections interactively with nmcli or nmtui
  networking.networkmanager.enable = true;

  # Allow the primary user to manage network connections
  users.users.${config.my.user.name}.extraGroups = lib.mkAfter [ "networkmanager" ];

}
