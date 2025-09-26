#{pkgs, lib, config, ...}:
#{
#  programs.rofi = {
#    enable = true;
#    #pass.enable = true;
#
#    extraConfig = {
#    show-icons = true;
#    #modi = "drun,run,ssh,window,pass:rofi-pass";
#    # Other configuration options...
#  };
#  };
#
#}
{pkgs, lib, config, ...}:
{
  programs.rofi = {
    enable = true;
    #pass.enable = true;
    
    # Font configuration
    font = "JetBrains Mono 14"; # Adjust font and size as needed
    
    extraConfig = {
      show-icons = true;
      #modi = "drun,run,ssh,window,pass:rofi-pass";
      
      # Display settings
      dpi = 96;
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
      
      # Size and positioning
      width = 50; # percentage of screen width
      lines = 10;
      columns = 2;
      
      # Behavior
      case-sensitive = false;
      cycle = true;
      eh = 1;
      auto-select = false;
      parse-hosts = true;
      parse-known-hosts = true;
      combi-modi = "drun,run";
      matching = "fuzzy";
      sort = true;
      threads = 0;
      scroll-method = 0;
      window-format = "{w} {c} {t}";
    };
    
    # Custom theme for better styling
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      # Global properties
      "*" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#ffffff";
        font = "JetBrains Mono Bold 16px"; # Larger font size
      };
      
      # Main window
      window = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = mkLiteral "false";
        width = mkLiteral "600px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "2px solid";
        border-radius = mkLiteral "10px";
        border-color = mkLiteral "#6272a4";
        background-color = mkLiteral "#282a36ee"; # Semi-transparent dark background
      };
      
      # Main container
      mainbox = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "20px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        children = map mkLiteral [ "inputbar" "listview" ];
      };
      
      # Input bar
      inputbar = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        margin = mkLiteral "0px";
        padding = mkLiteral "15px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "#44475a";
        text-color = mkLiteral "#f8f8f2";
        children = map mkLiteral [ "prompt" "entry" ];
      };
      
      # Prompt
      prompt = {
        enabled = mkLiteral "true";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "#8be9fd";
        font = "JetBrains Mono Bold 18px"; # Even larger for prompt
      };
      
      # Entry field
      entry = {
        enabled = mkLiteral "true";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "#f8f8f2";
        cursor = mkLiteral "#f8f8f2";
        placeholder = "Search...";
        placeholder-color = mkLiteral "#6272a4";
        font = "JetBrains Mono 16px";
      };
      
      # List view
      listview = {
        enabled = mkLiteral "true";
        columns = mkLiteral "1";
        lines = mkLiteral "8";
        cycle = mkLiteral "true";
        dynamic = mkLiteral "true";
        scrollbar = mkLiteral "false";
        layout = mkLiteral "vertical";
        reverse = mkLiteral "false";
        fixed-height = mkLiteral "true";
        fixed-columns = mkLiteral "true";
        spacing = mkLiteral "5px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        background-color = mkLiteral "transparent";
      };
      
      # List elements
      element = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "15px";
        margin = mkLiteral "0px";
        padding = mkLiteral "12px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "6px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#f8f8f2";
        cursor = mkLiteral "pointer";
      };
      
      "element normal.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#f8f8f2";
      };
      
      "element selected.normal" = {
        background-color = mkLiteral "#50fa7b";
        text-color = mkLiteral "#282a36";
        border-radius = mkLiteral "6px";
      };
      
      "element alternate.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "#f8f8f2";
      };
      
      # Element text and icon
      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        font = "JetBrains Mono Medium 15px"; # Good size for list items
      };
      
      "element-icon" = {
        background-color = mkLiteral "transparent";
        size = mkLiteral "32px"; # Larger icons
        cursor = mkLiteral "inherit";
      };
    };
  };
}
