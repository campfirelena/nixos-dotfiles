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
        intelBusId = "PCI:0:0:2";
        nvidiaBusId = "PCI:0:1:0";
        offload.enable = true;
        offload.enableOffloadCmd = true;
      };
    };
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
  };
}
