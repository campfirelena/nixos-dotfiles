{ inputs, config, pkgs, lib, ... }:

{
  imports = [
    #./spicetify
    ./nvim/default.nix
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
    gtk3
    gtk4
    usbutils

  # WM Stuff
    nwg-displays
    kitty
    rofi
    mpd
    dunst
  
  # Optional Stuff
    fastfetch
    keepassxc
    python3
    flameshot

  # GAMIG
    prismlauncher
    r2modman
    piper
    libratbag

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
  
  home.stateVersion = "24.05"; #SET TO SPECIFIC ISO VERSION

}
