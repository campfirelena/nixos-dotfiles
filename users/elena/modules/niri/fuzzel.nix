{ pkgs, config, lib, ... }:{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        layer = "overlay";
        font = "Iosevka Comfy:size=16";
      };
      colors.background = "ffffffff";
    };
  };
}
