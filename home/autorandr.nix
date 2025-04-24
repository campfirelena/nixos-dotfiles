{ config, lib, ... }:{
options = {
  homeModules.autorandr.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.homeModules.autorandr.enable {
  programs.autorandr = {
    enable = true;
  };
};
}
