{ config, lib, ... }:{
options = {
  userModules.autorandr.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.autorandr.enable {
  programs.autorandr = {
    enable = true;
  };
};
}
