{ config, lib, ... }:
{
options = {
  userModules.flatpak.enable = lib.mkEnableOption "";
  userModules.flatpak.packages = lib.mkOption {
    type = lib.types.listOf lib.types.str;
  };
  userModules.flatpak.remotes = lib.mkOption {
    type = lib.types.attrs;
  };
};
config = lib.mkIf config.userModules.flatpak.enable {
  services.flatpak = {
    enable = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
    packages = [ ] ++ config.userModules.flatpak.packages;
  };
};
}
