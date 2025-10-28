{ config, lib, pkgs, ... }:

{ 
  imports = [
    ./hardware-configuration.nix
    ../common
  ] ++ map ( user: ../../users + ( "/" + user)) (builtins.attrNames (builtins.readDir ../../users));
  
  # Selecting what root modules to run

systemModules = {
  displayManager.enable = true;
  displayManager.server = "Wayland";
  grocy.enable = false;
  immich.enable = false;
  jellyfin.enable = false;
  niri.enable = true;
  nixconfig.enable = true;
  graphics.enable = true;
  rivalcfg.enable = true;
  syncthing.enable = false;
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
    home-manager
    (ciscoPacketTracer8.override { packetTracerSource = /home/elena/nixos-dotfiles/assets/packettracer.deb;})
  ];

  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
  ];

  programs.steam.enable = true;
  programs.xfconf.enable = true;
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [ thunar-volman ];
  services.gvfs.enable = true;
  hardware.nvidia.open = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;
  programs.wireshark.usbmon.enable = true;
  qt.enable = true;

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
  networking.firewall.trustedInterfaces = [ "virbr0" ];
  networking.firewall.enable = true;

  # Don't change this
  system.stateVersion = "24.11";
  
}
