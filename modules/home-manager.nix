{ config, lib, pkgs, ... }:{
options = {
  home-manager.enable = lib.mkEnableOption "Enable Home Manager system module";
};
config = lib.mkIf config.home-manager.enable {
  environment.systemPackages = [pkgs.home-manager];
};
}
