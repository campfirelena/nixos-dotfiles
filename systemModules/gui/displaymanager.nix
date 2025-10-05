{ config, lib, ... }:{
options = {
  systemModules.displayManager.enable = lib.mkEnableOption "";
  systemModules.displayManager.server = lib.mkOption {
    type = lib.types.str;
  };
};
config = lib.mkIf config.systemModules.displayManager.enable {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
};
}
