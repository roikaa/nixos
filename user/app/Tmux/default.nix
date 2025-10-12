{pkgs, lib, config, ...}:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-Space";
    extraConfig = ''
      bind -n M-h previous-window
      bind -n M-l next-window
      
      # bind '"' split-window -v -c "#{pane_current_path}"
      # bind % split-window -h -c "#{pane_current_path}"
      bind-key -T prefix v split-window -v -c "#{pane_current_path}"
      bind-key -T prefix h split-window -h -c "#{pane_current_path}"


      set -g pane-base-index 1
      set -g base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
         '';
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
    ];
  };
}
