{ config, inputs, ... }: {

  # Manage user environment for the primary user
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${config.my.user.name} = config.my.user.config;
  };

}
