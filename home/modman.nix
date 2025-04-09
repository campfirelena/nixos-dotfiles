{ config, lib, pkgs, ... }:{
options = {
  modman.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.modman.enable {
  environment.systemPackages = with pkgs [
    r2modman
  ];
};
}