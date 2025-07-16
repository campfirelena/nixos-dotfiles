{ pkgs, config, lib, ... }:{
options = {
  userModules.awesome.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.awesome.enable {
  home.file.".config/awesome".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/awesome";
};
}
