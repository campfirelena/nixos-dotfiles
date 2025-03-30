{ config, lib, ... }:
{
options = {
  immich.enable = lib.mkEnableOption "Enable Immich system module";
};
config = lib.mkIf config.immich.enable {
  #services.immich.enable = true
};
}
