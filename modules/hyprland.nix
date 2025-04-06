{ config, lib, ... }:
{
options = {
  hyprland.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.hyprland.enable {
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
