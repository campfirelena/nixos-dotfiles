{ config, lib, ... }:
{
options = {
  findom.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.findom.enable {
  #services.findom.enable = true;
};
}
