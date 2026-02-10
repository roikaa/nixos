{ config, pkgs, lib, inputs, ... }: 
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    targets = {
      gtk.enable = true;
      qt.enable = true;
    };
    polarity = "dark";
    fonts = {
      sizes = {
        terminal = 12;
        applications = 11;
        desktop = 11;
        popups = 12;
      };
      
      monospace = {
        package = pkgs.nerd-fonts.hack;
        name = "Hack Nerd Font";
      };      
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      
      serif = {
        package = pkgs.eb-garamond;
        name = "EB Garamond";
      };
      
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    }; 
  };
  
  specialisation = {
    light.configuration = {
      stylix = {
        base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-medium.yaml";
        polarity = lib.mkForce "light";
      };
    };
    
    dark.configuration = {
      stylix = {
        base16Scheme = lib.mkForce "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
        polarity = lib.mkForce "dark";
      };
    };
  };
}
