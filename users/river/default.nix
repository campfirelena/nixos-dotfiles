{ config, lib, ... }:{
imports = [
  ./settings.nix
];

userapps.enable = true;

users.users.river = {
  isNormalUser = true;
  home = "/home/river";
  description = "River - ADMIN";
  extraGroups = [ "wheel" ];
  hashedPassword = "$y$j9T$y8Ju9NslSMm48uKnxO3sS0$XbxMMz95JUCcNjvwAQXCgfjHfi6x4BLl/eYycKdcrvD"; # run "mkpasswd <password>" in the terminal to get this hash
};

home-manager.users.river = lib.mkIf config.home-manager.enable (import ./home.nix);
}
