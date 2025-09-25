{ pkgs, ... }:
{
  stylix = {

    enable = true;
   
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    targets.gtk.enable = true;
    targets.qt.enable = true;

    polarity = "dark";
    
    opacity = {
      #applications = 1.0;
      #terminal = 0.7;
      #desktop = 1.0;
      #popups = 1.0;
    };


    fonts = {
      sizes = {
        terminal = 15;
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
}
