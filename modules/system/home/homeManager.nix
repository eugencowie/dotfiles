{ config, inputs, ... }: {

  # Manage user environment
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users.${config.my.user.name} = config.my.user.config;
  };

}
