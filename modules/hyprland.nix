{ config, lib, ... }:
{
options = {
  systemModules.hyprland.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.hyprland.enable {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.setPath.enable = true;
  };

  programs.xwayland.enable = true;
  programs.waybar.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
};
}
