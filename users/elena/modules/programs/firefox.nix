{lib, config, pkgs, ...}:{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    # Input about:config options
    profiles.elena = {
#      "browser.tabs.closeTabByDblClick" = true;
#      "sidebar.verticalTabs" = true;
    };
  };
}
