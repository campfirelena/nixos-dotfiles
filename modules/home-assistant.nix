{ config, lib, ... }:
{
options = {
  home-assistant.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home-assistant.enable {
  #services.home-assistant.enable = true;
};
}
