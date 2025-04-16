{ config, lib, pkgs, ... }:{
options = {
  home.modman.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home.modman.enable {
  environment.systemPackages = with pkgs [
    r2modman
  ];
};
}