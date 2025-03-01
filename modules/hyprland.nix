{ config, pkgs, lib, ... }:  

{
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
          "$mod" = "SUPER";
          "$terminal" = "kitty";
          "$appluncher" = "rofi";

      input = {
        repeat_delay = "300";
        repeat_rate = "50";
      };

      animations = {
        enabled = false;
      };

    bind =
      [
        "$mod, W, exec, firefox"
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
