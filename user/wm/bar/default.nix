{ config, pkgs, lib, inputs, ... }:
{

  home.packages = with pkgs; [
        # sketchybar
    ];

    programs.waybar.enable = true;

    home.file.".config/waybar" = {
	source = ./waybar;
  recursive = true;

};
}
