{ config, lib, pkgs, hostname, ... }:{
options = {
  enable = mkEnableOption "User is Elena";
};
config = lib.mkIf  config.elena.enable {
  programs.git = {
    enable = true;
    userName = "campfirelena";
    userEmail = "campfirelena@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = "/etc/nixos";
    };
  };
  
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