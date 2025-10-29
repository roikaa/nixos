{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Useful for album art extraction and display
    ffmpeg
    imagemagick
  ];

  programs.rmpc = {
    enable = true;
    config = ''
      # MPD Connection
      address = "127.0.0.1:6600"
      
      # ===== THEME & UI STYLING =====
      [theme]
      # Use terminal default colors
      default_background = "reset"
      default_foreground = "reset"
      
      # Highlighted item (under cursor) - terminal cyan/bright blue
      highlighted_item_foreground = "black"
      highlighted_item_background = "cyan"
      
      # Currently playing item - terminal green
      current_item_foreground = "black"
      current_item_background = "green"
      
      # Headers and borders - use terminal colors
      header_foreground = "bright_white"
      border_foreground = "bright_black"
      
      # Progress bar - terminal blue
      progress_bar_foreground = "blue"
      progress_bar_background = "black"
      
      # Modal windows - use terminal defaults
      modal_background = "reset"
      modal_foreground = "reset"
      
      # ===== ALBUM ART SETTINGS =====
      [album_art]
      method = "kitty"  # Options: "kitty", "ueberzug", "sixel", "none"
      max_size_px = 400
      
      # Show album art in a separate pane
      [panes.album_art]
      visible = true
      position = "right"  # or "left", "top", "bottom"
      size_percent = 30
      
      # ===== UI LAYOUT =====
      [browser]
      show_album_art_in_album_list = true
      columns = ["artist", "album", "year", "duration"]
      
      [queue]
      show_album_art = true
      columns = ["track", "title", "artist", "album", "duration"]
      
      # ===== KEYBINDINGS =====
      [keybinds]
      # Navigation
      "j" = "down"
      "k" = "up"
      "h" = "left"
      "l" = "right"
      "g" = "top"
      "G" = "bottom"
      "Ctrl+d" = "page_down"
      "Ctrl+u" = "page_up"
      
      # Tabs
      "1" = "goto_queue"
      "2" = "goto_browser"
      "3" = "goto_search"
      "4" = "goto_playlists"
      
      # Playback
      "space" = "toggle_pause"
      ">" = "next"
      "<" = "previous"
      "s" = "stop"
      
      # Volume
      "+" = "volume_up"
      "-" = "volume_down"
      "=" = "volume_up"
      
      # Toggle modes
      "r" = "toggle_repeat"
      "z" = "toggle_random"
      "y" = "toggle_single"
      "c" = "toggle_consume"
      
      # Queue management
      "d" = "delete"
      "D" = "clear_queue"
      "a" = "add"
      "A" = "add_all"
      
      # Search
      "/" = "search"
      "n" = "next_result"
      "N" = "previous_result"
      
      # Other
      "q" = "quit"
      "u" = "update_database"
      "?" = "show_help"
      
      # ===== DISPLAY OPTIONS =====
      [display]
      show_song_position = true
      show_volume = true
      show_elapsed_time = true
      symbols = "●▶❚❚ ◼"  # play, pause, stop symbols
      
      # Album art border
      [album_art.border]
      style = "rounded"  # "rounded", "solid", "double"
      color = "blue"  # uses terminal blue color
    '';
  };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    
    extraConfig = ''
      # Audio Output
      audio_output {
        type "pipewire"
        name "PipeWire Output"
        mixer_type "software"
      }
      
      # Visualizer output (for other apps)
      audio_output {
        type "fifo"
        name "Visualizer feed"
        path "/tmp/mpd.fifo"
        format "44100:16:2"
      }
      
      # Database settings
      auto_update "yes"
      auto_update_depth "3"
      
      # Playback settings
      restore_paused "yes"
      replaygain "album"
      volume_normalization "yes"
      
      # Logging
      log_level "default"
    '';
    
    network = {
      listenAddress = "127.0.0.1";
      port = 6600;

    startWhenNeeded = true;
    };
    
  };
}
