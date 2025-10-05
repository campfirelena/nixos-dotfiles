{ pkgs, lib, ... }:{
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  imports = (lib.filesystem.listFilesRecursive ../../systemModules);

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
    flake = "../../";
  };
}
