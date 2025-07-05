{ config, pkgs, lib, ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "DejaVu Sans Mono :size=14";
      };
    };
  };
}
