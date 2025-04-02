{ config, lib, hostname, ... }:{
options = {
  userapps.enable = lib.mkEnableOption "Enable main apps options";
  userapps.host = lib.mkOption {
  Type = types.str;
  default = "${hostname}";
  };
};
config = lib.mkIf config.userapps.enable (lib.mkMerge [
  (lib.mkIf (userapps.host == "server") {
    awesome.enable = false;
    firefox.enable = false;
    kitty.enable = false;
    neovim.enable = false;
    spicetify.enable = false;
    steam.enable = false;
  })
  (lib.mkIf (userapps.host == "desktop") {
    awesome.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    neovim.enable = true;
    spicetify.enable = true;
    steam.enable = false;
  })
  (lib.mkIf (userapps.host == "gaming") {
    awesome.enable = true;
    firefox.enable = true;
    kitty.enable = true;
    neovim.enable = true;
    spicetify.enable = true;
    steam.enable = true;
  })
]);
}