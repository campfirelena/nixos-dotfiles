{ config, lib, pkgs, ... }:
{
options = {
  immich.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.immich.enable {
  services.immich.enable = true
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
