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
        package = pkgs.dwl.override {
            configH = ./dwl-config.h;
        }.overrideAttrs (oldAttrs: {
            buildInputs = oldAttrs.buildInputs or [] ++ [
                pkgs.libdrm
                pkgs.fcft
            ];
        patches = oldAttrs.patches or [] ++ [
            ./bar-0.7.patch
            ];
        });
    }
} 
