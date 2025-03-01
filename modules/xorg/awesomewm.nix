{ config, nixpkgs, pkgs, ... }:
{
  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
  };
    xserver.windowManager.awesome = {
      package = pkgs.awesome.override { inherit (pkgs.lua53Packages) lua; };
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
      ];
    };
  };
  environment.systemPackages = with pkgs; [
  picom
  ];
}
