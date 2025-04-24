{ config, lib, pkgs, modulesPath, inputs, username, ... }:

{ 
  imports = [
    ./hardware-configuration.nix
  ] ++ map( moduleFile: ../../users + ( "/" + moduleFile)) (builtins.attrNames (builtins.readDir ../../users));
  
  # Selecting what root modules to run

  awesomewm.enable = true;
  grocy.enable = false;
  home-manager.enable = false;
  hyprland.enable = false;
  immich.enable = false;
  jellyfin.enable = false;
  nixconfig.enable = true;
  rivalcfg.enable = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_AU.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
   };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  #services.xserver.xkb.options = "eurosign:e,caps:escape";

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
  ];

  # DEFAULTS

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # idk if these are needed so I commented them out
  #programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;

  # Only change when different iso version used
  # This defines what kind of file structure is used
  # in the nix store
  system.stateVersion = "24.11";
  
}
