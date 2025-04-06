{ config, lib, ... }:
{
options = {
  frigate.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.frigate.enable {
  #services.frigate.enable = true;
};
}
