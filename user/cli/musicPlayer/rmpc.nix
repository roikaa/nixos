{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rmpc

  ];

  services.mpd.enable = true;
}
