{ pkgs, config, lib, ... }: {
options = {
  neovim.enable = lib.mkEnableOption "";
};
config = lib.mkIf  config.nvim.enable {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
};
}
