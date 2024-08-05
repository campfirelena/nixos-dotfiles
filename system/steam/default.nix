{ config, pkgs, inputs, ... }:
{
programs.gamemode.enable = true;
programs.gamescope.enable = true;
programs.steam = {
  enable = true;
  gamescopeSession.enable = true;
  package = pkgs.steam.override {
    withPrimus = true;
    extraPackages = [ bumblebee glxinfo ];
  };
};
}
