{ inputs, pkgs, hostname, ... }:
{
  imports = [
    ../pkgs
    ./elena
    ./river
    ./common.nix
  ];

  home = {
    username = "river";
    stateVersion = "24.11";
    homeDirectory = "/home/river";
  };

    # Enable what you want to use, depending on the system
  if hostname = "server" then {
  neovim.enable = true;
  firefox.enable = false;
  spicetify.enable = false;
  steam.enable = false;
  awesome.enable = false;
  };
  else if hostname = "desktop" then {
    neovim.enable = true;
    firefox.enable = true;
    spicetify.enable = true;
    steam.enable = true;
    awesome.enable = true;
  };

  programs.git = {
  enable = true;
  userName = "campfirelena";
  userEmail = "campfirelena@outlook.com";
  extraConfig = {
    init.defaultBranch = "main";
    safe.directory = "/etc/nixos";
  };
};

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
}
