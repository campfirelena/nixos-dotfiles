{ config, lib, pkgs , ... }:{
options = {
  home.obsidian.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home.obsidian.enable {
  environment.systemPackages = with pkgs [
    obsidian
  ];
};
}