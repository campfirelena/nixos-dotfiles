{ inputs, pkgs, config, ...}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
options = {
  spicetify.enable = mkEnableOption "enable Spicetify module";
};
config = lib.mkIf config.spicetify.enable {
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
