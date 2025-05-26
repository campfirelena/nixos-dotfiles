{ pkgs, config, lib, ... }: {
options = {
  userModules.neovim.enable = lib.mkEnableOption "";
};
config = lib.mkIf  config.userModules.neovim.enable {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
};
}
