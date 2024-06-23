{ inputs, pkgs, lib, config, ...}:
let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ inputs.spicetify-nix.homeManagerModule ];

  home.packages = [
    pkgs.spotify-cli-linux
  ];

  programs.spicetify = 
    let
      ellie = pkgs.fetchgit {
        url = "https://github.com/spicetify/spicetify-themes";
	sha256 = "8IF2Y7xJtzk92rl4bfjiMXCISzUMaxXxOaMZkLS5mww=";
	};
    in
  {
    enable = true;
    theme = {
      name = "StarryNight";
      src = ellie;
      requiredExtensions = [
      {
        filename = "theme.js";
	src = "${ellie}/StarryNight";
      }
      ];
      appendName = true;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
    colorScheme = "Galaxy";
    spotifyPackage = pkgs.spotify;

    enabledCustomApps = with spicePkgs.apps; [
    ];

    enabledExtensions = with spicePkgs.extensions; [
     #fullAppDisplay
      shuffle
     #hidePodcasts
      adblock
     #playNext
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
