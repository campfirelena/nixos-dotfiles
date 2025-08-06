{ pkgs, config, lib, ... }:{
options = {
  userModules.fuzzel.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.fuzzel.enable {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "kitty";
        layet = "overlay";
      };
      colors.background = "ffffffff";
    };
  };
};
}
