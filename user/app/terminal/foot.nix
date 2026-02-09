{ config, pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "10x10";  # Horizontal x vertical pixels (e.g., 10x10, 20x15); centers content by default [web:5]
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}

