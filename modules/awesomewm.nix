{ config, nixpkgs, pkgs, lib, ... }:{
options = {
  awesomewm.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.awesomewm.enable {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
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
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
  };
};
}
