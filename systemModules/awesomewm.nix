{ config, nixpkgs, pkgs, lib, ... }:{
options = {
  systemModules.awesomewm.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.awesomewm.enable {
  services.xserver = {
    enable = true;
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

  xdg.portal.enable = true;
  xdg.portal.config.common.default = "*";
};
}
