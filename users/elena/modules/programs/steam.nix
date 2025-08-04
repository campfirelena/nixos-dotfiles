{ config, lib, pkgs, inputs, ... }:
{
options = {
  userModules.steam.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.steam.enable {
  home.packages = with pkgs; [
    gamemode
    gamescope
    steam
  ];
};
}
