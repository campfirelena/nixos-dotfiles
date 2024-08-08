{ config, lib, pkgs, modulesPath, inputs, ... }:

{ 
  imports =[
    ./hardware-configuration.nix
    ./steam
    ./xorg
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use Flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
    permittedInsecurePackages = ["electron-25.9.0"];
    pulseaudio = true;
  };

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  networking.hostName = "nixos";
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

  services.printing.enable = true;
  
  security.rtkit.enable = true;
  sound.enable = lib.mkForce false;  #disable pulseaudio
  hardware.pulseaudio.enable = lib.mkForce false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = false;
  };

  users.users.elena = {
    isNormalUser = true;
    home = "/home/elena";
    uid = 1000;
    description = "Ellie";
    extraGroups = [ "wheel" "networkmanager" "audio" ]; 
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    autorandr
    piper
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [
      "nvidia"
    ];
  };
	services.libinput.enable = true;

  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Only change when different iso version used
  system.stateVersion = "24.05";
  
  # Setting up system-wide programs 
  programs.dconf.enable = true;
  programs.zsh.enable = true;
  
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
 
  services.xserver.windowManager.awesome.enable = true;
  services.ratbagd.enable = true;
}
