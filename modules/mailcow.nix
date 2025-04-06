{ config, lib, ... }:
{
options = {
    mailcow.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.mailcow.enable {
  #services.mailcow.enable = true;
};
}