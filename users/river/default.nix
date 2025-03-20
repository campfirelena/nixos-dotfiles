{ config, lib, pkgs, hostname, home-manager, ... }:{
users.users.river = {
  isNormalUser = true;
  home = "/home/river";
  description = "River - ADMIN";
  extraGroups = [ "wheel" ];
};
#home-manager.users.river (import ./home.nix);
}
