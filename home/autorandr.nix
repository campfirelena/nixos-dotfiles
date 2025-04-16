{ config, lib, ... }:{
options = {
  home.autorandr.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.autorandr.enable {
  programs.autorandr = {
    enable = true;
  };
};
}