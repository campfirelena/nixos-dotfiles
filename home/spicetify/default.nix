{ inputs, pkgs, config, ...}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  home.packages = [
    pkgs.spotify-cli-linux
  ];

  programs.spicetify = 
    let
      ellie = pkgs.fetchgit {
        url = "https://github.com/spicetify/spicetify-themes";
        sha256 = "JmH0oREsNMwtAIBb7OvSTt6FRpX1gjK3RptE1rrXWEg=";
        rev = "37c6348144a24bcdd5b554ed765a691fb33eece4";
	};
    in
  {
    enable = true;
    theme = {
      name = "StarryNight";
      src = ellie;
      appendName = true;
      injectCss = true;
      injectTHemeJs = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
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
}
