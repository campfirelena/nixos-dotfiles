{ inputs, pkgs, config, lib, ...}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
options = {
  home.spicetify.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.home.spicetify.enable {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  home.packages = [
    pkgs.spotify-cli-linux
  ];

  programs.spicetify = 
      {
    enable = true;
    theme = spicePkgs.themes.starryNight;
    colorScheme = "Galaxy";
    enabledCustomApps = with spicePkgs.apps; [
    ];
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblock
      playNext
      volumePercentage
    ];
  };

  xdg.desktopEntries = {
    spotify = {
      name = "Spicetify";
      exec = "spotify";
      icon = "spotify";
      type = "Application";
    };
  };
};
}
