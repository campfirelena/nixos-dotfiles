{ pkgs, hostname, lib, ... }:
{
  home = {
    username = "river";
    stateVersion = "24.11";
    homeDirectory = "/home/river";
  };

#  programs.git = {
#    enable = true;
#    userName = "campfirelena";
#    userEmail = "campfirelena@outlook.com";
#    extraConfig = {
#      init.defaultBranch = "main";
#      safe.directory = "/etc/nixos";
#    };
#  };

  home.packages = with pkgs; [
  # Essentials for every user
    btop
    nerdfonts
    unzip
    keepassxc
    bitwarden
    ];

  # Running without bash would be stupid
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  # Allow home manager to download itself if needed
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
}
