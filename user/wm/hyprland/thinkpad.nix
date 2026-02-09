{ config, pkgs, lib, ... }:  

{
  # Adding some dependencies
  home.packages = with pkgs; [
    brightnessctl      # for brightness control
    playerctl          # for media controls
    grimblast          # for screenshots (or use grim + slurp)
    wdisplays          # for display management
    networkmanager     # usually already installed
    swaylock           # for screen locking
    # rofi-wayland    # or wofi, fuzzel, tofi
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [
        "HDMI-A-2,preferred,auto,1,mirror,eDP-1"
        "eDP-1,preferred,auto,1"
      ];
      
      misc = {
        force_default_wallpaper = 0;  # Disables the anime mascot wallpapers
        disable_hyprland_logo = true;  # Disables the Hyprland logo and anime girl background
        disable_splash_rendering = true;  # Prevents the splash screen from rendering
      };

      exec-once = [
        "swww init"
        "fcitx5 -d --replace"
        # "waybar"
      ];

      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$backupterminal" = "kitty";
      "$appluncher" = "rofi";

      input = {
        repeat_delay = "300";
        repeat_rate = "50";
        kb_layout = "us";
      };

      decoration = {
        rounding = 4;
        active_opacity = 1;
        inactive_opacity = 1;

        blur = {
          enabled = false;
          size = 5;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
      
        bezier = [
          "o2_shot, 0, 0.72, 0.4, 1.15"
          "o2_smooth, 0.4, 0, 0.2, 1"
          "wind_up, 0.1, 0.8, 0.1, 1.1"
          "bounce, 1.1, 1.2, 0.1, 1.05"
          "fluffy, 0.1, 1.3, 0.1, 1.0"
          "slingshot, 1, -0.15, 0.75, 1.25"
        ];
      
        animation = [
          # allow the windows animation parent (keep global off)
          "windows, 1, 3, o2_smooth, popin 90%"   # very soft pop‑in 90%→100%
      
          # slight closing, barely noticeable
          "windowsOut, 1, 2, o2_smooth, popin 95%"
      
          # turn everything else explicitly off
          "windowsMove, 0"
          "global, 0"
        ];
      };
      
      
      # Window rules for transparency
      windowrulev2 = [
        # Terminal transparency (foot)
        "opacity 0.95 0.90, class:^(foot)$"
        
        # Backup terminal transparency (kitty)
        "opacity 0.95 0.90, class:^(kitty)$"
        
        # Everything else stays opaque by default
        # (ctrl+o toggle will still work)
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      
      binde = [
        # Volume controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        
        # Microphone mute
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        
        # Brightness controls
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      
      bind = [
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        
        # ThinkPad specific keys
        ", XF86Display, exec, wdisplays"  # Display switch key
        ", XF86WLAN, exec, nmcli radio wifi toggle"  # WiFi toggle (Fn+F8 on some models)
        
        # Screenshot
        ", Print, exec, grimblast copy area"  # Print Screen
        "SHIFT, Print, exec, grimblast copy screen"
        "$mod SHIFT, Print, exec, grimblast save screen ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        
        # Lock screen
        "$mod SHIFT, L, exec, swaylock"
        
        # Toggle opacity for active window (your ctrl+o feature)
        "$mod, O, exec, hyprctl dispatch setprop active opaque toggle"

        # Refresh waybar
        "$mod SHIFT, R, exec, systemctl --user restart waybar.service"

        # Launch Apps
        "$mod, Y, exec, $terminal yazi&,"
        "$mod, W, exec, librewolf&,"
        "$mod, return, exec, $terminal"
        "$mod SHIFT, return, exec, $backupterminal"

        "$mod, D, exec, $appluncher -show drun"

        # Window manipulation
        "$mod, Q, killactive,"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating,"

        # Move focus
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, h, alterzorder, top"
        "$mod, l, alterzorder, top"
        "$mod, k, alterzorder, top"
        "$mod, j, alterzorder, top"

        # Special workspaces (scratchpad) 
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ]
      ++ (
        # Workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
      );
    };
  };
}
