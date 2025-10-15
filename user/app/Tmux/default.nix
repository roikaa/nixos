{pkgs, lib, config, ...}:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-Space";
    extraConfig = ''
      # Fuck other WM status bar apps
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
      bind -n M-_ split-window -v -c "#{pane_current_path}" # vertical
      bind -n M-| split-window -h -c "#{pane_current_path}" # vertical
      # Open floating window with nnn file explorer (alt+e)
      bind -n M-e display-popup -w 120 -h 30 -x 0 -y 0 "nnn"
      # Resize panes (alt+arrow-keys)
      bind -n M-Up resize-pane -U 5
      bind -n M-Down resize-pane -D 5
      bind -n M-Left resize-pane -L 5
      bind -n M-Right resize-pane -R 5
      # Mark pane (alt+m)
      bind -n M-m select-pane -m
      # Join pane (alt+b)
      bind -n M-b command-prompt -p "Join pane from:" "join-pane -s '%%'"
      # Htop in floating window (alt+t)
      bind -n M-t display-popup -w 120 -h 30 "htop"
      # Zoom/fullscreen pane (alt+z / alt+f)
      bind -n M-z resize-pane -Z
      bind -n M-f resize-pane -Z
      # FZF session picker (prefix+c-j)
      bind -T prefix C-j display-popup -w 120 -h 30 "tmux list-sessions | grep -v attached | fzf | cut -d: -f1 | xargs -r tmux attach-session -t"
      # FZF session-window picker (prefix+c-k)
      bind -T prefix C-k display-popup -w 120 -h 30 "tmux list-windows -a | fzf | awk '{print $1}' | xargs -r tmux select-window -t"
      # Default tall layout with 1 main pane and others stacked (prefix+alt+4)
      bind -T prefix M-4 select-layout main-vertical
      # Cycle panes in tall layout (alt+O)
      bind -n M-O select-pane -t :.+
      # Removing dely
      set -sg escape-time 10
      # Colors
      set-option -sa terminal-overrides ",foot:Tc"
      set -g default-terminal "tmux-256color"
      set-option -sa terminal-overrides ",tmux-256color:RGB"
      # Set base index to 1
      set -g pane-base-index 1
      set -g base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on
         '';
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.vim-tmux-navigator
      {
        plugin = tmuxPlugins.cpu;
        extraConfig = "set -g status-right ' CPU: #{cpu_icon} #{cpu_percentage} | %a %h-%d %H:%M '";
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-dir '$HOME/.tmux/resurrect'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };
}
