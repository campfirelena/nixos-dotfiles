{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    ./spicetify
    ./steam
  ];
  home.username = "elena";
  home.homeDirectory = "/home/elena";
  home.packages = with pkgs; [
  # Essentials
    floorp
    networkmanager
    btop
    nerdfonts
    unzip
    rustup
    gcc
    vifm
    gtk3
    gtk4

  # WM Stuff
    nwg-displays
    kitty
    rofi
    mpd
    dunst
  
  # Optional Stuff
    fastfetch
    sway-contrib.grimshot #move to wayland setup
    keepassxc
    python3
    xflux-gui
    flameshot
    autokey

  # GAMIG
    steam
    prismlauncher
    glxinfo
    r2modman
    gamemode
    gamescope

    ] ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
      # UNSTABLE
      vesktop
      obs-studio
      wireguard-tools
    ]);

  # Git config
  programs.git = {
    enable = true;
    userName = "campfirelena";
    userEmail = "dan.cairns@outlook.com";
    extraConfig = {
     init.defaultBranch = "main";
     safe.directory = "/etc/nixos";
    };
  };

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  
  home.stateVersion = "23.11"; #DO NOT CHANGE, YOU NEED TO MANUALLY CHANGE DEFAULTS

}
