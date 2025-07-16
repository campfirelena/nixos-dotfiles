{ config, lib, pkgs, ... }:{
options = {
  userModules.modman.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.modman.enable {
  home.packages = with pkgs; [
    r2modman
  ];
};
}
