{ pkgs, config, lib, ... }:{
options = {
  userModules.waybar.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.waybar.enable {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
      settings = [{
        layer = "top";
        position = "top";
        mod = "dock";
        height = 0;
        modules-left = [
          "niri/workspaces"
        ];
        modules-center = [
          "niri/window"
        ];
        modules-right = [
          "tray"
          "network"
          "pulseaudio"
          "clock"
        ];
      }];
    };
};
}
