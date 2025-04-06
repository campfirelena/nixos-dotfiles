{ config, lib, ... }:
{
options = {
  jellyfin.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.jellyfin.enable {
  #services.jellyfin.enable = true;
};
}
