{lib, config, pkgs, ...}:{
    options = {
        enable = mkEnableOption "enable firefox module";
    };
    config = lib.mkIf config.firefox.enable {
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