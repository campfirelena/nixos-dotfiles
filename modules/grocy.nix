{ config, lib, ... }:{
  options = {
    grocy.enable = mkEnableOption "Enable Grocy system module";
  };
  config = mkIf config.grocy.enable {
    # grocy
  };
}