{ pkgs, hostName, lib, inputs, ... }:
{
  imports = [
    inputs.flatpaks.homeModule
  ];

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
    keepassxc
    bitwarden
    vesktop
    ];

  # Allow home manager to download itself if needed
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  userModules = {
    autorandr.enable = true;
    awesome.enable = true;
    bash.enable = true;
    firefox.enable = true;
    flatpak = {
      enable = true;
      packages = [
        "flathub:app/org.vinegarhq.Sober//stable"
        "flathub:app/org.prismlauncher.PrismLauncher//stable"
      ];
    };
    kitty.enable = true;
    modman.enable = true;
    neovim.enable = true;
    niri.enable = true;
    obsidian.enable = true;
    spicetify.enable = true;
    steam.enable = true;
  };
}
