{ pkgs, config, lib, inputs, ... }: {
options = {
  userModules.neovim.enable = lib.mkEnableOption "";
};
config = lib.mkIf  config.userModules.neovim.enable {
  home.packages = [
    inputs.nixvim.packages.${pkgs.system}.default
  ];
};
}
