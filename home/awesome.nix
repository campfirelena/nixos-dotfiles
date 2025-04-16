{ pkgs, config, ... }:{
options = {
  home.awesome.enable = mkEnableOption "";
};
config = lib.mkIf config.awesome.enable {
  home.file.".config/awesome".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/awesome";
};
}
