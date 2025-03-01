{ inputs, pkgs, username, homeDirectory, ... }:

{
  imports = [
    #./spicetify
    ./nvim/default.nix
    #./awesome/default.nix
  ];
  home.username = "elena";
  home.homeDirectory = "/home/elena";

  nvim.enable = true;

  home.packages = with pkgs; [
  # Essentials
    firefox
    btop
    nerdfonts
    unzip
    
  # Optional Stuff
    fastfetch
    keepassxc
    python3
    flameshot
    xclip

  # GAMIG
    prismlauncher
    r2modman
    jdk17

    ] ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
      # UNSTABLE
      vesktop
      wireguard-tools
    ]);

  # Git config
  programs.git = {
    enable = true;
    userName = "campfirelena";
    userEmail = "campfirelena@outlook.com";
    extraConfig = {
     init.defaultBranch = "main";
     safe.directory = "/etc/nixos";
    };
  };

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;
  
  home.stateVersion = "24.11"; #SET TO SPECIFIC ISO VERSION

}
