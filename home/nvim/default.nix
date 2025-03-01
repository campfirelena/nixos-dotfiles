{ pkgs, config, lib, ... }: {
options = {
  nvim.enable = lib.mkEnableOption "Enable NVIM";
};
config = lib.mkIf  config.nvim.enable {
  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-dotfiles/home/nvim";
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
};
}
