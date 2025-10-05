{ config, lib, ... }:{
  options = {
    systemModules.syncthing.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.syncthing.enable {
    services.syncthing = {
      enable = true;
      dataDir = "/data/syncthing";
    };
  };
}
