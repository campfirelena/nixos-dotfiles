{ config, pkgs, niri, lib, ... }:{
  options = {
    systemModules.niri.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.niri.enable {
    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };
    hardware.graphics.enable = true;
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false; 
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };
  };
}
