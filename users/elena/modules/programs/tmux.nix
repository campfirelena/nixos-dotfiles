{ pkgs, ... }:{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      pkgs.tmuxPlugins.vim-tmux-navigator  
    ];
  };
}
