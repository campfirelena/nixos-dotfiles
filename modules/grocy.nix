{ config, lib, ... }:{
  options = {
    grocy.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.grocy.enable {
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