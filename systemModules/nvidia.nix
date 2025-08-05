{ config, lib, ... }:{
  options = {
    systemModules.graphics.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.graphics.enable {
    hardware.graphics.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
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
    boot.initrd.kernelModules = [ "nvidia" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };
}
