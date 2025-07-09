{ config, nixpkgs, pkgs, lib, ... }:{
options = {
  systemModules.awesomewm.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.awesomewm.enable {
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.session = [
      {
        manage = "desktop";
	name = "default";
	start = ''exec awesome'';
      }
    ];
    windowManager.awesome = {
      package = pkgs.awesome.override { inherit (pkgs.lua53Packages) lua; };
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks
      ];
    };
  };

  services.displayManager.ly = {
    enable = true;
    x11Support = true;
  };

  services.displayManager.defaultSession = "default";

  environment.systemPackages = with pkgs; [
    rofi
  ];

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";

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
