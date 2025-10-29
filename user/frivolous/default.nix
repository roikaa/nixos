
{lib, config, pkgs, ... }:
{
    
  home.packages = with pkgs; [
    cmatrix
        fastfetch
        screenfetch
        pipes
        nitch
        neofetch

        ascii-image-converter
    ];
}
