{ config, lib, pkgs, inputs, ... }:
{
programs.gamemode.enable = true;
programs.gamescope.enable = true;
programs.steam = {
  enable = true;
  gamescopeSession.enable = true;
};
}
