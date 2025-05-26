{ config, lib, pkgs , ... }:{
options = {
  userModules.obsidian.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.obsidian.enable {
  home.packages = with pkgs; [
    obsidian
  ];
};
}
