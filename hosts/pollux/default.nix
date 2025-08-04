{ config, lib, pkgs, ... }:

{ 
  imports = [
    ./hardware-configuration.nix
    ../common
  ] ++ map ( user: ../../users + ( "/" + user)) (builtins.attrNames (builtins.readDir ../../users));
  
  # Selecting what root modules to run

systemModules = {
  awesomewm.enable = true;
  grocy.enable = false;
  immich.enable = false;
  jellyfin.enable = false;
  niri.enable = false;
  nixconfig.enable = true;
  rivalcfg.enable = true;
  virt.enable = true;
};

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pollux";
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
    git
    curl
    nh
    home-manager
    ciscoPacketTracer8
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
  networking.firewall.allowedTCPPorts = [ 2283 ];
  networking.firewall.allowedUDPPorts = [ 2283 ];
  networking.firewall.enable = true;

  # Only change when different iso version used
  # This defines what kind of file structure is used
  # in the nix store
  system.stateVersion = "24.11";
  
}
