{ den, ... }: {

  den.aspects.ai.provides.comfyui = { user, ... }: {

    # Require the NVIDIA driver for CUDA and Tailscale for remote access
    includes = with den.aspects; [ gpu._.nvidia remote._.tailscale ];

    os = { lib, pkgs, ... }: {

      # Use binary cache for CUDA builds, as otherwise torch builds from source
      nix.settings.extra-substituters = [ "https://cache.nixos-cuda.org" ];
      nix.settings.extra-trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];

      # Enable ComfyUI with CUDA acceleration
      services.comfyui = {
        enable = true;
        package = pkgs.pkgsCuda.comfyui;
        # Listen on all interfaces, but only open the port on the tailnet
        listen = [ "0.0.0.0" "::" ];
      };
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8188 ];

      # Let the user manage models and outputs without sudo, by making the data
      # directory and everything ComfyUI creates in it group-writable
      users.users.${user.userName}.extraGroups = [ "comfyui" ];
      systemd.services.comfyui.serviceConfig = {
        StateDirectoryMode = lib.mkForce "0770";
        UMask = "0007";
      };

    };

  };

}
