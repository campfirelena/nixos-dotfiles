{ pkgs, lib, ... }:{
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  imports = (lib.filesystem.listFilesRecursive ../../systemModules);
}
