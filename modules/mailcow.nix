{ config, lib, ... }:
{
options = {
    mailcow.enable = lib.mkEnableOption "Enable MailCow system module";
};
config = lib.mkIf config.mailcow.enable {
  #services.mailcow.enable = true;
};
}