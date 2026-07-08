{ den, ... }: {

  den.aspects.gpu.provides.nvidia.os = {

    # Enable the NVIDIA graphics drivers
    nixpkgs.config.allowUnfree = true;
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.open = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.powerManagement.enable = true;

  };

}
