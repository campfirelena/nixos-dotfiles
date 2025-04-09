{ config, lib, pkgs , ... }:{
options = {
  obsidian.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.obsidian.enable {
  environment.systemPackages = with pkgs [
    obsidian
  ];
};
}