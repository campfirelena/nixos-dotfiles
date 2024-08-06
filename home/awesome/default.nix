{ pkgs, config, ... }: {
home.file.".config/awesome".source = config.lib.file.mkOutOfStoreSymlink
  "${config.home.homeDirectory}/nixos-dotfiles/home/awesome";
}
