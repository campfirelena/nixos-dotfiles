{ lib, config, pkgs, ... }:{
  options = {
    userModules.terminal.enable = lib.mkEnableOption "";
    userModules.terminal.choice = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = lib.mkIf config.userModules.terminal.enable {
    programs.kitty = lib.mkIf (config.userModules.terminal.choice == "kitty") {
      enable = true;
      enableGitIntegration = true;
      shellIntegration.enableBashIntegration = true;
      font = {
        size = 12;
        package = pkgs.iosevka-comfy.comfy;
        name = "Iosevka Comfy";
      };
      extraConfig = ''
        
      '';
    };

    fonts.fontconfig = {
      enable = true;
    };
  };
}
