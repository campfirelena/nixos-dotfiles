{ config, nixpkgs, pkgs, lib, ... }:{
options = {
  systemModules.awesomewm.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.awesomewm.enable {
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "default";
    displayManager.session = [
      {
        manage = "desktop";
	name = "default";
	start = ''exec awesome'';
      }
    ];
    displayManager.lightdm = {
      enable = true;
      greeters.tiny.enable = true;
    };
    windowManager.awesome = {
      package = pkgs.awesome.override { inherit (pkgs.lua53Packages) lua; };
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    rofi
  ];
};
}
