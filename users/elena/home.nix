{ pkgs, hostName, lib, inputs, ... }:
{
  imports = [
  ] ++ (lib.filesystem.listFilesRecursive ./modules);

  home = {
    username = "elena";
    stateVersion = "24.11";
    homeDirectory = "/home/elena";
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
    unzip
    bitwarden
    vesktop
    fzf
    ];

  # Allow home manager to download itself if needed
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  userModules = {
    awesome.enable = true;
    bash.enable = true;
    firefox.enable = true;
#    flatpak = {
#      enable = false;
#      packages = [
#        "flathub:app/org.vinegarhq.Sober//stable"
#        "flathub:app/org.prismlauncher.PrismLauncher//stable"
#      ];
#    };
#    fuzzel.enable = true;
    kitty.enable = true;
    modman.enable = true;
#    neovim.enable = true;
   # niri.enable = true;
    obsidian.enable = true;
#    spicetify.enable = true;
    steam.enable = true;
#    waybar.enable = true;
  };
}
