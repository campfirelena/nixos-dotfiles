{ pkgs, ... }:{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    keyMode = "vi";
    prefix = "C-a";
    sensibleOnTop = true;
    mouse = true;
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      yank
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          resurrect_dir="$HOME/.tmux/resurrect"
          set -g @resurrect-dir $resurrect_dir
          set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
          set -g @continuum-systemd-start-cmd 'start-server'
        '';
      }
    ];
    extraConfig = ''
      set -sg escape-time 0

      unbind %
      unbind \"
      bind | split-window -h
      bind - split-window -v

      set-window-option -g mode-keys vi

      bind Escape copy-mode

      # Easy config reload
      bind r source-file ~/.config/tmux/tmux.conf

      # Prefix p paste
      unbind p
      bind p paste-buffer

      # nvim navigation stuff
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      bind -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'
      bind -n 'C-n' if-shell "$is_vim" 'send-keys C-n' 'select-window -n'
      bind-key -T copy-move-vi 'C-h' select-pane -L
      bind-key -T copy-move-vi 'C-j' select-pane -D
      bind-key -T copy-move-vi 'C-k' select-pane -U
      bind-key -T copy-move-vi 'C-l' select-pane -R
      bind-key -T copy-move-vi 'C-n' select-window -n


      # Custom binds and stuff
      bind-key -T prefix C-d switch -t dotfiles
      bind-key -T prefix C-l switch -t notes
    '';
  };
}
