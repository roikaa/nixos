{ config, pkgs, lib, ... }:  
{
  # Adding some dependencies
  home.packages = with pkgs; [
  wayland
  wayland-protocols
  wlroots_0_19
  foot
  git
  wmenu
  wl-clipboard
  grim
  slurp
  swaybg
  firefox
  jetbrains-mono
  ];
    programs.dwl = {
        enable = true;
    };
} 
