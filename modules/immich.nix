{ config, lib, ... }:
{
options = {
  immich.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.immich.enable {
  services.immich.enable = true
  services.immich.accelerationDevices = null;
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
