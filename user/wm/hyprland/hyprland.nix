{ config, pkgs, lib, ... }:  

{
  wayland.windowManager.hyprland = {
    enable = true;


    settings = {

      windowrule = "opacity 0.7, class:foot";

      exec-once = ["swww init"
      "fcitx5 -d --replace"];

      "$mod" = "SUPER";
      "$terminal" = "foot";
      "$appluncher" = "rofi";

      input = {
	repeat_delay = "300";
	repeat_rate = "50";
	kb_layout = "us";
#	kb_variant = ",,,";
#	kb_options = "grp:win_space_toggle";
      };

      decoration = {
	rounding = 5 ;
	active_opacity = 1;
	inactive_opacity = 1;

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
	  "$mod, D, exec, $appluncher -show drun"
	  "$mod, C, exec, keepmenu"
	  "$mod, V, togglefloating,"
	  "$mod, P, exec, hyprshot -m output"

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
