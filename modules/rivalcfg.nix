{ config, lib, pkgs, ... }:{
options = {
  rivalcfg.enable = lib.mkEnableOption "";
}; 
config = lib.mkIf config.rivalcfg.enable {
  environment.systemPackages = [
    pkgs.rivalcfg
  ];
  services.udev.enable = true;
  services.udev.packages = [
    pkgs.rivalcfg
  ];
  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      middleEmulation = false;
      accelSpeed = "0";
    };
  };
};
}
