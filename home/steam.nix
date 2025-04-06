{ config, lib, pkgs, inputs, ... }:
{
options = {
  steam.enable = mkEnableOption "";
};
config = lib.mkIf config.spicetify.enable {
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
};
}
