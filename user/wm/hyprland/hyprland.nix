{ config, pkgs, lib, ... }:  

{
  wayland.windowManager.hyprland = {
    enable = true;


    settings = {
workspace = [
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"
    ];

    windowrulev2 = [
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"
    ];
     # workspace = "name:myworkspace, gapsin:0, gapsout:0";
       # windowrule = "opacity 0.9, class:foot";

      exec-once = [
      "swww init"
      "fcitx5 -d --replace"
      # "waybar"
      ];

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
	rounding = 0;
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
      };

      bindm = [
# mouse movements
	"$mod, mouse:272, movewindow"
	"$mod, mouse:273, resizewindow"
	"$mod ALT, mouse:272, resizewindow"

      ];
      bind = [
	# Lunch Apps
	# "$mod, C, exec, keepmenu"
	"$mod, Y, exec, foot yazi&,"
	"$mod, W, exec, librewolf&,"
	"$mod, return, exec, $terminal"
	"$mod, D, exec, $appluncher -show drun"
	"$mod, P, exec, hyprshot -m output"

	# Window minupulation
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
