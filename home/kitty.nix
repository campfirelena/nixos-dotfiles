{ lib, config, pkgs, ... }:{
  options = {
    kitty.enable = mkEnableOption "";
  };
  config = lib.mkIf config.kitty.enable {
    home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/kitty";
    programs.kitty = {
      enable = true;

      };
  };
}
