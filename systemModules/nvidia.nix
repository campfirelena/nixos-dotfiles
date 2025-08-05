{ config, lib, ... }:{
  options = {
    systemModules.graphics.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.graphics.enable {
    hardware.graphics.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = true;
      nvidiaSettings = true;
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };
    };
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
