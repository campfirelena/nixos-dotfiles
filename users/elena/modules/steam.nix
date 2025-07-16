{ config, lib, pkgs, inputs, ... }:
{
options = {
  userModules.steam.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.spicetify.enable {
  home.packages = with pkgs; [
    gamemode
    gamescope
    steam
  ];
};
}
