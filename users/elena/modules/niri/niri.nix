{ config, pkgs, niri, lib, ... }:{
  options = {
    userModules.niri.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.userModules.niri.enable {
    programs.niri.settings = {
      layout = {
        gaps = 16;
        preset-column-widths = [
          { proportion = 1. / 1.; }
          { proportion = 1. / 2.; }
        ];
      };
      #commands to use at startup
      spawn-at-startup = [
        { command = ["systemctl" "--user" "reset-failed" "waybar.service"]; }
        { command = ["swaybg" "--image" "/home/elena/nixos-dotfiles/assets/wallpaper1.jpg"]; }
        { command = ["xwayland-satellite" ":1"]; }
      ];

      #input options lol
      input = {
        tablet.enable = false;
        touch.enable = false;
        touchpad.enable = true;
        trackpoint.enable = false;
      };

      #my monitors, might switch to a declarative way (per host)
      outputs = {
        "HDMI-A-1" = {
          focus-at-startup = true;
          position.x = 0;
          position.y = 0;
          scale = 1;
        };
        "DP-1" = {
          position.x = 1920;
          position.y = 0;
          scale = 1;
        };
      };

      #cursor theme later?
      cursor = {
        size = 6;
        theme = "default";
      };

      #animations are slow so I wanna get rid of them. Later I will speed them up
      animations.enable = false;

      #window decoration are ugly
      prefer-no-csd = true;

      environment = {
        DISPLAY = ":1";
      };
    };
  };
}
