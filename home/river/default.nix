{ config, lib, pkgs, ... }:{
options = {
  enable = mkEnableOption "User is River";
};
config = lib.mkIf  config.river.enable {
  # Enable what you want to use, depending on the system
  if hostname = "server" then {
  neovim.enable = true;
  firefox.enable = false;
  spicetify.enable = false;
  steam.enable = false;
  awesome.enable = false;
  };
  else if hostname = "desktop" then {
    neovim.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
    steam.enable = true;
    awesome.enable = true;
  };
};
}