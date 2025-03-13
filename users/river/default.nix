{ config, lib, pkgs, hostname, ... }:{
imports = [
  ./home.nix
];
users.users.river = {
  isNormalUser = true;
  home = "/home/river";
  description = "River - USER";
  extraGroups = [];
}
home-manager.users.river = (import ./home.nix);
}