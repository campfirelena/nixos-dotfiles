{ config, lib, ... }:
{
options = {
  findom.enable = lib.mkEnableOption "Enable Findom system module";
};
config = lib.mkIf config.findom.enable {
  #services.findom.enable = true;
};
}
