{ pkgs, config, ... }: {
home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink
  "${config.home.homeDirectory}/nixos-dotfiles/home/nvim";
}
