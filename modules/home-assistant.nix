{ config, lib, ... }:
{
options = {
  home-assistant.enable = lib.mkEnableOption "Enable Home-assistant system module";
};
config = lib.mkIf config.home-assistant.enable {
  #services.home-assistant.enable = true;
};
}
