{lib, config, pkgs, ...}:{
options = {
  home.firefox.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home.firefox.enable {
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