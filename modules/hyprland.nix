{ config, pkgs, lib, ... }:  

{
    wayland.windowManager.hyprland = {
      enable = true;


      settings = {
        
        windowrule = "opacity 0.8, class:footclient";

        exec-once = "swww init";
          
          "$mod" = "SUPER";
          "$terminal" = "foot";
          "$appluncher" = "rofi";

      input = {
        repeat_delay = "300";
        repeat_rate = "50";
      };

      decoration = {
        rounding = 10 ;
        active_opacity = 0.9;
        inactive_opacity = 0.8;
        
        blur = {
        enabled = false;
          size = 5;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
      };

    bindm = [
      # mouse movements
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];
    bind =
      [
        "$mod, Y, exec, foot yazi&,"
        "$mod, W, exec, librewolf&,"
        "$mod, return, exec, $terminal"
        "$mod, Q, killactive,"
        "$mod, R, exec, $appluncher -show drun"
        "$mod, V, togglefloating,"

        # special workspaces (scratchpad) 
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ]
      ++ (
        # workspaces
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
