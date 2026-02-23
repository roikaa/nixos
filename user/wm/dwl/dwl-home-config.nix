{ config, pkgs, lib, ... }:

{
  # Dependencies for dwl and associated tools
  home.packages = with pkgs; [
    # Window manager
    # dwl
    
    # Core dependencies
    wayland
    wayland-protocols
    wlroots_0_19
    
    # Terminal
    foot
    kitty
    
    # Utilities
    git
    wmenu                    # application launcher (dwl-compatible)
    wl-clipboard
    grim
    slurp
    swaybg                   # wallpaper
    swaylock                 # screen locking
    swaynotificationcenter   # notifications
    
    # Media/system control
    brightnessctl
    playerctl
    wpctl                    # volume control
    
    # Browsers & apps
    firefox
    librewolf
    
    # Fonts
    jetbrains-mono
  ];

  # Configure dwl startup
  # Note: dwl uses autostart scripts in ~/.dwl (XDG_RUNTIME_DIR or similar)
  # You'll need to create these shell scripts for startup programs
  home.file.".dwl/autostart" = {
    executable = true;
    text = ''
      #!/bin/sh
      # Startup programs
      swaybg -i ~/Pictures/wallpapers/photography/road.jpg &
      swaynotificationcenter &
      fcitx5 -d --replace &
    '';
  };

  # Create default keybindings documentation
  # dwl uses config.h - you'll need to customize it directly
  home.file.".dwl/README.md" = {
    text = ''
      # DWL Configuration

      ## Key Bindings Cheatsheet
      (Based on your Hyprland setup, adapted for dwl)

      ### Windows
      - Super + Q: Kill window
      - Super + F: Fullscreen
      - Super + V: Toggle floating
      - Super + H/J/K/L: Move focus (left/down/up/right)

      ### Workspaces
      - Super + 1-9: Switch workspace
      - Super + Shift + 1-9: Move window to workspace

      ### Applications
      - Super + Return: Open foot terminal
      - Super + Shift + Return: Open kitty
      - Super + D: Launch wmenu (app launcher)
      - Super + W: Open Firefox/Librewolf
      - Super + Y: Open file manager (yazi)

      ### Media
      - F10/F11: Volume down/up
      - F12: Toggle mute
      - XF86AudioPlay/Pause: Play/Pause
      - XF86AudioNext/Prev: Next/Previous track

      ### System
      - XF86MonBrightnessUp/Down: Adjust brightness
      - Super + Shift + L: Lock screen (swaylock)
      - Print: Screenshot (area)
      - Shift + Print: Screenshot (screen to clipboard)
      - Super + Shift + Print: Full screenshot

      ## To Customize

      You need to modify dwl's source code via `config.h`:

      1. Get dwl source: \`nix-shell -p dwl dwl.src\`
      2. Create custom package with your config.h
      3. Build and install custom dwl

      See https://www.tonybtw.com/tutorial/dwl/ for detailed setup.
    '';
  };

  # Optional: Create a shell script for common operations
  home.file.".dwl/scripts/screenshot.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      # Screenshot script matching your Hyprland setup
      DIR="$HOME/Pictures/Screenshots"
      mkdir -p "$DIR"
      
      case "''${1:-area}" in
        area)
          grimblast save area "$DIR/$(date +%Y-%m-%d_%H-%M-%S).jpg"
          ;;
        screen)
          grimblast copy screen
          ;;
        full)
          grimblast save screen "$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
          ;;
      esac
    '';
  };

  home.file.".dwl/scripts/media.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      # Media control script
      case "''${1}" in
        volume-up)
          wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          ;;
        volume-down)
          wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          ;;
        mute)
          wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
          ;;
        mic-mute)
          wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
          ;;
        brightness-up)
          brightnessctl set 5%+
          ;;
        brightness-down)
          brightnessctl set 5%-
          ;;
      esac
    '';
  };

  # Session variables for Wayland
  wayland.windowManager.dwl = {
    enable = true;
    # dwl doesn't support declarative config in home-manager yet
    # You'll need to use the custom package approach below
  };

  # Alternative: Create custom dwl package with your config
  # Uncomment and customize if you want to build dwl with specific settings
  
  home.packages = [
    (pkgs.dwl.overrideAttrs (oldAttrs: {
      postPatch = ''
        cp ${./dwl-config.h} config.h
      '';
    }))
  ];
}
