{ config, pkgs, lib, inputs, ... }: 
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets = {
      gtk.enable = true;
      qt.enable = true;
    };
    polarity = "dark";
    fonts = {
      sizes = {
        terminal = 15;
        applications = 12;
        desktop = 11;
        popups = 12;
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
  
  specialisation.light.configuration = {
    stylix = {
      base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-soft.yaml";
      polarity = lib.mkForce "light";
    };
  };
}
