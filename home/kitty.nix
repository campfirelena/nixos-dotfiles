{ lib, config, ... }:{
  options = {
    userModules.kitty.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.userModules.kitty.enable {
    programs.kitty = {
      enable = true;
      };
  };
}
