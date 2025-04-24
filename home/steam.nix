{ config, lib, pkgs, inputs, ... }:
{
options = {
  home.steam.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home.spicetify.enable {
  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
};
}
