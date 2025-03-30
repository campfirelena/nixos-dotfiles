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
    awesome.enable = false;
    firefox.enable = false;
    kitty.enable = false;
    neovim.enable = false;
    spicetify.enable = false;
    steam.enable = false;
  };
  else if userapps.host == "desktop" then {
    awesome.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    neovim.enable = true;
    spicetify.enable = true;
    steam.enable = true;
  };
  else if userapps.host == "testing" then {
    awesome.enable = false;
    firefox.enable = false;
    kitty.enable = false;
    neovim.enable = true;
    spicetify.enable = false;
    steam.enable = false;
  };
};
}