{ config, pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font Mono:size=14";
      };
    };
  };
}
