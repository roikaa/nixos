{ config, pkgs, lib, ... }:  

{
    wayland.windowManager.hyprland = {
      enable = true;


      settings = {

      exec-once = "swww init";
          "$mod" = "SUPER";
          "$terminal" = "kitty";
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
        enabled = true;
          size = 5;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = false;
      };

    bind =
      [
        "$mod, W, exec, librewolf"
        "$mod, return, exec, $terminal"
        "$mod, Q, killactive"
        "$mod, R, exec, $appluncher -show run"
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
