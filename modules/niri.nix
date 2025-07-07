{ config, nixpkgs, pkgs, lib, ... }:{
options = {
  systemModules.niri.enable = lib.mkEnableOption "";
};
  config = lib.mkIf config.systemModules.niri.enable {
    #stylix.targets.niri.enable = true;
    #programs.niri = {
    #      enable = true;
    #  package = pkgs.niri;
    #  settings = {
    #    binds = {
    #      "Mod+D".action.spawn = "fuzzel";
    #      "Mod+1".action.focus-workspace = 1;
    #    };
    #    spawn-at-startup = [
    #      { command = ["waybar"]; }
    #    ];
    #  };
    #};
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
