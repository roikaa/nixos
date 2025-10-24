{ config, pkgs, inputs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      # Disable bell/annoying sounds
      enable_audio_bell = false;
      visual_bell_duration = 0;
      window_alert_on_bell = false;
      
      # Don't confirm on close
      confirm_os_window_close = 0;
      
      # Make it more minimal like foot
      hide_window_decorations = false;
      window_padding_width = 2;
      
      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
    };
  };
}
