{ config, lib, pkgs, ... }:{
options = {
    enable = mkEnableOption "User is Elena";
};
config = lib.mkIf  config.elena.enable {
    programs.git = {
        enable = true;
        userName = "campfirelena";
        userEmail = "campfirelena@outlook.com";
        extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
        };
    };
    };
}