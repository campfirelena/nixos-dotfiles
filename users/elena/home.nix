{ pkgs, hostName, lib, inputs, ... }:
{
  imports = [
    ./system-specific.nix
  ] ++ (lib.filesystem.listFilesRecursive ./modules) ++ (lib.filesystem.listFilesRecursive ../../homeModules);

  home = {
    username = "elena";
    stateVersion = "24.11"; # DO NOT CHANGE
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
    onlyoffice-desktopeditors
    p7zip
    gimp
    material-symbols
    kew
    r2modman
    obsidian
    inputs.nixvim.packages.${pkgs.system}.default
    qutebrowser
    ];

  # Allow home manager to download itself if needed
  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = true;
  };

  userModules = {
    flatpak = {
      enable = true;
      packages = [
        "flathub:app/org.vinegarhq.Sober//stable"
        "flathub:app/org.prismlauncher.PrismLauncher//stable"
     ];
    };
    terminal = {
      enable = true;
      choice = "kitty";
    };
  };
}
