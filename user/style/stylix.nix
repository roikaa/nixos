{ config, pkgs, inputs, ... }: 
{
# this is home-manager stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
#base16Scheme = "${pkgs.base16-schemes}/share/themes/sakura.yaml";

    targets.nixvim.enable = true;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

   # iconTheme = { 
   #   package = pkgs.papirus-icon-theme;
   #   name = "Papirus";
   # };
      iconTheme = {
    enable = true;
    package = pkgs.gruvbox-plus-icons;
    light = "Gruvbox-Plus-Light";
    dark = "Gruvbox-Plus-Dark";
  };
  };
}   
