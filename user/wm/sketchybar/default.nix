
{ config, pkgs, lib, inputs, ... }:
{

  home.packages = with pkgs; [
        sketchybar
    ];

    home.file.".config/sketchybar" = {
	source = ./sketchybar/;
  recursive = true;

};
}
