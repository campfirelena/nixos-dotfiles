{ config, lib, ... }:{
options = {
  systemModules.nixconfig.enable = lib.mkEnableOption "";
};
config = lib.mkIf config.systemModules.nixconfig.enable {
  # Use Flakes
  nix = {
    extraOptions = "experimental-features = nix-command flakes";
  };
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["electron_34"];
  };

  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
};
}
