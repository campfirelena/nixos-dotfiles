{ config, lib, pkgs, ... }:{
options = {
  enable = mkEnableOption "User is River";
};
config = lib.mkIf  config.river.enable {
  # enable awesomewm no matter the system
};
}