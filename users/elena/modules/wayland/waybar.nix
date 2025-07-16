{ pkgs, config, lib, ... }:{
options = {
  userModules.waybar.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.waybar.enable {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Iosevka;
      }
      window#waybar {
        background: #16191C;
        color: #AAB2BF;
      }
      #workspaces button {
        padding: 0 5px;
      }
    '';
  };
};
}
