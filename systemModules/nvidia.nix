{ config, lib, inputs, pkgs, ... }:{
  options = {
    systemModules.graphics.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.graphics.enable {
    hardware.graphics.enable = true;
    hardware.graphics.extraPackages = with pkgs; [ vpl-gpu-rt intel-media-driver vaapiIntel ];
    hardware.nvidia = {
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        sync.enable = lib.mkDefault true;
        offload.enable = lib.mkDefault false;
        offload.enableOffloadCmd = lib.mkDefault false;
      };
    };
    services.xserver.videoDrivers = [
      "nvidia"
    ];
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
    # Laptop battery no die
    specialisation.on-the-go.configuration = {
      system.nixos.tags = [ "on-the-go" ];
      hardware.nvidia.prime = {
        offload.enable = lib.mkForce true;
        offload.enableOffloadCmd = lib.mkForce true;
        sync.enable = lib.mkForce false;
      };
    };
  };
}
