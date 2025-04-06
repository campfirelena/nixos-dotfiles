{ config, lib, pkgs, ... }:{
options = {
  home-manager.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home-manager.enable {
  environment.systemPackages = [pkgs.home-manager];
};
}
