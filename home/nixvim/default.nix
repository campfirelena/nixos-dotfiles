{ lib, config, ... }:{
options = {
  homeModules.nixvim.enable = lib.mkEnableOption "";
};
config = {
  imports = [
    ./plugins
    ./options.nix
    ./keybinds.nix
  ];
};
}
