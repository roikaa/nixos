{pkgs, lib, config, ...}:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-Space";
    extraConfig = ''
      # dont need status bar apps , Tmux is overkill
      set -g status-position top

       # Window navigation (alt+0-9)
      bind -n M-0 select-window -t 0
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      # Window navigation with h/l (alt+h/l)
      bind -n M-h previous-window
      bind -n M-l next-window

      # Session navigation (alt+J/K)
      bind -n M-J switch-client -p
      bind -n M-K switch-client -n

      # Kill pane (alt+x)
      bind -n M-x kill-pane

      # Kill window (alt+X)
      bind -n M-X kill-window

      # Create window (alt+c)
      bind -n M-c new-window

      # Rename window (alt+,)
      bind -n M-, command-prompt -I "#{window_name}" "rename-window '%%'"

      # Rename session (alt+$)
      bind -n M-\$ command-prompt -I "#{session_name}" "rename-session '%%'"

      # Split-window
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
      # tmuxPlugins.cpu
      # tmuxPlugins.tmux-prefix-highlight
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = "set -g status-right ' CPU: #{cpu_icon} #{cpu_percentage} | %a %h-%d %H:%M '";
      }
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
