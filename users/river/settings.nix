{ config, lib, hostname, ... }:{
options = {
  userapps.enable = lib.mkEnableOption "";
  userapps.host = lib.mkOption {
  Type = types.str;
  default = "${hostname}";
  };
};
config = lib.mkIf config.userapps.enable (lib.mkMerge [
  (lib.mkIf (userapps.host == "server") {
    awesome.enable = false;
    firefox.enable = false;
    flatpak.enable = false;
    kitty.enable = false;
    modman.enable = false;
    neovim.enable = false;
    obsidian.enable = false;
    spicetify.enable = false;
    steam.enable = false;
  })
  (lib.mkIf (userapps.host == "desktop") {
    awesome.enable = true;
    firefox.enable = true;
    flatpak.enable = false
    kitty.enable = true;
    modman.enable = false;
    neovim.enable = true;
    obsidian.enable = true;
    spicetify.enable = true;
    steam.enable = false;
  })
  (lib.mkIf (userapps.host == "gaming") {
    awesome.enable = true;
    firefox.enable = true;
    flatpak.enable = true;
    kitty.enable = true;
    modman.enable = true;
    neovim.enable = true;
    obsidian.enable = false;
    spicetify.enable = true;
    steam.enable = true;
  })
]);
}