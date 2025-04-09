{ config, lib, ... }:{
  options = {
    grocy.enable = mkEnableOption "";
  };
  config = mkIf config.grocy.enable {
    services.grocy = {
      enable = true;
      settings = {
        currency = "AUD";
        culture = "en";
        calendar = {
          showWeekNumber = false;
          firstDayOfWeek = 1;
        };
      };
    };
  };
}