{lib, config, pkgs, ...}:{
options = {
  userModules.firefox.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.firefox.enable {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # Input about:config options
    profiles.elena = {
      "browser.tabs.closeTabByDblClick" = true;
      "sidebar.verticalTabs" = true;
    };
  };
};
}
