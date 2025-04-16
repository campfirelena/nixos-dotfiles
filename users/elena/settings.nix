{ config, lib, hostName, ... }:{
options = {
  userapps.enable = lib.mkEnableOption "";
  userapps.host = lib.mkOption {
    Type = types.str;
    default = "${hostName}";
  };
};
config = lib.mkIf config.userapps.enable (lib.mkMerge [
  (lib.mkIf (config.userapps.host == "server") {
    autorandr.enable = false;
    awesome.enable = false;
    bash.enable = true;
    firefox.enable = false;
    flatpak.enable = false;
    kitty.enable = false;
    modman.enable = false;
    neovim.enable = false;
    obsidian.enable = false;
    spicetify.enable = false;
    steam.enable = false;
    stylix.enable = false;
  })
  (lib.mkIf (config.userapps.host == "desktop") {
    autorandr.enable = true;
    awesome.enable = true;
    bash.enable = true;
    firefox.enable = true;
    flatpak.enable = false;
    kitty.enable = true;
    modman.enable = false;
    neovim.enable = true;
    obsidian.enable = true;
    spicetify.enable = true;
    steam.enable = false;
    stylix.enable = true;
  })
  (lib.mkIf (config.userapps.host == "gaming") {
    autorandr.enable = true;
    awesome.enable = true;
    bash.enable = true;
    firefox.enable = true;
    flatpak.enable = true;
    kitty.enable = true;
    modman.enable = true;
    neovim.enable = true;
    obsidian.enable = false;
    spicetify.enable = true;
    steam.enable = true;
    stylix.enable = true;
  })
  (lib.mkIf (config.userapps.host == "testing") {
    autorandr.enable = false;
    awesome.enable = false;
    bash.enable = true;
    firefox.enable = false;
    flatpak.enable = false;
    kitty.enable = false;
    modman.enable = false;
    neovim.enable = false;
    obsidian.enable = false;
    spicetify.enable = false;
    steam.enable = false;
    stylix.enable = false;
  })
]);
}