{ config, pkgs, niri, lib, ... }:{
  options = {
    systemModules.niri.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.systemModules.niri.enable {
    programs.niri = {
      enable = true;
    };

    environment.systemPackages = with pkgs; [
      mako
      swaybg
      swaylock
      wl-clipboard
    ];

    #fix electron BS
    environment.variables = {
      NIXOS_OZONE_WL = 1;
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };
  };
}
