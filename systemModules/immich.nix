{ config, lib, pkgs, ... }:
{
options = {
  systemModules.immich.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.immich.enable {
  services.immich = {
    enable = true;
    port = 2283;
    accelerationDevices = null;
    mediaLocation = "/data/immich";
    host = "0.0.0.0";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  users.users.immich.extraGroups = [ "video" "render" ];
};
}
