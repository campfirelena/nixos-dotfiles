{ lib, config, pkgs, ... }:{
  options = {
    userModules.kitty.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.userModules.kitty.enable {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      shellIntegration.enableBashIntegration = true;
      font = {
        size = 12;
        package = pkgs.iosevka-comfy.comfy;
        name = "Iosevka Comfy";
      };
    };

    fonts.fontconfig = {
      enable = true;
    };
  };
}
