{ config, pkgs, niri, lib, ... }:{
  config = lib.mkIf config.userModules.niri.enable {
    programs.niri.settings = {
      binds = with config.lib.niri.actions; {
        #basic functions
        "Mod+D".action.spawn = "fuzzel";
        "Mod+T".action.spawn = "kitty";
        "Mod+Shift+Q".action.quit.skip-confirmation = true;
        "Print".action = screenshot;
        "Mod+Shift+Slash".action = show-hotkey-overlay;
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Shift+C".action = close-window;

        #Window interactions
        "Mod+H".action = focus-column-left;
        "Mod+L".action = focus-column-right;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+L".action = move-column-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+L".action = focus-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;
        "Mod+Shift+F".action = toggle-windowed-fullscreen;
        "Mod+M".action = switch-preset-column-width;
      };
    };
  };
}
