{ lib, config, ... }:{
  options = {
    userModules.kitty.enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.userModules.kitty.enable {
    home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/kitty";
    programs.kitty = {
      enable = true;
      };
  };
}
