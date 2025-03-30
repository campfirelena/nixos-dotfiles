{ config, lib, ... }:
{
options = {
  jellyfin.enable = lib.mkEnableOption "Enable Jellyfin system module";
};
config = lib.mkIf config.jellyfin.enable {
  #services.jellyfin.enable = true;
};
}
