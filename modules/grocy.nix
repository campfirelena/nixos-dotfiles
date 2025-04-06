{ config, lib, ... }:{
  options = {
    grocy.enable = mkEnableOption "";
  };
  config = mkIf config.grocy.enable {
    # grocy
  };
}