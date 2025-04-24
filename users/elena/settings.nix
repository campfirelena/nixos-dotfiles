{ config, lib, hostName, inputs, ... }:{
options = {
  userapps.enable = lib.mkEnableOption "";
  userapps.host = lib.mkOption {
    type = lib.types.str;
    default = "gaming";
  };
};
config = lib.mkIf config.userapps.enable (lib.mkMerge [
  (lib.mkIf (config.userapps.host == "server") {
    home.autorandr.enable = false;
    home.awesome.enable = false;
    home.bash.enable = true;
    home.firefox.enable = false;
    home.flatpak.enable = false;
    home.kitty.enable = false;
    home.modman.enable = false;
    home.neovim.enable = false;
    home.obsidian.enable = false;
    home.spicetify.enable = false;
    home.steam.enable = false;
    home.stylix.enable = false;
  })
  (lib.mkIf (config.userapps.host == "desktop") {
    home.autorandr.enable = true;
    home.awesome.enable = true;
    home.bash.enable = true;
    home.firefox.enable = true;
    home.flatpak.enable = false;
    home.kitty.enable = true;
    home.modman.enable = false;
    home.neovim.enable = true;
    home.obsidian.enable = true;
    home.spicetify.enable = true;
    home.steam.enable = false;
    home.stylix.enable = true;
  })
  (lib.mkIf (config.userapps.host == "gaming") {
    home.autorandr.enable = true;
    home.awesome.enable = true;
    home.bash.enable = true;
    home.firefox.enable = true;
    home.flatpak.enable = true;
    home.kitty.enable = true;
    home.modman.enable = true;
    home.neovim.enable = true;
    home.obsidian.enable = false;
    home.spicetify.enable = true;
    home.steam.enable = true;
    home.stylix.enable = true;
  })
  (lib.mkIf (config.userapps.host == "testing") {
    home.autorandr.enable = false;
    home.awesome.enable = false;
    home.bash.enable = true;
    home.firefox.enable = false;
    home.flatpak.enable = false;
    home.kitty.enable = false;
    home.modman.enable = false;
    home.neovim.enable = false;
    home.obsidian.enable = false;
    home.spicetify.enable = false;
    home.steam.enable = false;
    home.stylix.enable = false;
  })
]);
}
