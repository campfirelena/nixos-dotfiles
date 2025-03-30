{ config, lib, ... }:
{
options = {
  frigate.enable = lib.mkEnableOption "Enable Frigate system module";
};
config = lib.mkIf config.frigate.enable {
  #services.frigate.enable = true;
};
}
