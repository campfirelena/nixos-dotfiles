{ pkgs, config, lib, ... }: {
options = {
  home.neovim.enable = lib.mkEnableOption "";
};
config = lib.mkIf  config.home.nvim.enable {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/config/nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
};
}
