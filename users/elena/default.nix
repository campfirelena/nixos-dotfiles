{ config, lib, ... }:{
users.users.elena = {
  isNormalUser = true;
  home = "/home/elena";
  description = "Elena - ADMIN";
  extraGroups = [ "wheel" ];
  hashedPassword = "$6$o3/yQmjlVubKtVZD$TAdbP60Jc16ltN7kzl.klX5g.vpB5RNwyZMdg6qvTHdcB1mHsNnNfKuWJp.laPfvpR4eZLsy1TKA0oTox24PD.";
};

home-manager.users.elena = lib.mkIf config.home-manager.enable (import ./home.nix);

}
