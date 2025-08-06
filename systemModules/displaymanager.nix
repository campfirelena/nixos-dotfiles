{ config, lib, ... }:{
options = {
  systemModules.displayManager.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.displayManager.enable {
  services.displayManager.sddm = {
    enable = true;
  };
};
}
