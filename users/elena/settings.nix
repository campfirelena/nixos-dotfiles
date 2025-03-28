{ config, lib, hostname ... }:{
options = {
  userapps.enable = mkEnableOption "Enable main apps options";
  userapps.host = mkOtion {
  Type = types.str;
  default = "${hostname}";
  }
};
config = mkIf config.userapps.enable {
  if userapps.host == "server" then {
    firefox.enable = false;
  };
  else if userapps.host == "desktop" then {
    firefox.enable = true;
  };
};
}