{ config, pkgs, niri, lib, ... }:{
  options = {
    userModules.niri.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.userModules.niri.enable {
    programs.niri.settings = {

      #keybinds
      binds = {
        #basic functions
        "Mod+D".action.spawn = "fuzzel";
        "Mod+T".action.spawn = "kitty";
        "Mod+Q".action.quit.skip-confirmation = true;
        "Print".action = screenshot;
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        #moving windows around
        "Mod+H".action.focus-column-left;
          "Mod+L".action.focus-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+L".action = move-column-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+L".action = focus-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
      };

      #commands to use at startup
      spawn-at-startup = [
        { command = ["systemctl" "--user" "reset-failed" "waybar.service"]; }
        { command = ["swaybg" "--image" "~/nixos-dotfiles/assets/wallpaper1.jpg"]; }
      ];

      #idk I don't use any of these
      input = {
        tablet.enable = false;
        touch.enable = false;
        touchpad.enable = false;
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
        size = 8;
        theme = "default";
      };

      #animations are slow so I wanna get rid of them. Later I will speed them up
      animations.enable = false;

      #everything is maximised (not split into columns) TODO
    };
  };
}
