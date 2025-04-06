{ config, lib, ... }:
{
options = {
  immich.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.immich.enable {
  #services.immich.enable = true
};
}
