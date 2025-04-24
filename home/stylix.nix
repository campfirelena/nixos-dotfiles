{ config, lib, pkgs, ... }:{
options = {
  home.stylix.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home.stylix.enable {
  stylix = {
    enable = true;
    polarity = "dark"; # Screw light mode lol
    wallpaper = ./assets/wallpaper1.jpg; # Add wallpapers to assets directory, change this option
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
};
}
