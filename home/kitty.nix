{ lib, config, pkgs, ... }:{
  options = {
    home.kitty.enable = mkEnableOption "";
  };
  config = lib.mkIf config.home.kitty.enable {
    home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/kitty";
    programs.kitty = {
      enable = true;

      };
  };
}
