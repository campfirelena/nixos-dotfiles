{ inputs, pkgs, config, lib, ...}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  spicetify = inputs.spicetify-nix.lib.mkSpicetify pkgs {
    theme = spicePkgs.themes.starryNight;
    colorScheme = "Galaxy";
    enabledCustomApps = with spicePkgs.apps; [
    ];
    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
      adblockify
      playNext
      volumePercentage
    ];
  };
in
{
options = {
  userModules.spicetify.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.userModules.spicetify.enable {

  home.packages = [
    spicetify
  ];

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
