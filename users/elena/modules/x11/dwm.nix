{ config, lib, pkgs, ... }: {
  options = {
    elena.dwm.enable = mkEnableOption "";
  };
  config = lib.mkIf config.elena.dwm.enable {
    programs.dwm.enable = true;
  };
}
