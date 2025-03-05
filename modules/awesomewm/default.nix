{ config, nixpkgs, pkgs, ... }:{
options = {
  awesomewm.enable = lib.mkEnableOption "Enable AwesomeWM system module";
};
config = lib.mkIf config.awesomewm.enable {
  services = {
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
  };
    xserver.windowManager.awesome = {
      package = pkgs.awesome.override { inherit (pkgs.lua53Packages) lua; };
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
      ];
    };
  };
  environment.systemPackages = with pkgs; [
  picom
  ];
};
}