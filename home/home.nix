{ inputs, pkgs, username, homeDirectory, ... }:
{
  imports = [
    ../pkgs
  ];

  home = {
    inherit username;
    stateVersion = "24.11";
    sessionPath = [ "$HOME/.local/bin" ];
    homeDirectory = pkgs.lib.mkDefault "/home/elena";
  };

  #Turn modules on and off for each user
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
    ];

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
  

}
